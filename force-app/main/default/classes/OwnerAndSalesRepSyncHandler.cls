public class OwnerAndSalesRepSyncHandler {
    
    public static void Sync(List<Opportunity> o, List<AcctSeedERP__Sales_Order__c> s){
		/*
        if(!o.IsEmpty()){
         
            map<id, Opportunity> opMap = new map<id, Opportunity>(o);
            
            List<Opportunity> oList = [select id, ownerid, sales_rep_o__c, sales_rep_o__r.user__c,sales_rep_o__r.name,
                                       sales_rep_o__r.user__r.isActive from Opportunity where id in:opMap.KeySet()];
            
            List<Opportunity> Updatables = new List<Opportunity>();
            
            for(Opportunity op : oList){
                
                if(op.sales_rep_o__c != null){
                    string SalesRepName = op.sales_rep_o__r.name.toLowercase();
                    
                    if(!SalesRepName.contains('team') && op.Sales_Rep_O__r.User__c != null 
                       && op.Sales_Rep_O__r.User__r.IsActive){
                        
                        op.ownerid = op.sales_rep_o__r.User__c;
                           
                        Updatables.add(op);
                    }
            	}
            }
            
            if(!Updatables.isEmpty()) update Updatables;
        }
        */
        /*
        if(!s.isEmpty()){
            
            map<id, AcctSeedERP__Sales_Order__c> soMap = new map<id, AcctSeedERP__Sales_Order__c>(s);
            
            List<AcctSeedERP__Sales_Order__c> sList = [select id, ownerid, sales_rep_o__c, sales_rep_o__r.user__c,
                                       sales_rep_o__r.user__r.isActive, sales_rep_o__r.name
                                                       from AcctSeedERP__Sales_Order__c where id in:soMap.KeySet()];
            
            List<AcctSeedERP__Sales_Order__c> Updatables = new List<AcctSeedERP__Sales_Order__c>();
            
            for(AcctSeedERP__Sales_Order__c so : sList){
             
                if(so.sales_rep_o__c != null){
                    string SalesRepName = so.sales_rep_o__r.name.toLowercase();
                    
                    if(!SalesRepName.contains('team') && so.Sales_Rep_O__r.User__c != null 
                       && so.Sales_Rep_O__r.User__r.IsActive){
                        
                        so.ownerid = so.sales_rep_o__r.User__c; 
                        Updatables.add(so);
                    }
            	}
            }
            
            if(!Updatables.isEmpty()) Update Updatables;
        }
        */
    }
}