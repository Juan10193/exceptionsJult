global class Wrapper_seguro_details {
    public Takedowns_Contingency_plan__c takedownCP {get; set;}
    public Asset[] assets {get; set;}
    public TakedownContent contentTakedown {get; set;}
    public TakedownContentOld contentTakedownOLD {get; set;}
    public List<WaiverToGo__c> exceptionsToGoInCA {
        get{return exceptionsToGoInCA.size()>0?exceptionsToGoInCA:null;} 
        set;
    }
    public WrapperTakedownSeguro.seguroInformacion cotizacionSeguro {get; set;}
    
    public Wrapper_seguro_details(Takedowns_Contingency_plan__c takedownCP,  Asset[] assets, TakedownContent contentTakedown, WrapperTakedownSeguro.seguroInformacion cotizacionSeguro) {
		this.takedownCP = takedownCP;
        this.assets = assets;
        this.contentTakedown = contentTakedown;
		this.cotizacionSeguro = cotizacionSeguro;
        this.exceptionsToGoInCA = [SELECT Id,OwnerId,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,LastViewedDate,LastReferencedDate,
        Takedown_CP__c,Document_Type__c,Reason_for_Exception__c,Approver__c,Requester_Comments__c,
        Approver_Comments__c,Stage__c,Due_Date__c,Status__c,Takedown_Amount__c,Customer_Name__c,
        Takedown_Amount_USD__c,Service_Level_Agreement_Days__c,Takedown_Status__c,Commitment_Date__c,
        Close_Date__c,Blanket_Insurance_Policy_Type__c,Blanket_Insurance_Policy_Start_Date__c,
        Blanket_Insurance_Policy_End_Date__c,Blanket_Insurance_Policy_Aging__c,Exception_Type__c,
        Sr_Underwriter__c,Control_Desk_Analyst__c,Product__c,Supplier_Customer__c,Other_Approver__c,
        No_Remediation_Details__c,No_Remdiation_Approver_Comments__c,Approve_Date__c,Days_Open__c,Closing_Bucket__c,
        Credit_Approval__c FROM WaiverToGo__c WHERE Credit_Approval__c =:takedownCP.TKD_rb_Pricin_CA__r.ES3_rb_Credit_approval_CP__c ];
    }
    
    public Wrapper_seguro_details(Takedowns_Contingency_plan__c takedownCP,  Asset[] assets, TakedownContentOld contentTakedownOLD, WrapperTakedownSeguro.seguroInformacion cotizacionSeguro) {
		this.takedownCP = takedownCP;
        this.assets = assets;
        this.contentTakedownOLD = contentTakedownOLD;
        this.cotizacionSeguro = cotizacionSeguro;
        this.exceptionsToGoInCA = [SELECT Id,OwnerId,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,LastViewedDate,LastReferencedDate,
        Takedown_CP__c,Document_Type__c,Reason_for_Exception__c,Approver__c,Requester_Comments__c,
        Approver_Comments__c,Stage__c,Due_Date__c,Status__c,Takedown_Amount__c,Customer_Name__c,
        Takedown_Amount_USD__c,Service_Level_Agreement_Days__c,Takedown_Status__c,Commitment_Date__c,
        Close_Date__c,Blanket_Insurance_Policy_Type__c,Blanket_Insurance_Policy_Start_Date__c,
        Blanket_Insurance_Policy_End_Date__c,Blanket_Insurance_Policy_Aging__c,Exception_Type__c,
        Sr_Underwriter__c,Control_Desk_Analyst__c,Product__c,Supplier_Customer__c,Other_Approver__c,
        No_Remediation_Details__c,No_Remdiation_Approver_Comments__c,Approve_Date__c,Days_Open__c,Closing_Bucket__c,
        Credit_Approval__c FROM WaiverToGo__c WHERE Credit_Approval__c =:takedownCP.TKD_rb_Pricin_CA__r.ES3_rb_Credit_approval_CP__c ];
    }
    
    public static WrapperTakedownSeguro.seguroInformacion cotizacionSeguro(Cotizacion_seguro__c [] cotizacion) {
        WrapperTakedownSeguro.seguroInformacion takedownSeguro = new WrapperTakedownSeguro.seguroInformacion();
        List<WrapperTakedownSeguro.activoDetail> listActivos = new List<WrapperTakedownSeguro.activoDetail>();
        
        for(Integer i = 0; i< cotizacion.size(); i++) {
            if(i == 0){
                takedownSeguro.producto = cotizacion[i].Producto__c;
                takedownSeguro.plazo = String.valueOf(cotizacion[i].QS_Periodo_Cotizacion__c);
                takedownSeguro.moneda = cotizacion[i].CurrencyIsoCode;
                takedownSeguro.idOpportunity = cotizacion[i].Opportunity__c;
                takedownSeguro.razonSocial = cotizacion[i].QS_Razon_social__c;
                takedownSeguro.nombre = cotizacion[i].Opportunity__r.Account.Name;
            }
            WrapperTakedownSeguro.activoDetail activos = new WrapperTakedownSeguro.activoDetail();
            activos.id = cotizacion[i].Id;
            activos.Name = cotizacion[i].Name;
            activos.cobertura = cotizacion[i].QS_descripcion__c;
            activos.sumaAsegurada = cotizacion[i].QS_Suma_Asegurada__c;
            activos.primaNeta = cotizacion[i].QS_Prima_Neta__c;
            activos.primaNetaLabel = cotizacion[i].QS_Prima_Neta_Label__c;
            activos.iva = cotizacion[i].QS_IVA__c;
            activos.ivaLabel = cotizacion[i].QS_IVA_Label__c;
            activos.primaTotal = cotizacion[i].QS_Prima_Neta_Total__c;
            activos.primaTotalLabel = cotizacion[i].QS_Prima_Neta_Total_Label__c;
            activos.primaNetaTotal = cotizacion[i].QS_Prima_Total__c;
            activos.primaNetaTotalLabel = cotizacion[i].QS_Prima_Total_Label__c;
            activos.gastos = cotizacion[i].QS_Gastos__c;
            activos.gastosLabel = cotizacion[i].QS_Gastos_Label__c ;
            listActivos.add(activos);
        }
        
        takedownSeguro.activos = listActivos;
        return takedownSeguro;
    }
    
    public static WrapperProcessCategory processDeal(String producto, String dealCategory, String stage, String finance,Datetime creationDate ) {
        String convertProducto = Wrapper_seguro_details.productoConvert(producto);
        String process;
        String processName;
        Set<Integer> exclude;
        
        Data_Access_TKD_Doument_Exclusionmdt query = new Data_Access_TKD_Doument_Exclusionmdt(); 
        WrapperProcessCategory infoCategory;
        
        if(stage == 'Converted'){
            if(dealCategory == 'Release' || dealCategory == 'Refi') {
                process = '13';
                processName = 'TAKEDOWN REFI CONVERTED';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  = 'TAKEDOWN_WORK_OUT_LOAN_CONVERTED';
          		 processName = 'TAKEDOWN WORK OUT LOAN CONVERTED';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_CONVERTED';
                 processName ='TAKEDOWN WORKOUT ARRENDAMIENTO FINANCIERO CONVERTED';
            }else if(dealCategory == 'Workout Restructure' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_CONVERTED';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_CONVERTED';
            }else if(dealCategory == 'Not new origination' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_LOAN_CONVERTED';
                 processName ='ALIVIO_LOAN_CONVERTED';
            }else if(dealCategory == 'Not new origination' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_FINANCIERO_CONVERTED';
                 processName ='ALIVIO_ARRENDAMIENTO_FINANCIERO_CONVERTED';
            }else if(dealCategory == 'Not new origination' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_PURO_CONVERTED';
                 processName ='ALIVIO_ARRENDAMIENTO_PURO_CONVERTED';
            }
            else {
                if(convertProducto == 'TAKEDOWN LOAN CONVERTED') {
                    process = '1';
               		processName = 'TAKEDOWN LOAN CONVERTED';
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED') {
                    process = '2';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED';
                    try {
                        exclude =Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(QueryException e){
                        System.debug('Error: '+e);
                    }
                    
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED') {
					process = '3';
                    processName = 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED';
                    
                    try {
                         exclude =Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS') {
                    process = '2';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED';
                    try {
                        exclude =Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
            }
        }
        else if(stage == 'Tollgate 1'){
            if(dealCategory == 'Release' || dealCategory == 'Refi') {
                process = '7';
                processName = 'TAKEDOWN RELEASE REFI TG1';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  = 'TAKEDOWN_WORK_OUT_LOAN_TG1';
          		 processName = 'TAKEDOWN_WORK_OUT_LOAN_TG1';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_TG1';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_TG1';
            }else if(dealCategory == 'Workout Restructure' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_TG1';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_TG1';
            }else if(dealCategory == 'Not new origination' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_LOAN_TG1';
                 processName ='ALIVIO_LOAN_TG1';
            }else if(dealCategory == 'Not new origination' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_FINANCIERO_TG1';
                 processName ='ALIVIO_ARRENDAMIENTO_FINANCIERO_TG1';
            }else if(dealCategory == 'Not new origination' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_PURO_TG1';
                 processName ='ALIVIO_ARRENDAMIENTO_PURO_TG1';
            }
            else {
                if(convertProducto == 'TAKEDOWN LOAN CONVERTED') {
                    process = '4';
                    processName = 'TAKEDOWN LOAN TG1';
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED') {
                    process = '5';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO TG1';
                    try {
                        exclude =Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED') {
                    process = '6';
                    processName = 'TAKEDOWN ARRENDAMIENTO PURO TG1';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS') {
                    process = '5';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO TG1';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
            }
        }
        else if(stage == 'In Signatures') {
            if(dealCategory == 'Release' || dealCategory == 'Refi') {
                process = '11';
                processName = 'TAKEDOWN RELEASE REFI ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
          		 processName = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Workout Restructure' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_LOAN_ISC';
                 processName ='ALIVIO_LOAN_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Not new origination' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
            }
            else {
                if(convertProducto == 'TAKEDOWN LOAN CONVERTED') {
                    process = '8';
                    processName = 'TAKEDOWN LOAN ISC';
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED') {
                    process = '10';
                    processName = 'AKEDOWN ARRENDAMIENTO PURO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
            }
        }
        else if(stage == 'Tollgate 2') {
            if(dealCategory == 'Release' || dealCategory == 'Refi') {
                process = '11';
                processName = 'TAKEDOWN RELEASE REFI ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
          		 processName = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Workout Restructure' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_LOAN_ISC';
                 processName ='ALIVIO_LOAN_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Not new origination' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
            }
            else {
                if(convertProducto == 'TAKEDOWN LOAN CONVERTED') {
                    process = '8';
                    processName = 'TAKEDOWN LOAN ISC';
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED') {
                    process = '10';
                    processName = 'TAKEDOWN ARRENDAMIENTO PURO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertproducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
            }
        }
        else if(stage == 'Registry') {
            if(dealCategory == 'Release' || dealCategory == 'Refi') {
                process = '11';
                processName = 'TAKEDOWN RELEASE REFI ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
          		 processName = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Workout Restructure' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_LOAN_ISC';
                 processName ='ALIVIO_LOAN_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Not new origination' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
            }
            else {
                if(convertProducto == 'TAKEDOWN LOAN CONVERTED') {
					process = '8';
					processName = 'TAKEDOWN LOAN ISC';                    
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED') {
                    process = '10';
                    processName = 'TAKEDOWN ARRENDAMIENTO PURO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
            }
        }
        else if(stage == 'Funded') {
            if(dealCategory == 'Release' || dealCategory == 'Refi') {
                process = '11';
                processName = 'TAKEDOWN RELEASE REFI ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
          		 processName = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Workout Restructure' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_LOAN_ISC';
                 processName ='ALIVIO_LOAN_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Not new origination' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
            }
            else {
                if(convertProducto == 'TAKEDOWN LOAN CONVERTED') {
                    process = '8';
                    processName = 'TAKEDOWN LOAN ISC';
                }
                else if(convertProducto == 'AKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED') {
                    process = '10';
                    processName = 'TAKEDOWN ARRENDAMIENTO PURO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
            }
        }
        else if(stage == 'Closed') {
            if(dealCategory == 'Release' || dealCategory == 'Refi') {
                process = '11';
                processName = 'TAKEDOWN RELEASE REFI ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
          		 processName = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Workout Restructure' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_LOAN_ISC';
                 processName ='ALIVIO_LOAN_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Not new origination' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
            }
            else {
                if(convertProducto == 'TAKEDOWN LOAN CONVERTED') {
                    process = '8';
                    processName = 'TAKEDOWN LOAN ISC';
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED') {
                    process = '10';
                    processName = 'TAKEDOWN ARRENDAMIENTO PURO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
            }
        }
        else if(stage == 'Canceled') {
            if(dealCategory == 'Release' || dealCategory == 'Refi') {
                process = '11';
                processName = 'TAKEDOWN RELEASE REFI ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
          		 processName = 'TAKEDOWN_WORK_OUT_LOAN_ISC';
            }else if(dealCategory == 'Workout Restructure' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Workout Restructure' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
                 processName ='TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='PRESTAMO-FIJA' || producto =='PRESTAMO-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_LOAN_ISC';
                 processName ='ALIVIO_LOAN_ISC';
            }else if(dealCategory == 'Not new origination' &&(producto =='AFINAN-FIJA' || producto =='AFINAN-VAR')&& Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC';
            }else if(dealCategory == 'Not new origination' && producto =='OPERFIN-FIJA' && Wrapper_seguro_details.forWOAlprocess(creationDate)){
                 process  ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
                 processName ='ALIVIO_ARRENDAMIENTO_PURO_ISC';
            }
            else {
                if(convertProducto == 'TAKEDOWN LOAN CONVERTED') {
                    process = '8';
                    processName = 'TAKEDOWN LOAN ISC';
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED') {
                    process = '10';
                    process = 'TAKEDOWN ARRENDAMIENTO PURO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }
                else if(convertProducto == 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS') {
                    process = '9';
                    processName = 'TAKEDOWN ARRENDAMIENTO FINANCIERO ISC';
                    try {
                        exclude = Wrapper_seguro_details.getExclude(producto, finance, dealCategory);
                    }
                    catch(System.QueryException e){
                        System.debug('Error: '+e);
                    }
                }                
            }
        }
        
        return infoCategory = new WrapperProcessCategory(process, processName, exclude);
    }
    
    public static String productoConvert(String producto) {
        String productoType;
        
        if(producto == 'OPERFIN-FIJA') {
            productoType = 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED';
        }
        else if(producto == 'AFINAN-FIJA') {
            productoType = 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED';
        }
        else if(producto == 'AFINAN-VAR') {
            productoType = 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED';
        }
        else if(producto == 'PRESTAMO-FIJA') {
            productoType = 'TAKEDOWN LOAN CONVERTED';
        }
        else if(producto == 'PRESTAMO-VAR') {
            productoType = 'TAKEDOWN LOAN CONVERTED';
        }
        else if(producto == 'PROGRESIVO_FIJA') {
            productoType = 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS';
        }
        else {
            productoType = null;
        }
        return productoType;
    }
    
    public static Boolean forWOAlprocess(Datetime creationDate){
        Date fechaCreacion = date.newInstance(creationDate.year(), creationDate.month(), creationDate.day());
        Date fechaLimite = date.newInstance(2020, 6, 24);
        if(fechaCreacion >= fechaLimite){
            return true;
        }else{
            return false;
        }
    }
    
    public static set<integer> getExclude(string product, string financingNeeds,string  dealCategory){
         List<SObject>noFilteredIds = Data_Access_TKD_Doument_Exclusionmdt.getDocIds(product, financingNeeds, dealCategory);
         set<Integer>filteredDocsIds = new Set<Integer>();
        for(SObject obj:noFilteredIds){
           integer docId =integer.valueOf(obj.get('Document_ID__c'));
            filteredDocsIds.add(docId);
        }
        
        return filteredDocsIds;
    }
    
    global class WrapperProcessCategory {
        public String process {get; set;}
        public String processName {get; set;}
        public Set<Integer> exclude {get; set;}
        
        public WrapperProcessCategory(String process, String processName, Set<Integer> exclude) {
            this.process = process;
            this.processName = processName;
            this.exclude = exclude;
        }
    }
}