public class CPI_CACP_CAUpdateOpps {
    
    public static List<Opportunity_in_Credit_approval_CP__c> selectOppsInCA(List<id> idCaListInProcess) 
    {
        List<Opportunity_in_Credit_approval_CP__c> oppInCa = new List<Opportunity_in_Credit_approval_CP__c>(); 
        
        try
        {            
            oppInCa = [Select id, 
                       CP_rb_Oportunidad__c, 
                       CP_rb_Oportunidad__r.Amount, 
                       CP_rb_Oportunidad__r.MC3_dt_Original_Expiration_Date__c,
                       CP_rb_Oportunidad__r.Approval_Date__c,
                       CP_rb_Oportunidad__r.CPL_date_Expiration_Date__c,
                       CP_rb_Credit_approval_CP__r.MD_fh_New_Validity_Date__c,
                       CP_rb_Credit_approval_CP__r.CPI_ck_ItMayBeProvidedInAnotherCurrency__c,
                       CP_rb_Credit_approval_CP__r.Decision_Date__c,
                       CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_1__c,
                       CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_2__c,
                       CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_3__c,
                       CP_rb_Credit_approval_CP__r.CPI_rb_Competitor__c,
                       CP_rb_Credit_approval_CP__r.CPI_tx_Lost_Comments__c,
                       CP_rb_Credit_approval_CP__r.RecordType.Name,
                       CP_rb_Credit_approval_CP__r.MC3_date_New_Expiration_Date__c,
                       MD_Sumado_AddOn__c,
                       MD_ls_Type_Credit_MOD__c,
                       MD_Sum_Increment__c
                      
        
                       
                       
                       from Opportunity_in_Credit_approval_CP__c where CP_rb_Credit_approval_CP__c IN:idCaListInProcess];
        }
        Catch(Exception e)
        {
            System.debug('Exception al seleccionar las Opp en el Credit Approvals OEJ:'+e.getMessage());
        }
        return oppInCa;
        
    }          
    
   //////////////////////MOD
    public static List<Carveout_in_Credit_Approval_CP__c> selectOppsInCAMOD(List<id> idCaListInProcessMOD) 
    {
        List<Carveout_in_Credit_Approval_CP__c> oppInCar = new List<Carveout_in_Credit_Approval_CP__c>(); 
        
        try
        {            
            oppInCar = [Select id, 
                        MD_Opportunity__c,
                        MD_Opportunity__r.Amount,
                        MD_date_Date__c,
                       MD_rl_Destination_Opportunity__c,//esta es la destino
                       MD_rl_Destination_Opportunity__r.Amount,
                        MD_rls_Credit_approval__c,
                        MD_rls_Credit_approval__r.RecordType.Name,
                        MD_fm_Sumado__c,
                        MD_fm_Restado__c,
                       MD_Opportunity__r.MC3_dt_Original_Expiration_Date__c,
                       MD_Opportunity__r.Approval_Date__c,
                       MD_Opportunity__r.CPL_date_Expiration_Date__c,
                       MD_rls_Credit_approval__r.MD_fh_New_Validity_Date__c
                        
                       from Carveout_in_Credit_Approval_CP__c where MD_rls_Credit_approval__c IN:idCaListInProcessMOD];
        }
        Catch(Exception e)
        {
            System.debug('Exception al seleccionar las Opp en el Credit Approvals :'+e.getMessage());
        }
        return oppInCar;
        
    }
  
    
    ///////////////////TERMINA MODDDDD_____////////////////////////////////////////
    
