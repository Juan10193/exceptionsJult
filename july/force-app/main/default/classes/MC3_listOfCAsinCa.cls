public class MC3_listOfCAsinCa {
    @AuraEnabled
    public static list<Opportunity_in_Credit_approval_CP__c> getCAs(String idCA)
        {
            List<Opportunity_in_Credit_approval_CP__c> listOppInCAs= new List<Opportunity_in_Credit_approval_CP__c>();
            system.debug('id que llega' + idCA);
            listOppInCAs = [Select id, name, 
                            CP_rb_Oportunidad__r.name, //Opportunity Name
                            CP_rb_Oportunidad__r.Id,
                            CP_rb_Oportunidad__r.CPL_date_Expiration_Date__c, //Fecha de Expiración
                            CP_rb_Credit_approval_CP__c, // ID de credit AApproval
                            CP_rb_Credit_approval_CP__r.name, // nombre del Credit Approbal
                            CP_rb_Oportunidad__r.StageName, //Stage Name
                            CP_rb_Oportunidad__r.CPL_fm_Final_Balance__c, //Final Balance
                            CP_rb_Credit_approval_CP__r.RecordType_List__c,
                            CP_rb_Credit_approval_CP__r.CPL_ls_StageName__c
                            
                            
                            from Opportunity_in_Credit_approval_CP__c where CP_rb_Credit_approval_CP__c =:idCA];
            system.debug('lista opp ' + listOppInCAs);
            List<id> idsOppInCa = new List<id>(); 
            if(listOppInCAs.size()>0)
            {
                for( Opportunity_in_Credit_approval_CP__c oppInCa :  listOppInCAs)
                {
                    idsOppInCa.add(oppInCa.CP_rb_Oportunidad__c);
                }
            }
            // 
            if(idsOppInCa.size()>0)
            {
                listOppInCAs = [Select id, name, 
                            CP_rb_Oportunidad__r.name, //Opportunity Name
                            CP_rb_Oportunidad__r.Id,
                            CP_rb_Oportunidad__r.CPL_date_Expiration_Date__c, //Fecha de Expiración
                            CP_rb_Credit_approval_CP__c, // ID de credit AApproval
                            CP_rb_Credit_approval_CP__r.name, // nombre del Credit Approbal
                            CP_rb_Oportunidad__r.StageName, //Stage Name
                            CP_rb_Oportunidad__r.CPL_fm_Final_Balance__c, //Final Balance
                            CP_rb_Credit_approval_CP__r.RecordType.Name,
                            CP_rb_Credit_approval_CP__r.CPL_ls_StageName__c
              
                            
                            from Opportunity_in_Credit_approval_CP__c
                                where CP_rb_Oportunidad__c IN: idsOppInCa 
                                and CP_rb_Credit_approval_CP__c !=:idCA];
                
            }
            else
            {
                listOppInCAs = new List<Opportunity_in_Credit_approval_CP__c>();
            }
            
           
            return listOppInCAs;
        }

}