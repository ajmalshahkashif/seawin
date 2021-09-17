trigger OwnerAndSalesRepSyncOPTrigger on Opportunity (after insert) {
    if(Trigger.isInsert && Trigger.IsAfter){
        
        OwnerAndSalesRepSyncHandler.Sync(Trigger.new, new List<AcctSeedERP__Sales_Order__c>());
    }
}