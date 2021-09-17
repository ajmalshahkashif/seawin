@isTest
public class TermAndConditionsFieldExtensionTest {

    @testSetup static void createData(){

        AcctSeed__Accounting_Variable__c av = new AcctSeed__Accounting_Variable__c(
            Name = 'Seawin USA',AcctSeed__Type__c = 'GL Account Variable 1');
        
        insert av;

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.CloseDate = Date.today() + 7;
        opp.StageName = 'Analysis';
        opp.GL_Account_Variable_1__c = av.id;

        insert opp;

        Quote qt = new Quote();

        qt.Name = 'Test Quote';
        qt.OpportunityId = opp.id;
        qt.ExpirationDate = Date.today() + 7;
        qt.Quote_Date__c = Date.today();

        insert qt;
    }
    
    @isTest static void TermAndConditions(){
        
        QuoteTemplateStyle__c styl = new QuoteTemplateStyle__c(name='Styles', Margin__c='2px', font__c='13px');
        
        insert styl;

        quote qt = [select id 
                    from Quote where Name = 'Test Quote' limit 1];

        Test.startTest();
        
        ApexPages.StandardController std = new ApexPages.StandardController(qt);
        
        TermAndConditionsFieldExtension tandc = new TermAndConditionsFieldExtension(std);

        tandc.PopulateField();

        Test.stopTest();
        
    }
}