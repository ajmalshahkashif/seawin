public virtual class ParentClass {
    
  public Map<String, Set<String>> userTeamSetMap {get; set;}
  public Set<String> usersNames {get; set;}
  public String startDate {get; set;}
  public String endDate {get; set;}
  
  public Boolean SysAdminUSA { get; set; }
  public Date d { get; set; }
  public List<string> Months {
    get {
      return new List<string>{
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sept',
        'Oct',
        'Nov',
        'Dec'
      };
    }
    set;
  }
  public string MonthName { get; set; }
  public string LastYearMonthName { get; set; }
  public string PrevMonthName { get; set; }
  public String Year { get; set; }
  public String LastYear { get; set; }
  public Date MonthStart { get; set; }
  public Date MonthEnd { get; set; }
  public Date LastYearMonthStart { get; set; }
  public Date LastYearMonthEnd { get; set; }
  public string YearShort {
    get {
      DateTime tdy = Date.today();
      return tdy.format('YY');
    }
    set;
  }
  public String LastYearShort {
    get {
      DateTime t = Date.today();
      DateTime tdy = Date.NewInstance(
        t.Year() - 1,
        t.month(),
        Date.daysInMonth(t.year() - 1, t.month())
      );
      return tdy.format('YY');
    }
    set;
  }

  public set<string> All_SalesReps {get; set;}
  public set<string> Active_SalesReps {get; set;}
  public set<string> All_Users {get; set;}
  public set<string> Active_Users {get; set;}
  public set<string> Inside_Sales_Users {get; set;}

  public set<string> All_Lead_Soruces {get; set;}
  public set<string> All_Account_Types {get; set;}


  public Boolean isTest { get; set; }
  public list<string> Next12MonthsList { get; set; }
  public list<string> Last6MonthsList { get; set; }
  public list<string> Last7MonthsList { get; set; }
  public list<string> Last12MonthsList { get; set; }
  public list<string> Last12MonthsList_ASR { get; set; }
  public map<string, integer> Last12MonthsList_CombinedMap { get; set; }

  // Billing Aging
  public Map<string, Decimal> BillingAgingMap { get; set; }
  public set<string> BillingAgingKeys { get; set; }
  public Integer SizeOfBillingAgingMap {
    get {
      return BillingAgingMap.size();
    }
    set;
  }

  // Collection Performance
  public Decimal AverageDueDays { get; set; }

  //---------------- Hospitality Dashboard

  public map<string, List<ValuesWrapper>> MonthlySalesMap { get; set; }
  public set<string> MonthlySalesKeys { get; set; }
  public Integer SizeOfMonthlySalesMap {
    get {
      return MonthlySalesMap.size();
    }
    set;
  }



  public map<string, List<ValuesWrapper>> SalesByLeadSourceLastTwelveMonthsMap { get; set; }
  public set<string> SalesByLeadSourceLastTwelveMonthsKeys { get; set; }
  public Integer SizeOfSalesByLeadSourceLastTwelveMonthsMap {
    get {
      return SalesByLeadSourceLastTwelveMonthsMap.size();
    }
    set;
  }



  public map<string, List<ValuesWrapper>> SalesContestYTDMap { get; set; }
  public set<string> SalesContestYTDKeys { get; set; }
  public Integer SizeOfSalesContestYTDMap {
    get {
      return SalesContestYTDMap.size();
    }
    set;
  }

  public map<string, List<ValuesWrapper>> SalesContestQTDMap { get; set; }
  public set<string> SalesContestQTDKeys { get; set; }
  public Integer SizeOfSalesContestQTDMap {
    get {
      return SalesContestQTDMap.size();
    }
    set;
  }

  public map<string, List<ValuesWrapper>> SalesContestTMMap { get; set; }
  public set<string> SalesContestTMKeys { get; set; }
  public Integer SizeOfSalesContestTMMap {
    get {
      return SalesContestTMMap.size();
    }
    set;
  }

  public map<string, List<ValuesWrapper>> NegWinRateMap { get; set; }
  public set<string> NegWinRateKeys { get; set; }
  public Integer SizeOfNegWinRateMap {
    get {
      return NegWinRateMap.size();
    }
    set;
  }
  public set<string> NegWinRateCategories { get; set; }

  public map<string, List<ValuesWrapper>> WinRateMap { get; set; }
  public set<string> WinRateKeys { get; set; }
  public Integer SizeOfWinRateMap {
    get {
      return WinRateMap.size();
    }
    set;
  }
  public set<string> WinRateCategories { get; set; }

  public Boolean MonthlyQuotaIsNull { get; set; }
  public Decimal UptodateQuota { get; set; }
  public Decimal UptoDateAmount { get; set; }
  public Decimal UptoDatePercentage { get; set; }

  public set<string> ActiveOpptyByStageKeys { get; set; }
  public map<string, List<ValuesWrapper>> ActiveOpptyByStageMap { get; set; }
  public Integer SizeOfActiveOpptyByStageMap {
    get {
      return ActiveOpptyByStageMap.size();
    }
    set;
  }
  public set<string> ActiveOpptyByStageCategories { get; set; }

  public set<string> ForecastKeys { get; set; }
  public map<string, List<ValuesWrapper>> ForecastMap { get; set; }
  public Integer SizeOfForecastMap {
    get {
      return ForecastMap.size();
    }
    set;
  }


  public set<string> SalesForecastPipelineByLeadSourceKeys { get; set; }
  public map<string, List<ValuesWrapper>> SalesForecastPipelineByLeadSourceMap { get; set; }
  public Integer SizeOfSalesForecastPipelineByLeadSourceMap {
    get {
      return SalesForecastPipelineByLeadSourceMap.size();
    }
    set;
  }


  public set<string> LostOpptysKeys { get; set; }
  public map<string, List<ValuesWrapper>> LostOpptysMap { get; set; }
  public Integer SizeOfLostOpptysMap {
    get {
      return LostOpptysMap.size();
    }
    set;
  }

  public set<string> LossReasonsKeys { get; set; }
  public map<string, List<ValuesWrapper>> LossReasonsMap { get; set; }
  public Integer SizeOfLossReasonsMap {
    get {
      return LossReasonsMap.size();
    }
    set;
  }


  public set<string> newlySubmittedOpportunitiesKeys { get; set; }
  public map<string, List<ValuesWrapper>> newlySubmittedOpportunitiesMap { get; set; }
  public Integer SizeOfnewlySubmittedOpportunitiesMap {
    get {
      return newlySubmittedOpportunitiesMap.size();
    }
    set;
  }
  public set<string> NewlySubmittedOpportunitiesCategories { get; set; }
  
  
  public set<string> newlySubmittedOpportunitiesLastTwelveMonthsByLeadSourceKeys { get; set; }
  public map<string, List<ValuesWrapper>> newlySubmittedOpportunitiesLastTwelveMonthsByLeadSourceMap { get; set; }
  public Integer SizeOfnewlySubmittedOpportunitiesLastTwelveMonthsByLeadSourceMap {
    get {
      return newlySubmittedOpportunitiesLastTwelveMonthsByLeadSourceMap.size();
    }
    set;
  }
  public set<string> newlySubmittedOpportunitiesLastTwelveMonthsByLeadSourceCategories { get; set; }


  public set<string> OpptyByLeadSourceKeys { get; set; }
  public map<string, List<ValuesWrapper>> OpptyByLeadSourceMap { get; set; }
  public Integer SizeOfOpptyByLeadSourceMap {
    get {
      return OpptyByLeadSourceMap.size();
    }
    set;
  }
  public set<string> OpptyByLeadSourceCategories { get; set; }


  public set<string> HospitalityOpptyByLeadSourceKeys { get; set; }
  public map<string, List<ValuesWrapper>> HospitalityOpptyByLeadSourceMap { get; set; }
  public Integer SizeOfHospitalityOpptyByLeadSourceMap {
    get {
      return HospitalityOpptyByLeadSourceMap.size();
    }
    set;
  }
  public set<string> HospitalityOpptyByLeadSourceCategories { get; set; }
  
  
  public set<string> InstallerOpptyByLeadSourceKeys { get; set; }
  public map<string, List<ValuesWrapper>> InstallerOpptyByLeadSourceMap { get; set; }
  public Integer SizeOfInstallerOpptyByLeadSourceMap {
    get {
      return InstallerOpptyByLeadSourceMap.size();
    }
    set;
  }
  public set<string> InstallerOpptyByLeadSourceCategories { get; set; }
  


  public set<string> NewCustomersByIndustryKeys { get; set; }
  public map<string, List<ValuesWrapper>> NewCustomersByIndustryMap {
    get;
    set;
  }
  public Integer SizeOfNewCustomersByIndustryMap {
    get {
      return NewCustomersByIndustryMap.size();
    }
    set;
  }
  public set<string> NewCustomersByIndustryCategories { get; set; }



  public set<string> NewCustomersLast12MonthsByTypeKeys { get; set; }
  public map<string, List<ValuesWrapper>> NewCustomersLast12MonthsByTypeMap {
    get;
    set;
  }
  public Integer SizeOfNewCustomersLast12MonthsByTypeMap {
    get {
      return NewCustomersLast12MonthsByTypeMap.size();
    }
    set;
  }
  public set<string> NewCustomersLast12MonthsByTypeCategories { get; set; }



  public set<string> TasksCompletionKeys { get; set; }
  public map<string, List<ValuesWrapper>> TasksCompletionMap { get; set; }
  public Integer SizeOfTasksCompletionMap {
    get {
      return TasksCompletionMap.size();
    }
    set;
  }
  public set<string> TasksCompletionCategories { get; set; }

  public set<string> NeglectedOpptyKeys { get; set; }
  public map<string, List<ValuesWrapper>> NeglectedOpptyMap { get; set; }
  public Integer SizeOfNeglectedOpptyMap {
    get {
      return NeglectedOpptyMap.size();
    }
    set;
  }
  public set<string> NeglectedOpptyCategories { get; set; }

  public set<string> NewLeadsKeys { get; set; }
  public map<string, List<ValuesWrapper>> NewLeadsMap { get; set; }
  public Integer SizeOfNewLeadsMap {
    get {
      return NewLeadsMap.size();
    }
    set;
  }
  public set<string> NewLeadsCategories { get; set; }

  public set<string> CompanyTotalPipelineKeys { get; set; }
  public map<string, List<ValuesWrapper>> CompanyTotalPipelineMap { get; set; }
  public Integer SizeOfCompanyTotalPipelineMap {
    get {
      return CompanyTotalPipelineMap.size();
    }
    set;
  }

  public set<string> SalesRepTotalPipelineKeys { get; set; }
  public map<string, List<ValuesWrapper>> SalesRepTotalPipelineMap { get; set; }
  public Integer SizeOfSalesRepTotalPipelineMap {
    get {
      return SalesRepTotalPipelineMap.size();
    }
    set;
  }

  public set<string> ActivityGraphKeys { get; set; }
  public map<string, List<ValuesWrapper>> ActivityGraphMap { get; set; }
  public Integer SizeOfActivityGraphMap {
    get {
      return ActivityGraphMap.size();
    }
    set;
  }

  //---------------Drop Shipment Dashboard
  // Monthly Sales Last 12 Months
  public map<string, List<ValuesWrapper>> MonthlySalesDropshipMap { get; set; }
  public set<string> MonthlySalesDropshipKeys { get; set; }
  public Integer SizeOfMonthlySalesDropshipMap {
    get {
      return MonthlySalesDropshipMap.size();
    }
    set;
  }

  // Top Ten Accounts by SO
  public List<YearlyWrapper> TopTenAccountsDropship { get; set; }

  // Top Ten Shipped Drop Shipped
  public Map<string, Decimal> TopTenShippedDropShipMap { get; set; }
  public Set<string> TopTenShippedDropShipKeys { get; set; }
  public Integer SizeOfTopTenShippedDropShipMap {
    get {
      return TopTenShippedDropShipMap.size();
    }
    set;
  }

  //---------------Wholesale Distribution Dashboard
  // Monthly Sales Last 12 Months
  public map<string, List<ValuesWrapper>> MonthlySalesWholesaleMap { get; set; }
  public set<string> MonthlySalesWholesaleKeys { get; set; }
  public Integer SizeOfMonthlySalesWholesaleMap {
    get {
      return MonthlySalesWholesaleMap.size();
    }
    set;
  }

  // Top Ten Accounts by SO
  public List<YearlyWrapper> TopTenAccountsWholesale { get; set; }

  // Top Ten Shipped Drop Shipped
  public Map<string, Decimal> TopTenShippedWholesaleMap { get; set; }
  public Set<string> TopTenShippedWholesaleKeys { get; set; }
  public Integer SizeOfTopTenShippedWholesaleMap {
    get {
      return TopTenShippedWholesaleMap.size();
    }
    set;
  }

  // Team Quota YTD Percent
  public map<string, Decimal> TeamQuotaPercentMap { get; set; }
  public Set<string> TeamQuotaPercentKeys { get; set; }
  public Integer SizeOfTeamQuotaPercentMap {
    get {
      return TeamQuotaPercentMap.size();
    }
    set;
  }

  public ParentClass() {

    userTeamSetMap = new Map<String, Set<String>>();
    usersNames = new Set<String>();
    startDate = 'startDate';
    endDate = 'endDate';
    
    SysAdminUSA = false;
    d = Date.today();

    UptodateQuota = 0;
    UptoDateAmount = 0;
    UptoDatePercentage = 0;
    MonthlyQuotaIsNull = false;

    Next12MonthsList = new List<string>();
    Last6MonthsList = new List<string>();
    Last7MonthsList = new List<string>();
    Last12MonthsList = new List<string>();
    Last12MonthsList_ASR = new List<string>();
    Last12MonthsList_CombinedMap = new Map<string, integer>();

    Datetime lstYear = DateTime.newInstance(d.year() - 1, d.month(), d.day());
    datetime thsYear = DateTime.newInstance(d.year(), d.month(), d.day());

    PrevMonthName =
      Months[((thsYear.month() - 2) > -1) ? thsYear.month() - 2 : 11] +
      ' \'' +
      thsYear.format('YY');
    MonthName = Months[thsYear.month() - 1] + ' \'' + thsYear.format('YY');
    LastYearMonthName =
      Months[thsYear.month() - 1] +
      ' \'' +
      lstYear.format('YY');

    Year = thsYear.format('YYYY');
    LastYear = lstYear.format('YYYY');

    MonthStart = Date.newInstance(d.year(), d.month(), 1);
    MonthEnd = Date.newInstance(d.year(), d.month() + 1, 1);
    LastYearMonthStart = Date.newInstance(d.year() - 1, d.month(), 1);
    LastYearMonthEnd = Date.newInstance(d.year() - 1, d.month() + 1, 1);

    // Collection initialization

    BillingAgingMap = new Map<string, Decimal>();
    BillingAgingKeys = new Set<String>();

    AverageDueDays = 0;

    // Hospitality Dashboard

    MonthlySalesMap = new Map<string, List<ValuesWrapper>>();
    MonthlySalesKeys = new Set<string>();
   
    SalesByLeadSourceLastTwelveMonthsMap = new Map<string, List<ValuesWrapper>>();
    SalesByLeadSourceLastTwelveMonthsKeys = new Set<string>();

    SalesContestYTDMap = new Map<string, List<ValuesWrapper>>();
    SalesContestYTDKeys = new Set<string>();

    SalesContestQTDMap = new Map<string, List<ValuesWrapper>>();
    SalesContestQTDKeys = new Set<string>();

    SalesContestTMMap = new Map<string, List<ValuesWrapper>>();
    SalesContestTMKeys = new Set<string>();

    NegWinRateMap = new Map<string, List<ValuesWrapper>>();
    NegWinRateKeys = new Set<string>();
    NegWinRateCategories = new Set<string>();

    WinRateMap = new Map<string, List<ValuesWrapper>>();
    WinRateKeys = new Set<string>();
    WinRateCategories = new Set<string>();

    ActiveOpptyByStageMap = new Map<string, List<ValuesWrapper>>();
    ActiveOpptyByStageKeys = new Set<string>();
    ActiveOpptyByStageCategories = new Set<string>();

    ForecastKeys = new Set<string>();
    ForecastMap = new Map<string, List<ValuesWrapper>>();
  
    SalesForecastPipelineByLeadSourceKeys = new Set<string>();
    SalesForecastPipelineByLeadSourceMap = new Map<string, List<ValuesWrapper>>();

    LostOpptysKeys = new Set<string>();
    LostOpptysMap = new Map<string, List<ValuesWrapper>>();

    LossReasonsKeys = new Set<string>();
    LossReasonsMap = new Map<string, List<ValuesWrapper>>();

    newlySubmittedOpportunitiesKeys = new Set<string>();
    newlySubmittedOpportunitiesMap = new Map<string, List<ValuesWrapper>>();
    NewlySubmittedOpportunitiesCategories = new Set<string>();
    
    newlySubmittedOpportunitiesLastTwelveMonthsByLeadSourceKeys = new Set<string>();
    newlySubmittedOpportunitiesLastTwelveMonthsByLeadSourceMap = new Map<string, List<ValuesWrapper>>();
    newlySubmittedOpportunitiesLastTwelveMonthsByLeadSourceCategories = new Set<string>();

    OpptyByLeadSourceKeys = new Set<string>();
    OpptyByLeadSourceMap = new Map<string, List<ValuesWrapper>>();
    OpptyByLeadSourceCategories = new Set<string>();
    
    HospitalityOpptyByLeadSourceKeys = new Set<string>();
    HospitalityOpptyByLeadSourceMap = new Map<string, List<ValuesWrapper>>();
    HospitalityOpptyByLeadSourceCategories = new Set<string>();
    
    InstallerOpptyByLeadSourceKeys = new Set<string>();
    InstallerOpptyByLeadSourceMap = new Map<string, List<ValuesWrapper>>();
    InstallerOpptyByLeadSourceCategories = new Set<string>();

    NewCustomersByIndustryKeys = new Set<string>();
    NewCustomersByIndustryMap = new Map<string, List<ValuesWrapper>>();
    NewCustomersByIndustryCategories = new Set<string>();
    
    NewCustomersLast12MonthsByTypeKeys = new Set<string>();
    NewCustomersLast12MonthsByTypeMap = new Map<string, List<ValuesWrapper>>();
    NewCustomersLast12MonthsByTypeCategories = new Set<string>();

    TasksCompletionKeys = new Set<string>();
    TasksCompletionMap = new Map<string, List<ValuesWrapper>>();
    TasksCompletionCategories = new Set<string>();

    NeglectedOpptyKeys = new Set<string>();
    NeglectedOpptyMap = new Map<string, List<ValuesWrapper>>();
    NeglectedOpptyCategories = new Set<string>();

    NewLeadsKeys = new Set<string>();
    NewLeadsMap = new Map<string, List<ValuesWrapper>>();
    NewLeadsCategories = new Set<string>();

    SalesRepTotalPipelineKeys = new Set<String>();
    SalesRepTotalPipelineMap = new Map<string, List<ValuesWrapper>>();

    CompanyTotalPipelineKeys = new Set<String>();
    CompanyTotalPipelineMap = new Map<string, List<ValuesWrapper>>();

    ActivityGraphKeys = new Set<String>();
    ActivityGraphMap = new Map<string, List<ValuesWrapper>>();

    // Drop Shipment Dashboard
    MonthlySalesDropshipMap = new Map<string, List<ValuesWrapper>>();
    MonthlySalesDropshipKeys = new Set<string>();

    TopTenAccountsDropship = new List<YearlyWrapper>();

    TopTenShippedDropShipMap = new Map<string, Decimal>();
    TopTenShippedDropShipKeys = new Set<string>();

    // Wholesale Distribution Dashboard
    MonthlySalesWholesaleMap = new Map<string, List<ValuesWrapper>>();
    MonthlySalesWholesaleKeys = new Set<string>();

    TopTenAccountsWholesale = new List<YearlyWrapper>();

    TopTenShippedWholesaleMap = new Map<string, Decimal>();
    TopTenShippedWholesaleKeys = new Set<string>();

    // Team Quota Percent
    TeamQuotaPercentMap = new Map<string, Decimal>();
    TeamQuotaPercentKeys = new Set<string>();

    List<User> LoggedInUserUSA = [
      SELECT id
      FROM user
      WHERE
        default_gl_account_variable__c INCLUDES ('Seawin USA')
        AND id = :UserInfo.getUserId()
      LIMIT 1
    ];

    if (!LoggedInUserUSA.isEmpty()) {
      SysAdminUSA = true;
    }
    if (SysAdminUSA) {

      All_Lead_Soruces = new Set<string>();
      All_Account_Types = new Set<string>();


      // Lists added on 18 December 2020 by Azhar Khan
      All_Users = new set<string>();
      Active_Users = new set<string>();
      Inside_Sales_Users = new set<string>();
      All_SalesReps = new set<string>();
      Active_SalesReps = new set<string>();


      // List end

      isTest = Test.isRunningTest();

      // ----------------------------------Users compilation 
      
      // All users
      List<User> All_Users_List = [
        SELECT name
        FROM user
        WHERE
          default_gl_account_variable__c INCLUDES ('Seawin USA')
          AND name != 'Murtaza Ashraf'
          AND name != 'Ashraf Murtaza'
      ];

      if (!All_Users_List.isEmpty()) {
        for (User all_usrs : All_Users_List) {
          All_Users.add(all_usrs.name);
        }
      }

      // Active users
      List<User> Active_Users_List = [
        SELECT name
        FROM user
        WHERE
          isActive = TRUE
          AND default_gl_account_variable__c INCLUDES ('Seawin USA')
          AND name != 'Murtaza Ashraf'
          AND name != 'Ashraf Murtaza'
      ];

      if (!Active_Users_List.isEmpty()) {
        for (User active_usrs : Active_Users_List) {
          Active_Users.add(active_usrs.name);
        }
      }

      // Inside Sales users
      
      List<User> Inside_Sales_Users_List = [
        SELECT name
        FROM user
        WHERE
          default_gl_account_variable__c INCLUDES ('Seawin USA')
          AND Profile.name LIKE '%Inside Sales%'
          AND name != 'Murtaza Ashraf'
          AND name != 'Ashraf Murtaza'
      ];

      if (!Inside_Sales_Users_List.isEmpty()) {
        for (User inside_users : Inside_Sales_Users_List) {
          Inside_Sales_Users.add(inside_users.name);
        }
      }

      // ---------------------------------- Sales Reps compilation -------------------------------- 


      List<sales_rep__c> All_SalesReps_List = [
        SELECT name
        FROM sales_rep__c
        WHERE 
          name != 'Murtaza Ashraf'
          AND name != 'Ashraf Murtaza'
      ];

      if (!All_SalesReps_List.isEmpty()) {
        for (Sales_rep__c all_sales : All_SalesReps_List) {
          All_SalesReps.add(all_sales.name);
        }
      }

      List<sales_rep__c> Active_Sales_Reps_List = [
        SELECT name
        FROM sales_rep__c
        WHERE
          Active__c = 'Yes'
          AND name != 'Murtaza Ashraf'
          AND name != 'Ashraf Murtaza'
      ];
      if (!Active_Sales_Reps_List.isEmpty()) {
        for (Sales_rep__c active_reps : Active_Sales_Reps_List) {
          Active_SalesReps.add(active_reps.name);
        }
      }

      // compilation ends


      Schema.DescribeFieldResult fieldResult = Opportunity.LeadSource.getDescribe();
      List<Schema.PicklistEntry> leadSourceList = fieldResult.getPicklistValues();
      if (!leadSourceList.isEmpty()) {
        for (Schema.PicklistEntry ls: leadSourceList) {
          All_Lead_Soruces.add(ls.getValue());
        }
      }


      Schema.DescribeFieldResult accountTypeFieldResult = Account.Type.getDescribe();
      List<Schema.PicklistEntry> accountTypeList = accountTypeFieldResult.getPicklistValues();
      if (!accountTypeList.isEmpty()) {
        for (Schema.PicklistEntry at: accountTypeList) {
          All_Account_Types.add(at.getValue());
        }
      }

      // Only valid for testing purposes
      if (isTest) {
        All_Users.add('Murtaza Ashraf');
        Active_Users.add('Murtaza Ashraf');
        Inside_Sales_Users.add('Murtaza Ashraf');
        All_SalesReps.add('Murtaza Ashraf');
        Active_SalesReps.add('Murtaza Ashraf');
        
      }
    }
  }
    
  
  
  public class MainWrapper {
    public string Name { get; set; }
    public List<ValuesWrapper> Data { get; set; }
    public Decimal total { get; set; }

    public MainWrapper(string n, List<ValuesWrapper> d, Decimal t) {
      this.Name = n;
      this.Data = d;
      this.total = t;
    }
  }
  public class ValuesWrapper {
    public integer index { get; set; }
    public string name { get; set; }
    public string general { get; set; }
    public decimal amount { get; set; }
    public Integer year { get; set; }
    public List<string> links { get; set; }
    public decimal misc { get; set; }

    public ValuesWrapper(
      Integer i,
      string n,
      string g,
      decimal a,
      integer y,
      List<string> l,
      decimal m
    ) {
      this.Index = i;
      this.name = n;
      this.general = g;
      this.amount = a;
      this.year = y;
      this.links = l;
      this.misc = m;
    }
  }
  public class YearlyWrapper {
    public string name { get; set; }
    public string acctid { get; set; }
    public string owner { get; set; }
    public string salesrep { get; set; }
    public decimal total { get; set; }
    public decimal thismonth { get; set; }
    public decimal prevmonth { get; set; }
    public decimal lastmonth { get; set; }
    public decimal thisyear { get; set; }
    public decimal lastyear { get; set; }

    public YearlyWrapper(
      string n,
      string a,
      string o,
      string s,
      decimal tl,
      decimal tm,
      decimal pm,
      decimal lm,
      decimal ty,
      decimal ly
    ) {
      this.name = n;
      this.acctid = a;
      this.owner = o;
      this.salesrep = s;
      this.total = tl;
      this.thismonth = tm;
      this.prevmonth = pm;
      this.lastmonth = lm;
      this.thisyear = ty;
      this.lastyear = ly;
    }
  }

  public List<string> sortedKeys(map<string, List<ValuesWrapper>> data) {

    /*
    map<string, decimal> DataMap = new Map<string, decimal>();

    for (string key : data.keyset()) {

      List<ValuesWrapper> values = data.get(key);

      Decimal total = 0;

      for (ValuesWrapper v : values) {

        if (v.amount == null) {
          v.amount = 0;
        }

        total += v.amount;
      }

      DataMap.put(key, total);
    }

    return this.sortEngine(DataMap);
    */

    list<string> sortedKeys = new list<string>(data.keyset());
    sortedKeys.sort();

    return sortedKeys;
  }

  public List<string> sortEngine(map<string, Decimal> DataMap) {

    list<string> keyList = new List<string>();
    map<decimal, list<string>> valuesMap = new Map<decimal, list<string>>();

    for (string s : DataMap.keyset()) {
      Decimal value = DataMap.get(s);

      if (valuesMap.containskey(value)) {
        List<string> existing = valuesMap.get(value);
        existing.add(s);
        valuesMap.put(value, existing);
      } else {
        keyList = new List<string>();
        keyList.add(s);
        valuesMap.put(value, keyList);
      }
    }

    List<string> KeyListSorted = new List<string>();

    if (valuesMap.size() > 0) {
      list<Decimal> valuesAscending = new List<Decimal>(ValuesMap.keyset());
      valuesAscending.sort();

      List<Decimal> ValuesDescending = new List<Decimal>();
      for (Integer i = valuesAscending.size() - 1; i >= 0; i--) {
        ValuesDescending.add(valuesAscending[i]);
      }

      // create the sorted map

      for (decimal d : ValuesDescending) {
        for (string s : ValuesMap.get(d)) {
          KeyListSorted.add(s);
        }
      }
    }

    return KeyListSorted;
  }

  public List<string> sortMapEngine(map<string, Decimal> DataMap) {

    list<string> keyList = new List<string>();

    for (string s : DataMap.keyset()) {     
      keyList.add(s);
    }
    keyList.sort();

    return KeyList;
  }
  public Decimal CalculateUptoDateQuota(Decimal MonthlyQuota,Date InactiveDate,DateTime CreatedDate) {
    Date today_date = Date.today();
    Date year_start_date = Date.newInstance(today_date.year(), 1, 1);
    Date created_date = Date.newInstance(
      CreatedDate.year(),
      CreatedDate.month(),
      CreatedDate.day()
    );

    Decimal per_day_quota = 0;

    Integer days = 0;
    Integer months = 0;
    Decimal quota = 0;

    if (InactiveDate != null && InactiveDate.year() == today_date.year()) {
      // If sales rep is inactive
      months = year_start_date.monthsBetween(InactiveDate);
      per_day_quota =
        MonthlyQuota /
        Date.daysInMonth(InactiveDate.year(), InactiveDate.month());

      days = months > 0
        ? InactiveDate.day()
        : year_start_date.daysBetween(InactiveDate);

      quota = (months * MonthlyQuota) + (per_day_quota * days);
    } else if (created_date.year() == today_date.year()) {
      // If the sales rep was created this year
      months = created_date.monthsBetween(today_date);
      per_day_quota =
        MonthlyQuota / Date.daysInMonth(today_date.year(), today_date.month());

      days = months > 0
        ? today_date.day()
        : created_date.daysBetween(today_date);

      quota = (months * MonthlyQuota) + (per_day_quota * days);
    } else if (InactiveDate == null) {
      // If sales rep is active and the above condition does not meet
      months = year_start_date.monthsBetween(today_date);
      per_day_quota =
        MonthlyQuota / Date.daysInMonth(today_date.year(), today_date.month());

      days = months > 0
        ? today_date.day()
        : year_start_date.daysBetween(today_date);

      quota = (months * MonthlyQuota) + (per_day_quota * days);
    }

    return quota;
  }
  public Decimal CalculateTotal(List<ValuesWrapper> values) {
    Decimal total = 0;

    for (ValuesWrapper v : values) {
      if (v.amount == null)
        v.amount = 0;

      total += v.amount;
    }

    return total;
  }
  public void Next12Months() {
    Next12MonthsList = new List<String>();

    Date now = date.today();
    Integer month = now.month() - 1;

    List<String> names = new List<string>{
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    };

    for (Integer i = 0; i < 12; ++i) {
      Next12MonthsList.add(names[month]);
      if (++month == 12) {
        month = 0;
      }
    }
  }
  public void Last6Months() {
    Last6MonthsList = new List<String>();

    Date now = date.today();
    Integer month = (now.month() - 1) < 1 ? 11 : (now.month() - 1) - 1; // 1

    List<String> names = new List<string>{
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    };

    for (Integer i = 0; i < 6; ++i) {
      Last6MonthsList.add(names[month]);
      if (--month == -1) {
        month = 11;
      }
    }
  }
  public void Last7Months() {
    Last7MonthsList = new List<String>();

    Date now = date.today();
    Integer month = now.month() - 1 < 1 ? 11 : now.month() - 1; // 1

    List<String> names = new List<string>{
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    };

    for (Integer i = 0; i < 7; ++i) {
      Last7MonthsList.add(names[month]);
      if (--month == -1) {
        month = 11;
      }
    }
  }
  public void Last12Months() {
    Last12MonthsList = new List<String>();

    Date now = date.today();
    Integer month = now.month() - 1;

    List<String> names = new List<string>{
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    };

    for (Integer i = 0; i < 12; ++i) {
      Last12MonthsList.add(names[month]);
      if (--month == -1) {
        month = 11;
      }
    }
  }
  public void Last12Months_ASR() {
    Last12MonthsList_ASR = new List<String>();
    List<String> TEMPMonthsList = new List<String>();

    Date now = date.today();
    Integer month = now.month() - 1;

    List<String> names = new List<string>{
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    };

    for (Integer i = 0; i < 12; ++i) {
      TEMPMonthsList.add(names[month]);
      if (--month == -1) {
        month = 11;
      }
    }

    // reverse the order
    for (Integer i = 11; i >= 0; i--) {
      Last12MonthsList_ASR.add(TEMPMonthsList[i]);
    }
  }
  public void Last12Months_Combined() {
    Last12MonthsList_CombinedMap = new Map<string, integer>();
    List<String> TEMPMonthsList = new List<String>();

    Integer Months_Passed = d.month();

    // TM = Twelve Months

    Integer TM_Start_Year = (Months_Passed < 12) ? d.year() - 1 : d.year();
    Integer TM_Start_Month = d.month() < 12 ? d.month() + 1 : 1;

    Date TM_Start_Date = Date.newInstance(TM_Start_Year, TM_Start_Month, 1);

    Integer Month = TM_Start_Date.month(); // 9
    Integer CurrentMonth = d.month(); // 8
    Integer TotalDifference = 12 - CurrentMonth;
    Integer TotalPreviousMonths = 12 - Month;

    List<String> names = new List<string>{
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    };

    for (Integer i = 0; i < 12; i++) {
      Integer year = TotalDifference > 0 &&
        i < TotalDifference
        ? d.year() - 1
        : (TotalDifference == 0 && i <= TotalPreviousMonths) ||
            (TotalDifference > 0 &&
            i <= TotalDifference + 11)
            ? d.year()
            : d.year() + 1;

      string key = month + '-' + year;

      Last12MonthsList_CombinedMap.put(key, i);
      if (++month == 13) {
        month = 1;
      }
    }
  }
  public map<string, List<ValuesWrapper>> SortByValues(map<string, List<ValuesWrapper>> maps) {
    map<string, List<ValuesWrapper>> returnedMap = new Map<string, List<ValuesWrapper>>();

    set<string> keys = maps.keyset();

    for (string MainKey : keys) {
      List<ValuesWrapper> values = maps.get(MainKey);

      map<integer, ValuesWrapper> ValuesMap = new Map<integer, valuesWrapper>();

      for (ValuesWrapper v : values) {
        ValuesMap.put(v.index, v);
      }

      List<Integer> RandomKeys = new List<integer>(ValuesMap.keyset());

      RandomKeys.sort();

      map<integer, ValuesWrapper> SortedMap = new Map<integer, valuesWrapper>();

      for (integer SubKey : RandomKeys) {
        if (ValuesMap.containsKey(SubKey)) {
          SortedMap.put(SubKey, ValuesMap.get(SubKey));
        }
      }

      returnedMap.put(MainKey, SortedMap.Values());
    }

    return returnedMap;
  }
  public Set<String> getUsersSetFromTeam(String teamString){

    Set<String> usersIds = new Set<String>();
    usersNames = new Set<String>();
    if(teamString != null){
        usersIds.addAll(getUserIdsInSetFromString(teamString));
        usersNames.addAll(getUserNamesInSetFromSet(usersIds));
    }

    //return usersIds;
    return usersNames;
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
  public Set<String> getUserNamesInSetFromSet(Set<String> userIds){

    Set<String> userNameSet = new Set<String>();

    List<User> usersList = new List<User>([Select Name From User Where Id In :userIds]);

    for(User usr :usersList){
      userNameSet.add(usr.Name);
    }

    return userNameSet;
  }

}