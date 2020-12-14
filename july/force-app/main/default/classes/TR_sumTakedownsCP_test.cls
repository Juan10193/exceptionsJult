@istest
public class TR_sumTakedownsCP_test {
	@testSetup static void setup() {
    	EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;   
    }
    @istest
    static void beforeInsert(){
        
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'FISHERS', 'FISH1092');
        ContentVersion contentVersionInsert = new ContentVersion();
        contentVersionInsert.ContentLocation ='S';
        contentVersionInsert.Title ='TEST';
        contentVersionInsert.PathOnClient ='TEST.PDF';
        contentVersionInsert.VersionData = Blob.valueOf('Test content Data');
        contentVersionInsert.IsMajorVersion = true;
        //Crea contentversion
        insert contentVersionInsert;
        
    }
}