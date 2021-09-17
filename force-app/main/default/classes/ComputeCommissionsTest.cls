@isTest
public class ComputeCommissionsTest {
    
     @testSetup static void createData(){

        AcctSeed__Accounting_Variable__c av = 
            new AcctSeed__Accounting_Variable__c(Name = 'Seawin USA',AcctSeed__Type__c = 'GL Account Variable 1');
        insert av;
        
        // Profile pf = [Select Id from profile where Name = 'System Administrator']; 
        Profile pf = [Select Id from profile where Name Like 'Inside Sales%' limit 1];
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer RandomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName = orgId + dateString + RandomId; 
        
        User uu1 = new User(firstname = 'ABC', 
                            lastName = 'XYZ', 
                            email = uniqueName + '@test' + orgId + '.org', 
                            Username = uniqueName + '@test' + orgId + '.org', 
                            EmailEncodingKey = 'ISO-8859-1', 
                            Alias = uniqueName.substring(18, 23), 
                            TimeZoneSidKey = 'America/Los_Angeles', 
                            LocaleSidKey = 'en_US', 
                            LanguageLocaleKey = 'en_US', 
                            ProfileId = pf.Id
                           ); 
        
        insert uu1;
        
        Sales_rep__c sr = new Sales_rep__c();
        sr.Active__c = 'Yes';
        sr.Name = 'John Doe';
        sr.User__c = uu1.id;
        //sr.Price_Level_13_20__c = 4; 
        //sr.Price_Level_1_12__c = 3;
        //sr.Price_Level_21_26__c = 2;
        //sr.Price_Level_27_30__c = 1;
        
        insert sr;
        
        uu1.Sales_Rep_Id__c = sr.id;
        
        update uu1;
        
        // create account
        Account acct = new Account();
        
        acct.Sales_Rep_O__c = sr.id;
        acct.Name = 'myAccount';
        acct.Type = 'Customer';
        acct.AcctSeed__GL_Account_Variable_1__c = av.id;
        
        insert acct;
        
        // create contact
        Contact cont = new Contact();
        
        cont.LastName = 'myLastName';
        cont.AccountId = acct.Id;
        cont.GL_Account_Variable_1__c = av.id;
        
        insert cont;
        
        AcctSeed__GL_Account__c aegl = new AcctSeed__GL_Account__c();
        aegl.name = 'glaccount';
        aegl.AcctSeed__Type__c = 'Expense';
        aegl.AcctSeed__Sub_Type_1__c = 'Facilities';
        aegl.AcctSeed__Sub_Type_2__c = 'Rent';
        aegl.AcctSeed__Bank__c = true;
        aegl.GL_Account_Variable_1__c = av.Id;
        insert aegl;
        
        // Gl account with bank unchecked
        AcctSeed__GL_Account__c ga = new AcctSeed__GL_Account__c();
        ga.Name = 'GL Account Test';
        ga.AcctSeed__Active__c = true;
        ga.AcctSeed__Type__c = 'Revenue';
        ga.AcctSeed__Sub_Type_1__c = 'Product Revenue';
        ga.AcctSeed__Sub_Type_2__c = 'Product Family 1';
        ga.AcctSeed__Bank__c = false;
        
        insert ga;
        
        // create product
        Product2 prod = new Product2();
        
        prod.Name = 'myProduct';
        prod.ProductCode = 'ABC123';
        prod.AcctSeed__Unit_Cost__c = 100;
        prod.IsActive = true;
        prod.AcctSeed__Inventory_Type__c = 'Purchased';
        prod.AcctSeed__Expense_GL_Account__c = ga.id;
        prod.AcctSeed__Inventory_GL_Account__c = ga.id;
        prod.AcctSeed__Revenue_GL_Account__c = ga.id;
        prod.Type__c = 'Product';
        
        insert prod;
        
        // create opportunity
        Opportunity opp = new Opportunity();
        
        opp.Name = 'myOpportunity';
        opp.Sales_Rep_O__c = sr.id;
        opp.AccountId = acct.Id;
        opp.Type = 'Actual Order';
        opp.StageName = 'Closed Won';
        opp.CloseDate = system.today();
        opp.ContactPerson__c = cont.Id;
        opp.GL_Account_Variable_1__c = av.id;
        
        insert opp;
        
        // create pricebook2
        Pricebook2 priceb2 = new Pricebook2();
        
        priceb2.Name = 'myPriceBook';
        priceb2.Description = 'myPBDescription';
        priceb2.IsActive = true;
        //priceb2.IsStandard = true;
        
        insert priceb2;
        
        // insert to standard price book
        Id pricebookId = Test.getStandardPricebookId();
        
        // create standard price book entry
        PricebookEntry pricebentry1 = new PricebookEntry();
        
        pricebentry1.Pricebook2Id = pricebookId;
        pricebentry1.Product2Id = prod.Id;
        pricebentry1.UnitPrice = 100;
        pricebentry1.IsActive = true;
        
        insert pricebentry1;
        
        // create pricebookentry
        PricebookEntry pricebentry2 = new PricebookEntry();
        
        pricebentry2.Pricebook2Id = priceb2.Id;
        pricebentry2.Product2Id = prod.Id;
        pricebentry2.UnitPrice = 100;
        pricebentry2.IsActive = true;
        
        insert pricebentry2;
        
        // create opportunity line item
        
        OpportunityLineItem oli = new OpportunityLineItem();
        
        oli.OpportunityId = opp.Id;
        oli.Product2Id = prod.Id;
        oli.PricebookEntryId = pricebentry2.Id;
        oli.Quantity = 10;
        oli.UnitPrice = 100;
        oli.Description = 'myDescription';
        
        insert oli;
        
        AcctSeed__Billing_Format__c abf = new AcctSeed__Billing_Format__c();
        
        abf.Name = 'Test Format';
        abf.AcctSeed__Type__c = 'Purchase Order';
        abf.AcctSeed__Visualforce_PDF_Page__c = 'BillingActivityStatementPDF';
        abf.AcctSeed__Default_Email_Template__c = 'Activity_Statement_Email_Template';
        
        insert abf;
        
        AcctSeed__Ledger__c ledger = new AcctSeed__Ledger__c();
        
        ledger.Name = 'myLedger';
        ledger.AcctSeed__Type__c = 'Transactional';
        ledger.AcctSeed__Billing_Activity_Statement_Format__c = abf.id;
        ledger.AcctSeed__Billing_Outstanding_Statement_Format__c = abf.id;
        ledger.AcctSeed__Default_Bank_Account__c = aegl.id;
        ledger.AcctSeed__Default_Billing_Format__c = abf.id; 
        ledger.AcctSeed__Default_Purchase_Order_Format__c = abf.id;
        ledger.AcctSeed__Default_Packing_Slip_Format__c = abf.id;
        
        
        insert ledger;
        
        // create a sales order
        AcctSeedERP__Sales_Order__c salesorder = new AcctSeedERP__Sales_Order__c(); 
        
        //salesorder.name = 'testSalesOrder';
        salesorder.AcctSeedERP__Customer__c = acct.Id;
        salesorder.AcctSeedERP__Opportunity__c = opp.Id;
        salesorder.Contact__c = cont.Id;
        salesorder.AcctSeedERP__Status__c = 'Open';
        salesorder.AcctSeedERP__Ledger__c = ledger.id;
        salesorder.GL_Account_Variable_1__c = av.id;
        salesorder.Sales_Rep_O__c = sr.id;
        
        
        insert salesorder;
         
        List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>(); 
        
        AcctSeedERP__Sales_Order_Line__c sol = new AcctSeedERP__Sales_Order_Line__c(); 
        
        sol.AcctSeedERP__Sales_Order__c = salesorder.id;
        sol.AcctSeedERP__Unit_Price__c = 1000;
        sol.AcctSeedERP_Description__c = 'This is salesorder line item';
        sol.AcctSeedERP__Product__c = prod.id;
        sol.AcctSeedERP__Quantity_Ordered__c = 1;
         
        solList.add(sol);
         
        AcctSeedERP__Sales_Order_Line__c sol2 = new AcctSeedERP__Sales_Order_Line__c(); 
        
        sol2.AcctSeedERP__Sales_Order__c = salesorder.id;
        sol2.AcctSeedERP__Unit_Price__c = 500;
        sol2.AcctSeedERP_Description__c = 'This is salesorder line item';
        sol2.AcctSeedERP__Product__c = prod.id;
        sol2.AcctSeedERP__Quantity_Ordered__c = 1;
         
        solList.add(sol2);
        
        insert solList;

		
    }

