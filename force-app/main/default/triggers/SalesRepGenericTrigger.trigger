trigger SalesRepGenericTrigger on Sales_Rep__c (before delete, before insert, before update, after delete, 
                                                after insert, after update, after undelete) 
{
    
    if(Trigger.isAfter && Trigger.isUpdate){
        
        //On update of "Visible To" (Team__c) field, if a new user is added then we have to add accessibility for this user also.
        //If a user is deleted then we have to remove accessibility for this user
        //accessibility will be altered for Opp, Quote & SO
        Integer i = SalesRepGenericTriggerHandler.SalesRepTeamAccessibilityAfterUpdate(Trigger.Old, Trigger.New);
        if(i > 0){
           // Trigger.New[0].addError('Please enable the Primary contact one');
        }
        
    }
}