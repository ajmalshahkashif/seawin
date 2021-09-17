public class OpportunityGenericTriggerHandler {
    
    public static void SalesRepTeamAccessibilityAfterInsert(List<Opportunity> newdata){
        
        List<Profile> adminPrfiles = ([select id from Profile
                                       where name = 'System Administrator' ]);
        Set<id> adminProfilesIds = new Set<id>();
        for(Profile prf : adminPrfiles)
            adminProfilesIds.add(prf.id);
        
        Set<Id> oppIdsCreated = new Set<Id>();
        Set<id> SRepIds2BGivenAccess = new Set<id>();
        
        for(Opportunity opp : newdata){
            oppIdsCreated.add(opp.id);
            SRepIds2BGivenAccess.add(opp.Sales_Rep_O__c);
        }
        
        List<Sales_Rep__c> srepList = new List<Sales_Rep__c>();   
        srepList = [select id, team__c
                    from Sales_Rep__c
                    where id in : SRepIds2BGivenAccess];
        
        System.debug('srepList: ' + srepList);
        
        List<id> userIds = new List<id>();
        Set<id> UsersIdsList = new Set<id>();
        for(Sales_Rep__c sr : srepList){
            if(sr.Team__c != null){
                if(sr.Team__c.contains(';')){
                    userIds =  sr.Team__c.split(';');
                    System.debug('userIds: ' + userIds);
                    for(Id i : userIds){
                        if(!adminProfilesIds.contains(i))
                            UsersIdsList.add(i);
                    }
                }else{
                    if(!adminProfilesIds.contains(sr.Team__c))
                        UsersIdsList.add(sr.Team__c);
                }
            }
        }
        
        System.debug('UsersIdsList: ' + UsersIdsList);
        
        List<sObject> oppAccessList = new List<sObject>();
        
        try{
            if(!UsersIdsList.IsEmpty() ){
                for(id oppId : oppIdsCreated){
                    
                    for(Id uId : UsersIdsList){
                        
                        sObject sObj = Schema.getGlobalDescribe().get('OpportunityShare').newSObject();
                        sObj.put('OpportunityId', oppId) ;
                        sObj.put('OpportunityAccessLevel', 'Edit') ;
                        sObj.put('UserOrGroupId', uId) ;
                        oppAccessList.add(sObj);
                    }            
                }
            }
            
            Database.insert(oppAccessList, false);
        }
        catch(Exception e){
            System.debug('ex on insertion is: ' + e.getMessage());
        }
    }
    
    public static void SalesRepTeamAccessibilityAfterUpdate(List<Opportunity> olddata, List<Opportunity> newdata){
        
        Boolean UpdateSRep = false;
        integer i = 0;
        Set<id> OppIds = new Set<id>();
        Map<id, id> OppId2SrepId2BDeltdMap = new Map<id, id>();//Old Srep id's that needs to be deleted
        Map<id, Set<id>> OppIds2UsrIds2BCreateddMap = new Map<id, Set<id>>();//New Users with id's that needs to be created
        
        Map<id, id> OppId2SrepId2BCreatdMap = new Map<id, id>();//New Srep id's that needs to be created
        
        for(Opportunity n : newdata){
            OppIds.add(n.Id);
            if (n.Sales_Rep_O__c !=olddata[i].Sales_Rep_O__c){
                UpdateSRep = true;
                OppId2SrepId2BDeltdMap.put(olddata[i].Id, olddata[i].Sales_Rep_O__c);
                OppId2SrepId2BCreatdMap.put(n.Id, n.Sales_Rep_O__c);
            }
            i++;
        }
        
        if(UpdateSRep){
            
            
            List<Profile> adminPrfiles = ([select id from Profile
                                           where name = 'System Administrator' ]);
            Set<id> adminProfilesIds = new Set<id>();
            for(Profile prf : adminPrfiles)
                adminProfilesIds.add(prf.id);
            
            
            try{
                if(!OppId2SrepId2BDeltdMap.isEmpty()){
                    List<Sales_Rep__c> srepListOld = [select id, Team__c from Sales_Rep__c
                                                      where id in: OppId2SrepId2BDeltdMap.values() ];
                    
                    List<Sales_Rep__c> srepListNew = [select id, Team__c from Sales_Rep__c
                                                      where id in: OppId2SrepId2BCreatdMap.values() ];
                    
                    Set<Id> UsersIdsWOAdminSet;
                    String teamStr;
                    
                    
                    if(!srepListOld.isEmpty()){
                        for(Sales_Rep__c sr : srepListOld){
                            teamStr = sr.Team__c; 
                            UsersIdsWOAdminSet = new Set<id>();
                            if(teamStr.contains(';')){
                                List<Id> UsersIdsList = new List<Id>();
                                UsersIdsList = teamStr.split(';');
                                for(Id m : UsersIdsList){
                                    if(!adminProfilesIds.contains(m))
                                        UsersIdsWOAdminSet.add(m);
                                }
                            }
                            else{
                                if(!adminProfilesIds.contains(teamStr))
                                    UsersIdsWOAdminSet.add(teamStr);
                            }
                        }
                        
                    }
                    
                    
                    /*  List<OpportunityShare> OppSharingAccess2BDeltd =  [select id, UserOrGroupId,OpportunityId
from OpportunityShare
where UserOrGroupId in : UsersIdsWOAdminSet
and OpportunityId in : OppIds];
delete OppSharingAccess2BDeltd;
*/
                    
                    String myTestString = 'ImplicitChild';
                    String query = 'select id from OpportunityShare ';
                    query += 'where UserOrGroupId in : UsersIdsWOAdminSet ';
                    query += 'and OpportunityId in : OppIds and RowCause !=: myTestString';
                    
                    List<Sobject> oppAccessList2BeDeltd = Database.query(query);
                    delete oppAccessList2BeDeltd;
                    
                    if(!srepListNew.isEmpty()){
                        
                        for(Sales_Rep__c sr : srepListNew){
                            teamStr = sr.Team__c; 
                            UsersIdsWOAdminSet = new Set<id>();
                            if(teamStr.contains(';')){
                                List<Id> UsersIdsList = new List<Id>();
                                UsersIdsList = teamStr.split(';');
                                for(Id m : UsersIdsList){
                                    if(!adminProfilesIds.contains(m))
                                        UsersIdsWOAdminSet.add(m);
                                }
                            }
                            else{
                                if(!adminProfilesIds.contains(teamStr))
                                    UsersIdsWOAdminSet.add(teamStr);
                            }
                            for(id key : OppId2SrepId2BCreatdMap.keyset()){
                                if(OppId2SrepId2BCreatdMap.get(key) == sr.Id){
                                    OppIds2UsrIds2BCreateddMap.put(key, UsersIdsWOAdminSet);
                                }
                            }
                        }
                    }
                    
                    
                    List<sObject> soAccessList2BCreated = new List<sObject>();
                    
                    for(Id key : OppIds2UsrIds2BCreateddMap.keyset()){
                        
                        Set<id> users = new Set<id>();
                        users = OppIds2UsrIds2BCreateddMap.get(key);
                        for(id u : users){
                            sObject soAccess = Schema.getGlobalDescribe().get('OpportunityShare').newSObject();
                            soAccess.put('OpportunityId', key) ;//was working with ParentID field
                            soAccess.put('OpportunityAccessLevel', 'Edit') ;//was working with AccessLevel field
                            soAccess.put('UserOrGroupId', u) ;
                            soAccessList2BCreated.add(soAccess); 
                        }
                        
                    }
                    Database.insert(soAccessList2BCreated, false);
                    
                }
                
            }catch(Exception ex){
                System.debug('ex is : ' + ex.getMessage());
            }
        }
        
    }    
}