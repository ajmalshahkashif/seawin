public with sharing class ChangeSalesRepExtension {

    List<Account> accountList {get; set;}
    String srId {get; set;}
    public String selected {get; set;}
    public Map<String, User> optionValues {get; set;}
    public boolean OwnerMissing {get; set;}

    public ChangeSalesRepExtension(ApexPages.StandardController std) {
       
        accountList = new List<Account>();
        srId = ApexPages.currentPage().getParameters().get('id');
        optionValues = new Map<String, User>();
    }

    public List<Account> getAccountList(){

        List<Account> accountList = new List<Account>([Select id, name, Sales_Rep_O__c, OwnerId From Account Where Sales_Rep_O__c = :srId]);
        for(Account acc :accountList){
            acc.Sales_Rep_O__c = null;
            acc.OwnerId = null;
        }

        return accountList;
    }


    public void setOptionValues(){

        Map<String, User> availableUsersList = new Map<String, User>();

        for(Sales_Rep__c rep : [Select Id, Name, Team__c From Sales_Rep__c Where Id =:srId]){
            availableUsersList = getAvailableUsersForTeam(rep.Team__c);
        }
        
        this.optionValues = availableUsersList;
    }

    public Map<String, User> getAvailableUsersForTeam(String teamString){

        Set<String> userIds = getUserIdsInSetFromString(teamString);
        
        Map<String, User> availableUsersList = new Map<String, User>([Select Name From User  Where Id In : userIds and  isactive = true order by Name asc]);

        return availableUsersList;
    }


    public Set<String> getUserIdsInSetFromString(String teamUserString){

        Set<String> teamUserSet = new Set<String>();
        if(String.isNotEmpty(teamUserString)){
            List<String> teamUserList = teamUserString.split(';');
            for(String val : teamUserList){
                teamUserSet.add(val);
            }
        }

        return teamUserSet;
    }


    public String getSelected(){

        return selected;
    }


    public void setSelected(string ownerId){

        this.selected = ownerId;
    }


    public List<SelectOption> getAllOptionValues(){

        List<SelectOption> options = new List<SelectOption>();
        Set<String> objList = new Set<String>(optionValues.keySet());
        for(String s : objList){
            
            options.add(new SelectOption(s, optionValues.get(s).Name));
        }

        return options;
    }


    public PageReference saveAccount(){
    
        //update accountList;

        return null;
    }

}