public class MD_ExtencionControllerOpcas {

    public Carveout_in_Credit_Approval_CP__c      oppcar             {get;set;}
    public Opportunity_in_Credit_approval_CP__c   oppsInCarveout	 {get;set;} 
    public string                                 idOpportunity      {get;set;}
    public  SelectOption[]                        listaOps           {get;set;}
    public ApexPages.StandardController           stdCtrl;
    public string                                 riskE              {get;set;}
    public boolean                                activaPagina       {get;set;}
    public boolean                                TipoDetalleMOD     {get;set;}
    public List<ES3_OpportunitiesInCaWraper>	  opps     			 {get;set;}
    public boolean CarveoutAct;
 
    
    public MD_ExtencionControllerOpcas (Carveout_in_Credit_Approval_CP__c oppcar) {
       this.oppcar = oppcar;
    }
    
    public MD_ExtencionControllerOpcas (Id oppInCarId ) {
        cargaOppInCar(oppInCarId);
               
    }

    public void valida(){
        TipoDetalleMOD = false;
        list<Credit_approval_CP__c> a = [SELECT Type_of_credit_approval__c,RecordType.Name from Credit_approval_CP__c where Id=:getCAID()];
        system.debug('aron ' + a[0].Type_of_credit_approval__c);
        if(a[0].Type_of_credit_approval__c == 'MOD/MAC'){
            TipoDetalleMOD=true;
        }else{
            TipoDetalleMOD=false;
        }
    }
    
    public MD_ExtencionControllerOpcas(ApexPages.StandardController stdController) {
        this.oppcar =(Carveout_in_Credit_Approval_CP__c)stdController.getRecord();
        //this.oppsInCarveout=(Opportunity_in_Credit_approval_CP__c)stdController.getRecord();
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
            this.activaPagina =false;
        }else{
            this.activaPagina =true;
        }
        
        SYSTEM.debug('O' + activaPagina);
        
        valida();
    }
    
    public string getCAID(){
        return oppcar.MD_rls_Credit_approval__c;
       
    }
     
    public SelectOption[] getListOpInCaMOD(){
        system.debug('lista de CA MOD'); 
        list<Credit_approval_CP__c>nombreCuenta = [SELECT CPL_rb_account__c, Name,	Type_of_credit_approval__c from Credit_approval_CP__c where Id =:getCAID()];
        list<Carveout_in_Credit_Approval_CP__c> montoCuenta = [SELECT MD_num_Destination_Amount__c, Name from Carveout_in_Credit_Approval_CP__c where Id =:getCAID()];   
        system.debug('nombreCuenta:' +nombreCuenta[0].CPL_rb_account__c);
        listaOps = new SelectOption[0];
        for(Opportunity record : [Select Id, Name  from Opportunity where Opportunity.Account.Id=:nombreCuenta[0].CPL_rb_account__c 
                                  AND (StageName='Backlog' )
                                  AND CPL_fm_Final_Balance__c>0]){
                                      
                                      listaOps.add(new SelectOption(record.Id, record.Name));
                                  }   
        system.debug('listaaaa: ' + listaOps); 
        return listaOps;
    }
    
    public SelectOption[] getListOpInCaModDestino(){
        system.debug('lista de CA MOD destino');
        list<Credit_approval_CP__c>nombreCuenta = [SELECT CPL_rb_account__c from Credit_approval_CP__c where Id =:getCAID()];
        system.debug('nombreCuenta:' +nombreCuenta[0].CPL_rb_account__c);
        listaOps = new SelectOption[0];
        for(Opportunity record : [Select Id, Name  from Opportunity where Opportunity.Account.Id=:nombreCuenta[0].CPL_rb_account__c 
                                  AND (StageName='Proposal Awarded' OR StageName='Backlog' OR StageName='Backlog with fundings' OR StageName='Partially Booked' OR StageName='Expired Unused Backlog' )
                                  ]){
                                      
                                      listaOps.add(new SelectOption(record.Id, record.Name));
                                  }   
        system.debug('listaaaa: ' + listaOps); 
        return listaOps;
    }

     public void cargaOppInCar(Id oppInCarId)  {
        this.oppcar = new Carveout_in_Credit_Approval_CP__c();
        List <Opportunity_in_Credit_approval_CP__c> oppsInCarveout = [Select Id,Name,CP_rb_Credit_approval_CP__r.Name
                        FROM Opportunity_in_Credit_approval_CP__c  
                        where CP_rb_Credit_approval_CP__c =:getCAID()];
        try{
            this.oppcar = [Select Id, Name,Opportunity_in_CA__c	, Opportunity_in_CA__r.Name , count_carvaut__c,CreatedById,CurrencyIsoCode,LastModifiedById,MD_Amount__c,MD_chec_Copy_Date_MAC__c,
                                  MD_date_Date__c,MD_fm_Restado__c,MD_fm_Sumado__c,MD_num_Destination_Amount__c,MD_Opp_use_by_carveaut__c,MD_Opportunity__c,MD_Opportunity__r.Name,
                                  MD_rl_Destination_Opportunity__c,MD_rls_Credit_approval__c,MD_rls_Credit_approval__r.Name
                           
                            FROM Carveout_in_Credit_Approval_CP__c   
                            where id =:oppInCarId] [0]; 
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }             
    }
    
    public pageReference saveop(){
        String fullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/lightning/r/Credit_approval_CP__c/'+oppcar.MD_rls_Credit_approval__c+'/view';
        pageReference pr = new pageReference(fullRecordURL);
        insert oppcar;
        
        pr.setRedirect(true);
        
        return pr;
        
    }

    public pageReference refresh(){
     pageReference prr = ApexPages.currentPage();
        prr.setRedirect(true);
        return null;
    }
    
    public list<Carveout_in_Credit_Approval_CP__c> opp_in_ca(string id){
        list<Carveout_in_Credit_Approval_CP__c> opp = new list<Carveout_in_Credit_Approval_CP__c>(); 
        for(Carveout_in_Credit_Approval_CP__c oppincar : [Select id,Name, MD_Opportunity__c  from Carveout_in_Credit_Approval_CP__c where MD_Opportunity__c =:id] ){
            if (oppincar != null) {
                opp.add(oppincar);

            }
          
        }
        system.debug('listas oppinca ' + opp);

        

        return opp;
    }
    
    public PageReference NewRecord(){
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'You can´t Add more Opportunities'));
        PageReference pg = new PageReference('/'+getCAID() );
        pg.setRedirect(true);
        return pg;  
    }
    }