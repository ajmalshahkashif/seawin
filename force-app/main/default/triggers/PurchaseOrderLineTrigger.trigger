trigger PurchaseOrderLineTrigger on AcctSeedERP__Purchase_Order_Line__c (before insert, before update) {
    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
        PurchaseOrderLineTriggerHandler.ReceiveExcluded(Trigger.New);

}