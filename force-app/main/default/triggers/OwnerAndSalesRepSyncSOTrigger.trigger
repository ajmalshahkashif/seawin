trigger OwnerAndSalesRepSyncSOTrigger on AcctSeedERP__Sales_Order__c (after insert) {
    if(Trigger.isInsert && Trigger.IsAfter){
        
        OwnerAndSalesRepSyncHandler.Sync(new List<Opportunity>(), Trigger.new);
    }
}