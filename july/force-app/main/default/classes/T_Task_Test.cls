@IsTest 
public class T_Task_Test {

	@isTest static void test_method_one() {
        Lead le = new Lead();
        le.LastName ='testCon';
        le.Email = 'test@test.com';
        le.LEA_ls_Company_Tier__c='Tier One';
        le.Company='BXToolkit';
        le.Street='uno';
        le.City='dos';
        le.State='Chiapas';
        le.CountryCode='MX';
        le.postalCode='90000';
        le.LEA_tf_Company_Phone__c='53090202980';
        insert le;  

        
        Task e = new Task();
        e.WhoId=le.id;
        e.Type = 'Call';
        e.Priority='Normal';
        e.Status='Completed';
        e.ActivityDate=system.today();
        e.Subject='Call';
        e.Description=' lorem ipsulorem ipsulorem ipsulorem ipsulorem ipsulorem ipsulorem ipsulorem ipsu';
        insert e; 

    }
    
       @isTest static void test_method_two() {     
                
        Contact cont= new Contact();
        cont.Email='jesus@salesforce.com';
        cont.LastName='Vital Tapia';   
        insert cont;
        
        Task contacto = new Task();
        contacto.WhoId=cont.id;
        contacto.Type = 'Call';
        contacto.Status='Completed';
        contacto.ActivityDate=system.today();
        contacto.Subject='Call';
        contacto.Description=' lorem ipsulorem ipsulorem ipsulorem ipsulorem ipsulorem ipsulorem ipsulorem ipsu';
        insert contacto; 
           
       }//test method two
    
}