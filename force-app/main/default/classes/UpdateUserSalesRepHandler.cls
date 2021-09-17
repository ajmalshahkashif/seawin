public class UpdateUserSalesRepHandler {
    
    public static void UpdateUser(List<Sales_Rep__c> oldData, List<Sales_Rep__c> newData){
        
        Map<Id, String> userSalesRepMap = new map<Id, String>();
        if(!oldData.IsEmpty()){

            Integer i = 0;
            for(Sales_rep__c srNew : newData){

                if(srNew.User__c != oldData[i].User__c){
                    userSalesRepMap.put((srNew.User__c == null) ? oldData[i].User__c : srNew.User__c, srNew.Id);
                }

                if(srNew.Team__c != oldData[i].Team__c){

                    //For populating new user Ids
                    Set<Id> newUserIds = getUserIdsInSetFromString(srNew.Team__c);
                    for(Id uId : newUserIds){
                        userSalesRepMap.put(uId, srNew.Id);
                    }

                    //for populating old user Ids
                    Set<Id> oldUserIds = getUserIdsInSetFromString(oldData[i].Team__c);
                    for(Id uId : newUserIds){
                        if(!userSalesRepMap.containsKey(uId)){
                            userSalesRepMap.put(uId, srNew.user__c);
                        }
                    }
                }
                i++;
            }
            
        }else{
            
            for(Sales_rep__c srNew : newData){

                if(srNew.User__c != null){
                    userSalesRepMap.put(srNew.User__c, srNew.Id);
                } 
                
                //For populating new user Ids
                Set<Id> newUserIds = getUserIdsInSetFromString(srNew.Team__c);
                for(Id uId : newUserIds){
                    userSalesRepMap.put(uId, srNew.Id);
                }   
            }
        }

        
        
        if(userSalesRepMap.size() > 0){
            FinallyUpdateUser(userSalesRepMap);
        }    
    }
    

    public static Set<Id> getUserIdsInSetFromString(String teamUserString){

        system.debug('teamUserString === ' + teamUserString);
        Set<Id> teamUserSet = new Set<Id>();
        if(String.isNotEmpty(teamUserString)){
            List<Id> teamUserList = teamUserString.split(';');
            for(String val : teamUserList){
                teamUserSet.add(val);
            }
        }

        system.debug('teamUserSet === ' + teamUserSet);
        return teamUserSet;
    }
    

    @future
    public static void FinallyUpdateUser(Map<Id, String> userSalesRepMap){
        
        // get all users to update
        List<User> users = [select id, sales_rep_id__c from user where id in:userSalesRepMap.keyset()];
        if(!users.isEmpty()){
            
            for(user usr : users){
                Id salesRepId = null;
                salesRepId = userSalesRepMap.get(usr.id);
                usr.sales_rep_id__c = salesRepId;
            }
            
            update users;
        }
    }

}