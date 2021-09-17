trigger UserTrigger on User (after update) {
    
    if(Trigger.isAfter && Trigger.IsUpdate){
        
        UserTriggerHandler.ProcessIt(Trigger.old, Trigger.new);
        
    }
}