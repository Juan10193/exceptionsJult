public class DMLO_EntityCP {
    public static void createEntitycpFromEntityM(EM_Wrapper_Entity.EntityMain entityMaster){
        if(Schema.sObjectType.Entity_CP__c.isCreateable()){
           Entity_CP__c entityCP = new Entity_CP__c();
           entityCP.EM_Party_ID__c 								= string.valueOf(entityMaster.entityInfo.entity.partyID);
           entityCP.EM_Economic_Group_ID__c 					= entityMaster.entityInfo.entity.economicGroupId;
           entityCP.EM_Top_Parent_ID__c 						= entityMaster.entityInfo.entity.topParentId;
           entityCP.Name 										= entityMaster.entityInfo.entity.oracleAccountName;
           entityCP.CPL_rb_Cuenta__c 							= entityMaster.entityInfo.entity.sFaccountID;
            
            if(entityMaster.entityInfo.entity.customerType =='INDIVIDUAL'){
                entityCP.CPI_ls_TIPO_DE_CLIENTE__c 				= 'PERSONA';
            }else{
                entityCP.CPI_ls_TIPO_DE_CLIENTE__c 				= 'ORGANIZATION';
            }
            
            if(entityMaster.entityInfo.entity.foreignEntity ==true){
               
               entityCP.CPI_tx_RFC_TIN__c   					= entityMaster.entityInfo.entity.tin;
            }else{
               entityCP.CPI_tx_RFC_TIN__c 						= entityMaster.entityInfo.entity.rfc;
            }
          							         													           
            if(entityMaster.entityInfo.entity.supplierFlag == true){
                 entityCP.CPI_ls_SUPPLIER_FLAG__c  				= 'Yes';
            }else{
                entityCP.CPI_ls_SUPPLIER_FLAG__c  				= 'No';
            }
            
            if(entityMaster.entityInfo.entity.customerStatus =='YES'){
                entityCP.CPI_ls_EXTRANJERO_Y_N__c 				= 'Y';
            }else{
                entityCP.CPI_ls_EXTRANJERO_Y_N__c 				= 'N';
            }
            
           insert entityCP;
           system.debug(LoggingLevel.INFO,'New EntityCP created success: ' + entityCP);
            
        }else{
            system.debug(LoggingLevel.ERROR, 'El usuario no tiene permiso para crear Entity_CP__c');
        }
    }
    
    
     public static void upsertEntitycpFromEntityM(EM_Wrapper_Entity.EntityMain entityMaster, Entity_CP__c entityCP, boolean isUpdatingVA ){
        if(Schema.sObjectType.Entity_CP__c.isCreateable()){
            
           entityCP.EM_Party_ID__c 								= string.valueOf(entityMaster.entityInfo.entity.partyID);
           entityCP.EM_Economic_Group_ID__c 					= entityMaster.entityInfo.entity.economicGroupId;
           entityCP.EM_Top_Parent_ID__c 						= entityMaster.entityInfo.entity.topParentId;
           entityCP.Name 										= entityMaster.entityInfo.entity.oracleAccountName;
           entityCP.CPL_rb_Cuenta__c 							= entityMaster.entityInfo.entity.sFaccountID;
           entityCP.CPL_tx_Account_Number__c                    = entityMaster.entityInfo.entity.oracleAccountNumber;
            
            if(entityMaster.entityInfo.entity.customerType =='INDIVIDUAL'){
                entityCP.CPI_ls_TIPO_DE_CLIENTE__c 				= 'PERSONA';
            }else{
                entityCP.CPI_ls_TIPO_DE_CLIENTE__c 				= 'ORGANIZATION';
            }
            
            if(entityMaster.entityInfo.entity.foreignEntity ==true){
               
               entityCP.CPI_tx_RFC_TIN__c   					= entityMaster.entityInfo.entity.tin;
            }else{
               entityCP.CPI_tx_RFC_TIN__c 						= entityMaster.entityInfo.entity.rfc;
            }
          							         													           
            if(entityMaster.entityInfo.entity.supplierFlag == true){
                 entityCP.CPI_ls_SUPPLIER_FLAG__c  				= 'Yes';
            }else{
                entityCP.CPI_ls_SUPPLIER_FLAG__c  				= 'No';
            }
            
            if(entityMaster.entityInfo.entity.customerStatus =='YES'){
                entityCP.CPI_ls_EXTRANJERO_Y_N__c 				= 'Y';
            }else{
                entityCP.CPI_ls_EXTRANJERO_Y_N__c 				= 'N';
            }
         	
            if(entityMaster.entityInfo.addressInfo.addresses != null){
                EM_Wrapper_Entity.Address direccion = new EM_Wrapper_Entity.Address();
                
                for(EM_Wrapper_Entity.Address addres : entityMaster.entityInfo.addressInfo.addresses.address){
                    if(addres.purpose =='BILL_TO, SHIP_TO, INSTALL_AT' && addres.locationId >=addres.locationId ){
                        direccion = addres;
                    }
                }
                
                entityCP.Country__c = direccion.country;
                entityCP.Neighborhood__c = direccion.county;
                if(direccion.country =='MEX'){
                    entityCP.Mexican_State__c = direccion.state =='DF'?'CMX':direccion.state;
                    entityCP.Foreingn_State__c = '';
                }else{
                    entityCP.Mexican_State__c ='';
                    entityCP.Foreingn_State__c = direccion.state;
                }
                
                entityCP.Street__c = direccion.street;
                entityCP.Exterior_Number__c = direccion.outdoorNumber;
                entityCP.ZIP_Code__c = direccion.zipCode;
                entityCP.Interior_Number__c = direccion.interiorNumber;
                entityCP.City__c = direccion.city;
            }
            if(isUpdatingVA){
            	if(entityMaster.entityInfo.invoiceInfo.invoices != null){
                    list<string> nameVirtualAccount = new list<string>();
                    for(EM_Wrapper_Entity.Invoice invoice : entityMaster.entityInfo.invoiceInfo.invoices.invoice){
                        nameVirtualAccount.add(invoice.ecPaymentAccount);    
                    }
                    map<String,Virtual__c> mapVirtualAccount = Data_Access_VirtualAccount.getVirtualAccountByName(nameVirtualAccount);
                   
                   entityCP.Virtual_Account397__c = mapVirtualAccount.containsKey('397') ? mapVirtualAccount.get('397').id : null;
                   entityCP.Virtual_Account798__c = mapVirtualAccount.containsKey('798') ? mapVirtualAccount.get('798').id : null;
                   entityCP.Virtual_AccountXA7__c = mapVirtualAccount.containsKey('XA7') ? mapVirtualAccount.get('XA7').id : null;                
                }    
            }
            
            system.debug('entityCP ' + entityCP);
           upsert entityCP;
           system.debug(LoggingLevel.INFO,'EntityCP updated success: ' + entityCP);
            
        }else{
            system.debug(LoggingLevel.ERROR, 'El usuario no tiene permiso para editar Entity_CP__c');
        }
    }
}