public class UserTriggerHandler {
    
    public static void ProcessIt(List<User> od, List<user> nd){
        
        
        integer i = 0;
        map<id, User> usersMap = new map<id, User>();
        
        for(User u : nd){
            if(u.IsActive != od[i].IsActive){ 
                // if status has changed and equal to false
                usersMap.put(u.id, u);
            }
            i++;
        }
        
        if(usersMap.size() > 0){
            
           UpdateIt(usersMap.keyset());
        }
    }
    
    @future
    public static void UpdateIt(set<id> userIds){
        
        map<id, User> usersMap = new map<id, User>();
        
        List<user> users = [select id, IsActive from user where id in:userIds];
        
        if(!users.isEmpty()){
            
            for(User u : users){ 
                // if status has changed and equal to false
                usersMap.put(u.id, u);
        	}
            
        }
        
        if(usersMap.size() > 0){
        
         List<sales_rep__c> reps = [select id, Active__c, User__c from 
                                       sales_rep__c where user__c 
                                       in:usersMap.keyset()];
            
            if(!reps.isEmpty()){
                
                for(sales_rep__c sr : reps){
                    
                    User usr = usersMap.get(sr.user__c);
                    
                    if(usr == null) continue;
                    
                    sr.active__c = usr.isactive ? 'Yes' : 'No';
                }
                
               try{
                    
                    update reps;
               }catch(Exception ex){
                    
                    system.debug('Error occured...');
                    system.debug(ex.getmessage());
                }
            }
    }
    }
}