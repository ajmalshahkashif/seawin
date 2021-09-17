trigger KitPLITrigger on AcctSeedERP__Purchase_Order_Line__c (after insert, after update, after delete, after undelete) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete){
            
            KitHandler.Process(
            Trigger.isUpdate ? Trigger.old : new List<AcctSeedERP__Purchase_Order_Line__c>(),    
            Trigger.isDelete ? Trigger.old : Trigger.new, 'pli');
     		       
        }
    }
}