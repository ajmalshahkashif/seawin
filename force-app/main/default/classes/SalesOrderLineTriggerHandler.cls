public with sharing class SalesOrderLineTriggerHandler {
    
    public static void shipmentExcluded(List<AcctSeedERP__Sales_Order_Line__c> newSalesOrderLines){
        
        for(AcctSeedERP__Sales_Order_Line__c sOrderLine : newSalesOrderLines){
            sOrderLine.Shipment_Excluded__c = sOrderLine.Shipment_Excluded_Formula__c;
            sOrderLine.Is_Inventory_Product__c = sOrderLine.Is_Inventory_Product_Formula__c;
        }
    }    
}