trigger ES3_UpdateCreditApprobalRatings on ES2_Obj_EntityMasterInCreditApproval__c (after insert, after update, after undelete) {
    List<id> idCaList = new List<id>(); 
    List<ES2_Obj_EntityMasterInCreditApproval__c> entityList = new List<ES2_Obj_EntityMasterInCreditApproval__c>();
    
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isUnDelete))
    {
        for(Integer i=0; i<trigger.new.size(); i++)
        {
            idCaList.add(trigger.new[i].ES2_rb_Credit_approval__c); 
            
        }
    }
    
    //Seleccionamos los CAs Id = this.CA.Id, ES3_TX_MRA_ID__c = mra, ES3_tx_Bloomberg_ID__c = bloomberg, ES3_TX_HNWI_ID__c = hnwi, CPI_rb_OR_rating__c = orRatingNew.id);         
    List<Credit_approval_CP__c> CAList = [Select id, ES3_TX_MRA_ID__c, ES3_tx_Bloomberg_ID__c,ES3_TX_HNWI_ID__c, CPI_rb_OR_rating__c, ES3_fm_Level_OR_Rating__c 
                                          from Credit_approval_CP__c where id IN:idCaList];
    if(CAList.size()>0)
    {
        List <Credit_approval_CP__c> CAListToUpdate = new List <Credit_approval_CP__c>();
        //Volvemos a recorrer los triggers pero ahora ya con el CA para actualizar
        if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isUnDelete))
        {
            for(Integer i=0; i<trigger.new.size(); i++)
            {
                //Recorremos la lista de CAs consultada
                for(Credit_approval_CP__c ca : CAList)
                {
                    if(trigger.new[i].ES2_rb_Credit_approval__c == ca.id) //Es el credit Approval
                    {
                        Integer levelEntityOR = 0;
                        TBO005_OR_rating__c orRatingNew = new TBO005_OR_rating__c();
                        
                        System.debug('OEJ--trigger.new[i].ES3_tx_Or_Rating__c:' + trigger.new[i].ES3_tx_Or_Rating__c);
                        if(trigger.new[i].ES3_tx_Or_Rating__c != null && trigger.new[i].ES3_tx_Or_Rating__c.replace('OR','0').isNumeric())
                        {
                            levelEntityOR = Integer.valueOf(trigger.new[i].ES3_tx_Or_Rating__c.replace('OR','0'));
                            try{
                                orRatingNew = [Select id, name from TBO005_OR_rating__c where name =:trigger.new[i].ES3_tx_Or_Rating__c][0];    
                            }
                            CATCH(exception e){ System.debug('El id del sic code seleccionado no existe OEJ'); }
                                
                            
                        }
                        if(levelEntityOR >= ca.ES3_fm_Level_OR_Rating__c && trigger.new[i].ES2_ms_Role__c.contains('Risk Decision Entity') )
                        {
                            
                            Credit_approval_CP__c  CAtoUpdate = new Credit_approval_CP__c(Id = CA.Id, 
                                                                                          ES3_TX_MRA_ID__c = trigger.new[i].ES3_tx_MRAID__c , 
                                                                                          ES3_tx_Bloomberg_ID__c = trigger.new[i].ES3_tx_BloombergID__c, 
                                                                                          ES3_TX_HNWI_ID__c = trigger.new[i].ES3_tx_HNWI_ID__c, 
                                                                                          CPI_rb_OR_rating__c = orRatingNew.id);   
                            CAListToUpdate.add(CAtoUpdate);
                        }
                    }
                }
            }
        }
        update CAListToUpdate;
    }    
}