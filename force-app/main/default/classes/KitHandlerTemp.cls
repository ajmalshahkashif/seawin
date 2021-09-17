public class KitHandlerTemp {
  public static void Process(List<sobject> od, List<sobject> nd, string initials) {
    map<id, Id> TriggerProductIdMap = new Map<id, id>();

    Integer i = 0;
    for (sobject obj : nd) {
      Id productId = initials == 'oli' ||
        initials == 'qli'
        ? (Id) obj.get('Product2Id')
        : initials == 'opo' ||
            initials == 'opq'
            ? (Id) obj.get('Product__c')
            : initials == 'sli' ||
                initials == 'pli'
                ? (Id) obj.get('AcctSeedERP__Product__c')
                : null;
      Decimal nquantity = initials == 'oli' ||
      initials == 'qli'
      ? (decimal) obj.get('Quantity')
      : initials == 'opo' ||
          initials == 'opq'
          ? (decimal) obj.get('Quantity__c')
          : initials == 'sli'
              ? (decimal) obj.get('AcctSeedERP__Quantity_Ordered__c')
              : initials == 'pli'
                  ? (decimal) obj.get('AcctSeedERP__Quantity__c')
                  : 0;

      Decimal oquantity = !od.isEmpty() ? initials == 'oli' ||
      initials == 'qli'
      ? (decimal) od[i].get('Quantity')
      : initials == 'opo' ||
          initials == 'opq'
          ? (decimal) od[i].get('Quantity__c')
          : initials == 'sli'
              ? (decimal) od[i].get('AcctSeedERP__Quantity_Ordered__c')
              : initials == 'pli'
                  ? (decimal) od[i].get('AcctSeedERP__Quantity__c')
                  : 0 : 0;

      if (productId != null && ((!od.isEmpty() && nquantity != oquantity) || (od.isEmpty() && !nd.isEmpty())))
        TriggerProductIdMap.put(productId, productId);

      i++;
    }

    map<id, product2> ProductsMap = new Map<id, product2>();

    if (TriggerProductIdMap.size() > 0) {
      ProductsMap = new Map<id, product2>(
        [
          SELECT id, kit_available_quantity__c
          FROM product2
          WHERE
            id IN :TriggerProductIdMap.keyset()
            AND AcctSeed__Inventory_Type__c = 'Kit'
        ]
      );
    }

    Map<id, list<decimal>> TotalKitQuantitiesMap = new Map<id, list<decimal>>();

    if (ProductsMap.size() > 0) {
      // We will be getting the total quantity from code because the field on product changes with adding and deleting of lines
      TotalKitQuantitiesMap = InventoryCalculationHelper.Calculate(
        ProductsMap.keyset()
      );
    }

    List<aggregateResult> agr = new List<aggregateResult>();
    map<id, decimal> ObjectsMaxQuantityMap = new Map<id, decimal>();

    if (TotalKitQuantitiesMap.size() > 0) {
      agr = [
        SELECT Product2Id p, Max(Quantity) q
        FROM OpportunityLineItem
        WHERE Product2Id IN :TotalKitQuantitiesMap.keyset()
        GROUP BY Product2Id
      ];

      ObjectsMaxQuantityMap = FindQuantity(agr, ObjectsMaxQuantityMap);

      agr = [
        SELECT Product__c p, Max(Quantity__c) q
        FROM Optional_Products_Opportunity__c
        WHERE Product__c IN :TotalKitQuantitiesMap.keyset()
        GROUP BY Product__c
      ];

      ObjectsMaxQuantityMap = FindQuantity(agr, ObjectsMaxQuantityMap);

      agr = [
        SELECT Product2Id p, Max(Quantity) q
        FROM QuoteLineItem
        WHERE Product2Id IN :TotalKitQuantitiesMap.keyset()
        GROUP BY Product2Id
      ];

      ObjectsMaxQuantityMap = FindQuantity(agr, ObjectsMaxQuantityMap);

      agr = [
        SELECT Product__c p, Max(Quantity__c) q
        FROM Optional_Products_Quote__c
        WHERE Product__c IN :TotalKitQuantitiesMap.keyset()
        GROUP BY Product__c
      ];

      ObjectsMaxQuantityMap = FindQuantity(agr, ObjectsMaxQuantityMap);

      agr = [
        SELECT
          AcctSeedERP__Product__c p,
          Max(AcctSeedERP__Quantity_Ordered__c) q
        FROM AcctSeedERP__Sales_Order_Line__c
        WHERE AcctSeedERP__Product__c IN :TotalKitQuantitiesMap.keyset()
        GROUP BY AcctSeedERP__Product__c
      ];

      ObjectsMaxQuantityMap = FindQuantity(agr, ObjectsMaxQuantityMap);

      agr = [
        SELECT AcctSeedERP__Product__c p, Max(AcctSeedERP__Quantity__c) q
        FROM AcctSeedERP__Purchase_Order_Line__c
        WHERE AcctSeedERP__Product__c IN :TotalKitQuantitiesMap.keyset()
        GROUP BY AcctSeedERP__Product__c
      ];

      ObjectsMaxQuantityMap = FindQuantity(agr, ObjectsMaxQuantityMap);

      List<Product2> Updatables = new List<Product2>();

      if(productsMap.size() > 0){

          for(product2 p : productsMap.values()){

            decimal totalQuantity = TotalKitQuantitiesMap.containsKey(p.id) ? 
            TotalKitQuantitiesMap.get(p.id)[0] : 0;

            decimal AvailableQuantity = ProductsMap.containsKey(p.id) ? 
            ObjectsMaxQuantityMap.containsKey(p.id) && totalQuantity > 0 ? totalQuantity - ObjectsMaxQuantityMap.get(p.id) : totalQuantity : 0;

            p.Kit_Available_Quantity__c = AvailableQuantity;

            Updatables.add(p);
          }
        }

        if(!Updatables.isEmpty()) update Updatables;
      }
    }

  public static map<id, decimal> FindQuantity(
    List<aggregateResult> agr,
    map<id, decimal> ObjectsQuantityMap
  ) {
    for (AggregateResult a : agr) {
      Decimal quantity = 0;

      if (ObjectsQuantityMap.containsKey((id) a.get('p'))) {
        quantity = (decimal) a.get('q') > ObjectsQuantityMap.get((id) a.get('p')) ?
        (decimal) a.get('q') : ObjectsQuantityMap.get((id) a.get('p'));

      } else {
        quantity = (decimal) a.get('q');
      }
      ObjectsQuantityMap.put((id) a.get('p'), quantity == null ? 0 : quantity);
    }

    return ObjectsQuantityMap.size() > 0 ? ObjectsQuantityMap : new Map<id, decimal>();
  }
}