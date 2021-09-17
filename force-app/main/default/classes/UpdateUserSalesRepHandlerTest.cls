@isTest 
public class UpdateUserSalesRepHandlerTest
{
    static testMethod void testMethod1() 
 	{
    

        AcctSeed__Accounting_Variable__c accVar = new AcctSeed__Accounting_Variable__c();
        accVar.Name = 'GL acc var1';
        accVar.AcctSeed__Type__c = 'GL Account Variable 1';
        accVar.Shipping_Header__c = 'test header';
        accVar.Shipping_Footer__c = 'test footer';
        accVar.Shipping_Terms__c = 'test terms';
        
        insert accVar;


        AcctSeed__GL_Account__c aegl = new AcctSeed__GL_Account__c();
        aegl.name = 'glaccount';
        aegl.AcctSeed__Type__c = 'Expense';
        aegl.AcctSeed__Sub_Type_1__c = 'Facilities';
        aegl.AcctSeed__Sub_Type_2__c = 'Rent';
        aegl.AcctSeed__Bank__c = true;
        aegl.GL_Account_Variable_1__c = accVar.Id;
        
        insert aegl;


    	// create account
        Account acct = new Account();
        
        acct.Name = 'myAccount';
        acct.Type = 'Customer';
        acct.AcctSeed__Accounting_Type__c = 'Customer';
        acct.AcctSeed__GL_Account_Variable_1__c = accVar.Id;
        
        insert acct;
        
        // create account
        Account acct2 = new Account();
        
        acct2.Name = 'myAccount2';
        acct2.Type = 'Customer';
        acct2.AcctSeed__Accounting_Type__c = 'Customer';
        acct2.AcctSeed__GL_Account_Variable_1__c = accVar.Id;
        
        insert acct2;
		
        // create contact
        Contact cont = new Contact();
        
        cont.LastName = 'myLastName';
        cont.AccountId = acct.Id;
        
        insert cont;
        
        // create product
        Product2 prod = new Product2();
        
        prod.Name = 'myProduct';
        prod.ProductCode = 'ABC123';
        prod.Description = 'myDescription';
        prod.AcctSeed__Unit_Cost__c = 100;
        prod.IsActive = true;
        prod.Category__c = 'Shower Door';
        prod.Sub_Category__c = 'Single Sliding';
        prod.AcctSeed__Expense_GL_Account__c = aegl.Id;
        prod.AcctSeed__Inventory_GL_Account__c = aegl.Id;
        prod.AcctSeed__Revenue_GL_Account__c = aegl.Id;
        prod.Type__c = 'other';
        
        insert prod;
        
        // create user
        Profile pf = [Select Id from profile where Name = 'System Administrator']; 
        //Profile pf = [Select Id from profile where Name = 'Sales Rep'];
         
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
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
        
		String dateString2 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId2 = Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName2 = orgId + dateString2 + RandomId2; 
        
        User uu2 = new User(firstname = 'ABCd', 
                             lastName = 'XYZ1', 
                             email = uniqueName2 + '@test' + orgId + '.org', 
                             Username = uniqueName2 + '@test' + orgId + '.org', 
                             EmailEncodingKey = 'ISO-8859-1', 
                             Alias = uniqueName2.substring(18, 23), 
                             TimeZoneSidKey = 'America/Los_Angeles', 
                             LocaleSidKey = 'en_US', 
                             LanguageLocaleKey = 'en_US', 
                             ProfileId = pf.Id
                            ); 

        insert uu2;
        
        List<sales_rep__c> srlist = new list<sales_rep__c>();
        
        Sales_rep__c sr = new Sales_rep__c();
        
        sr.Name = 'ABC XYZ';
        sr.User__c = uu1.id;
        sr.Active__c = 'Yes';
        sr.Team__c = uu1.id + ';' + uu2.id;
        
        srlist.add(sr);
        
        // insert sr;
        
        Sales_rep__c sr2 = new Sales_rep__c();
        
        sr2.Name = 'ABCd XYZ1';
        sr2.User__c = uu2.id;
        sr2.Active__c = 'No';
        sr2.Team__c = uu2.id;
        
        // insert sr2;
        // 
        srlist.add(sr2);
        
        insert srlist;
        
        sr.Active__c = 'No';
        sr.Team__c = uu2.id + ';' + uu1.id;
        
        update sr;
        
        sr2.Active__c = 'Yes';
        sr2.User__c = null;
        sr2.Team__c = null;

        //Update srlist;
        
		
    }
}