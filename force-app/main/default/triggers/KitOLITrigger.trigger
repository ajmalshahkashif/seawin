trigger KitOLITrigger on OpportunityLineItem (after insert, after update, after delete, after undelete) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete){
            
            KitHandler.Process(
            Trigger.isUpdate ? Trigger.old : new List<OpportunityLineItem>(),    
            Trigger.isDelete ? Trigger.old : Trigger.new, 'oli');
     		       
        }
    }
}