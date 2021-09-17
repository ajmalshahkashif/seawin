trigger DeleteSalesRepTrigger on Sales_Rep__c (after delete) {
    
    if(Trigger.isAfter && Trigger.isDelete){
        
        DeleteSalesRepHandler.DeleteAssociatedSID(Trigger.old);
        
    }

}