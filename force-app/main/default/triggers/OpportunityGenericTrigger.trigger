trigger OpportunityGenericTrigger on Opportunity (before delete, before insert, before update, after delete, 
                                                  after insert, after update, after undelete) 
{
    
    if(Trigger.isAfter && Trigger.isInsert){
        
        //Since we have set Opp as private in the Sharing Settings, then on create of Opp, we need to create sharing access 
        //specific to the Sales Rep team members of this Opp. So that all members should have edit permissions
        OpportunityGenericTriggerHandler.SalesRepTeamAccessibilityAfterInsert(Trigger.New);
        
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        
        //Since we have set Opp as private in the Sharing Settings, then on create of Opp, we need to create sharing access 
        //specific to the Sales Rep team members of this Opp. So that all members should have edit permissions
        OpportunityGenericTriggerHandler.SalesRepTeamAccessibilityAfterUpdate(Trigger.Old, Trigger.New);
        
    }
    
    
    
}