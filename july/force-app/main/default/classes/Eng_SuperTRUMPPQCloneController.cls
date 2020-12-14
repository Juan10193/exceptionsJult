public with sharing class Eng_SuperTRUMPPQCloneController
{
	@TestVisible
    private IST.SuperTRUMPCloneController stPQCloneController;
    private SuperTrumpCloneController cloneController;
    
    public String actionNavigate {
    	get { return stPQCloneController.actionNavigate; }
        set { stPQCloneController.actionNavigate = value; }
    }
    public String actionURL {
    	get { return stPQCloneController.actionURL; }
        set { stPQCloneController.actionURL = value; }
    }                      
    public String actionView {
    	get { return stPQCloneController.actionView; }
        set { stPQCloneController.actionView = value; }
    }
    public String recordName {
    	get { return stPQCloneController.recordName; }
    	set { stPQCloneController.recordName = value; }
    }

    public Eng_SuperTRUMPPQCloneController(ApexPages.StandardController con)
    {
        stPQCloneController = new IST.SuperTRUMPCloneController(con);
        this.cloneController = new SuperTrumpCloneControllerImpl(stPQCloneController);
    }
    
    @TestVisible
    private Eng_SuperTRUMPPQCloneController(ApexPages.StandardController con, SuperTrumpCloneController cloneController)
    {
        stPQCloneController = new IST.SuperTRUMPCloneController(con);
        this.cloneController = cloneController;
    }
    
    @TestVisible
    PageReference pgref;
    string gpobjId;
    
    public PageReference executeST()
    {
        // Set ApexPages messages with messages from the first process before the one calling this and don't
        // do the extra work here. (The visualforce page was set up to call this routine in a 2nd process
        // after the initial save of the pricing quote. This is because callouts can't happen after DML
        // operations in the same process and the first process is inserting a pricing quote.)
        if (dispenseMessages())
        {
            return null;
        }
        
        try
        {
            if (gpobjId == null)
            {
                return null;
            }
            // Get the Schedule, with percent of TV.$VS report blob
            Blob reportBlob = null;
            List<IST__SuperTRUMP_Report__c> reportIDs = [Select ID From IST__SuperTRUMP_Report__c where IST__Name__c='Schedule, with percent of TV' and IST__Extension__c='$VS' limit 1];
            if (!reportIDs.isEmpty())
            {
                ID reportID = reportIDs[0].ID;
                List<ContentDocumentLink> cdl = [SELECT ContentDocumentId,Id,LinkedEntityId,ShareType FROM ContentDocumentLink WHERE LinkedEntityId = :reportID limit 1];
                if (!cdl.isEmpty())
                {
                    ID docId = cdl[0].ContentDocumentId;
                    List<ContentVersion> Docs = [SELECT ContentDocumentId,ContentSize,CreatedDate,Title,VersionData FROM ContentVersion WHERE ContentDocumentId=:docId limit 1];
                    if (!Docs.isEmpty())
                    {
                        reportBlob = Docs[0].VersionData;
                    }
                }
            }

            String transState = IST.SuperTRUMPController.getTransactionState(gpobjId);
            if (transState == null)
            {
                return null;
            }
            Eng_STSFEnhancements stSFEnhancements = new Eng_STSFEnhancements();
            String xmlIn = stSFEnhancements.queryXML(transState, reportBlob);
            String xmlOut = IST.SuperTRUMPWebServices.ProcessXML(xmlIn);
            stSFEnhancements.ParseAndCreateEnhancements(gpobjId, xmlOut);
        }
        catch (Exception e)
        {
            ApexPages.AddMessages(e);
            if (Eng_IvorySalesforceServices.isSF1())
            {
                actionNavigate = '';
                actionURL = '';
            }            
            return null;
        }
        return pgref;
    }
        
    public PageReference cloneRecord()
    {
        gpobjId = cloneController.cloneRecord();
        ID recordId = ID.valueOf(gpobjId);
            
        if (Eng_IvorySalesforceServices.isSF1())
        {
            actionURL = '/'+recordId;
            pgref = null;
        }
        else
        {
            PageReference pqPage = new ApexPages.StandardController(recordId.getSObjectType().newSObject(recordId)).view();
            pqPage.setRedirect(true);
            pgref = pqPage;
        }
        accumulateMessages();
        return null;
    }
    
    public PageReference cancel()
    {
        return cloneController.cancel();
    }
    
    class msg {
        ApexPages.severity severity;
        String summary;
        String detail;
    }
    
    @TestVisible
    private List<msg> msgs = new List<msg>();

    @TestVisible
    private void accumulateMessages()
    {
        if (ApexPages.hasMessages())
        {
            List<ApexPages.Message> amsgs = ApexPages.getMessages();
            for (ApexPages.Message amsg : amsgs)
            {
                msg m = new msg();
                m.severity = amsg.getSeverity();
                m.summary = amsg.getSummary();
                m.detail = amsg.getDetail();
                msgs.Add(m);
            }
        }
        else
        {
            if (msgs.Size() > 0)
            {
                msgs.clear();
            }
        }
    }
    
    @TestVisible
    private boolean dispenseMessages()
    {
        if (msgs.Size() > 0)
        {
            for (msg m : msgs)
            {
                ApexPages.Message amsg = new ApexPages.Message(m.severity, m.summary, m.detail);
                ApexPages.addMessage(amsg);
            }
            msgs.clear();
            return true;
        }
        return false;
    }
    
    // This interface allows testing of the clone routines of this controller.
    @TestVisible
    private interface SuperTrumpCloneController {
        String cloneRecord();
        PageReference cancel();
    }
    
    @TestVisible
    private class SuperTrumpCloneControllerImpl implements SuperTrumpCloneController {
        
        private IST.SuperTRUMPCloneController controller;
        
        public SuperTrumpCloneControllerImpl(IST.SuperTRUMPCloneController controller){
            this.controller = controller;
        }
        public String cloneRecord(){
        	return controller.doCloneRecord();
        }
        public PageReference cancel(){
        	return controller.cancel();
        }
    }
}