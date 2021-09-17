public class SalesRepGenericTriggerHandler {
    
    public static Integer SalesRepTeamAccessibilityAfterUpdate(List<Sales_Rep__c> olddata, List<Sales_Rep__c> newdata){
        
        Integer  ownerCount= 0;
        Boolean TeamMembersUpdated = false;
        integer i = 0;
        Set<id> SRepIds = new Set<id>();
        List<id> OlduserIds = new List<id>();
        List<id> NewuserIds = new List<id>();
        Map<id, List<id>> srep2UsersIds2BDeltdMap = new Map<id, List<id>>();
        Map<id, List<id>> srep2UsersIds2BAddedMap = new Map<id, List<id>>();
        List<id> userIds2BDeltdAccessFor = new List<id>();
        
        Set<Id> adminProfilesIds = new Map<id, Profile>([select id from Profile
                                                         where name = 'System Administrator' ]).keyset();       
        for(Sales_Rep__c n : newdata){
            
            if (n.Team__c != olddata[i].Team__c){
                SRepIds.add(n.Id);
                
                if(olddata[i].Team__c.contains(';')){
                    OlduserIds = olddata[i].Team__c.split(';'); // OlduserIds = {u1,u2,u3}
                }else{
                    Id userId = olddata[i].Team__c;
                    
                }
                
                if(n.Team__c.contains(';')){
                    NewuserIds = n.Team__c.split(';'); 			// NewuserIds = {u2,u4}
                }else{
                    Id userId = n.Team__c;
                    NewuserIds.add(userId);
                }
                
                System.debug('OlduserIds: ' + OlduserIds);
                System.debug('NewuserIds: ' + NewuserIds);
                
                
                
                List<id> userIds2BAddedAccessFor = new List<id>();
                for(id u :  OlduserIds ){//u = u3
                    if(!NewuserIds.contains(u)){ //Check if new updated team member has 
                        if(!adminProfilesIds.contains(u))
                            userIds2BDeltdAccessFor.add(u);// userIds2BDeltdAccessFor = {u1,u3}
                    }
                }
                for(id u :  NewuserIds ){//u = u4
                    if(!OlduserIds.contains(u)){
                        if(!adminProfilesIds.contains(u))
                            userIds2BAddedAccessFor.add(u);// userIds2BAddedAccessFor = {u4}
                    }
                }
                
                System.debug('userIds2BDeltdAccessFor: ' + userIds2BDeltdAccessFor);
                System.debug('userIds2BAddedAccessFor: ' + userIds2BAddedAccessFor);
                
                
                if(userIds2BDeltdAccessFor.size() > 0)
                    srep2UsersIds2BDeltdMap.put(n.Id, userIds2BDeltdAccessFor); // srep2UsersIds2BDeltdMap = (srpId, {u1,u3})
                if(userIds2BAddedAccessFor.size() > 0)
                    srep2UsersIds2BAddedMap.put(n.Id, userIds2BAddedAccessFor); // srep2UsersIds2BAddedMap = (srpId, {u4})
                TeamMembersUpdated = true;
            }              
            
            i++;
        }
        
        if(TeamMembersUpdated){
            try{
                
                //Start: Remove or grant access for Opportunities
                List<Opportunity> oppList = [select id, Sales_Rep_O__c,OwnerId
                                             from Opportunity
                                             where Sales_Rep_O__c in: SRepIds];
                System.debug('oppList: ' + oppList);
                Map<Id, Id> OppId2SrepIdMap = new Map<Id, Id>();
                Map<id, List<Id>> OppIds2UserIdsList2BDeltdMap = new Map<id, List<id>>();
                Set<id> OppidsSet = new Set<id>();
                for(Opportunity opp : oppList){
                    OppId2SrepIdMap.put(opp.Id, opp.Sales_Rep_O__c);
                    OppidsSet.add(opp.id);
                }
                
                
                System.debug('OppId2SrepIdMap: ' + OppId2SrepIdMap);
                LIST<SObject> existingOppSharingList = new List<SObject>();
                
                String queryy = 'select id, UserOrGroupId, RowCause from OpportunityShare ';
                queryy += 'where OpportunityId in : OppidsSet ';
                
                List<Sobject> oppShareList = Database.query(queryy);
                
                
                //TODO: check if existing opp sharing have any of the users as owner which also
                //exist in the userIds2BDeltdAccessFor Map
                //which means it needs to be deleted, so throw an error 
                List<id> ExistAsowners = new List<id>();
                for(id ind : userIds2BDeltdAccessFor){
                    for(SObject sob : oppShareList){
                        
                        if((Id)sob.get('UserOrGroupId')  == ind){
                            ExistAsowners.add(ind);
                        }
                    }
                }
                system.debug('oppShareList: ' + oppShareList);
                
                if(ExistAsowners.size() > 0){
                   ownerCount = ExistAsowners.size();
                }else{
                    for(Id srepId : srep2UsersIds2BDeltdMap.keyset()){ // srepId = a1N59000000Gw3wEAC
                        
                        for(Id oppId : OppId2SrepIdMap.keyset()){	   // oppId = 0065900000AwNSFAA3
                            
                            if(srepId == OppId2SrepIdMap.get(oppId)){  // a1N59000000Gw3wEAC == a1N59000000Gw3wEAC
                                OppIds2UserIdsList2BDeltdMap.put(oppId, srep2UsersIds2BDeltdMap.get(srepId));
                            }
                        }    
                    }
                    
                    String rowCauseOpp = 'Manual';
                    String query = 'select id, UserOrGroupId, OpportunityId from OpportunityShare ';
                    query += 'where OpportunityId in : oppList and ';
                    query += 'UserOrGroupId in : userIds2BDeltdAccessFor and RowCause =: rowCauseOpp ';
                    
                    List<Sobject> oppAccessList2BeDeltd = Database.query(query);
                    delete oppAccessList2BeDeltd;
                    
                    List<Sobject> oppAccessList2BCreated = new List<SObject> ();
                    
                    System.debug('srep2UsersIds2BAddedMap: ' + srep2UsersIds2BAddedMap);
                    System.debug('OppId2SrepIdMap: ' + OppId2SrepIdMap);
                    
                    for(Id key : srep2UsersIds2BAddedMap.keyset()){
                        for(Id oppId : OppId2SrepIdMap.keyset()){
                            if(OppId2SrepIdMap.get(oppId) == key){ 
                                List<id> userList = srep2UsersIds2BAddedMap.get(key);
                                System.debug('userList: ' + userList);
                                for(id u : userList){ 
                                    
                                    sObject soAccess = Schema.getGlobalDescribe().get('OpportunityShare').newSObject();
                                    soAccess.put('OpportunityId', oppId) ;
                                    soAccess.put('OpportunityAccessLevel', 'Edit') ;
                                    soAccess.put('UserOrGroupId', u) ;
                                    oppAccessList2BCreated.add(soAccess);
                                }
                                
                            }
                        }
                    }
                    
                    
                    for(Sobject sobj: oppAccessList2BCreated){
                        system.debug('sobj: ' + sobj);
                    }
                    system.debug('oppAccessList2BCreated: ' + oppAccessList2BCreated);
                    
                    insert oppAccessList2BCreated;
                    //End: Remove or grant access for Opportunities
                    
                    
                    
                    
                    
                    
                    //Start: Remove or grant access for Sales Orders
                    List<AcctSeedERP__Sales_Order__c> soList = [select id, Sales_Rep_O__c
                                                                from AcctSeedERP__Sales_Order__c
                                                                where Sales_Rep_O__c in: SRepIds];
                    
                    System.debug('soList: ' + soList.size());
                    Map<Id, Id> SOId2SrepIdMap = new Map<Id, Id>();
                    Map<id, List<Id>> SOIds2UserIdsList2BDeltdMap = new Map<id, List<id>>();
                    
                    for(AcctSeedERP__Sales_Order__c so : soList){
                        SOId2SrepIdMap.put(so.Id, so.Sales_Rep_O__c);
                    }
                    
                    for(Id srepId : srep2UsersIds2BDeltdMap.keyset()){ 
                        
                        for(Id soId : SOId2SrepIdMap.keyset()){	  
                            
                            if(srepId == SOId2SrepIdMap.get(soId)){ 
                                SOIds2UserIdsList2BDeltdMap.put(soId, srep2UsersIds2BDeltdMap.get(srepId));
                            }
                        }    
                    }
                    
                    String rowCauseSO = 'Manual';
                    String querySO = 'select id, UserOrGroupId, ParentID from AcctSeedERP__Sales_Order__Share ';
                    querySO += 'where ParentID in : soList and ';
                    querySO += 'UserOrGroupId in : userIds2BDeltdAccessFor and RowCause =: rowCauseSO ';
                    
                    //TODO: on updation, suppose we are removing some users which are are set as owner 
                    //in some of the associated opportunities. In this case we have to show an error message 
                    // that you can't remove this or these owner b/c it is set as owner in 10Opportunities
                    List<Sobject> soAccessList2BeDeltd = Database.query(querySO);
                    delete soAccessList2BeDeltd;
                    
                    List<Sobject> soAccessList2BCreated = new List<SObject> ();
                    
                    for(Id key : srep2UsersIds2BAddedMap.keyset()){
                        for(Id soId : SOId2SrepIdMap.keyset()){
                            if(SOId2SrepIdMap.get(soId) == key){ 
                                List<id> userList = srep2UsersIds2BAddedMap.get(key);
                                
                                for(id u : userList){ 
                                    
                                    sObject soAccess = Schema.getGlobalDescribe().get('AcctSeedERP__Sales_Order__Share').newSObject();
                                    soAccess.put('ParentID', soId) ;
                                    soAccess.put('AccessLevel', 'Edit') ;
                                    soAccess.put('UserOrGroupId', u) ;
                                    soAccessList2BCreated.add(soAccess);
                                }
                                
                            }
                        }
                    }
                    insert soAccessList2BCreated;
                    //End: Remove or grant access for Sales Orders
                    
                    
                    
                    
                    
                }
            }
            
            catch(Exception ex){
                System.debug('ex is: ' + ex.getMessage());
            }
            
        } 
        return ownerCount;
    }
}