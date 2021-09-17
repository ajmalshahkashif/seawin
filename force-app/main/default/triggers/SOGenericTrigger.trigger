trigger SOGenericTrigger on AcctSeedERP__Sales_Order__c (before delete, before insert, before update, after delete, after insert, after update, after undelete) {
    
    
    
    //On update of SO Sales Rep Team, we need to remove all sharing accessibility for the removed Sales Rep Team Members
    //And give edit accessibility to new selected Sales Rep Team Members
    if(Trigger.IsAfter && Trigger.IsUpdate){
        SOGenericTriggerHandler.SalesRepTeamAccessibility(Trigger.old, Trigger.new);
        
    }
    
    
}