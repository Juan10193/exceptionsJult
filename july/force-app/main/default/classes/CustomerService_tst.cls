@isTest
public class CustomerService_tst {
    
    
    static testMethod void testaddCurrency() {
        test.startTest();
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'CustomerService', 'Customer Service Executive');
        
        System.runAs(currentUser) {
            RecordType RFPRectype = [select id,DeveloperName from RecordType where RecordType.DeveloperName ='CAS_tre_RecordtypeCustService'];
            Account accnt = TestDataFactory_tst.createAccount();
            //accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;
            //update accnt;
            
            
            Entitlement ent = new Entitlement();
            ent.Name = 'In Queue';
            ent.AccountId = accnt.id;
            ent.EndDate = System.today()+10;
            ent.StartDate = System.today()-10;
            insert ent; 
            
            Entitlement entt = new Entitlement();
            entt.Name = 'On Hold-Pending Client';
            entt.AccountId = accnt.id;
            entt.EndDate = System.today()+10;
            entt.StartDate = System.today()-10;
            insert entt;             
            
            Entitlement enttt = new Entitlement();
            enttt.Name = 'Solicitud de Factura Manual';
            enttt.AccountId = accnt.id;
            enttt.EndDate = System.today()+10;
            enttt.StartDate = System.today()-10;
            insert enttt;             
            
            Contact con = new Contact();
            con.firstname = 'Juan';
            con.LastName = 'Fernandez';
            con.Email = 'omar.espinosa@engeniumcapital.com';
            insert con;//            

            
            Case cas = new Case();
            cas.Status = 'New';
            cas.Subject = 'Prueba de Servicio a Clientes';
            cas.RecordTypeId = RFPRectype.id;
            cas.Priority = 'Medium';
            cas.AccountId = accnt.id;
            cas.ContactId = con.id;
            cas.EntitlementId = ent.id;
            insert cas;
            
            cas.Status = 'On Hold-Pending Client';
            //cas.OwnerId = currentUser.id;
            update cas;           
            
            CaseComment cComment= new CaseComment();
            cComment.CommentBody = 'Nuevo Comentario';
            cComment.ParentId = cas.id;
            insert cComment;            
            
            cas.Status = 'Assigned';
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Factura Manual';
            cas.OwnerId = currentUser.id;
            update cas;              
            
            LogCustomerService.upsertLogSC(cas.id, '0A2g0000000B10x' , System.Datetime.now()  , System.Datetime.now(), 12.0, 'Evento', 'd');
            
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Factura Manual'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Nota de Crédito'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Emisión de Recibo'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Condonación de moratorios'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Cambio de contacto de envío de factura'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Confirmación de Saldos'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Cambio de Datos Fiscales'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Cambio en agrupación de Facturas'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Certificaciones Contables'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Disposición de Cuentas EOL'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Abrir Open Item'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Modificar Open Item'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Eliminar Open Item'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Streams Seguro'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Aplicación de opción de compra'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de Estados de cuenta'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Confirmación de Security Deposit'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Limpieza de voucher'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Negative Adjustments'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de gestoría'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Conciliación de Cuentas'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Reaplicación de Pagos'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Devoluciones a Cliente'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Historial de Pagos'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Solicitud de documentos'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Devolución de documentos'; update cas;
            cas.CAS001_ls_requerimiento__c = 'Write off (Rentas, Residuales)'; update cas;
       		Case cass = new Case();
            cass.AccountId = accnt.id;
            cass.CAS001_ls_requerimiento__c = '';
            cass.Status = 'New';
            cass.Subject = 'Prueba de Servicio a Clientes';
            cass.RecordTypeId = RFPRectype.id;
            cass.Priority = 'Medium';
            insert cass;     
            
            cass.CAS001_ls_requerimiento__c = 'Solicitud de Cuenta bancaria'; update cass;
            cass.CAS001_ls_requerimiento__c = 'Información de Seguros'; update cass;
            cass.CAS001_ls_requerimiento__c = 'Aclaración de Cargos'; update cass;
            cass.CAS001_ls_requerimiento__c = 'Soporte de pago efectuado'; update cass;
            cass.CAS001_ls_requerimiento__c = 'Split de Equipos'; update cass;
            cass.CAS001_ls_requerimiento__c = 'Rebooking'; update cass;
            cass.CAS001_ls_requerimiento__c = 'T&A'; update cass;
            cass.CAS001_ls_requerimiento__c = 'Registro de re-estructura'; update cass;
            cass.CAS001_ls_requerimiento__c = 'Cambios de integridad de datos'; update cass;
            cass.CAS001_ls_requerimiento__c = 'Evergreens'; update cass;
            //cass.CAS001_ls_requerimiento__c = 'Solicitud de Cotización de Fin de Arrendamiento'; update cass;
            //cass.CAS001_ls_requerimiento__c = 'Seguimiento de Siniestro'; update cass;
            //cass.CAS001_ls_requerimiento__c = 'Duda en Facturación'; update cass;
            //cass.CAS001_ls_requerimiento__c = 'Información de Arrendamiento'; update cass;
            //cass.CAS001_ls_requerimiento__c = 'Envío de copia de documento'; update cass;
            //cass.CAS001_ls_requerimiento__c = 'Solicitud de Emisión de Carta '; update cass;
            //cass.CAS001_ls_requerimiento__c = 'Solicitud de Reimplementación'; update cass;
            

            
        }
        
        test.stopTest();       
        
    }    
}