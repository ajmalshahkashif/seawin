public class CreateSalesRepQueueable implements Queueable {
    
    list<sales_rep__c> InsertableSalesReps {get; set;}
    
    public CreateSalesRepQueueable(list<sales_rep__c> record){
        
        InsertableSalesReps = record;
    }
    public void execute(QueueableContext context) {
        if(!InsertableSalesReps.isEmpty()){
            
           insert InsertableSalesReps; 
        }        
    }
}