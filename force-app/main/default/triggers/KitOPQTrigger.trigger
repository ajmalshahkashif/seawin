trigger KitOPQTrigger on Optional_Products_Quote__c (after insert, after update, after delete, after undelete) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete){
            
            KitHandler.Process(
            Trigger.isUpdate ? Trigger.old : new List<Optional_Products_Quote__c>(),    
            Trigger.isDelete ? Trigger.old : Trigger.new, 'opq');
     		       
        }
    }
}