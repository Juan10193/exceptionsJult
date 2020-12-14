public class PPF_CreappfClass {
    public PPF_CreappfClass(){ crear(); }
    public string dateinstring(){
        string result;
        Date day = Date.today();
        integer month = day.month();
        integer year = day.year();
        switch on month {
            when 1 {result = 'Jan ' + year;}when 2 {result = 'Feb ' + year;}
            when 3 {result = 'Mar ' + year;}when 4 {result = 'Apr ' + year;}
            when 5 {result = 'May ' + year;}when 6 {result = 'Jun ' + year;}
            when 7 {result = 'Jul ' + year;}when 8 {result = 'Aug ' + year;}
            when 9 {result = 'Sep ' + year;} when 10 {result = 'Oct ' + year;}
            when 11 {result = 'Nov ' + year;}when 12 {result = 'Dec ' + year;}
            when else {system.debug('no tengo registrada esa fecha');}
        }return result;}
    public Boolean validaDay(){return true;}
    public void crear(){
        system.debug('hello world');
        string min = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='PP_Limite_min'][0].EIV_tx_parameter__c;
        string max = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='PP_Limite_max'][0].EIV_tx_parameter__c;
        
        list<Progress_Payment__c> allPP = [Select name,Id,PPE_Age_of_Commencement__c,PPF_rm_Progress_Payments_Fees__c,PPF_dt_Commencement__c,
                                           PPE_ls_DayOfTheMonthOfGenerationOfFee__c, CreatedDate,PPF_rb_Opportunity__c,PPF_rb_Original_Takedown_ProgressPayment__c,PPE_rb_User_ISC__c,CurrencyIsoCode
                                           FROM Progress_Payment__c 
                                           WHERE PPE_Age_of_Commencement__c >=:decimal.valueOf(min) 
                                           AND PPF_ck_Stop_Charge_Fee__c = : false];
        system.debug('JDLL: esto tenemos en allpp' + allPP);
        for(Progress_Payment__c PP :allPP){
            PPF_obj_Progress_Payment_Fee__c PPF;
            if(PP.PPE_Age_of_Commencement__c >= decimal.valueOf(min) && PP.PPE_Age_of_Commencement__c <= decimal.valueOf(max)){
                PPF = new PPF_obj_Progress_Payment_Fee__c( PPF_txid_progress_payment_fee_of_month__c = PP.name + ' - ' +dateinstring(),
                                                          PPE_rb_Opportunity__c = pp.PPF_rb_Opportunity__c,PPE_rb_Takedown_CP__c=pp.PPF_rb_Original_Takedown_ProgressPayment__c,                                
                                                          Fee_Amount_Percentege__c = '0.5',PPF_nu_PPFee__c=PP.PPF_rm_Progress_Payments_Fees__c+1,
                                                          PPF_rb_User_ISC__c=pp.PPE_rb_User_ISC__c,CurrencyIsoCode=PP.CurrencyIsoCode,
                                                          PPF_rb_Progress_Payment__c = PP.Id,PPE_dt_Commencement_Origin__c = PP.PPF_dt_Commencement__c); 
            }else if(PP.PPE_Age_of_Commencement__c > decimal.valueOf(max)){
                PPF = new PPF_obj_Progress_Payment_Fee__c( PPF_txid_progress_payment_fee_of_month__c = PP.name + ' - ' +dateinstring(),
                                                          PPE_rb_Opportunity__c = pp.PPF_rb_Opportunity__c,PPE_rb_Takedown_CP__c=pp.PPF_rb_Original_Takedown_ProgressPayment__c,  
                                                          Fee_Amount_Percentege__c = '1.0',PPF_nu_PPFee__c=PP.PPF_rm_Progress_Payments_Fees__c+1,
                                                          PPF_rb_User_ISC__c=pp.PPE_rb_User_ISC__c,CurrencyIsoCode=PP.CurrencyIsoCode,
                                                          PPF_rb_Progress_Payment__c = PP.Id,PPE_dt_Commencement_Origin__c = PP.PPF_dt_Commencement__c); 
            }else{system.debug('no voy a hacer nada :)'); }
            try{
                system.debug('JDLL :estoy apunto de insertar:' + PP.PPE_ls_DayOfTheMonthOfGenerationOfFee__c);
                if(PP.PPE_ls_DayOfTheMonthOfGenerationOfFee__c != null && Integer.valueOf(PP.PPE_ls_DayOfTheMonthOfGenerationOfFee__c)>0 )
                {
                    system.debug('OEJ Esta seleccionada una fecha'); 
                    if( Integer.valueOf(Date.today().month()) == 2 && Integer.valueOf(Date.today().day()) == 28 && Integer.valueOf(PP.PPE_ls_DayOfTheMonthOfGenerationOfFee__c) > 28 ){insert PPF;}
                    if(Integer.valueOf(PP.PPE_ls_DayOfTheMonthOfGenerationOfFee__c) == Integer.valueOf(Date.today().day())){insert PPF;}
                }
                else
                {
                    system.debug('OEJ NO Esta seleccionada una fecha');
                    if(Integer.valueOf(Date.today().day()) > 30){PP.PPE_ls_DayOfTheMonthOfGenerationOfFee__c = '30';}
                    else{PP.PPE_ls_DayOfTheMonthOfGenerationOfFee__c = String.valueOf(Date.today().day());}                    
                    update PP;insert PPF;
                }
                system.debug('JDLL :ya inserte');Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                req.setComments('automatic request for charge fee'); req.setObjectId(PPF.Id);
                Approval.ProcessResult result = Approval.process(req);
                system.debug('se inserto el registro y ya se mando la solicitud');
            }catch(exception e){
                system.debug('ya existe un registro para este mes');
            }
            
        }
    }
    
}