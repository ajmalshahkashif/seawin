trigger SalesOrderLineTrigger on AcctSeedERP__Sales_Order_Line__c (before insert, before update) {
    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
        SalesOrderLineTriggerHandler.shipmentExcluded(Trigger.New);
}