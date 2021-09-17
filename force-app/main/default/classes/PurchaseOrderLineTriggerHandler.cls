public class PurchaseOrderLineTriggerHandler {
    
    public static void ReceiveExcluded(List<AcctSeedERP__Purchase_Order_Line__c> newPurchaseOrderLines){
        
        for(AcctSeedERP__Purchase_Order_Line__c purchaseLine : newPurchaseOrderLines){
            purchaseLine.Receive_Excluded__c = purchaseLine.Receive_Excluded_Formula__c;
            purchaseLine.Is_Inventory_Product__c = purchaseLine.Is_Inventory_Product_Formula__c;
        }
    }
}