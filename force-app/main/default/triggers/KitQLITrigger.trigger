trigger KitQLITrigger on QuoteLineItem (after insert, after update, after delete, after undelete) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete){
            
            KitHandler.Process(
            Trigger.isUpdate ? Trigger.old : new List<QuoteLineItem>(),    
            Trigger.isDelete ? Trigger.old : Trigger.new, 'qli');
     		       
        }
    }
}