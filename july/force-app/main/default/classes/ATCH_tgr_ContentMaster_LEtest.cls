@isTest
public class ATCH_tgr_ContentMaster_LEtest {
    static testMethod void testTriggertCMOPP() {
        test.startTest();
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'President & CEO');
        
        System.runAs(currentUser) {
            
            Account accnt = TestDataFactory_tst.createAccount();            
            accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;            
            update accnt;            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);            
            opp.StageName = 'Opportunity Identified';            
            update opp;
            
            Blob bodyBlob=Blob.valueOf('Unit Test ContentVersion Body'); 
            ContentVersion contentVersion_1 = new ContentVersion(
                Title='Header.pdf', 
                PathOnClient ='/Header.pdf',
                VersionData = bodyBlob, 
                FirstPublishLocationId = opp.id,
                origin = 'H'
            ); 
            insert contentVersion_1;
            List<ContentDocument> doc = [Select id from ContentDocument];
            system.debug(doc);
            delete doc;
            
            

        }
    }
}