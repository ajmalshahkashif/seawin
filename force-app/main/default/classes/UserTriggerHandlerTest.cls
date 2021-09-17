@isTest
public class UserTriggerHandlerTest {
    
    @TestSetup static void createData(){
        
        Profile pf = [Select Id from profile where Name = 'Inside Sales USA'];
         
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName = orgId + dateString + RandomId; 
        
        User usr = new User(firstname = 'ABC', 
                             lastName = 'XYZ', 
                             email = uniqueName + '@test' + orgId + '.org', 
                             Username = uniqueName + '@test' + orgId + '.org', 
                             EmailEncodingKey = 'ISO-8859-1', 
                             Alias = uniqueName.substring(18, 23), 
                             TimeZoneSidKey = 'America/Los_Angeles', 
                             LocaleSidKey = 'en_US', 
                             LanguageLocaleKey = 'en_US', 
                             ProfileId = pf.Id,
                            IsActive = true
                            ); 

        insert usr;
        
        Sales_rep__c rep = new Sales_rep__c(Name=usr.name, User__c=usr.id, Active__c='Yes');
        
        
    }
    
    @isTest static void RunTests(){
        
        User usr = [select id, isactive from user where name='ABC XYZ' limit 1];
        
        usr.IsActive = false;
        
        Test.startTest();
        
        update usr;
        
        Test.stopTest();
        
    }

}