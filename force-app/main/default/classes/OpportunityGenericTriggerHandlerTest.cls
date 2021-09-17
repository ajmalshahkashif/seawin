@isTest
public class OpportunityGenericTriggerHandlerTest {
    
    
    @testSetup static void createData(){
        
        //UserRole role = new UserRole();
        //role.Name = 'role1';
        //role.DeveloperName = 'CEO2';
        //insert role;
        
        //Profile pf = [Select Id from profile where Name = 'China Inside Sales Rep']; 
        Profile pf = [Select Id from profile where Name = 'System Administrator']; 
        //Profile pf = [Select Id from profile where Name = 'Sales Rep'];
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName = orgId + dateString + RandomId; 
        
        AcctSeed__Accounting_Variable__c accVar = new AcctSeed__Accounting_Variable__c();
        accVar.Name = 'GL acc var1';
        accVar.AcctSeed__Type__c = 'GL Account Variable 1';
        insert accVar;
        
        Account acct = new Account();
        //acct.Sales_Rep_O__c = sr.id;
        acct.Name = 'myAccount';
        acct.Type = 'Designer';
        acct.AcctSeed__Accounting_Type__c = 'Customer';
        acct.AcctSeed__GL_Account_Variable_1__c = accVar.Id;
        insert acct;
        
        Contact cont = new Contact();
        cont.LastName = 'myLastName';
        cont.AccountId = acct.Id;
        cont.LeadSource = 'AAOHA 2020';
        cont.GL_Account_Variable_1__c = accVar.Id;
        insert cont;
        
        
        
        User usr = new User();
        usr.LastName = 'alias158';
        usr.Alias = 'alias158';
        usr.Email = 'user1@gmail.com';
        usr.Username = 'user158@gmail.com';
        usr.CommunityNickname = 'commnickname1';
        usr.ProfileId = pf.id;
        //insert usr;
        
        
        String u = usr.id;
        
        Sales_Rep__c sr = new Sales_Rep__c();
        sr.Name = 'sr1';
        sr.Company_Name_Lookup__c = acct.id;
        sr.Email__c = 'sr1@gmail.com';
        sr.GL_Account_Variable_to_Sales_Rep__c = accVar.id;
        sr.Active__c = 'Yes';
        sr.IsTeam__c = true;
        sr.Team__c = '0051I000007Qwri;0051I000007Qwri';
        insert sr;
        
        Sales_Rep__c sr2 = new Sales_Rep__c();
        sr2.Name = 'sr1';
        sr2.Company_Name_Lookup__c = acct.id;
        sr2.Email__c = 'sr1@gmail.com';
        sr2.GL_Account_Variable_to_Sales_Rep__c = accVar.id;
        sr2.Active__c = 'Yes';
        sr2.IsTeam__c = true;
        sr2.Team__c = '0051I000007Qwri;0051I000007Qwri';
        insert sr2;
        
        Opportunity opp = new Opportunity();  
        opp.Name = 'myOpportunity';
        //opp.Sales_Rep_O__c = sr.id;
        opp.AccountId = acct.Id;
        opp.Type = 'Actual Order';
        opp.StageName = 'Follow up';
        opp.CloseDate = system.today();
        opp.ContactPerson__c = cont.Id;
        opp.GL_Account_Variable_1__c = accVar.Id;
        opp.Run_Validation_Rule__c = true;
        opp.Sales_Rep_O__c = sr.id;
        insert opp;
        
        opp.Sales_Rep_O__c= sr2.Id;
        update opp;
    }
    
    @isTest static void StartProcess(){
        Opportunity opp = [select id,Name
                           from opportunity where name='myOpportunity' limit 1];
        
    }
    
}