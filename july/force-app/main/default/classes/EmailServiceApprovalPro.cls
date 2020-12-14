public without sharing class EmailServiceApprovalPro {
    public void recallTkdRegistry(string recordId){
        list<Messaging.SingleEmailMessage> listMessage = new list<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage oMessage = new Messaging.SingleEmailMessage();
        EmailServicesAddress emailServiceAddress = [SELECT Id, IsActive, LocalPart, EmailDomainName, AuthorizedSenders, RunAsUserId, FunctionId, DeveloperName 
                                                    FROM EmailServicesAddress
                                                    where LocalPart = 'recallemail' limit 1]; 
        oMessage.toAddresses = new String[] {emailServiceAddress.LocalPart + '@' + emailServiceAddress.EmailDomainName};
        oMessage.subject = 'please Approve this';
        oMessage.plainTextBody = recordId;
        listMessage.add(oMessage);
        Messaging.SendEmailResult[] oResults = Messaging.sendEmail(listMessage);
        for(Messaging.SendEmailResult rr:oResults){
        System.debug('Email result ' + rr);
    } 
    }
    
}