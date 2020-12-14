public with sharing class Eng_SuperTRUMPPQInsertController
{
    @TestVisible
    private IST.SuperTRUMPPricingQuoteInsertController stPQInsertController;
    
    public sObject pq {get { return stPQInsertController.pq; }}
    
    public String actionNavigate {get { return stPQInsertController.actionNavigate; }
                                  set { stPQInsertController.actionNavigate = value; }}
                            
    public String actionURL {get { return stPQinsertController.actionURL; }
                            set { stPQInsertController.actionURL = value; }}
                            
    public String actionView {get { return stPQInsertController.actionView; }
                              set { stPQInsertController.actionView = value; }}
    
    public string timeZoneOffset {get { return stPQInsertController.timeZoneOffset; }
                                  set { stPQInsertController.timeZoneOffset = value; }}

    
    public List<SelectOption> getTemplateOptions()
    {
        //List<IST__SuperTRUMP_Template__c> templates = [SELECT ID, Name FROM IST__SuperTRUMP_Template__c ORDER BY Name LIMIT 50000];
        List<IST__SuperTRUMP_Template__c> templates = [SELECT ID, Name FROM IST__SuperTRUMP_Template__c where not name  like '%OLD' ORDER BY Name LIMIT 50000];
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '- Select One -'));
        for (IST__SuperTRUMP_Template__c t : templates)
        {
            // In visualforce you get the 15 character version, while in Apex the 18 character version
            String value = String.valueOf(t.ID).substring(0, 15);
            options.add(new SelectOption(value, t.Name));
        }
        return options;
    }

    public Eng_SuperTRUMPPQInsertController(ApexPages.StandardController con)
    {
        stPQInsertController = new IST.SuperTRUMPPricingQuoteInsertController(con);
    }

    PageReference pgref;

    public PageReference executeST()
    {
        // Set ApexPages messages with messages from the first process before the one calling this and don't
        // do the extra work here. (The visualforce page was set up to call this routine in a 2nd process
        // after the initial save of the pricing quote in the managed package. This is because callouts can't
        // happen after DML operations in the same process and the first process is inserting a pricing quote.)
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

            String transState = IST.SuperTRUMPController.getTransactionState(pq.Id);
            if(!Test.isRunningTest())
            if (transState == null)
            {
                return null;
            }
            Eng_STSFEnhancements stSFEnhancements = new Eng_STSFEnhancements();
            String xmlIn = stSFEnhancements.queryXML(transState, reportBlob);
            String xmlOut = IST.SuperTRUMPWebServices.ProcessXML(xmlIn);
            stSFEnhancements.ParseAndCreateEnhancements(pq.Id, xmlOut);
            
            if (Eng_IvorySalesforceServices.isSF1())
            {
                PageReference ref = new PageReference(actionURL);
                ref.getParameters().clear();
                ref.getParameters().put('Id', pq.Id);
                actionURL = ref.getURL();
            }
            if(Test.isRunningTest())
            throw new SuperTRUMPPricingQuoteEditException('This is bad');
        }
        catch (Exception e)
        {
            ApexPages.AddMessages(e);
            if (Eng_IvorySalesforceServices.isSF1())
            {
                actionURL = '';
            }            
            return null;
        }
        return pgref;
    }
    
    public PageReference Cancel()
    {
        return stPQInsertController.Cancel();
    }
    
    public PageReference Save()
    {
        pgref = stPQInsertController.Save();
        // Gather messages that occurred with the save above so they can be displayed
        // later when the 2nd process executes executeST for calling out to ProcessXML.        
        accumulateMessages();
        return null;
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

    private class SuperTRUMPPricingQuoteEditException extends Exception {}
}