    public static List<Opportunity> OppsToUpdateInCredit(List<Opportunity_in_Credit_approval_CP__c> oppsInCA) 
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        if(oppsInCA.size()>0)
        {
            for(Opportunity_in_Credit_approval_CP__c oppInCA : oppsInCA)
            {
                oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,StageName='In Credit'));
            }
            
        }
        return oppToUpdate;
    }
    
    public static List<Opportunity> OppsToUpdateCreditLine(List<Opportunity_in_Credit_approval_CP__c> oppsInCA) 
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        Decimal CARate = 0.0;        
        try
        {            
            CARate = [Select ConversionRate FROM CurrencyType Where ConversionRate > 1.0 and IsActive = true and IsoCode = 'MXN'].ConversionRate;
        }
        Catch(Exception e)
        {
            System.debug('Exception al buscar el tipo de cambio CARate:'+e.getMessage());
        }
        if(oppsInCA.size()>0)
        {
            for(Opportunity_in_Credit_approval_CP__c oppInCA : oppsInCA)
            {
                system.debug('oppInCA.CP_rb_Credit_approval_CP__r.MC3_date_New_Expiration_Date__c' + oppInCA.CP_rb_Credit_approval_CP__r.MC3_date_New_Expiration_Date__c);
                //MAC
                if(oppInCa.CP_rb_Credit_approval_CP__r.RecordType.name == 'MAC'){
                    
                    oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                    //StageName='Backlog',
                                                    //CPL_dv_Approved_Amount__c = oppInCA.CP_rb_Oportunidad__r.Amount,
                                                    //CPL_nu_CA_Rate__c = CARate,
                                                    CPL_date_Expiration_Date__c = oppInCA.CP_rb_Credit_approval_CP__r.MC3_date_New_Expiration_Date__c                                                    
                                                    //CPL_ck_maybeProvidedAnotherCurrency__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ck_ItMayBeProvidedInAnotherCurrency__c
                                                   ));
                
                }else if(oppInCa.CP_rb_Credit_approval_CP__r.RecordType.name == 'Workout'){
                    
                    oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                    StageName='Processed',
                                                    CPL_dv_Approved_Amount__c = oppInCA.CP_rb_Oportunidad__r.Amount,
                                                    CPL_nu_CA_Rate__c = CARate,
                                                    CPL_date_Expiration_Date__c = System.today() + 90,
                                                    Approval_Date__c = oppInCA.CP_rb_Credit_approval_CP__r.Decision_Date__c
                                                    //CPL_ck_maybeProvidedAnotherCurrency__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ck_ItMayBeProvidedInAnotherCurrency__c
                                                   ));
                }
                 
                else{
                    oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                    StageName='Backlog',
                                                    CPL_dv_Approved_Amount__c = oppInCA.CP_rb_Oportunidad__r.Amount,
                                                    CPL_nu_CA_Rate__c = CARate,
                                                    CPL_date_Expiration_Date__c = System.today() + 90,
                                                    CPL_ck_maybeProvidedAnotherCurrency__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ck_ItMayBeProvidedInAnotherCurrency__c
                                                   ));
                }
            }
            
        }
        return oppToUpdate;
    }   
    
    
   // MODMAC
   // 
    public static List<Opportunity> OppsToUpdateCreditLineMOD(List<Carveout_in_Credit_Approval_CP__c> oppsInCAr) //Sumado Carveout
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        Decimal CARate = 0.0;        
        try
        {            
            CARate = [Select ConversionRate FROM CurrencyType Where ConversionRate > 1.0 and IsActive = true and IsoCode = 'MXN'].ConversionRate;
        }
        Catch(Exception e)
        {
            System.debug('Exception al buscar el tipo de cambio CARate:'+e.getMessage());
        }
        if(oppsInCAr.size()>0)
        {
            for(Carveout_in_Credit_Approval_CP__c oppInCAr : oppsInCAr)
            {
                System.debug('Prueba Contenido Carveuot' + oppsInCAr);
                if(oppInCar.MD_rls_Credit_approval__r.RecordType.Name == 'MOD/MAC'){
                    
                    
                    
                    oppToUpdate.add(new Opportunity(Id=oppInCAr.MD_rl_Destination_Opportunity__c,
                                                    StageName='Backlog',
                                                    CPL_date_Expiration_Date__c = System.today() + 90,
                                                    Approval_Date__c=oppInCAr.MD_rls_Credit_approval__r.MD_fh_New_Validity_Date__c,
                                                    CPL_dv_Approved_Amount__c= oppInCAr.MD_fm_Sumado__c));

                }
                else{
                    oppToUpdate.add(new Opportunity(id=oppInCAr.MD_rl_Destination_Opportunity__c,
                                                    
                                                    CPL_nu_CA_Rate__c = CARate,
                                                    CPL_date_Expiration_Date__c = System.today() + 90));
                }
                
            }
            
        }
        return oppToUpdate;
    }
    
    
     public static List<Opportunity> OppsToUpdateCreditLineMODmac(List<Carveout_in_Credit_Approval_CP__c> oppsInCAr) // Restado Carveout
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        Decimal CARate = 0.0;        
        try
        {            
            CARate = [Select ConversionRate FROM CurrencyType Where ConversionRate > 1.0 and IsActive = true and IsoCode = 'MXN'].ConversionRate;
        }
        Catch(Exception e)
        {
            System.debug('Exception al buscar el tipo de cambio CARate:'+e.getMessage());
        }
        if(oppsInCAr.size()>0)
        {
            for(Carveout_in_Credit_Approval_CP__c oppInCAr : oppsInCAr)
            {
                
                 if(oppInCar.MD_rls_Credit_approval__r.RecordType.Name == 'MOD/MAC'){
                        System.debug('valor a restar'+ oppInCAr.MD_fm_Restado__c);
                        oppToUpdate.add(new Opportunity(id=oppInCAr.MD_Opportunity__c,
                                                        CPL_dv_Approved_Amount__c =  oppInCAr.MD_fm_Restado__c));
                    }
                    else{
                        oppToUpdate.add(new Opportunity(id=oppInCAR.MD_Opportunity__c,
                                                         
                                                        CPL_nu_CA_Rate__c = CARate));
                                                       // CPL_date_Expiration_Date__c = System.today() + 180
                    }
                
            }
            
        }
        return oppToUpdate;
    } 
    
   
    
        public static List<Opportunity> OppsToUpdateAddOnMODMAC(List<Opportunity_in_Credit_approval_CP__c> oppsInCA) 
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        Decimal CARate = 0.0;        
        try
        {            
            CARate = [Select ConversionRate FROM CurrencyType Where ConversionRate > 1.0 and IsActive = true and IsoCode = 'MXN'].ConversionRate;
        }
        Catch(Exception e)
        {
            System.debug('Exception al buscar el tipo de cambio CARate:'+e.getMessage());
        }
        if(oppsInCA.size()>0)
        {
            System.debug('oppsInCA'+oppsInCA);
            for(Opportunity_in_Credit_approval_CP__c oppInCA : oppsInCA)
            {
                
                //MOD
                System.debug('ADD ON'+oppInCA.MD_Sumado_AddOn__c);
                if(oppInCa.CP_rb_Credit_approval_CP__r.RecordType.name == 'MOD/MAC' && oppInCa.MD_ls_Type_Credit_MOD__c=='ADD_ON'){
                    System.debug('ADD ON2'+oppInCA.MD_Sumado_AddOn__c);
                    
                    oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                  
                                                    StageName='Backlog',
                                                    CPL_date_Expiration_Date__c = System.today() + 90,
                                                    Approval_Date__c=oppInCA.CP_rb_Credit_approval_CP__r.Decision_Date__c,
                                                    CPL_dv_Approved_Amount__c =oppInCA.MD_Sumado_AddOn__c                                                    
                                                   ));
                    
                    System.debug('ADD ON'+oppInCA.MD_Sumado_AddOn__c);
                }
                else{
                    oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                   
                                                    CPL_nu_CA_Rate__c = CARate,
                                                    CPL_date_Expiration_Date__c = System.today() + 90,
                                                    CPL_ck_maybeProvidedAnotherCurrency__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ck_ItMayBeProvidedInAnotherCurrency__c
                                                   ));
                }
            }
            
        }
        return oppToUpdate;
    }
    
    
    
            public static List<Opportunity> OppsToUpdateIncrementalMODMAC(List<Opportunity_in_Credit_approval_CP__c> oppsInCA) 
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        Decimal CARate = 0.0;        
        try
        {            
            CARate = [Select ConversionRate FROM CurrencyType Where ConversionRate > 1.0 and IsActive = true and IsoCode = 'MXN'].ConversionRate;
        }
        Catch(Exception e)
        {
            System.debug('Exception al buscar el tipo de cambio CARate:'+e.getMessage());
        }
        if(oppsInCA.size()>0)
        {
            
            for(Opportunity_in_Credit_approval_CP__c oppInCA : oppsInCA)
            {
                
                //MOD
                
                if(oppInCa.CP_rb_Credit_approval_CP__r.RecordType.name == 'MOD/MAC' && oppInCa.MD_ls_Type_Credit_MOD__c=='Incremental'){
                  
                    oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
           
                                                    StageName='Backlog',
                                                    CPL_date_Expiration_Date__c = System.today() + 90,
                                                    Approval_Date__c=oppInCA.CP_rb_Credit_approval_CP__r.Decision_Date__c,
                                                    CPL_dv_Approved_Amount__c =oppInCA.MD_Sum_Increment__c                                                   
                                                   ));
                    
                    
                }
                else{
                    oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                   
                                                    CPL_nu_CA_Rate__c = CARate,
                                                    CPL_date_Expiration_Date__c = System.today() + 90,
                                                    CPL_ck_maybeProvidedAnotherCurrency__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ck_ItMayBeProvidedInAnotherCurrency__c
                                                   ));
                }
            }
            
        }
        return oppToUpdate;
    }
    
    
    
    
    
    
    //////////////////////////////TERMINA MOD
    
  
    //CA NORMAL
    
    public static List<Opportunity> OppsToUpdateReasonLost(List<Opportunity_in_Credit_approval_CP__c> oppsInCA) 
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        if(oppsInCA.size()>0)
        {
            for(Opportunity_in_Credit_approval_CP__c oppInCA : oppsInCA)
            {
                oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                StageName='Lost Deal', 
                                                OPP_ls_Reason_Lost_Level_1__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_1__c, 
                                                OPP_ls_Reason_Lost_Level_2__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_2__c, 
                                                OPP_ls_Reason_Lost_Level_3__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_3__c,
                                                OPP_rb_Competitor__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_rb_Competitor__c,	
                                                OPP_tx_Lost_Comments__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_tx_Lost_Comments__c));
            }
            
        }
        return oppToUpdate;
    }    
    //MAC
    
    public static List<Opportunity> OppsToUpdateReasonLostMAC(List<Opportunity_in_Credit_approval_CP__c> oppsInCA) 
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        if(oppsInCA.size()>0)
        {
            for(Opportunity_in_Credit_approval_CP__c oppInCA : oppsInCA)
            {
                oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                //StageName='Lost Deal', 
                                                OPP_ls_Reason_Lost_Level_1__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_1__c, 
                                                OPP_ls_Reason_Lost_Level_2__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_2__c, 
                                                OPP_ls_Reason_Lost_Level_3__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_3__c,
                                                OPP_rb_Competitor__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_rb_Competitor__c,	
                                                OPP_tx_Lost_Comments__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_tx_Lost_Comments__c));
            }
            
        }
        return oppToUpdate;
    }
     //MOD/MAC
    public static List<Opportunity> OppsToUpdateReasonLostMODMAC(List<Opportunity_in_Credit_approval_CP__c> oppsInCA) 
    {    
        //creamos las opps que queremos actualizar
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        if(oppsInCA.size()>0)
        {
            for(Opportunity_in_Credit_approval_CP__c oppInCA : oppsInCA)
            {
                oppToUpdate.add(new Opportunity(id=oppInCA.CP_rb_Oportunidad__c,
                                                StageName='Lost Deal', 
                                                OPP_ls_Reason_Lost_Level_1__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_1__c, 
                                                OPP_ls_Reason_Lost_Level_2__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_2__c, 
                                                OPP_ls_Reason_Lost_Level_3__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_ls_Reason_Lost_Level_3__c,
                                                OPP_rb_Competitor__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_rb_Competitor__c,	
                                                OPP_tx_Lost_Comments__c = oppInCA.CP_rb_Credit_approval_CP__r.CPI_tx_Lost_Comments__c));
            }
            
        }
        return oppToUpdate;
    }
    
    
    public static void updateOpps(List<Opportunity> opps) 
    {     
        try
        {
            if(opps.size()>0)
            {
                update opps;
            }
        }
        Catch(Exception e)
        {
            System.debug('Exception al actualizar las oportunidades OEJ:'+e.getMessage());
        }
    }
    
    
    
    
    
}