    @isTEst static void RunTest(){
        
        opportunity opp = [select id from opportunity where name = 'myOpportunity' limit 1];
        
        AcctSeedERP__Sales_Order__c so = [select id, Price_Level__c, Paid_Amount__c, AcctSeedERP__Total__c, 
                                          Sales_Rep_O__c, 
                                          Sales_Rep_O_2__c, Referral_sales_rep__c from 
                                          AcctSeedERP__Sales_Order__c where 
                                          AcctSeedERP__Opportunity__c =: opp.id limit 1];
        
        Test.startTest();
        
        ComputeCommissionsController.IntializeCommissions(new list<AcctSeedERP__Sales_Order__c>{so});
        
        ApexPages.currentPage().getParameters().put('id', so.id);
        System.assert(ComputeCommissionsController.AlreadyPaid != null);
        
		ComputeCommissionsController.FromPage();
        ComputeCommissionsController.back();
  		
        Test.stopTest();
    }
    @isTEst static void AdditionalSalesRep(){
        
        opportunity opp = [select id from opportunity where name = 'myOpportunity' limit 1];
        
        AcctSeedERP__Sales_Order__c so = [select id, Price_Level__c, Paid_Amount__c, 
                                          AcctSeedERP__Total__c, Sales_Rep_O__c, 
                                         Sales_Rep_O_2__c, Referral_sales_rep__c from 
                                          AcctSeedERP__Sales_Order__c where 
                                          AcctSeedERP__Opportunity__c =: opp.id limit 1];
        
        SAles_rep__c sales = new Sales_rep__c(name='sales rep 2', email__c='abc@email.com', 
                                              user__c = UserInfo.getUserId(),
                                              Price_Level_13_20__c = 4, Price_Level_1_12__c = 3, 
                                               Price_Level_21_26__c = 2, Price_Level_27_30__c = 1);
        
        insert sales;
        
        so.Sales_Rep_O_2__c = sales.id;
        
        update so;
        
        Test.startTest();
        
        ComputeCommissionsController.IntializeCommissions(new list<AcctSeedERP__Sales_Order__c>{so});
        
        ApexPages.currentPage().getParameters().put('id', so.id);

        System.assert(ComputeCommissionsController.AlreadyPaid != null);
        
		ComputeCommissionsController.FromPage();
        ComputeCommissionsController.back();
  		
        Test.stopTest();
    }
}