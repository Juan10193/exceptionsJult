global with sharing class ConvertForecastExtensionController {
    Private final Takedowns_Contingency_plan__c takedownsCp;
	public ApexPages.StandardController stdCtrl;
    public string Opportunity {get;set;}
    public string TDAmount {get;set;}
    public string Divisa {get;Set;}
    public string EasyFId {get;set;}
    public string InvoiceCurrency {get;Set;}
    public string FundingDate {get;set;}
    public string InsideSalesComments {get;Set;}
    public string converted {get;Set;}
    public string IdForecast {get;set;}
    public string OwnerId {get;set;}
    public string UserName {get;set;} 
    
    public ConvertForecastExtensionController(ApexPages.StandardController stdController){
        this.takedownsCp=(Takedowns_Contingency_plan__c)stdController.getRecord();
        this.stdCtrl = stdController;
        this.Opportunity = apexpages.currentpage().getparameters().get('Opportunity');
        this.TDAmount = apexpages.currentpage().getparameters().get('TDAmount');
        this.Divisa = apexpages.currentPage().getparameters().get('CurrencyIsoCode');
        this.EasyFId = apexpages.currentPage().getparameters().get('EasyFId');
        this.InvoiceCurrency =apexpages.currentPage().getparameters().get('InvoiceCurrency');
        this.FundingDate = apexpages.currentPage().getparameters().get('FundingDate');
        this.InsideSalesComments =apexpages.currentPage().getparameters().get('InsideSalesComments');
        this.converted = apexpages.currentPage().getparameters().get('converted');
        this.IdForecast =apexpages.currentPage().getparameters().get('IDForecast');
        this.OwnerId =apexpages.currentPage().getparameters().get('OwnerId');
        
        if(this.converted == '1'){
            NewRecord();
        }
    }
    
   public PageReference NewRecord()
    {
      
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'This Easy Forecast has been Converted befores'));
        
        PageReference pg = new PageReference('/'+IdForecast );
        pg.setRedirect(true);
        return pg;  
    }
    
    public PageReference back(){
        PageReference pg = new PageReference('/'+IdForecast );
        pg.setRedirect(false);
        return pg;  
    }
 
}