public class DeleteSalesRepHandler {
    
    public static void DeleteAssociatedSID(List<Sales_Rep__c> TriggerData){
        
        set<id> repIds = new Set<Id>();
        
        for(Sales_rep__c sr : TriggerData){        
            repIds.add(sr.Id);
        }
        
        if(!repIds.isEmpty()){
            
            FinallyDelete(repIds);
            
        }
    }

    
    @future
    public static void FinallyDelete(Set<Id> repIds){

        List<User> users = [Select Id, sales_rep_id__c from user where (sales_rep_id__c in:repIds)];
            
            for(User usr : users){              
                usr.sales_rep_id__c = null;           
            }
            
            update users;
    }

}