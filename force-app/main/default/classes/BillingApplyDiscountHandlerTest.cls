@isTest
public class BillingApplyDiscountHandlerTest {
    
    @testSetup static void createBillingData(){

        AcctSeed__Accounting_Variable__c av = new AcctSeed__Accounting_Variable__c();
        av.Name = 'GL acc var1';
        av.AcctSeed__Type__c = 'GL Account Variable 1';
        insert av;

        Date dt = date.today();

        AcctSeed__Accounting_Period__c ap = new AcctSeed__Accounting_Period__c();
        ap.name =
        dt.year() +
        '-' +
        ((dt.month() < 10) ? '0' + dt.month() : String.ValueOf(dt.month()));
        ap.AcctSeed__Start_Date__c = Date.today() - (dt.day() - 1);
        ap.AcctSeed__End_Date__c = Date.today() + 28;
        ap.AcctSeed__Status__c = 'Open';
        insert ap;

        
        // create account
        Account acct = new Account();

        acct.Name = 'myAccount';
        acct.Type = 'Customer';
        acct.acctseed__gl_account_variable_1__c = av.id;
        acct.AcctSeed__Billing_Discount_Percent__c = 5;
        acct.AcctSeed__Billing_Discount_Days_Due__c = 7;
        acct.AcctSeed__Billing_Terms_Name__c = 'Test terms';
        
        insert acct;

        
        AcctSeed__GL_Account__c gl = new AcctSeed__GL_Account__c();
        gl.name = 'glaccount';
        gl.AcctSeed__Type__c = 'Expense';
        gl.AcctSeed__Sub_Type_1__c = 'Facilities';
        gl.AcctSeed__Sub_Type_2__c = 'Rent';
        gl.AcctSeed__Bank__c = true;
        gl.gl_account_variable_1__c = av.id;
        
        insert gl;
        

        AcctSeed__Billing_Format__c format = new AcctSeed__Billing_Format__c();
        
        format.Name = 'newPDF Format';
        format.AcctSeed__Type__c = 'Purchase Order';
        format.AcctSeed__Visualforce_PDF_Page__c = 'BillingActivityStatementPDF';
        format.AcctSeed__Default_Email_Template__c = 'Activity_Statement_Email_Template';
        
        insert format;
        
        AcctSeed__Ledger__c ledger = new AcctSeed__Ledger__c();
        
        ledger.Name = 'myLedger';
        ledger.AcctSeed__Type__c = 'Transactional';
        ledger.AcctSeed__Billing_Activity_Statement_Format__c = format.id;
        ledger.AcctSeed__Billing_Outstanding_Statement_Format__c = format.id;
        ledger.AcctSeed__Default_Bank_Account__c = gl.id;
        ledger.AcctSeed__Default_Billing_Format__c = format.id; 
        ledger.AcctSeed__Default_Purchase_Order_Format__c = format.id;
        ledger.AcctSeed__Default_Packing_Slip_Format__c = format.id;
        
        
        insert ledger;

        // Gl account with bank unchecked
        AcctSeed__GL_Account__c ga = new AcctSeed__GL_Account__c();
        ga.Name = 'GL Account Test';
        ga.AcctSeed__Active__c = true;
        ga.AcctSeed__Type__c = 'Revenue';
        ga.AcctSeed__Sub_Type_1__c = 'Product Revenue';
        ga.AcctSeed__Sub_Type_2__c = 'Product Family 1';
        ga.AcctSeed__Bank__c = false;
        ga.gl_account_variable_1__c = av.id;
        
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
        
        insert prod;
        
        // insert to standard price book
        Id pricebookId = Test.getStandardPricebookId();
        
        // create standard price book entry
        PricebookEntry pricebentry = new PricebookEntry();
        
        pricebentry.Pricebook2Id = pricebookId;
        pricebentry.Product2Id = prod.Id;
        pricebentry.UnitPrice = 100;
        pricebentry.IsActive = true;
        
        insert pricebentry;
        
        AcctSeed__Billing__c bill = new AcctSeed__Billing__c();
        
        bill.AcctSeed__Status__c = 'Approved';
        bill.AcctSeed__PDF_Email_Status__c = 'Unsent';
        bill.AcctSeed__Billing_Format__c = format.id;
        bill.AcctSeed__Date__c = Date.Today();
        bill.AcctSeed__Due_Date2__c = Date.Today();
        bill.AcctSeed__Ledger__c = ledger.id;
        bill.AcctSeed__Customer__c = acct.id;
        bill.AcctSeed__Accounting_Period__c = ap.id;

        insert bill;
        
        AcctSeed__Billing_Line__c bline = new AcctSeed__Billing_Line__c();
        bline.AcctSeed__Billing__c = bill.id;
        bline.AcctSeed__Date__c = date.today();
        bline.AcctSeed__Hours_Units__c = 1;
        bline.AcctSeed__Product__c = prod.id;
        bline.AcctSeed__Rate__c = 1;
        bline.Item_Description__c = 'test description';
        
        insert bline;
        
    }
    
    @isTest static void BillingProcess(){
		
        
        AcctSeed__Billing__c bill = [select id, acctseed__discount_percent__c from 
                                    AcctSeed__Billing__c];
        
        bill.acctseed__discount_percent__c = 10;
        
        Test.startTest();
        update bill;
        Test.stopTest();
        
    }
}