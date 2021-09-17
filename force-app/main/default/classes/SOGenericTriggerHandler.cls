public class SOGenericTriggerHandler {
    
    public static void SalesRepTeamAccessibility(List<AcctSeedERP__Sales_Order__c> olddata, List<AcctSeedERP__Sales_Order__c> newdata){
        
        Boolean UpdateSRep = false;
        integer i = 0;
        Set<id> SOIds = new Set<id>();
        Map<id, id> SOId2SrepId2BDeltdMap = new Map<id, id>();//Old Srep id's that needs to be deleted
        Map<id, Set<id>> SOIds2UsrIds2BCreateddMap = new Map<id, Set<id>>();//New Users with id's that needs to be created
        
        Map<id, id> SOId2SrepId2BCreatdMap = new Map<id, id>();//New Srep id's that needs to be created
        
        for(AcctSeedERP__Sales_Order__c n : newdata){
            SOIds.add(n.Id);
            if (n.Sales_Rep_O__c !=olddata[i].Sales_Rep_O__c){
                UpdateSRep = true;
                SOId2SrepId2BDeltdMap.put(olddata[i].Id, olddata[i].Sales_Rep_O__c);
                SOId2SrepId2BCreatdMap.put(n.Id, n.Sales_Rep_O__c);
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
                if(!SOId2SrepId2BDeltdMap.isEmpty()){
                    List<Sales_Rep__c> srepListOld = [select id, Team__c from Sales_Rep__c
                                                      where id in: SOId2SrepId2BDeltdMap.values() ];
                    
                    List<Sales_Rep__c> srepListNew = [select id, Team__c from Sales_Rep__c
                                                      where id in: SOId2SrepId2BCreatdMap.values() ];
                    
                    Set<Id> UsersIdsWOAdminSet;
                    String teamStr;
                    
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
                    
                    
                  /*  List<OpportunityShare> OppSharingAccess2BDeltd =  [select id, UserOrGroupId,OpportunityId
                                                                       from OpportunityShare
                                                                       where UserOrGroupId in : UsersIdsWOAdminSet
                                                                       and OpportunityId in : SOIds];
                    delete OppSharingAccess2BDeltd;
                    */
                    
                    String query = 'select id from OpportunityShare ';
                    query += 'where UserOrGroupId in : UsersIdsWOAdminSet ';
                    query += 'and OpportunityId in : SOIds';
                    
                    List<Sobject> oppAccessList2BeDeltd = Database.query(query);
                    delete oppAccessList2BeDeltd;
                    
                    
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
                        for(id key : SOId2SrepId2BCreatdMap.keyset()){
                            if(SOId2SrepId2BCreatdMap.get(key) == sr.Id){
                                SOIds2UsrIds2BCreateddMap.put(key, UsersIdsWOAdminSet);
                            }
                        }
                    }
                    
                    
                    List<sObject> soAccessList2BCreated = new List<sObject>();
                    
                    for(Id key : SOIds2UsrIds2BCreateddMap.keyset()){
                        
                        Set<id> users = new Set<id>();
                        users = SOIds2UsrIds2BCreateddMap.get(key);
                        for(id u : users){
                            sObject soAccess = Schema.getGlobalDescribe().get('AcctSeedERP__Sales_Order__Share').newSObject();
                            soAccess.put('ParentID', key) ;//was working with ParentID field
                            soAccess.put('AccessLevel', 'Edit') ;//was working with AccessLevel field
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