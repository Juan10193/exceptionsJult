public class EIV_EntityWrapClass {
    public string entityName                       {get;set;}
    public string Customer_Name                    {get;set;}
    public string Customer_Alias                   {get;set;}    
    public string Customer_Type                    {get;set;}
    public string Customer_Status                  {get;set;}
    public string Cust_AccountId                   {get;set;}
    public string Top_Parent_Name                  {get;set;}
    public string SF_Account_Name                  {get;set;}
    public string RFC                              {get;set;}
    public string TIN                              {get;set;}
    public string Economic_Group_ID                {get;set;}
    public string Economic_Group_Name              {get;set;}
    public string EconomicGroupPartyId             {get;set;}
    public Boolean Limited_information_entity      {get;set;}
    public string Tax_Regime                       {get;set;}
    public string Foreign_Entity                   {get;set;}
    public string Nationality                      {get;set;}
    public string Oracle_Account_Number            {get;set;}
    public string CURP                             {get;set;}
    public string Prefix                           {get;set;}
    public string First_Name                       {get;set;}
    public string Middle_Name                      {get;set;}
    public string First_Last_Name                  {get;set;}
    public string Second_Last_Name                 {get;set;}
    public string Sales_Representative             {get;set;}
    public string Supplier_Flag                    {get;set;}
    public string Legal_Name_sin_denominacion      {get;set;}
    public string Company_Legal_Name_termination   {get;set;}
    public string Oracle_Account_Name              {get;set;}
    public string Source_Created_by                {get;set;}
    public string Source_Updated_by                {get;set;}
    public string Source_Application_ID            {get;set;}
    public Datetime Source_Create_Date             {get;set;}
    public Datetime Source_Last_Update_Date        {get;set;}
    public string Oracle_Created_by                {get;set;}
    public string Oracle_Updated_by                {get;set;}
    public Datetime Oracle_Create_Date             {get;set;}
    public Datetime Oracle_Last_Update_Date        {get;set;}
    public string Target_Market_Jurisdiction       {get;set;}
    public string CRR                              {get;set;}
    public string CRR_Override                     {get;set;}
    public string CRR_Comments                     {get;set;}
    public string Entity_Type                      {get;set;}
    public String MRA_ID                           {get;set;}
    public String Bloomberg_ID                     {get;set;}
    public String HNWI_ID                          {get;set;}
    public String orRating                  	   {get;set;}	
    public String riskClassification         	   {get;set;}	
    public String transactionDate                  {get;set;}       
    //Agregadas para SicCode
    public string SIC_Code                         {get;set;}
    public string SIC_Description                  {get;set;}
    public string Economic_group_SIC_Code          {get;set;}
    public string Economic_Group_SIC_Description   {get;set;}  
    //Agregadas y que faltan en el esquema
    public string Party_Id                         {get;set;}
    public string SIC_CodeId                       {get;set;}
    public string SIC_CodeIndustry                 {get;set;}
    public string Economic_group_SIC_CodeId        {get;set;} 
    public string foreingn_TAX_ID                  {get;set;}
    //variable para el manejo del formato correspondiente
    public string vfSNameRead                      {get;set;}   
    public string vfSNameEdit                      {get;set;}      
    //Agregadas para buro
    public string buroFlag                         {get;set;}
    /*public string Top_Parent_ID {get;set;}
    public String Account_ID{get;set;}*/
    public string Top_Parent_ID {
        get {
            return Top_Parent_ID; 
        }
        set {
            system.debug('original ' + value);
            if(value!=null && value.length() >= 15){
               String s2 = value.substring(0, 15);
            system.debug('valor '+s2);
            this.Top_Parent_ID = s2; 
            }else{
                system.debug('valor vacio');
            }
            
        }
    }
    public String Account_ID{
        get {
            return Account_ID; 
        }
        set {
            system.debug('original ' + value);
            if(value!=null && value.length() >= 15){
               String s2 = value.substring(0, 15);
            system.debug('valor '+s2);
            this.Account_ID = s2; 
            }else{
                system.debug('valor vacio');
            }
            
        }
    }

}