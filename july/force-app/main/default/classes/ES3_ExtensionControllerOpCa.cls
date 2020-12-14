public class ES3_ExtensionControllerOpCa {
    private final Opportunity_in_Credit_approval_CP__c oppca;
    //private final Carveout_in_Credit_Approval_CP__c oppcar;
    public string idOpportunity {get;set;}
    public  SelectOption[] listaOps {get;set;}
    public ApexPages.StandardController stdCtrl;
    public string riskE {get;set;}
    public boolean activaPag {get;set;}
    public boolean TipoDetalleMac {get;set;}
    public boolean TipoDetalleCA {get;set;}
    public boolean TipoDetalleMOD {get;set;}
	public boolean TipoDetalleWK {get;set;}
    public String  TypeOppMod {get;set;}
    public boolean TypeOppMod2 {get;set;}
    public List<MD_Controller_PDF_MODMAC>	opps   {get;set;}
    public void valida(){
        
        TipoDetalleMOD = false;
        TipoDetalleMac = false;
        TipoDetalleCA= false;
        TipoDetalleWK = false;
        list<Credit_approval_CP__c> a = [SELECT Type_of_credit_approval__c,RecordType.Name from Credit_approval_CP__c where Id=:getCAID()];
        system.debug('aron ' + a[0].Type_of_credit_approval__c);
        if(a[0].Type_of_credit_approval__c == 'MAC'){
            TipoDetalleMac=true;
        } else if(a[0].Type_of_credit_approval__c == 'MOD/MAC'){ 
            TipoDetalleMOD=true;
        }else if(a[0].RecordType.name == 'Workout'){
            TipoDetalleWK = true;
        }else{
            TipoDetalleCA=true;
        }
    }
    
    public ES3_ExtensionControllerOpCa(ApexPages.StandardController stdController) {
        this.oppca =(Opportunity_in_Credit_approval_CP__c)stdController.getRecord();
        this.stdCtrl = stdController;
        list<Credit_approval_CP__c> CA = [SELECT ES3_ls_RISK_REVIEW_STATUS__c from Credit_approval_CP__c where Id=:getCAID()];
        string riskStatus =  CA[0].ES3_ls_RISK_REVIEW_STATUS__c;
        system.debug('JD: riskstatus' + riskStatus);
        this.riskE = riskStatus;
        id id1 = userinfo.getProfileId();
        system.debug('JD idddd:' + id1);
        string profileName;
        
        for (profile record :[Select Name  from profile where Id=:id1]){
            profileName = record.Name;
            
        }
        
        system.debug('JD: profilename' + profileName);
        
        if((riskE == 'Approved' || riskE=='Decline' || riskE=='Approved with conditions' || riskE=='Withdrawn') && profileName !='System Administrator' && profileName !='Administrador del sistema' &&profileName!='Administrator' && profileName!='Administrador' ){
            this.activaPag =false;
        }else{
            this.activaPag =true;
        }
        
        SYSTEM.debug('O' + activaPag);
        
        valida();
    }
    
    public string getCAID(){
        return oppca.CP_rb_Credit_approval_CP__c;
    }
    
    public SelectOption[] getListOpInCa(){
        system.debug('lista de ca normales');
        list<Credit_approval_CP__c>nombreCuenta = [SELECT CPL_rb_account__c from Credit_approval_CP__c where Id =:getCAID()];
        system.debug('nombreCuenta:' +nombreCuenta[0].CPL_rb_account__c);
        listaOps = new SelectOption[0];
        for(Opportunity record : [Select Id, Name  from Opportunity where  Opportunity.Account.Id=:nombreCuenta[0].CPL_rb_account__c AND StageName='Proposal Awarded']){
            listaOps.add(new SelectOption(record.Id, record.Name));
        }   
        
        
        system.debug('listaaaa: ' + listaOps); 
        return listaOps;
    }
    
    
    public SelectOption[] getListOpInCaMac(){
        system.debug('lista de ca Mac');
        list<Credit_approval_CP__c>nombreCuenta = [SELECT CPL_rb_account__c from Credit_approval_CP__c where Id =:getCAID()];
        system.debug('nombreCuenta:' +nombreCuenta[0].CPL_rb_account__c);
        listaOps = new SelectOption[0];
        for(Opportunity record : [Select Id, Name  from Opportunity where Opportunity.Account.Id=:nombreCuenta[0].CPL_rb_account__c 
                                  AND (StageName='Backlog' OR StageName='Backlog with fundings' OR StageName='Partially Booked' OR StageName='Expired Unused Backlog')
                                  AND CPL_fm_Final_Balance__c>0]){
                                      
                                      listaOps.add(new SelectOption(record.Id, record.Name));
                                  }   
        system.debug('listaaaa: ' + listaOps); 
        return listaOps;
    }

      public SelectOption[] getListOpInMOD(){
        system.debug('lista MOD');
        list<Credit_approval_CP__c>nombreCuenta = [SELECT CPL_rb_account__c from Credit_approval_CP__c where Id =:getCAID()];
        system.debug('nombreCuenta:' +nombreCuenta[0].CPL_rb_account__c);
        listaOps = new SelectOption[0];
        for(Opportunity record : [Select Id, Name, StageName from Opportunity where  Opportunity.Account.Id=:nombreCuenta[0].CPL_rb_account__c AND (StageName='Proposal Awarded' OR
                                                   StageName='Backlog' OR StageName='Backlog with fundings' OR StageName='Partially Booked' OR StageName='Expired Unused Backlog')]){
                                                       
            listaOps.add(new SelectOption(record.Id,record.Name));                               
        }   
        
        
        system.debug('listaMOD: ' + listaOps); 
        return listaOps;
    }

    public SelectOption[] getListOpInCaWK(){
        list<Credit_approval_CP__c>nombreCuenta = [SELECT CPL_rb_account__c from Credit_approval_CP__c where Id =:getCAID()];
        listaOps = new SelectOption[0];
        for(Opportunity record : [Select Id, Name  from Opportunity where Opportunity.Account.Id=:nombreCuenta[0].CPL_rb_account__c 
                                  AND StageName='New' ]){
                                      list<Opportunity_in_Credit_approval_CP__c> oppcas = opp_in_ca(record.Id);
                                      if (oppcas.isEmpty()){
                                          listaOps.add(new SelectOption(record.Id, record.Name));
                                      } 
                                  }   
        system.debug('listaaaa: ' + listaOps); 
        return listaOps;
    }
   
    
    public pageReference saveop(){
        String fullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/lightning/r/Credit_approval_CP__c/'+oppca.CP_rb_Credit_approval_CP__c+'/view';
        pageReference pr = new pageReference(fullRecordURL);
        insert oppca;
        
        pr.setRedirect(true);
        
        return pr;
        
    }
    public list<Opportunity_in_Credit_approval_CP__c> opp_in_ca(string id){
        list<Opportunity_in_Credit_approval_CP__c> opp = new list<Opportunity_in_Credit_approval_CP__c>();
        for(Opportunity_in_Credit_approval_CP__c oppinca : [Select Name, MD_ls_Type_Credit_MOD__c  from Opportunity_in_Credit_approval_CP__c where CP_rb_Oportunidad__c =:id] ){
            if (oppinca != null) {	
                opp.add(oppinca);
            }
            
        }
        system.debug('listas oppinca ' + opp);
        return opp;
    } 
    
    public PageReference NewRecord()
    {
      
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'You can´t Add more Opportunities'));
        
        PageReference pg = new PageReference('/'+getCAID() );
        pg.setRedirect(true);
        return pg;  
    }
    
        
}