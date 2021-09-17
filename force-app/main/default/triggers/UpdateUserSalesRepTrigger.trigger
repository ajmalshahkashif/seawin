trigger UpdateUserSalesRepTrigger on Sales_Rep__c (after insert, after update) {
    
    UpdateUserSalesRepHandler.UpdateUser((Trigger.old != null) ? Trigger.old: new list<Sales_rep__c>(), 
                                         Trigger.new);

}