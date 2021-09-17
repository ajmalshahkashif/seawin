public with sharing class Testing {

    public Testing() {

        /*
        /// Payment Terms
        List<Account> accListToUpdate = new List<Account>();
        for(Account acc : [Select Id, AcctSeed__Billing_Terms_Name__c from Account Where AcctSeed__Billing_Terms_Name__c like '%delivery%']){
            if(acc.AcctSeed__Billing_Terms_Name__c != null){
                String s1 = acc.AcctSeed__Billing_Terms_Name__c;
                String target = 'delivery';
                String replacement = 'shipment';
                String s2 = s1.replace(target, replacement);
                acc.AcctSeed__Billing_Terms_Name__c = s2;
                accListToUpdate.add(acc);
            }
        }
        database.executeBatch(new updatebatchable(accListToUpdate), 200);
        */


        /// GL_Account_Variable_to_Sales_Rep__c
        /*
        List<Sales_Rep__c> srList = new List<Sales_Rep__c>([SELECT Id, Name, GL_Account_Variable_to_Sales_Rep__c, Default_Record_Type__c, team__c FROM Sales_Rep__c Where GL_Account_Variable_to_Sales_Rep__c = null]);
        for(Sales_Rep__c sr :srList){

            if(string.isNotEmpty(sr.Default_Record_Type__c)){

                if(sr.Default_Record_Type__c.contains('USA')){
                    sr.GL_Account_Variable_to_Sales_Rep__c = 'a0A1I000002RthzUAC';
                }
                else if(sr.Default_Record_Type__c.contains('China')){
                    sr.GL_Account_Variable_to_Sales_Rep__c = 'a0A1I000002Rti4UAC';
                }
            }
        }
        update srList;
        */


        /// Newly_Submitted_Quote_First_Date__c
        /*
        List<Opportunity> opportunitiesListToUpdate = new List<Opportunity>();
        for(Opportunity oppty : [SELECT Id, Newly_Submitted_Quote_First_Date__c, LeadSource, owner.name, 
                                (Select Status, Quote_Date__c From Quotes Where Status = 'Presented' Order By CreatedDate Asc Limit 1) 
                                From Opportunity Where Newly_Submitted_Quote_First_Date__c = null]){
            for(Quote qt : oppty.Quotes){
                oppty.Newly_Submitted_Quote_First_Date__c = qt.Quote_Date__c;
                opportunitiesListToUpdate.add(oppty);
            }
        }
        database.executeBatch(new updatebatchable(opportunitiesListToUpdate), 50);
        */


    }
}