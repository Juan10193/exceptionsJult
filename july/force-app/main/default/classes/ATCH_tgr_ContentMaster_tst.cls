@isTest
public class ATCH_tgr_ContentMaster_tst {
    static testMethod void pdfAttchOpp() {
        test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
                
            Opportunity opp = TestDataFactory_tst.createOpportunity(null, currentUser, competitor);
            
            Attachment attch = TestDataFactory_tst.createAttachment('Proposal.pdf', opp.Id);
            
            Attachment deletedAttch;
            
            try {
                deletedAttch = [SELECT Id FROM Attachment WHERE Id = :attch.Id];
            }
            catch (Exception exDeletedAttch) {
                System.debug('Error: ' + exDeletedAttch.getMessage() + ' (Line: ' + exDeletedAttch.getLineNumber() + ').');
            }
    
            if (deletedAttch != null) {
                delete deletedAttch;
            }
        }
        
        test.stopTest();
    }
}