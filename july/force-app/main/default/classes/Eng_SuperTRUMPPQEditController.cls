public with sharing class Eng_SuperTRUMPPQEditController
{
	@TestVisible
    private IST.SuperTRUMPPricingQuoteEditController stPQEditController;
    private SuperTrumpEditController editController;
    
    public String actionNavigate {
    	get { return stPQEditController.actionNavigate; }
        set { stPQEditController.actionNavigate = value; }
    }
    public String actionURL {
    	get { return stPQEditController.actionURL; }
        set { stPQEditController.actionURL = value; }
    }                      
    public String actionView {
    	get { return stPQEditController.actionView; }
        set { stPQEditController.actionView = value; }
    }
    public transient string timeZoneOffset {
    	get { return stPQEditController.timeZoneOffset; }
        set { stPQEditController.timeZoneOffset = value; }
    }
    public transient string transactionState {
    	get { return stPQEditController.transactionState; }
        set { stPQEditController.transactionState = value; }
    }
    public transient string sfRetData {
    	get { return stPQEditController.sfRetData; }
        set { stPQEditController.sfRetData = value; }
    }                                
    
    public Boolean isSF1 {get { return stPQEditController.isSF1; }}
    
    public transient string sfData {get { return stPQEditController.sfData; }}
    public transient string sfDataInfo {get { return stPQEditController.sfDataInfo; }}
    public transient string sfDynamic {get { return stPQEditController.sfDynamic; }}
    public transient string sfCustomHeaders {get { return stPQEditController.sfCustomHeaders; }}
    public transient string fieldSecurity {get { return stPQEditController.fieldSecurity; }}
    
    public string resourceName {get { return stPQEditController.resourceName; }}
    public string securityToken {get { return stPQEditController.securityToken; }}
    public string token {get { return stPQEditController.token; }}
    public string stURL {get { return stPQEditController.stURL; }}
    public string sfURL {get { return stPQEditController.sfURL; }}
    public string sfNamespace {get { return stPQEditController.sfNamespace; }}
    public string helpURL {get { return stPQEditController.helpURL; }}
    public string objId {get { return stPQEditController.objID; }}
    public string sfQuoteName {get { return stPQEditController.sfQuoteName; }}

    public string sfUserId {get { return stPQEditController.sfUserId; }}
    public string databaseTransactionState{get { return stPQEditController.databaseTransactionState; }}
    
    public string lastModifiedById {get { return stPQEditController.lastModifiedById; }}
    public string getLastModifiedByUser() { return stPQEditController.getLastModifiedByUser(); }

    @RemoteAction
    public static String retrieveReport(Map<String, String> parameters)
    {
        return IST.SuperTRUMPPricingQuoteEditController.retrieveReport(parameters);
    }

    public Eng_SuperTRUMPPQEditController(ApexPages.StandardController con)
    {
        stPQEditController = new IST.SuperTRUMPPricingQuoteEditController(con);
        this.editController = new SuperTrumpEditControllerImpl(stPQEditController);
    }
    
    @TestVisible
    private Eng_SuperTRUMPPQEditController(ApexPages.StandardController con, SuperTrumpEditController editController)
    {
        stPQEditController = new IST.SuperTRUMPPricingQuoteEditController(con);
        this.editController = editController;
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
    
    public PageReference save()
    {        
        gpobjId = objId;
        pgref = editController.save();
                        
        // Gather messages that occurred with the save above so they can be displayed
        // later when the 2nd process executes executeST for calling out to ProcessXML.        
        accumulateMessages();
        return null;
    }
    
    public PageReference saveAs()
    {
    	String s = editController.saveAs();
        pgref = parseSaveAs(s);
        accumulateMessages();
        return null;
    }

    public PageReference quicksave()
    {
        gpobjId = objId;
        pgref = editController.quicksave();
        accumulateMessages();
        return null;
    }
    
    public PageReference cancel()
    {
        return editController.cancel();
    }
    
    private PageReference parseSaveAs(String s)
    {
        try
        {
            String[] sArray = s.split('~');
            
            if (sArray.Size() != 3)
            {
                throw new SuperTRUMPPricingQuoteEditException (s);
            }
            
            gpobjId = sArray[0];
            ID recordId = ID.valueOf(sArray[0]);
            
            if (Eng_IvorySalesforceServices.isSF1())
            {
                actionURL = '/'+recordId+'/e';
                return null;
            }
            else
            {
                PageReference pqPage = new ApexPages.StandardController(recordId.getSObjectType().newSObject(recordId)).view();
                pqPage.setRedirect(true);
                return pqPage;
            }
        }
        catch(Exception e)
        {
            handlePageException(e);
            return null;
        }
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
    
    @TestVisible    
    private void handlePageException(Exception e)
    {
        boolean isDml = false;
        Exception ex = e;
        do {
            if (ex instanceof DmlException)
            {
                isDml = true;
                break;
            }
            ex = ex.getCause();
        } while(ex != null);

        // If DmlException have already added a message to the page, so we don't need to do it here.
        if (!isDml || !ApexPages.hasMessages(ApexPages.Severity.ERROR))
        {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }
    }

    private class SuperTRUMPPricingQuoteEditException extends Exception {}
    
    // This interface allows testing of the save routines of this controller.
    @TestVisible
    private interface SuperTrumpEditController {
        String getTimezoneOffset();
        String getTransactionState();
        String getSalesforceRetData();
        String getQuoteID();

        PageReference quicksave();
        PageReference save();
        String saveAs();
        PageReference cancel();
    }
    
    @TestVisible
    private class SuperTrumpEditControllerImpl implements SuperTrumpEditController {
        
        private IST.SuperTRUMPPricingQuoteEditController controller;
        
        public SuperTrumpEditControllerImpl(IST.SuperTRUMPPricingQuoteEditController controller){
            this.controller = controller;
        }
        
        public String getTimezoneOffset(){ return controller.timeZoneOffset; }
        public String getTransactionState(){ return controller.transactionState; }
        public String getSalesforceRetData(){ return controller.sfRetData; }
        public String getQuoteID(){ return controller.objId; }
                
        public PageReference quicksave(){
            return controller.quicksave();
        }
        public PageReference save(){
        	return controller.save();
        }
        public String saveAs(){
            return IST.SuperTRUMPPricingQuoteRESTSaveBlobAs.SaveBlobAs(
                this.getTimezoneOffset(),
                this.getQuoteId(),
                this.getSalesforceRetData(),
                this.getTransactionState());
        }
        public PageReference cancel(){
        	return controller.cancel();
        }
    }
}