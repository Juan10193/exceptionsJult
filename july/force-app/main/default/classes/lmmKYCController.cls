/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 07-31-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-30-2020   eduardo.amiens@outlook.com   Initial Version
**/
public with sharing class lmmKYCController{
    public lmmKYCController() {

    }
    @AuraEnabled(cacheable=true)
    public static list<Entity_CP__c> getEntitiesWithContacts(string opportunityId){
        set<Id> setEntityId = new set<Id>();
        for(LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad : [SELECT Id, Name, LMM_pd_Entity_CP__c, LMM_pd_Oportunidad__c 
                FROM LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c = :opportunityId]){
                    setEntityId.add(LMM_Entidad_de_oportunidad.LMM_pd_Entity_CP__c);
        }
        system.debug('setEntityId ' + setEntityId);
        return [SELECT Id, Name, EM_Party_ID__c, EIV_tx_partyID__c, 
                (SELECT id, name, LMM_tx_Primer_nombre__c, LMM_tx_Segundo_nombre__c, LMM_tx_Apellido_paterno__c,
                LMM_tx_Apellido_materno__c, LMM_ce_Correo_electronico__c, LMM_rb_Entity_CP__c, LMM_num_envios__c, 
                LMM_pl_status_email__c, LMM_rb_KYC__r.LMM_fm_site__c
                FROM Contactos__r) 
                FROM Entity_CP__c where Id in :setEntityId];
    }
    @AuraEnabled(cacheable=true)
    public static list<LMM_Custom_Contact__c> getContactsWithKYCs(string opportunityId){
        set<Id> setEntityId = new set<Id>();
        for(LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad : [SELECT Id, Name, LMM_pd_Entity_CP__c, LMM_pd_Oportunidad__c 
                FROM LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c = :opportunityId]){
                    setEntityId.add(LMM_Entidad_de_oportunidad.LMM_pd_Entity_CP__c);
        }
        system.debug('setEntityId ' + setEntityId);
        return [SELECT LMM_tx_Primer_nombre__c, LMM_tx_Segundo_nombre__c, LMM_tx_Apellido_paterno__c, LMM_tx_Apellido_materno__c, 
        LMM_ce_Correo_electronico__c, LMM_tf_Telefono_celular__c, LMM_tx_Oracle_Id__c, LMM_rb_Entity_CP__c, Id, Name,
        LMM_rb_Entity_CP__r.Name, LMM_rb_Entity_CP__r.EM_Party_ID__c,
        LMM_rb_KYC__c, LMM_rb_KYC__r.LMM_ls_Estatus__c         
        FROM LMM_Custom_Contact__c where LMM_rb_Entity_CP__c in :setEntityId];
    }
    @AuraEnabled(cacheable=true)
    public static void getKYCs(id opportunityId){

    }
    
    @AuraEnabled(cacheable=false)
    public static void updateContactKYC(List<LMM_Custom_Contact__c> contactos) {
        System.debug('Arrays: ' + contactos);
        if(contactos.size() > 0) {
            try {
                update contactos;
            }
            catch(Exception e) {
                System.debug('Error: ' + e.getMessage());
            	throw new AuraHandledException(e.getMessage());
            }
        }
    }
    
    @AuraEnabled(cacheable=false)
    public static void sendEmailKYC(LMM_Custom_Contact__c contacto) {
        System.debug('Contact: ' + contacto);
        try {
            User usr =[Select firstname, lastname from User WHERE Id =:Userinfo.getUserId()];  
            EmailTemplate template = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Notificaction_KYC_HTML'];
      
            String nameInternalUser = Usr.FirstName+' '+Usr.LastName;
            String link = contacto.LMM_url_page__c+'&userInitial='+contacto.Name;
            String nameExternalUser = contacto.LMM_tx_Primer_nombre__c+' '+contacto.LMM_tx_Apellido_paterno__c;
            
            String htmlBody = template.HtmlValue;
            htmlBody = htmlBody.replace('{!User.Name}', nameExternalUser);
            htmlBody = htmlBody.replace('{!User.Owner}', nameInternalUser);
            htmlBody = htmlBody.replace('{!Link}', link);
            htmlBody = htmlBody.replace('{!User.ContactId}', contacto.Name);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new List<String>{contacto.LMM_ce_Correo_electronico__c});   
            mail.setHtmlBody(htmlBody);
            mail.setSubject(template.Subject); 
            Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        }
        catch(Exception e) {
            System.debug('Error to send email: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<LMM_KYC__c> getKycDetails(String opportunity) {
        System.debug('Detalles de KYC: ' + opportunity);
        return [SELECT id, Name, RecordType.Name, LMM_fm_Porcentaje_de_llenado_PF__c, LMM_tx_Razon_Social__c, LMM_tx_Giro_de_la_empresa__c, 
                LMM_rb_Opportunity__c, LMM_fm_site__c
                FROM LMM_KYC__c WHERE LMM_rb_Opportunity__c =: opportunity];
    }
}