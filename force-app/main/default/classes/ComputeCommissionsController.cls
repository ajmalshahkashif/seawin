public class ComputeCommissionsController {
    
    public static string soId {get; set;}
    
    public static boolean AlreadyPaid {    
        get{
            if(AlreadyPaid == null){
                AlreadyPaid = false;
            }
            
            return AlreadyPaid;
        } 
        set;}
    
    public static PageReference Back(){
        return null;
    }
    
    public static PageReference FromPage(){
        
        soId = ApexPages.currentPage().getParameters().get('id');
        
        PageReference page = null;
        
        AcctSeedERP__Sales_Order__c so = [select id, Price_Level__c from AcctSeedERP__Sales_Order__c
                                          where id =:soId limit 1];
        
        list<sales_order_commissions__c> TotalCommissions = [select id, sales_order__c from 
                                                             Sales_Order_Commissions__c where 
                                                             sales_order__c =:so.id];
        /*
        list<sales_order_commissions__c> PaidCommissions = [select id, sales_order__c from 
                                                            Sales_Order_Commissions__c where 
                                                            sales_order__c =:so.id and comission_paid__c = true];
        
        if(!TotalCommissions.isEmpty() && !PaidCommissions.isEmpty()){
            
            if(TotalCommissions.size() == PaidCommissions.size()){
                
                AlreadyPaid = true;
                return null;
            } 
        }
        */
        
        
        IntializeCommissions(new list<AcctSeedERP__Sales_Order__c>{so});
        
        page = new PageReference('/' + so.Id);
        
        page.setRedirect(true);
        
        return page;
    }
    
    @InvocableMethod
    public static void IntializeCommissions(list<AcctSeedERP__Sales_Order__c> data){
        
        set<id> soIds = new set<id>();
        
        for(AcctSeedERP__Sales_Order__c so : data){
            if(so.Price_Level__c != null){
                soIds.add(so.id);
            }
        }
        
        map<Id, list<AcctSeedERP__Sales_Order_Line__c>> OrderMap = 
            new map<Id, list<AcctSeedERP__Sales_Order_Line__c>>(); 
        
        if(soIds.size() > 0){
            
            list<AcctSeedERP__Sales_Order_Line__c> lines = null;
            for(AcctSeedERP__Sales_Order_Line__c Line : 
                [select Id, AcctSeedERP__Sales_Order__c, 
                 AcctSeedERP__Total__c,
                 AcctSeedERP__Sales_Order__r.Paid_Amount_Formula__c,
                 AcctSeedERP__Sales_Order__r.Price_Level__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O__r.Price_Level_1_12__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O__r.Price_Level_13_20__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O__r.Price_Level_21_26__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O__r.Price_Level_27_30__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__r.Price_Level_1_12__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__r.Price_Level_13_20__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__r.Price_Level_21_26__c,
                 AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__r.Price_Level_27_30__c,
                 AcctSeedERP__Sales_Order__r.AcctSeedERP__Total__c,
                 AcctSeedERP__Sales_Order__r.Referral_Sales_Rep__c from 
                 AcctSeedERP__Sales_Order_Line__c where 
                 AcctSeedERP__Sales_Order__c 
                 in:soIds]){
                     
                     if(OrderMap.containsKey(Line.AcctSeedERP__Sales_Order__c)){
                         list<AcctSeedERP__Sales_Order_Line__c> exists = 
                             OrderMap.get(Line.AcctSeedERP__Sales_Order__c); 
                         exists.add(line);
                         OrderMap.Put(Line.AcctSeedERP__Sales_Order__c, exists);
                     }else{
                         lines = new list<AcctSeedERP__Sales_Order_Line__c>{line};
                             OrderMap.Put(Line.AcctSeedERP__Sales_Order__c, lines);
                     }
                 }
        }
        
        if(OrderMap.size() > 0){
            
            list<Sales_Order_Commissions__c> Insertables = new list<Sales_Order_Commissions__c>();
            
            for(string key : OrderMap.keyset()){
                
                List<AcctseedERP__Sales_Order_Line__c> Lines = OrderMap.get(key);
                
                Insertables.AddAll(CalculateCommissions(Lines));
                
            }
            
            SavePoint sp = Database.setSavepoint();
            
            try{
                delete [select id from Sales_Order_Commissions__c where 
                        sales_order__c in:soIds];
                
                if(!Insertables.isEmpty()){insert Insertables;
                }
                
            }catch(Exception ex){
                Database.rollback(sp);
                
                system.debug(ex.getMessage());
            }
        }
    }
    
    public static list<Sales_Order_Commissions__c> 
        CalculateCommissions(list<Acctseederp__sales_order_Line__c> Lines){
            
            list<Sales_Order_Commissions__c> Commissions = new list<Sales_Order_Commissions__c>();
            
            Sales_Order_Commissions__c Commission = null;
            
            Id soId = null;
            Boolean isChecked = false;
            Boolean hasFullReps = false;
            Decimal salesRep1Commission = 0;
            Decimal SalesRep2Commission = 0;
            Decimal SalesRep1Percent = 0;
            Decimal SalesRep2Percent = 0;
            
            Id SalesRep1Id = null;
            Id SalesRep2Id = null;
            Boolean onlyFirstTime = true; // Just to make sure that TotalAmt is calculated time only. Not everytime
            for(AcctSeedERP__Sales_Order_Line__c Line : Lines){
                
                // Sales order Id
                if(soId == null){
                    
                    soId = Line.AcctSeedERP__Sales_Order__c;
                }
                
                // Primary Sales Rep Id
                if(SalesRep1Id == null && Line.AcctSeedERP__Sales_Order__r.Sales_Rep_O__c != null){
                    SalesRep1Id = Line.AcctSeedERP__Sales_Order__r.Sales_Rep_O__c;
                }
                
                // Secondary Sales Rep Id
                if(SalesRep2Id == null && Line.AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__c != null){
                    
                    SalesRep2Id = Line.AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__c;
                }
                
                // Both Sales Rep are present
                if(line.AcctSeedERP__Sales_Order__r.Sales_Rep_O__c != null && 
                   line.AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__c != null && !hasFullReps){
                       
                       hasFullReps = true;
                   }
                
                // Price Level percentage
                if(SalesRep1Percent == 0 && line.AcctSeedERP__Sales_Order__r.Sales_Rep_O__c != null){
                    
                    Integer priceLevel = Integer.ValueOf(line.AcctSeedERP__Sales_Order__r.Price_Level__c.split(' ')[1]);
                    
                    SalesRep1Percent = (priceLevel >= 1 && priceLevel <= 12) ? 
                        line.AcctSeedERP__Sales_Order__r.Sales_Rep_O__r.Price_Level_1_12__c : 
                    (priceLevel >= 13 && priceLevel <= 20) ? 
                        line.AcctSeedERP__Sales_Order__r.Sales_Rep_O__r.Price_Level_13_20__c : 
                    (priceLevel >= 21 && priceLevel <= 26) ? 
                        line.AcctSeedERP__Sales_Order__r.Sales_Rep_O__r.Price_Level_21_26__c : 
                    line.AcctSeedERP__Sales_Order__r.Sales_Rep_O__r.Price_Level_27_30__c; 
                }
                
                // Price Level percentage
                if(SalesRep2Percent == 0 && line.AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__c != null){
                    
                    Integer priceLevel = Integer.ValueOf(line.AcctSeedERP__Sales_Order__r.Price_Level__c.split(' ')[1]);
                    
                    SalesRep2Percent = (priceLevel >= 1 && priceLevel <= 12) ? 
                        line.AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__r.Price_Level_1_12__c : 
                    (priceLevel >= 13 && priceLevel <= 20) ? 
                        line.AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__r.Price_Level_13_20__c : 
                    (priceLevel >= 21 && priceLevel <= 26) ? 
                        line.AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__r.Price_Level_21_26__c : 
                    line.AcctSeedERP__Sales_Order__r.Sales_Rep_O_2__r.Price_Level_27_30__c; 
                }
                
                // ------------------- Recalculate Total based on Finders Fee Sales Rep availability -------- //
                Decimal TotalAmt = 0;  
                
                System.debug('Line Total: ' + Line.AcctSeedERP__Total__c);
                System.debug('Line Total: ' + Line.AcctSeedERP__Sales_Order__r.Paid_Amount_Formula__c);
                if(Line.AcctSeedERP__Sales_Order__r.Referral_Sales_Rep__c != null){Referral_Fee__c fee = Referral_Fee__c.getOrgDefaults();
                    
                    // subtract the finders fee from total
                    if(onlyFirstTime){
                        TotalAmt = Line.AcctSeedERP__Sales_Order__r.Paid_Amount_Formula__c - 
                            ((Line.AcctSeedERP__Sales_Order__r.Paid_Amount_Formula__c * fee.Percentage__c) / 100);
                        onlyFirstTime = false;
                    }
                }else{
                    if(onlyFirstTime){
                        TotalAmt = Line.AcctSeedERP__Sales_Order__r.Paid_Amount_Formula__c;
                        onlyFirstTime = false;
                    }
                }
                
                
                if(SalesRep1Percent != 0 && SalesRep1Percent != null){ salesRep1Commission += (hasFullReps) ? (TotalAmt * (SalesRep1Percent/100)) / 2 :
                    TotalAmt * (SalesRep1Percent/100);
                } 
                if(SalesRep2Percent != 0 && SalesRep2Percent != null){
                    salesRep2Commission += (hasFullReps) ? (TotalAmt * (SalesRep2Percent/100)) / 2 : TotalAmt * (SalesRep2Percent/100);
                }
            }
            
            // Primary Sales Rep Id
            if(SalesRep1Id != null && salesRep1Commission != 0){Commission = new Sales_Order_Commissions__c();
                //Commission.Comission_Paid__c = isChecked;
                Commission.Commission_Amount__c = salesRep1Commission;
                // Commission.Commission_Paid_Date__c = null;
                Commission.Sales_Order__c = soId;
                Commission.Sales_Rep__c = SalesRep1Id;
                
                Commissions.add(Commission);
            }
            
            // Secondary Sales Rep Id
            if(SalesRep2Id != null && salesRep2Commission != 0){Commission = new Sales_Order_Commissions__c();
                
                //Commission.Comission_Paid__c = isChecked;
                Commission.Commission_Amount__c = salesRep2Commission;
                //Commission.Commission_Paid_Date__c = null;
                Commission.Sales_Order__c = soId;
                Commission.Sales_Rep__c = SalesRep2Id;
                
                Commissions.add(Commission);
            }
            
            return Commissions;
        }
}