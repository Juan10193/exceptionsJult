/**
 * @File Name          : archivo bc.apxc
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/11/2019 13:49:33
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    11/11/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
trigger TR_actOppCAStatus on Credit_approval_CP__c (before update) {
    
    //Listas CA Normal
    List<id> idCaListInProcess = new List<id>();
    List<id> idCaListApproved = new List<id>();
    List<id> idCaListDeclined = new List<id>();
    List<ES3_obj_Pricing_in_Credit_Approval__c> listPricingInCA = new List<ES3_obj_Pricing_in_Credit_Approval__c>();
    List<id> IdOpps = new List<id>();
    //Listas MAC
    List<id> idCaListInProcessMac = new List<id>();
    List<id> idCaListDeclinedMac = new List<id>();
    List<id> idCaListApprovedMac = new List<id>();
    //Listas MOD/MAC
    List<id> idCaListInProcessMODMac = new List<id>();
    List<id> idCaListDeclinedMODMac = new List<id>();
    List<id> idCaListApprovedMODMac = new List<id>();
    List<id> idCaListApprovedMODMacdos = new List<id>();
   List<id> idCaListApprovedAddOnMODMac = new List<id>();
    List<id>idCaListApprovedIncrementalMODMac = new List<id>();
    List<Opportunity_in_Credit_approval_CP__c> listOppInCA = new List <Opportunity_in_Credit_approval_CP__c>();
    List<Carveout_in_Credit_Approval_CP__c> listCarveoutInCA = new List <Carveout_in_Credit_Approval_CP__c>();
    
    //Listas Workout
    List<id> idCaListInProcessWK = new List<id>();
    List<id> idCaListDeclinedWK = new List<id>();
    List<id> idCaListApprovedWK = new List<id>();

    //TR_handler_actOppCAStatus 
    String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
    boolean canIUpdate = true;
    boolean insertCarveout = true;
    map<id,string> mapRecordType = new map<id,string>();
    for(RecordType RT : [SELECT Id, Name, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Credit_approval_CP__c']){
        mapRecordType.put(RT.id,RT.name);    
    }
    if(Trigger.isbefore && Trigger.isUpdate){
        TR_handler_actOppCAStatus handler_actOppCAStatus = new TR_handler_actOppCAStatus();
        if(!profileName.equals('Administrator') && !profileName.equals('System Administrator') && !profileName.equals('Administrador del sistema')){
            canIUpdate = handler_actOppCAStatus.addErrorUpdate(Trigger.newMap);   
        } 
    }
    for(Integer i=0; i<trigger.new.size(); i++)
    {
        
        
        if(Trigger.isUpdate && Approval.isLocked(trigger.new[i].Id)){      Approval.unlock(trigger.new[i].Id);}
        
        
        
        if((trigger.new[i].ES3_ls_RISK_REVIEW_STATUS__c!=trigger.old[i].ES3_ls_RISK_REVIEW_STATUS__c)||
           (trigger.new[i].ES3_ls_AML_Review_Status__c!=trigger.old[i].ES3_ls_AML_Review_Status__c)){
                   
               if(trigger.new[i].ES3_ls_RISK_REVIEW_STATUS__c=='Approved' && (trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved' ||trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved with conditions') && 
                  Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Credit Approval').getRecordTypeId()==trigger.new[i].RecordTypeId)
               {    
                   
                   trigger.new[i].CPL_ls_StageName__c = 'Approved'; 
                   trigger.new[i].Decision_Date__c = Date.today();
               }
               
               if(trigger.new[i].ES3_ls_RISK_REVIEW_STATUS__c=='Approved' && (trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved' ||trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved with conditions'||  trigger.new[i].ES3_ls_AML_Review_Status__c=='New') && 
                 Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('MAC').getRecordTypeId()==trigger.new[i].RecordTypeId)
               {
                   trigger.new[i].CPL_ls_StageName__c = 'Approved'; 
                   trigger.new[i].Decision_Date__c = Date.today();
               }
               
               if(trigger.new[i].ES3_ls_RISK_REVIEW_STATUS__c=='Approved' && (trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved' ||trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved with conditions'||  trigger.new[i].ES3_ls_AML_Review_Status__c=='New') && 
                  Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('MOD/MAC').getRecordTypeId()==trigger.new[i].RecordTypeId)
               {
                   trigger.new[i].CPL_ls_StageName__c = 'Approved'; 
                   trigger.new[i].Decision_Date__c = Date.today();
               }
               if(trigger.new[i].ES3_ls_RISK_REVIEW_STATUS__c=='Approved' && (trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved' || trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved with conditions'||  trigger.new[i].ES3_ls_AML_Review_Status__c=='New')     && 
                 Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Workout').getRecordTypeId()==trigger.new[i].RecordTypeId)
               {
                   trigger.new[i].CPL_ls_StageName__c = 'Approved'; 
                   trigger.new[i].Decision_Date__c = Date.today();
               }
               /*if((trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved' || trigger.new[i].ES3_ls_AML_Review_Status__c=='Approved with conditions'||  trigger.new[i].ES3_ls_AML_Review_Status__c=='New')  && 
                 Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Workout').getRecordTypeId()==trigger.new[i].RecordTypeId)
               {
                   trigger.new[i].CPL_ls_StageName__c = 'Approved'; 
                   trigger.new[i].Decision_Date__c = Date.today();
               }*/
           }
        
        //Validamos que algun valor del pricing ha cambiado
        system.debug('canIUpdate ' + canIUpdate);
        if(canIUpdate){
            if(trigger.new[i].ES3_nu_Advance_Payment__c != trigger.old[i].ES3_nu_Advance_Payment__c ||
               trigger.new[i].ES3_tx_Appraisal__c != trigger.old[i].ES3_tx_Appraisal__c ||
               trigger.new[i].ES3_tx_Boot_Collateral__c != trigger.old[i].ES3_tx_Boot_Collateral__c ||
               //trigger.new[i].ES3_ls_Boot_Collateral_Type__c != trigger.old[i].ES3_ls_Boot_Collateral_Type__c ||
               trigger.new[i].ES3_ls_EBO__c != trigger.old[i].ES3_ls_EBO__c ||
               trigger.new[i].ES3_tl_EBO_Description__c != trigger.old[i].ES3_tl_EBO_Description__c||
               trigger.new[i].ES3_ls_EFA__c != trigger.old[i].ES3_ls_EFA__c ||
               trigger.new[i].ES3_nu_Grace_Period_in_Months__c != trigger.old[i].ES3_nu_Grace_Period_in_Months__c ||
               trigger.new[i].ES3_ls_Low_High_High_Low__c != trigger.old[i].ES3_ls_Low_High_High_Low__c ||
               trigger.new[i].ES3_ls_Progress_Payments__c != trigger.old[i].ES3_ls_Progress_Payments__c ||
               trigger.new[i].ES3_nu_Progress_Payments_M__c != trigger.old[i].ES3_nu_Progress_Payments_M__c ||
               trigger.new[i].ES3_pc_Remarketing_Fee__c != trigger.old[i].ES3_pc_Remarketing_Fee__c ||
               trigger.new[i].ES3_nu_ROI_No_Insurance__c != trigger.old[i].ES3_nu_ROI_No_Insurance__c ||
               trigger.new[i].ES3_ls_SL_B_YES_NO__c != trigger.old[i].ES3_ls_SL_B_YES_NO__c ||
               trigger.new[i].ES3_pc_Split_Trac__c != trigger.old[i].ES3_pc_Split_Trac__c ||
               trigger.new[i].ES3_pc_Trac__c != trigger.old[i].ES3_pc_Trac__c    ||
               trigger.new[i].ES3_ls_Type_of_Grace_Period__c != trigger.old[i].ES3_ls_Type_of_Grace_Period__c ||
               trigger.new[i].ES3_ls_Used_New__c != trigger.old[i].ES3_ls_Used_New__c ||
               trigger.new[i].ES3_NUM_SD__c != trigger.old[i].ES3_NUM_SD__c ||
               trigger.new[i].ES3_pc_Rate__c!= trigger.old[i].ES3_pc_Rate__c||
               trigger.new[i].ES3_pc_RV__c != trigger.old[i].ES3_pc_RV__c||
               trigger.new[i].ES3_pc_Opening_Fee__c != trigger.old[i].ES3_pc_Opening_Fee__c||
               trigger.new[i].ES3_pc_Term_in_months_without_PP__c != trigger.old[i].ES3_pc_Term_in_months_without_PP__c||
               trigger.new[i].ES3_pc_Frequency_Monthly_Quarterly__c != trigger.old[i].ES3_pc_Frequency_Monthly_Quarterly__c||
               trigger.new[i].ES3_pc_Term_in_Months__c != trigger.old[i].ES3_pc_Term_in_Months__c||
               trigger.new[i].ES3_num_Ballon_Bullet_Payment__c  != trigger.old[i].ES3_num_Ballon_Bullet_Payment__c||
               trigger.new[i].ES3_pc_P_option__c  != trigger.old[i].ES3_pc_P_option__c ||
               trigger.new[i].BKL_pc_Lock_Fee__c != trigger.old[i].BKL_pc_Lock_Fee__c||
               trigger.new[i].BKL_lst_Prom_Note__c != trigger.old[i].BKL_lst_Prom_Note__c||
               trigger.new[i].BKL_TXT_L_H_Description__c != trigger.old[i].BKL_TXT_L_H_Description__c||
               trigger.new[i].BKL_TXT_Progres_Description__c != trigger.old[i].BKL_TXT_Progres_Description__c||
               trigger.new[i].BKL_txt_EOL_Option__c != trigger.old[i].BKL_txt_EOL_Option__c||
               trigger.new[i].BKL_TXT_Model_Asset_Return_Condition__c != trigger.old[i].BKL_TXT_Model_Asset_Return_Condition__c||
               trigger.new[i].BKL_TXT_Model__c!= trigger.old[i].BKL_TXT_Model__c||
               trigger.new[i].BKL_TXT_Asset__c != trigger.old[i].BKL_TXT_Asset__c||
               trigger.new[i].ES3_pc_COLLECTION_RIGHTS__c != trigger.old[i].ES3_pc_COLLECTION_RIGHTS__c||
               trigger.new[i].ES3_pc_CROSS_COLLATERAL__c     != trigger.old[i].ES3_pc_CROSS_COLLATERAL__c||
               trigger.new[i].ES3_pc_DIRECT_DEBIT__c     != trigger.old[i].ES3_pc_DIRECT_DEBIT__c||
               trigger.new[i].ES3_pc_CASH_COLLATERAL__c != trigger.old[i].ES3_pc_CASH_COLLATERAL__c||
               trigger.new[i].ES3_pc_C_PELIGROSA__c  != trigger.old[i].ES3_pc_C_PELIGROSA__c    ||
               trigger.new[i].BKL_TXT_Return_Condition__c != trigger.old[i].BKL_TXT_Return_Condition__c||
               trigger.new[i].BLG_pr_SD_percent__c != trigger.old[i].BLG_pr_SD_percent__c||
               trigger.new[i].BLG_at_SD_Comment__c  != trigger.old[i].BLG_at_SD_Comment__c//||
               //mod
               //trigger.new[i].JR_num_Security_Deposit_Rents__c    != trigger.old[i].JR_num_Security_Deposit_Rents__c
              )
            {    System.debug('pru');
                for(ES3_obj_Pricing_in_Credit_Approval__c p : [Select id from ES3_obj_Pricing_in_Credit_Approval__c where ES3_rb_Credit_approval_CP__c=:trigger.new[i].id])
                {
                     System.debug('pru1');
                    p.ES3_nu_Advance_PaymentPercent__c  = trigger.new[i].ES3_nu_Advance_Payment__c;     
                    p.ES3_tx_Appraisal__c               = trigger.new[i].ES3_tx_Appraisal__c;                               
                    p.ES3_tx_Boot_Collateral__c         = trigger.new[i].ES3_tx_Boot_Collateral__c;             
                    p.ES3_ls_EBO__c                     = trigger.new[i].ES3_ls_EBO__c;
                    p.ES3_tl_EBO_Description__c         = trigger.new[i].ES3_tl_EBO_Description__c;
                    p.ES3_ls_EFA__c                     = trigger.new[i].ES3_ls_EFA__c;                                     
                    p.ES3_nu_Grace_Period_in_Months__c  = trigger.new[i].ES3_nu_Grace_Period_in_Months__c;  
                    p.ES3_ls_Low_High_High_Low__c       = trigger.new[i].ES3_ls_Low_High_High_Low__c;           
                    p.ES3_ls_Progress_Payments__c       = trigger.new[i].ES3_ls_Progress_Payments__c; 
                    p.ES3_num_SD__c                     = trigger.new[i].ES3_num_SD__c;         
                    p.ES3_pc_Opening_Fee__c             = trigger.new[i].ES3_pc_Opening_Fee__c;  
                    p.ES3_pc_Term_in_months_without_PP__c = trigger.new[i].ES3_pc_Term_in_months_without_PP__c; 
                    p.ES3_pc_Frequency_Monthly_Quarterly__c = trigger.new[i].ES3_pc_Frequency_Monthly_Quarterly__c; 
                    p.ES3_pc_Term_in_Months__c          = trigger.new[i].ES3_pc_Term_in_Months__c;
                    p.ES3_pc_P_option__c                = trigger.new[i].ES3_pc_P_option__c;
                    p.ES3_nu_Progress_Payments_M__c     = trigger.new[i].ES3_nu_Progress_Payments_M__c;     
                    p.ES3_pc_Remarketing_Fee_Percent__c = trigger.new[i].ES3_pc_Remarketing_Fee__c;         
                    p.ES3_nu_ROI_No_Insurance__c        = trigger.new[i].ES3_nu_ROI_No_Insurance__c;            
                    p.ES3_ls_SL_B_YES_NO__c             = trigger.new[i].ES3_ls_SL_B_YES_NO__c; 
                    p.ES3_pc_Split_Trac_Percentent__c   = trigger.new[i].ES3_pc_Split_Trac__c;          
                    p.ES3_pc_Trac_Percent__c            = trigger.new[i].ES3_pc_Trac__c;                                
                    p.ES3_ls_Type_of_Grace_Period__c    = trigger.new[i].ES3_ls_Type_of_Grace_Period__c;    
                    p.ES3_ls_Used_New__c                = trigger.new[i].ES3_ls_Used_New__c;                    
                    p.ES3_pc_Rate__c                    = trigger.new[i].ES3_pc_Rate__c;    
                    p.ES3_pc_RV__c                      = trigger.new[i].ES3_pc_RV__c;                      
                    p.ES3_num_Ballon_Bullet_Payment__c  = trigger.new[i].ES3_num_Ballon_Bullet_Payment__c;
                    p.BKL_pc_Lock_Fee__c                = trigger.new[i].BKL_pc_Lock_Fee__c; 
                    p.BKL_lst_Prom_Note__c              = trigger.new[i].BKL_lst_Prom_Note__c;
                    p.BKL_TXT_L_H_Description__c = trigger.new[i].BKL_TXT_L_H_Description__c;
                    P.BKL_TXT_Progres_Description__c = trigger.new[i].BKL_TXT_Progres_Description__c;
                    p.BKL_txt_EOL_Option__c = trigger.new[i].BKL_txt_EOL_Option__c;
                    p.BKL_TXT_Model_Asset_Return_Condition__c = trigger.new[i].BKL_TXT_Model_Asset_Return_Condition__c;
                    p.BKL_TXT_Model__c = trigger.new[i].BKL_TXT_Model__c;
                    p.BKL_TXT_Asset__c = trigger.new[i].BKL_TXT_Asset__c;
                    p.BKL_TXT_Return_Condition__c = trigger.new[i].BKL_TXT_Return_Condition__c;
                    p.BLG_pr_SD_percent__c = trigger.new[i].BLG_pr_SD_percent__c;
                    p.BLG_at_SD_Comment__c  = trigger.new[i].BLG_at_SD_Comment__c;
                    p.ES3_pc_COLLECTION_RIGHTS__c = trigger.new[i].ES3_pc_COLLECTION_RIGHTS__c;
                    p.ES3_pc_CROSS_COLLATERAL__c = trigger.new[i].ES3_pc_CROSS_COLLATERAL__c;
                    p.ES3_pc_DIRECT_DEBIT__c = trigger.new[i].ES3_pc_DIRECT_DEBIT__c;
                    p.ES3_pc_CASH_COLLATERAL__c = trigger.new[i].ES3_pc_CASH_COLLATERAL__c;
                    p.ES3_pc_C_PELIGROSA__c = trigger.new[i].ES3_pc_C_PELIGROSA__c;
                    //mod
                    //p.JR_num_Security_Deposit_Rents__c    = trigger.new[i].JR_num_Security_Deposit_Rents__c;
                    listPricingInCA.add(p); 
                }            
            }  
        }
        //Validamos que el valor de stage este cambiando
        if(trigger.new[i].CPL_ls_StageName__c != trigger.old[i].CPL_ls_StageName__c)
        {
            
            //Si el nuevo valor es en progreso
            System.debug('OEJ Estoy Entrando a validar el estado y el recortype ' + trigger.new[i].CPL_ls_StageName__c + ' ' + trigger.new[i].RecordTypeId);
            //String nameOfRecordType = [Select name from RecordType where id = :trigger.new[i].RecordTypeId][0].name;
            String nameOfRecordType = mapRecordType.get(trigger.new[i].RecordTypeId);
            //String nameOfRecordType = trigger.new[i].RecordTypeId][0].name;
            System.debug('El nombre del recordType es :' + nameOfRecordType + ':');
            
            if(trigger.new[i].CPL_ls_StageName__c == 'In Process' && nameOfRecordType == 'Credit Approval')                                                 
            {
                idCaListInProcess.add(trigger.new[i].id); 
            }
            
            if(trigger.new[i].CPL_ls_StageName__c == 'In Process' && nameOfRecordType == 'MAC')                                                 
            {
                idCaListInProcessMac.add(trigger.new[i].id); 
            }
            
            if(trigger.new[i].CPL_ls_StageName__c=='In Process'&& nameOfRecordType == 'MOD/MAC')
            {
                idCaListInProcessMODMac.add(trigger.new[i].id);
            }
        if(trigger.new[i].CPL_ls_StageName__c=='In Process'&& nameOfRecordType == 'Workout')
            {
                idCaListInProcessWK.add(trigger.new[i].id);
            }
            
            
            if(trigger.new[i].CPL_ls_StageName__c == 'Decline' && nameOfRecordType == 'Credit Approval')                                                        
            {
                System.debug('OEJ Estoy Entrando en Declined Credit Approval');
                idCaListDeclined.add(trigger.new[i].id); 
            }
            
            if(trigger.new[i].CPL_ls_StageName__c == 'Decline' && nameOfRecordType == 'MAC')                                                        
            {
                System.debug('OEJ Estoy Entrando en Declined MAC');
                idCaListDeclinedMac.add(trigger.new[i].id); 
            }
            
            if(trigger.new[i].CPL_ls_StageName__c == 'Decline' && nameOfRecordType == 'MOD/MAC')                                                        
            {
                System.debug('OEJ Estoy Entrando en Declined MOD/MAC');
                idCaListDeclinedMODMac.add(trigger.new[i].id); 
            }
        if(trigger.new[i].CPL_ls_StageName__c == 'Decline' && nameOfRecordType == 'Workout')                                                        
            {
                System.debug('OEJ Estoy Entrando en Declined Workout');
                idCaListDeclinedWK.add(trigger.new[i].id); 
            }
            
            //Si el nuevo valor es Withdrawn (hacemos los mismo que declined)
            if(trigger.new[i].CPL_ls_StageName__c == 'Withdrawn' && nameOfRecordType == 'Credit Approval')
            {
                idCaListDeclined.add(trigger.new[i].id); 
            }
            
            if(trigger.new[i].CPL_ls_StageName__c == 'Withdrawn' && nameOfRecordType == 'MAC')
            {
                idCaListDeclinedMac.add(trigger.new[i].id); 
            }
            
            if(trigger.new[i].CPL_ls_StageName__c == 'Withdrawn' && nameOfRecordType == 'MOD/MAC')
            {
                idCaListDeclinedMODMac.add(trigger.new[i].id); 
            }
        if(trigger.new[i].CPL_ls_StageName__c == 'Withdrawn' && nameOfRecordType == 'Workout')
            {
                idCaListDeclinedWK.add(trigger.new[i].id); 
            }
            
            
            //Si el nuevo valor es Withdrawn (hacemos los mismo que declined)
            if(nameOfRecordType == 'Credit Approval' && trigger.new[i].CPL_ls_StageName__c == 'Approved') 
            {
                idCaListApproved.add(trigger.new[i].id);
            }
            
            if(nameOfRecordType == 'MAC' && trigger.new[i].CPL_ls_StageName__c == 'Approved') 
            {
                idCaListApprovedMac.add(trigger.new[i].id);
            }
            if(nameOfRecordType == 'MOD/MAC' && trigger.new[i].CPL_ls_StageName__c == 'Approved') 
            {
                idCaListApprovedMODMac.add(trigger.new[i].id);
                idCaListApprovedMODMacdos.add(trigger.new[i].id);
                idCaListApprovedAddOnMODMac.add(trigger.new[i].id);
                idCaListApprovedIncrementalMODMac.add(trigger.new[i].id);
            }
        if(nameOfRecordType == 'Workout' && trigger.new[i].CPL_ls_StageName__c == 'Approved') 
            {
                system.debug('hola wK');
                idCaListApprovedWK.add(trigger.new[i].id);
            }
            
        }     
        
    }
    
    if(idCaListDeclinedMODMac.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateReasonLostMODMAC(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListDeclinedMODMac)));}
    if(idCaListApprovedMODMac.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateCreditLineMOD(CPI_CACP_CAUpdateOpps.selectOppsInCAMOD(idCaListApprovedMODMac)));}
    if(idCaListApprovedMODMacdos.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateCreditLineMODmac(CPI_CACP_CAUpdateOpps.selectOppsInCAMOD(idCaListApprovedMODMacdos)));}
    if(idCaListApprovedAddOnMODMac.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateAddOnMODMAC(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListApprovedAddOnMODMac)));}
    if(idCaListApprovedIncrementalMODMac.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateIncrementalMODMAC(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListApprovedIncrementalMODMac)));}
    
 
    
    //if(idCaListInProcessMac.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateInCredit(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListInProcessMac)));}
    if(idCaListDeclinedMac.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateReasonLostMAC(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListDeclinedMac)));}
    if(idCaListApprovedMac.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateCreditLine(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListApprovedMac)));}
    if(idCaListApprovedWK.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateCreditLine(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListApprovedWk)));}

    if(idCaListInProcess.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateInCredit(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListInProcess)));}
    if(idCaListApproved.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateCreditLine(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListApproved)));}
    if(idCaListDeclined.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateReasonLost(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListDeclined)));}
    if(listPricingInCA.size()>0) {
    
    if(idCaListApprovedWK.size()>0) {CPI_CACP_CAUpdateOpps.updateOpps(CPI_CACP_CAUpdateOpps.OppsToUpdateCreditLine(CPI_CACP_CAUpdateOpps.selectOppsInCA(idCaListApprovedWk)));}
       // update listPricingInCA;
        
        // update listPricingInCA;
        
        Database.SaveResult[] result = Database.update(listPricingInCA, false);
        for(Database.SaveResult saveResult : result){
            if (!saveResult.isSuccess()) {               
                for(Database.Error err : saveResult.getErrors()) {
                    System.debug('Código de estatus ' + err.getStatusCode());
                    System.debug('Mensaje ' + err.getMessage());
                    System.debug('Campos con error ' + err.getFields());
                }
                System.debug('Error en la insersión ');
            } else{ 
                System.debug('La inserción de prospectos se realizó con éxito');     
            }    
        }            
    }
  
}