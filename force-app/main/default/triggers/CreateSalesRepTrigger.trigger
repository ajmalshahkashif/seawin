trigger CreateSalesRepTrigger on User (after insert) {
    
    if(Trigger.IsAfter && Trigger.IsInsert){
        
        CreateSalesRepHandler.CreateSalesRepRecord(Trigger.new);
        
    }
}