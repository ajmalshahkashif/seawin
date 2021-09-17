public class TestPageExtension  {
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    public String searchText {get; set;}
    public String selectedSearchVal {get; set;}
    public Product2 prod2 {get; set;}
    public string queryStr{get; set;}
    public String sortOrder {get; set;}
    public Boolean ProductNameSortASC{get; set;}
    public Boolean ProductNameSortDESC{get; set;}
    
    
    public String selectedCountry
    {
        get
        {
            if(selectedCountry==null)
                selectedCountry='CANADA';
            return selectedCountry;
        }
        set;
    }
    
    public List<SelectOption> getItems() {
        
        List<Product2> prodCategoriesList = new List<Product2>();
        prodCategoriesList = [select id, name, Category__c from product2];
        
 	 	List<SelectOption> options = new List<SelectOption>();
        
        for(Product2 p : prodCategoriesList){
            if(p.Category__c != null)
                options.add(new SelectOption(p.Id, p.Category__c));
        }
 	 	
 	 	return options;
  	}
    
    
    
    
    
    
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 15;
                queryStr = 'select id, name, image__c, productcode, description, category__c, size__c, Sub_Category__c,Complementary_Category__c, hardware_finish__c, acctseed__unit_cost__c,Glass__c,Glass_Thickness__c from product2 where IsActive = true order by Name ' + sortOrder; 
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryStr));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }
    
    public List<Product2> getProducts(){
        return (List<Product2>)setCon.getRecords();
    }
    
    public TestPageExtension(){
        selectedSearchVal = 'all';
        sortOrder = 'ASC';
        ProductNameSortASC = true;
        ProductNameSortDESC = false;
        prod2 = new Product2();
    }
    
    public void FetchProducts(String queryStr){
        size = 10;
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryStr));
        setCon.setPageSize(size);
        noOfRecords = setCon.getResultSize();
    }
    
    public PageReference searchByName(){
        
        String category = prod2.Category__c;
        String subCategory = prod2.Sub_Category__c;
        String complementaryCategory = prod2.Complementary_Category__c;
        Boolean isActive = prod2.IsActive;
        
        String fieldname = '';
        if(selectedSearchVal == 'all' || selectedSearchVal == null){
            fieldname = 'all';
        }else{
            fieldname = selectedSearchVal;
        }
        if(searchText != null) 
            searchText = searchText.replaceAll('[|<>?":}{|"+\\)\\(*&^%$#@!\\]\\[;\\/,\\\\]', '');
        
        queryStr = 'select id,name, image__c, productcode, description, category__c, size__c,';
        queryStr = queryStr + 'Sub_Category__c,Complementary_Category__c,hardware_finish__c, acctseed__unit_cost__c,Glass__c,Glass_Thickness__c from Product2 where (';
        if(fieldname != 'all')
            queryStr = queryStr + fieldname + ' like \'%' + searchText + '%\')';
        else{
            Integer i = 1;
            for(SelectOption field : SearchValList){
                if(field.getLabel() == 'None'){
                    i++;
                    continue;
                }
                else if (field.getLabel() == 'All' ){
                    i++;
                    continue;
                }
                else{
                    queryStr = queryStr + field.getValue() + ' like \'%' + searchText + '%\'';
                    if(i != SearchValList.size())
                        queryStr = queryStr + ' OR ';
                    i++;
                }   
            }
            queryStr = queryStr + ')';
        }
        if(category != null)
            queryStr = queryStr + ' and category__c =\'' + category + '\'';
        if(subCategory != null)
            queryStr = queryStr + ' and Sub_Category__c =\'' + subCategory + '\'';
        if(complementaryCategory != null)
            queryStr = queryStr + ' and Complementary_Category__c =\'' + complementaryCategory + '\'';
        
        queryStr = queryStr + ' and IsActive = ' + isActive;
        
        System.debug('query is: ' + queryStr);
        
        queryStr = queryStr + ' order by Name ';
        this.FetchProducts(queryStr);
        return null;
    }
    
    public LIST<SelectOption> SearchValList {
        
        get{
            SearchValList = new LIST<SelectOption>();
            SearchValList.add(new SelectOption('', 'None'));
            SearchValList.add(new SelectOption('all', 'All'));
            
            String type = 'Product2';
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType ProductSchema = schemaMap.get(type);
            Map<String, Schema.SObjectField> fieldMap = ProductSchema.getDescribe().fields.getMap();
            
            for (String fieldName: fieldMap.keySet()) {
                String LabelIs = fieldMap.get(fieldName).getDescribe().getLabel();
                String APIIs = fieldMap.get(fieldName).getDescribe().getName();
                
                if(APIIs == 'Name' || APIIs == 'ProductCode' || APIIs == 'Description' 
                   || APIIs == 'Size__c' || APIIs == 'Category__c' || APIIs == 'Type__c' 
                   || APIIs == 'AcctSeed__Inventory_Type__c'){
                       SearchValList.add(new SelectOption(APIIs, LabelIs));
                   }
            }
            
            return SearchValList;
        }
        set;
    }
    
    public pageReference refresh() {
        setCon = null;
        this.FetchProducts(queryStr);
        //Products = setCon.getRecords();
        setCon.setPageNumber(1);
        return null;
    }
    
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
    
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
    
    public void first() {
        setCon.first();
    }
    
    public void last() {
        setCon.last();
    }
    
    public void previous() {
        setCon.previous();
    }
    
    public void next() {
        setCon.next();
    }
    
    public void checkSort(){   
        
        setCon = null;
        
        if(sortOrder == 'ASC'){
            sortOrder = 'DESC';
            ProductNameSortDESC = true;
            ProductNameSortASC = false;
        }else if(sortOrder == 'DESC'){
            sortOrder = 'ASC';
            ProductNameSortDESC = false;
            ProductNameSortASC = true;
        }
        this.FetchProducts(queryStr);
        
    }
    
    public PageReference createNew(){
        
        String url = '/setup/ui/recordtypeselect.jsp?ent=Product2&retURL=/apex/ProductPage?save_new=1&sfdc.override=1';
        url = url + '&nooverride=1&save_new_url=/01t/e?retURL=/apex/ProductPage?save_new=1&sfdc.override=1';
        PageReference page = new PageReference(url);
        page.setRedirect(true);
        return page;
    }
}