public  class TKD_KnownSupplierHelp {
    public static void insertBancks(string recordTypeId, list<TKD_Site__c> sitesList, list<Bank_Account__c> banckaccounts, List<Contact> contacts, string recordId ){
        list<Bank_Account__c> banckList = new List<Bank_Account__c>();
        if(banckaccounts != null){
            for(TKD_Site__c sit: sitesList ){
                for(Bank_Account__c bk : banckaccounts){
                    system.debug('fuera de bancos');
                    system.debug(bk);
                    if((String.valueof(bk.TKD_Vendor_Site_ID__c) + recordId) == sit.TKD_Vendor_Site_ID__c){
                        system.debug('en bancos');
                        bk.TKD_rb_Site__c =sit.Id;
                        bk.RecordTypeId =recordTypeId;
                        bk.TKD_Vendor_Site_ID__c = String.valueof(bk.TKD_Vendor_Site_ID__c) + recordId;
                        banckList.add(bk);
                    }else{
                        system.debug('NO hay banks');
                    }
                }
            }

            try{
                system.debug('banklist');
                system.debug(banckList);
                insert banckList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error to insert bank accounts on sites:'+ e.getMessage());
            }
        }


        Id recordTypeIdCon =Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Supplier Contact').getRecordTypeId();

        List<Contact> contactList = new List<Contact>();
        System.debug('CONTACTSSITE: ' + contacts);
        if(contacts != null){
            for(TKD_Site__c sit : sitesList){
                for(Contact con: contacts){
                    if((String.valueof(con.TKD_Vendor_Site_ID__c) + recordId) == sit.TKD_Vendor_Site_ID__c){
                        con.TKD_rb_Site__c = sit.Id;
                        con.RecordTypeId = recordTypeIdCon;
                        con.TKD_Vendor_Site_ID__c = String.valueof(con.TKD_Vendor_Site_ID__c) + recordId;
                        contactList.add(con);
                    }else{
                        system.debug('No hay contactos');
                    }
                }
            }

            try {
                insert contactList;
            } catch (Exception e) {
                system.debug(LoggingLevel.ERROR, 'Error al insertar contactos');
                system.debug(LoggingLevel.ERROR, e.getMessage());
            }
        }

    }
}