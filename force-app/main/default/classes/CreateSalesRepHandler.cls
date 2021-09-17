public class CreateSalesRepHandler {
    
    public static void CreateSalesRepRecord(List<User> TriggerData){
        
        Map<Id, User> UserMap = new Map<Id, User>();
        
        for(User usr : TriggerData){
            UserMap.put(usr.id, usr);
        }
        
        if(UserMap.size() > 0){
            
            if(UserMap.size() > 0){
                
                // check if the Sales Rep exists, remove if necessary from the map
                List<Sales_Rep__c> SalesRepExists = [select User__c from Sales_Rep__c where User__c in: UserMap.keyset()];
                
                if(!SalesRepExists.isEmpty()){
                    for(Sales_Rep__c srp : SalesRepExists){
                        UserMap.remove(srp.User__c);
                    }
                }
            }
            
            List<Sales_Rep__c> salesRecord = new List<Sales_Rep__c>();
            
            if(UserMap.size() > 0){
                for(Id userid : UserMap.keyset()){
                    
                    User usrRecord = UserMap.get(userid);
                    
                    if(usrRecord == null) continue;
                    
                    salesRecord.add(new Sales_Rep__c(User__c = usrRecord.id, 
                                                     Name = (usrRecord.FirstName == null ? '' : 
                                                             usrRecord.FirstName) + ' ' + 
                                                     (usrRecord.LastName == null ? '' : 
                                                      usrRecord.LastName), Title__c = usrRecord.Title, 
                                                     Company_Name__c = usrRecord.CompanyName, 
                                                     Email__c = usrRecord.Email, 
                                                     Phone__c = usrRecord.Phone, 
                                                     Mobile__c = usrRecord.MobilePhone, 
                                                     Address__c = (usrRecord.Street == null ? '' : usrRecord.Street) 
                                                     + ' ' + 
                                                     (usrRecord.City == null ? '' : usrRecord.City) 
                                                     + ' ' + 
                                                     (usrRecord.State== null ? '' : usrRecord.State) 
                                                     + ' ' + 
                                                     (usrRecord.Country== null ? '' : usrRecord.Country),
                                                    Active__c='Yes'));
                    
                }
                
            }
            
            if(!salesRecord.IsEmpty()){
                //create a queue class InsertSalesRepsInQueueable then pass it the list.
                // insert salesRecord;
                ID jobID = System.enqueueJob(new CreateSalesRepQueueable(salesRecord));
            }
        }
    }
}