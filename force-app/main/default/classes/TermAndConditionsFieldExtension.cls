public class TermAndConditionsFieldExtension {
    
    Public Id QuoteId {get; set;} 
    Public Quote Qt {get; set;}
    public Boolean startTheCall {get; set;}
    
    public TermAndConditionsFieldExtension(apexpages.StandardController std){
        
        QuoteId = (Id)std.getId();
        
        startTheCall = false;
        
        Qt = [select id, 
              deposit_and_payments__c,
              Account.AcctSeed__Billing_Terms_Name__c,
              Opportunity.Billing_Terms_Name__c from 
              Quote where id =: QuoteId limit 1];

    }
    
    public void PopulateField(){
        
        QuoteTemplateStyle__c styl = QuoteTemplateStyle__c.getValues('Styles');
        
        String termsTxt = String.isNotEmpty(Qt.Opportunity.Billing_Terms_Name__c) ?
            Qt.Opportunity.Billing_Terms_Name__c : Qt.Account.AcctSeed__Billing_Terms_Name__c;
        
        String txt = '';
        txt += '<p style="font-size: '+styl.font__c+'; margin-top: '+styl.margin__c+
            '">This Order is subject to the following payment terms: ' + termsTxt;
        txt += '. If there is a deposit, it will remain as a credit on the account until the final payment for the order ';
        txt += 'and associated shipping change order is complete. In the event customer requires special payment ';
        txt += 'arrangement must be notified before '; 
        txt += 'order confirmation. Order is placed on Hold until if required deposit or prepayment are made. If '; 
        txt += 'progress or balance payments are not made on time, applicable late fees 1% per week will be applied.</p>';
        
        Boolean runUpdate = qt.Deposit_and_Payments__c != txt ? true : false;

        if(runUpdate) qt.Deposit_and_Payments__c = txt;
        
        try{
            if(runUpdate) update qt;
        }catch(Exception ex){
            system.debug(ex.getMessage());
        }      
    }
    
    public void init(){
        
        startTheCall = true;
    }
}