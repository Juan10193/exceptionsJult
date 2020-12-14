public class CustomerStatus_cls {    
    public List<TBO001_AccountClassification__c> accountClassificationList {set; get;}   
    public List<Account> accountList {set; get;}  
    
    public CustomerStatus_cls (List<TBO001_AccountClassification__c> accClsList) {
        this.accountClassificationList = accClsList; 
    }
    
    /**
    public CustomerStatus_cls (List<Account> accList) {
        this.accountList = accList; 
    }
    */
    
    public void setAccountClassificationStatusFromList() {
        // Get the current date
        Date todaysDate = Date.today();
        
        // Get the current year
        Integer currentYear = todaysDate.year(); 
        
        // Get the current month
        Integer currentMonth = todaysDate.month();
        
        // Initialize an id set to store de accound ids
        Set<Id> accountSet = new Set<Id>();
        
        // Get the set of account Ids
        for (TBO001_AccountClassification__c classification : this.accountClassificationList) {
            if (!accountSet.contains(classification.TBO001_rb_Account__c)) {
                accountSet.add(classification.TBO001_rb_Account__c);
            }
        }
        
        // Initialize a map with the account information
        Map<Id, Account> accountMap = new Map<Id, Account>();
        
        // Get the list of accounts per account classification
        List<Account> accountList;
        
        try {
            accountList = [SELECT Id, CreatedDate, ACC_tx_Account_Status__c, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c FROM Account WHERE Id IN :accountSet ORDER BY Id];
        }
        catch (Exception exAccList) {
            System.debug('Error: ' + exAccList.getMessage() + ' (Line: ' + exAccList.getLineNumber() + ').');
        }
        
        if (accountList != null) {
            // Get the accounts per account classification 
            for (Account acc : accountList) {
                accountMap.put(acc.Id, acc);
            }      
            
            // Initialize the maps with the takedowns that where funded for each account
            Map<String, List<TBO020_Takedowns__c>> takedownsFundedMap = new Map<String, List<TBO020_Takedowns__c>>();
            
            // get the list of the last funded takedown per account
            List<TBO020_Takedowns__c> fundedTakedownList;
            
            try {
                fundedTakedownList = [SELECT TBO020_pd_Opportunity__r.AccountId,
                                      TBO020_ls_Line_of_Business__c, 
                                      TBO020_fh_Delivery_Date__c 
                                      FROM TBO020_Takedowns__c 
                                      WHERE TBO020_tx_Status__c = 'Funded' 
                                      AND TBO020_pd_Opportunity__r.AccountId IN :accountSet 
                                      AND TBO020_ls_Line_of_Business__c <> null
                                      AND TBO020_fh_Delivery_Date__c <> null
                                      ORDER BY TBO020_pd_Opportunity__r.AccountId, TBO020_ls_Line_of_Business__c, TBO020_fh_Delivery_Date__c DESC
                                     ];
            }
            catch (Exception exFundedList) {
                System.debug('Error: ' + exFundedList.getMessage() + ' (Line: ' + exFundedList.getLineNumber() + ').');
            }
            
            if (fundedTakedownList != null) {
                for (TBO020_Takedowns__c fundedTakedown : fundedTakedownList) {
                    Id accountId =  fundedTakedown.TBO020_pd_Opportunity__r.AccountId;
                    String lineBusiness = fundedTakedown.TBO020_ls_Line_of_Business__c;
                    Date deliveryDate = fundedTakedown.TBO020_fh_Delivery_Date__c;
                    
                    String accountLBKey = accountId + ':' + lineBusiness;
                    
                    if (takedownsFundedMap.size() == 0) {
                        List<TBO020_Takedowns__c> takedownList = new List<TBO020_Takedowns__c>();
                        takedownList.add(fundedTakedown);
                        
                        takedownsFundedMap.put(accountLBKey, takedownList);
                    }              
                    else if (takedownsFundedMap.get(accountLBKey) != null) {
                        Boolean isReapeated = false;
                        
                        for (TBO020_Takedowns__c fundedTakedownCheck : ((List<TBO020_Takedowns__c>) takedownsFundedMap.get(accountLBKey))) {
                            Date currentDeliveryDate = fundedTakedown.TBO020_fh_Delivery_Date__c;
                            Date checkDeliveryDate = fundedTakedownCheck.TBO020_fh_Delivery_Date__c;
                            
                            if (currentDeliveryDate.daysBetween(checkDeliveryDate) == 0) {
                                isReapeated = true;
                                break;
                            }
                        }
                        
                        if (!isReapeated) {
                        	takedownsFundedMap.get(accountLBKey).add(fundedTakedown);
                        }
                    }
                    else {
                        List<TBO020_Takedowns__c> takedownList = new List<TBO020_Takedowns__c>();
                        takedownList.add(fundedTakedown);
                        
                        takedownsFundedMap.put(accountLBKey, takedownList);
                    }
                }  
            }
            
            // Get the set of account Ids
            for (TBO001_AccountClassification__c classification : this.accountClassificationList) {
                // Get the specific account for the Account Classification
                Account acc = accountMap.get(classification.TBO001_rb_Account__c);
                
                if (acc != null) {
                    // Variable to store the boolean value indicating if the Line of Business has a value
                    Boolean hasLineOfBusiness = false;
                    
                    // Variable to store the boolean value of whetere the account has exposure
                    Boolean hasExposure = false;
                    
                    // Verify if the account has exposure according to the Account Classification's Line of Business
                    if (String.isNotEmpty(classification.TBO001_ls_Line_of_Business__c)) {
                        if (classification.TBO001_ls_Line_of_Business__c.equals('Equipment')) {
                            if (acc.ACC_un_Capex_Exposure__c != null) {
                                if (acc.ACC_un_Capex_Exposure__c > 0) {
                                    hasExposure = true;
                                }
                            }
                        }
                        else if (classification.TBO001_ls_Line_of_Business__c.equals('Technology')) {
                            if (acc.ACC_un_Technology_Exposure__c != null) {
                                if (acc.ACC_un_Technology_Exposure__c > 0) {
                                    hasExposure = true;
                                }
                            }
                        }
                        else if (classification.TBO001_ls_Line_of_Business__c.equals('Fleet')) {
                            if (acc.ACC_un_Fleet_Exposure__c != null) {
                                if (acc.ACC_un_Fleet_Exposure__c > 0) {
                                    hasExposure = true;
                                }
                            }
                        }
                        else if (classification.TBO001_ls_Line_of_Business__c.equals('Real Estate')) {
                            if (acc.ACC_un_Real_Estate_Exposure__c != null) {
                                if (acc.ACC_un_Real_Estate_Exposure__c > 0) {
                                    hasExposure = true;
                                }
                            }
                        }
                        
                        hasLineOfBusiness = true;
                    }
                    
                    // Get the key to search the existing takedown List
                    String existingTakedownsKey = acc.Id + ':' + classification.TBO001_ls_Line_of_Business__c; 
                    
                    // Get the Account-s existing takedowns according to the Line of Business
                    List<TBO020_Takedowns__c> takedownsPerAccountList;
                    
                    try {
                        takedownsPerAccountList = takedownsFundedMap.get(existingTakedownsKey);
                    }
                    catch (Exception exTakedownsPerAccountList) {
                        System.debug('Error: ' + exTakedownsPerAccountList.getMessage() + ' (Line: ' + exTakedownsPerAccountList.getLineNumber() + ').');
                    }
                    
                    if (takedownsPerAccountList != null) {
                        if (takedownsPerAccountList.size() > 0) {
                            // Get the amount of funded takedowns
                            Integer quantityOfFundedTakedowns = takedownsPerAccountList.size();
                            
                            // Set the variable to store the month difference between the last funded takedown and today
                            Integer monthDifferenceFromToday;
                            
                            TBO020_Takedowns__c lastFundedTakedown;
                            
                            try {
                                lastFundedTakedown = takedownsPerAccountList[0];
                            }
                            catch (Exception exLastFundedTakedown) {
                                System.debug('Error: ' + exLastFundedTakedown.getMessage() + ' (Line: ' + exLastFundedTakedown.getLineNumber() + ').');
                            }
                            
                            // Flag to validate if the account has suffered a status change
                            Boolean isStatusChanged = false;
                            
                            if (lastFundedTakedown != null) {
                                Date lastFundedTakedownDeliveryDate = lastFundedTakedown.TBO020_fh_Delivery_Date__c;
                                Integer lastFundedTakedownYear = lastFundedTakedownDeliveryDate.year();
                                
                                if (quantityOfFundedTakedowns > 0) {
                                    // Get the difference in months between the last takedown and today
                                    monthDifferenceFromToday = lastFundedTakedownDeliveryDate.monthsBetween(todaysDate);
                                }
                                
                                //System.debug('Last Funded Delivery Date (' + classification.Id + '): ' + lastFundedTakedownDeliveryDate);
                                
                                // Verify if the account was created this year and the Account Classification has the Customer Status as 'New customer to EC'
                                Boolean isNewCustomerToEC = (lastFundedTakedownYear == currentYear) && (classification.TBO001_ls_Customer_Status__c == 'New customer to EC');
                                
                                // Verify if the accounts last takedown was created this year and the Account Classification has the Customer Status as 'Reactivated' or 'Recovered'
                                Boolean isReactivatedOrRecovered = (lastFundedTakedownYear == currentYear) && ((classification.TBO001_ls_Customer_Status__c == 'Reactivated') || (classification.TBO001_ls_Customer_Status__c == 'Recovered'));
                                                                
                                if (!isNewCustomerToEC && !isReactivatedOrRecovered) { // Verify that the Account Classification should change its status from 'New customer to EC' because the account creation year is different from the current year
                                                                        
                                    /** Si el producto nunca había tenido un fondeo y por lo tanto nunca estuvo en el portafolio y tiene un fondeo, 
(este status solo aplicará para el año calendario en donde se generó el cliente): New customer to EC */
                                    
                                    if ((quantityOfFundedTakedowns == 1) && (lastFundedTakedownYear == currentYear) && (!isStatusChanged)) {
                                        classification.TBO001_ls_Customer_Status__c = 'New customer to EC';
                                		
                                        isStatusChanged = true;
                                    }
                                    else {
                                        if (lastFundedTakedownYear == currentYear) {
                                            /** Si en el año calendario, un cliente que es “Dormant” y tiene un fondeo, durante ese año calendario, el estatus deberá 
de ser: Reactivated */
                                            
                                            // Validar que el Customer Status de su Account es "Dormant", si esto aplica se revisa si tiene un Takedown con status "Funded"
                                            // durante el año calendario actual. En este caso el Customer Status es "Reactivated".
                                            
                                            if (String.isNotEmpty(classification.TBO001_ls_Customer_Status__c) && (!isStatusChanged)) {
                                                if (classification.TBO001_ls_Customer_Status__c.equals('Dormant')) {
                                                    classification.TBO001_ls_Customer_Status__c = 'Reactivated';
                                        
                                        			isStatusChanged = true;
                                                }  
                                            }
                                            
                                            if (quantityOfFundedTakedowns > 1) {
                                                // Get the previous funded Takedown
                                                TBO020_Takedowns__c previousFundedTakedown;
                                                
                                                try {
                                                    previousFundedTakedown = takedownsPerAccountList[1];
                                                }
                                                catch (Exception exPreviousFundedTakedown) {
                                                    System.debug('Error: ' + exPreviousFundedTakedown.getMessage() + ' (Line: ' + exPreviousFundedTakedown.getLineNumber() + ').');
                                                }
                                                
                                                if (previousFundedTakedown != null) {
                                                    Date previousFundedTakedownDeliveryDate = previousFundedTakedown.TBO020_fh_Delivery_Date__c;
                                                    
                                                    Integer firstIndex = quantityOfFundedTakedowns - 1;
                                                    
                                                    // Get the previous funded Takedown
                                                    TBO020_Takedowns__c firstFundedTakedown;
                                                    
                                                    try {
                                                        firstFundedTakedown = takedownsPerAccountList[firstIndex];
                                                    }
                                                    catch (Exception exFirstFundedTakedown) {
                                                        System.debug('Error: ' + exFirstFundedTakedown.getMessage() + ' (Line: ' + exFirstFundedTakedown.getLineNumber() + ').');
                                                    }
                                                    
                                                    if (firstFundedTakedown != null) {
                                                        Date firstFundedTakedownDeliveryDate = firstFundedTakedown.TBO020_fh_Delivery_Date__c;
                                                        
                                                        Integer firstFundedTakedownDDYear = firstFundedTakedownDeliveryDate.year();
                                                        
                                                        if ((firstFundedTakedownDDYear == currentYear) && (!isStatusChanged)) {
                                                            classification.TBO001_ls_Customer_Status__c = 'New customer to EC';
                                        
                                        					isStatusChanged = true;
                                                        }
                                                    }
                                                    
                                                    /** Si el producto tuvo un fondeo hace más 36 meses y vuelve a tener un fondeo, el status deberá ser: New customer 
(podría haber sido antes “Dormant” o “Lost”) */
                                                    
                                                    // Buscar los últimos dos Takedowns que están en status "Funded" y validar si la diferencia de meses es mayor a 
                                                    // los 36 meses. En este caso poner el Customer Status en "New customer".
                                                    
                                                    Integer monthDifference = previousFundedTakedownDeliveryDate.monthsBetween(lastFundedTakedownDeliveryDate);
                                                    
                                                    if (monthDifference > 36) {
                                                        if (String.isEmpty(classification.TBO001_ls_Customer_Status__c) && (!isStatusChanged)) {
                                                            classification.TBO001_ls_Customer_Status__c = 'New customer';
                                        
                                        					isStatusChanged = true;
                                                        }
                                                        else if ((classification.TBO001_ls_Customer_Status__c.equals('Dormant') || classification.TBO001_ls_Customer_Status__c.equals('Lost') || classification.TBO001_ls_Customer_Status__c.equals('Prospect')) && (!isStatusChanged)) {
                                                            classification.TBO001_ls_Customer_Status__c = 'New customer';
                                        
                                        					isStatusChanged = true;
                                                        }
                                                    }
                                                    else if (monthDifference <= 36) {
                                                        /** Si en el año calendario, un cliente que es “Lost” y tiene un fondeo (y este fondeo vs. el último no es mayor a 36 meses), 
durante ese año calendario el estatus deberá de ser: Recovered */
                                                        
                                                        // Validar que el Customer Status de su Account es "Lost", si esto aplica se busca el último Takedown con status "Funded"
                                                        // y el último Takedown existente. Las fechas de estos dos se comparan para revisar si la diferencia es menor o igual a 36 meses, 
                                                        // de ser así el Customer Status es "Recovered".
                                                        
                                                        if (String.isNotEmpty(classification.TBO001_ls_Customer_Status__c)) {
                                                            if (classification.TBO001_ls_Customer_Status__c.equals('Lost') && (!isStatusChanged)) {
                                                                classification.TBO001_ls_Customer_Status__c = 'Recovered';
                                        
                                        						isStatusChanged = true;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                        if (hasLineOfBusiness && hasExposure) {
                                            
                                            /** Si el producto tuvo un fondeo hace más de 12 meses y ese producto tiene “exposure” vigente en el portafolio: Dormant */
                                            
                                            // Buscar el último Takedown que esté en status "Funded" y validar si tiene más de 12 meses de haberse puesto como "Funded".
                                            // En este caso, si tiene exposure vigente (Ej.: Technology Exposure mayor a 0) según su Line of Business entonces el Customer 
                                            // Status es "Dormant".
                                            
                                            if ((monthDifferenceFromToday > 12) && (!isStatusChanged)) {
                                                classification.TBO001_ls_Customer_Status__c = 'Dormant';
                                        
                                        		isStatusChanged = true;
                                            }
                                        }
                                        else {
                                            if (!isStatusChanged) {
                                                /** Si el producto tuvo algún fondeo histórico y ya no tiene “exposure” en el portafolio: Lost */
                                                
                                                // Buscar si alguna vez tuvo un Takedown en status "Funded". En este caso, si no tiene "exposure" 
                                                // (Ej.: Technology Exposure igual a 0) según su Line of Business, entonces el Customer Status es 
                                                // "Lost".
                                                
                                                classification.TBO001_ls_Customer_Status__c = 'Lost';
                                        
                                        		isStatusChanged = true;
                                            }
                                        }
                                    }
                                }
                                
                                /** Si el cliente fue New customer, Reactivated o Recovered, en el año calendario anterior, en el siguiente año el status 
deberá cambiar a: active (esto status permanecerá siempre y cuando el último no sea mayor a 12 meses)*/
                                
                                // Validar que el Customer Status de su Account es "New customer", "Reactivated" o "Recovered" en el año calendario anterior.
                                // Al cambiar al siguiente año calendario el Customer Status será "Active".
                                
                                
                                if ((monthDifferenceFromToday <= 12) && !isReactivatedOrRecovered) {
                                    if (!isStatusChanged) {
                                        if (String.isEmpty(classification.TBO001_ls_Customer_Status__c) || classification.TBO001_ls_Customer_Status__c.equals('Prospect') || classification.TBO001_ls_Customer_Status__c.equals('New customer') || classification.TBO001_ls_Customer_Status__c.equals('Reactivated') || classification.TBO001_ls_Customer_Status__c.equals('Recovered') || (classification.TBO001_ls_Customer_Status__c.equals('New customer to EC') && (lastFundedTakedownYear != currentYear))) {
                                            classification.TBO001_ls_Customer_Status__c = 'Active';
                                        
                                        	isStatusChanged = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else { 
                        Integer customerSinceYear;
                        
                        try {
                            customerSinceYear = Integer.valueOf(classification.TBO001_tx_Customer_Since__c);
                        }
                        catch (Exception csyEx) {}
                            
                        if (customerSinceYear <= 2015) {
                            if (hasLineOfBusiness && hasExposure) {
                                classification.TBO001_ls_Customer_Status__c = 'Dormant';
                            }
                            else {
                                classification.TBO001_ls_Customer_Status__c = 'Lost';
                            }
                        }
                        else {// If the existing Takedowns Map is empty the the Customer Status is "Prospect"
                        	classification.TBO001_ls_Customer_Status__c = 'Prospect';
                        }
                    }
                }
            }
        }
    }
    
    /**
    public Map<Id, Account> setAccountListStatus() {
        
        Set<Id> accountSet = new Set<Id>();
        
        for (TBO001_AccountClassification__c classification : this.accountClassificationList) {
            if (classification.TBO001_rb_Account__c != null) {
                if (!accountSet.contains(classification.TBO001_rb_Account__c)) {
                    accountSet.add(classification.TBO001_rb_Account__c);
                }
            }
        }
        
        // Initialize a map with the account information
        Map<Id, Account> accountMap = new Map<Id, Account>();
        
        List<Account> accountList;
        
        try {
            accountList = [SELECT Id, ACC_tx_Account_Status__c FROM Account WHERE Id IN :accountSet];
        }
        catch (Exception exAccList) {
            System.debug('Error: ' + exAccList.getMessage() + ' (Line: ' + exAccList.getLineNumber() + ').');
        }
        
        if (accountList != null) {
            Map<Id, String> accountStatusMap = new Map<Id, String>();
            
            List<TBO001_AccountClassification__c> accClassList;
            
            try {
                accClassList = [SELECT Id, TBO001_rb_Account__c, TBO001_ls_Customer_Status__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountSet ORDER BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c];
            }
            catch (Exception exAccClassList) {
                System.debug('Error: ' + exAccClassList.getMessage() + ' (Line: ' + exAccClassList.getLineNumber() + ').');
            }
            
            if (accClassList != null) {
                for (TBO001_AccountClassification__c accClass : accClassList) {
                    Id accountId = accClass.TBO001_rb_Account__c;
                    String status = accClass.TBO001_ls_Customer_Status__c;
                    
                    if ((accountStatusMap.size() == 0) || (String.isEmpty(accountStatusMap.get(accountId)))) {                        
                        if (String.isNotEmpty(status)) {
                            accountStatusMap.put(accountId, status);
                        }
                    }
                    else {
                        
                        String accountStatus = accountStatusMap.get(accountId);
                        
                        if (String.isNotEmpty(accountStatus) && String.isNotEmpty(status)) {
                            if (!accountStatus.equals('Active') && (status.equals('Active'))) {
                                accountStatusMap.put(accountId, status);
                            }
                            else if (!accountStatus.equals('Active')) {
                                if (!accountStatus.equals('Dormant') && (status.equals('Dormant'))) {
                                    accountStatusMap.put(accountId, status);
                                }
                                else if (!accountStatus.equals('Dormant')) {
                                    if (!accountStatus.equals('Reactivated') && (status.equals('Reactivated'))) {
                                        accountStatusMap.put(accountId, status);
                                    }
                                    else if (!accountStatus.equals('Reactivated')) {
                                        if (!accountStatus.equals('Recovered') && (status.equals('Recovered'))) {
                                            accountStatusMap.put(accountId, status);
                                        }
                                        else if (!accountStatus.equals('Recovered')) {
                                            if (!accountStatus.equals('New customer') && (status.equals('New customer'))) {
                                                accountStatusMap.put(accountId, status);
                                            }
                                            else if (!accountStatus.equals('New customer')) {
                                                if (!accountStatus.equals('New customer to EC') && (status.equals('New customer to EC'))) {
                                                    accountStatusMap.put(accountId, status);
                                                }
                                                else if (!accountStatus.equals('New customer to EC')) {
                                                    if (!accountStatus.equals('Lost') && (status.equals('Lost'))) {
                                                        accountStatusMap.put(accountId, status);
                                                    }
                                                    else if (!accountStatus.equals('Lost')) {
                                                        if (!accountStatus.equals('Prospect') && (status.equals('Prospect'))) {
                                                            accountStatusMap.put(accountId, status);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            Map<Id, Account> accountUpdateMap = new Map<Id, Account>();
            
            for (Account accnt : accountList) {
                
                String accountStatus = accountStatusMap.get(accnt.Id);
                
                if (String.isNotEmpty(accountStatus)) {
                    if (String.isEmpty(accnt.ACC_tx_Account_Status__c)) {
                        accnt.ACC_tx_Account_Status__c = accountStatus;
                        
                        accountUpdateMap.put(accnt.Id, accnt);
                    }
                    else if (!accountStatus.equals(accnt.ACC_tx_Account_Status__c)) {
                        accnt.ACC_tx_Account_Status__c = accountStatus;
                        
                        accountUpdateMap.put(accnt.Id, accnt);
                    }
                }
            }
            
            return accountUpdateMap;
        }
        
        return null;
    }
    
    public Map<Id, Account> setTopParentAccountListStatus() {
		//System.debug('Top Parent Account List Status -->');
        
        // Initialize a set list with the top parent account id
        Set<Id> topParentAccountIdSet = new Set<Id>();
        
        for (Account accnt : this.accountList) {
            if (accnt.ACC_rb_Top_Parent_Account__c != null) {
                if (!topParentAccountIdSet.contains(accnt.ACC_rb_Top_Parent_Account__c)) {
                    topParentAccountIdSet.add(accnt.ACC_rb_Top_Parent_Account__c);
                }
            }
        }
        
        if (topParentAccountIdSet.size() > 0) {
            List<Account> topParentAccountList;
            
            try {
                topParentAccountList = [SELECT Id, ACC_tx_Account_Status__c FROM Account WHERE Id IN :topParentAccountIdSet];
            }
            catch (Exception exTopParentAccountList) {
                System.debug('Error: ' + exTopParentAccountList.getMessage() + ' (Line: ' + exTopParentAccountList.getLineNumber() + ').');
            }
            
            Map<Id, Account> accountUpdateMap = new Map<Id, Account>();
            
            if (topParentAccountList != null) {
                Map<Id, String> accountStatusMap = new Map<Id, String>();
                
                List<TBO001_AccountClassification__c> accClassList;
                
                try {
                    accClassList = [SELECT Id, TBO001_rb_Account__c, TBO001_ls_Customer_Status__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :topParentAccountIdSet ORDER BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c];
                }
                catch (Exception exAccClassList) {
                    System.debug('Error: ' + exAccClassList.getMessage() + ' (Line: ' + exAccClassList.getLineNumber() + ').');
                }
                
                if (accClassList != null) {
                    for (TBO001_AccountClassification__c accClass : accClassList) {
                        Id accountId = accClass.TBO001_rb_Account__c;
                        String status = accClass.TBO001_ls_Customer_Status__c;
                    
                    	//System.debug('Account Classification Status: ' + status);
                        
                        if ((accountStatusMap.size() == 0) || (String.isEmpty(accountStatusMap.get(accountId)))) {
                            if (String.isNotEmpty(status)) {
                                accountStatusMap.put(accountId, status);
                            }
                        }
                        else {                        
                            String accountStatus = accountStatusMap.get(accountId);
                    
                    		//System.debug('Account Status: ' + accountStatus);
                            
                            if (String.isNotEmpty(accountStatus) && String.isNotEmpty(status)) {
                                if (!accountStatus.equals('Active') && (status.equals('Active'))) {
                                    accountStatusMap.put(accountId, status);
                                }
                                else if (!accountStatus.equals('Active')) {
                                    if (!accountStatus.equals('Dormant') && (status.equals('Dormant'))) {
                                        accountStatusMap.put(accountId, status);
                                    }
                                    else if (!accountStatus.equals('Dormant')) {
                                        if (!accountStatus.equals('Reactivated') && (status.equals('Reactivated'))) {
                                            accountStatusMap.put(accountId, status);
                                        }
                                        else if (!accountStatus.equals('Reactivated')) {
                                            if (!accountStatus.equals('Recovered') && (status.equals('Recovered'))) {
                                                accountStatusMap.put(accountId, status);
                                            }
                                            else if (!accountStatus.equals('Recovered')) {
                                                if (!accountStatus.equals('New customer') && (status.equals('New customer'))) {
                                                    accountStatusMap.put(accountId, status);
                                                }
                                                else if (!accountStatus.equals('New customer')) {
                                                    if (!accountStatus.equals('New customer to EC') && (status.equals('New customer to EC'))) {
                                                        accountStatusMap.put(accountId, status);
                                                    }
                                                    else if (!accountStatus.equals('New customer to EC')) {
                                                        if (!accountStatus.equals('Lost') && (status.equals('Lost'))) {
                                                            accountStatusMap.put(accountId, status);
                                                        }
                                                        else if (!accountStatus.equals('Lost')) {
                                                            if (!accountStatus.equals('Prospect') && (status.equals('Prospect'))) {
                                                                accountStatusMap.put(accountId, status);
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                    
            	//System.debug('Account Status Map: ' + accountStatusMap);
                
                Map<Id, String> topParentAccountStatusMap = new Map<Id, String>();
                
                List<Account> accStatusList;
                
                try {
                    accStatusList = [SELECT Id, ACC_rb_Top_Parent_Account__c, ACC_rb_Top_Parent_Account__r.ACC_tx_Account_Status__c, ACC_tx_Account_Status__c FROM Account WHERE ACC_rb_Top_Parent_Account__c IN :topParentAccountIdSet ORDER BY ACC_rb_Top_Parent_Account__c, ACC_tx_Account_Status__c];
                }
                catch (Exception exAccStatusList) {
                    System.debug('Error: ' + exAccStatusList.getMessage() + ' (Line: ' + exAccStatusList.getLineNumber() + ').');
                }
                
                if (accStatusList != null) {
                    for (Account accStatus : accStatusList) {
                        Id accountId = accStatus.ACC_rb_Top_Parent_Account__c;
                        String status = accStatus.ACC_tx_Account_Status__c;
                        String topParentStatus = accountStatusMap.get(accountId);
                        
            			//System.debug('Account Status (' + accountId + '): ' + status);
            			//System.debug('Top Parent Account Status (' + accountId + '): ' + topParentStatus);
                        
                        if (String.isEmpty(topParentAccountStatusMap.get(accountId))) {                        
                            if (String.isNotEmpty(topParentStatus)) {
                                topParentAccountStatusMap.put(accountId, topParentStatus);
                            }
                        }                        
                        
                        if ((topParentAccountStatusMap.size() == 0) || (String.isEmpty(topParentAccountStatusMap.get(accountId)))) {
                            if (String.isNotEmpty(status)) {
                                topParentAccountStatusMap.put(accountId, status);
                            }
                        }
                        else {
                            
                            String accountStatus = topParentAccountStatusMap.get(accountId);
            				//System.debug('Top Parent Account Status Map Status (' + accountId + '): ' + accountStatus);
                            
                            if (String.isNotEmpty(accountStatus) && String.isNotEmpty(status)) {
                                if (!accountStatus.equals('Active') && (status.equals('Active'))) {
                                    topParentAccountStatusMap.put(accountId, status);
                                }
                                else if (!accountStatus.equals('Active')) {
                                    if (!accountStatus.equals('Dormant') && (status.equals('Dormant'))) {
                                        topParentAccountStatusMap.put(accountId, status);
                                    }
                                    else if (!accountStatus.equals('Dormant')) {
                                        if (!accountStatus.equals('Reactivated') && (status.equals('Reactivated'))) {
                                            topParentAccountStatusMap.put(accountId, status);
                                        }
                                        else if (!accountStatus.equals('Reactivated')) {
                                            if (!accountStatus.equals('Recovered') && (status.equals('Recovered'))) {
                                                topParentAccountStatusMap.put(accountId, status);
                                            }
                                            else if (!accountStatus.equals('Recovered')) {
                                                if (!accountStatus.equals('New customer') && (status.equals('New customer'))) {
                                                    topParentAccountStatusMap.put(accountId, status);
                                                }
                                                else if (!accountStatus.equals('New customer')) {
                                                    if (!accountStatus.equals('New customer to EC') && (status.equals('New customer to EC'))) {
                                                        topParentAccountStatusMap.put(accountId, status);
                                                    }
                                                    else if (!accountStatus.equals('New customer to EC')) {
                                                        if (!accountStatus.equals('Lost') && (status.equals('Lost'))) {
                                                            topParentAccountStatusMap.put(accountId, status);
                                                        }
                                                        else if (!accountStatus.equals('Lost')) {
                                                            if (!accountStatus.equals('Prospect') && (status.equals('Prospect'))) {
                                                                topParentAccountStatusMap.put(accountId, status);
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            	//System.debug('Top Parent Account Status Map: ' + topParentAccountStatusMap);
                
                for (Account topParentAccnt : topParentAccountList) {
                    
                    String accountStatus = topParentAccountStatusMap.get(topParentAccnt.Id);
                
                	//System.debug('Top Parent Account (' + topParentAccnt.Id + ') Status: ' + accountStatus);
                    
                    if (String.isNotEmpty(accountStatus)) {
                        if (String.isEmpty(topParentAccnt.ACC_tx_Account_Status__c)) {
                            topParentAccnt.ACC_tx_Account_Status__c = accountStatus;
                            accountUpdateMap.put(topParentAccnt.Id, topParentAccnt);
                
                			//System.debug('Final Top Parent Account (' + topParentAccnt.Id + ') Status: ' + topParentAccnt.ACC_tx_Account_Status__c);
                        }
                        else if (!accountStatus.equals(topParentAccnt.ACC_tx_Account_Status__c)) {
                            topParentAccnt.ACC_tx_Account_Status__c = accountStatus;
                            accountUpdateMap.put(topParentAccnt.Id, topParentAccnt);
                
                			//System.debug('Final Top Parent Account (' + topParentAccnt.Id + ') Status: ' + topParentAccnt.ACC_tx_Account_Status__c);
                        }
                    }  
                    else {
                        if (String.isEmpty(topParentAccnt.ACC_tx_Account_Status__c)) {
                            topParentAccnt.ACC_tx_Account_Status__c = 'Prospect';
                            accountUpdateMap.put(topParentAccnt.Id, topParentAccnt);
                
                			//System.debug('Final Top Parent Account (' + topParentAccnt.Id + ') Status: ' + topParentAccnt.ACC_tx_Account_Status__c);
                        }
                        else if (!topParentAccnt.ACC_tx_Account_Status__c.equals('Prospect')) {
                            topParentAccnt.ACC_tx_Account_Status__c = 'Prospect';
                            accountUpdateMap.put(topParentAccnt.Id, topParentAccnt);
                
                			//System.debug('Final Top Parent Account (' + topParentAccnt.Id + ') Status: ' + topParentAccnt.ACC_tx_Account_Status__c);
                        }
                    }
                }
                
                return accountUpdateMap;
            }
        }
        
        return null;
    }
    
    public Map<Id, Account> setParentChildAccountListStatus() {
		//System.debug('Parent Child Account List Status -->');
        
        // Initialize a set list with the top parent account id
        Set<Id> topParentAccountIdSet = new Set<Id>();
        
        for (Account accnt : this.accountList) {
            if ((accnt.Id != null) && (accnt.ACC_rb_Top_Parent_Account__c == null)) {
                if (!topParentAccountIdSet.contains(accnt.Id)) {
                    topParentAccountIdSet.add(accnt.Id);
                }
            }
        }
        
        List<Account> topParentAccountList;
        
        try {
            topParentAccountList = [SELECT Id, ACC_tx_Account_Status__c FROM Account WHERE Id IN :topParentAccountIdSet];
        }
        catch (Exception exTopParentAccountList) {
            System.debug('Error: ' + exTopParentAccountList.getMessage() + ' (Line: ' + exTopParentAccountList.getLineNumber() + ').');
        }
        
        Map<Id, Account> accountUpdateMap = new Map<Id, Account>();
        
        if (topParentAccountList != null) {
            Map<Id, String> childAccountStatusMap = new Map<Id, String>();
            
            List<Account> childAccountList;
            
            try {
                childAccountList = [SELECT Id, ACC_rb_Top_Parent_Account__c, ACC_tx_Account_Status__c FROM Account WHERE ACC_rb_Top_Parent_Account__c IN :topParentAccountIdSet ORDER BY ACC_rb_Top_Parent_Account__c, ACC_tx_Account_Status__c];
            }
            catch (Exception exChildAccountList) {
                System.debug('Error: ' + exChildAccountList.getMessage() + ' (Line: ' + exChildAccountList.getLineNumber() + ').');
            }
            
            if (childAccountList != null) {
                for (Account childAccount : childAccountList) {
                    Id accountId = childAccount.ACC_rb_Top_Parent_Account__c;
                    String status = childAccount.ACC_tx_Account_Status__c;
                    
                    //System.debug('Child Account Status: ' + status);
                    
                    if ((childAccountStatusMap.size() == 0) || (String.isEmpty(childAccountStatusMap.get(accountId)))) {
                        
                        if (String.isNotEmpty(status)) {
                            childAccountStatusMap.put(accountId, status);
                        }
                    }
                    else {
                        
                        String accountStatus = childAccountStatusMap.get(accountId);
                    
                    	//System.debug('Account Status: ' + accountStatus);
                        
                        if (String.isNotEmpty(accountStatus) && String.isNotEmpty(status)) {
                            if (!accountStatus.equals('Active') && (status.equals('Active'))) {
                                childAccountStatusMap.put(accountId, status);
                            }
                            else if (!accountStatus.equals('Active')) {
                                if (!accountStatus.equals('Dormant') && (status.equals('Dormant'))) {
                                    childAccountStatusMap.put(accountId, status);
                                }
                                else if (!accountStatus.equals('Dormant')) {
                                    if (!accountStatus.equals('Reactivated') && (status.equals('Reactivated'))) {
                                        childAccountStatusMap.put(accountId, status);
                                    }
                                    else if (!accountStatus.equals('Reactivated')) {
                                        if (!accountStatus.equals('Recovered') && (status.equals('Recovered'))) {
                                            childAccountStatusMap.put(accountId, status);
                                        }
                                        else if (!accountStatus.equals('Recovered')) {
                                            if (!accountStatus.equals('New customer') && (status.equals('New customer'))) {
                                                childAccountStatusMap.put(accountId, status);
                                            }
                                            else if (!accountStatus.equals('New customer')) {
                                                if (!accountStatus.equals('New customer to EC') && (status.equals('New customer to EC'))) {
                                                    childAccountStatusMap.put(accountId, status);
                                                }
                                                else if (!accountStatus.equals('New customer to EC')) {
                                                    if (!accountStatus.equals('Lost') && (status.equals('Lost'))) {
                                                        childAccountStatusMap.put(accountId, status);
                                                    }
                                                    else if (!accountStatus.equals('Lost')) {
                                                        if (!accountStatus.equals('Prospect') && (status.equals('Prospect'))) {
                                                            childAccountStatusMap.put(accountId, status);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
                    
            //System.debug('Child Account Status Map: ' + childAccountStatusMap);
            
            Map<Id, Account> topParentAccountUpdateMap = new Map<Id, Account>();
            
            for (Account accnt : topParentAccountList) {
                Id accountId = accnt.Id;
                String status = accnt.ACC_tx_Account_Status__c;
                String childStatus = childAccountStatusMap.get(accountId);
                    
            	//System.debug('Top Parent Account Status: ' + status);
            	//System.debug('Child Account Status: ' + childStatus);
                
                if (String.isNotEmpty(status) && String.isNotEmpty(childStatus)) {
                    if (!status.equals('Active') && (childStatus.equals('Active'))) {
                        accnt.ACC_tx_Account_Status__c = childStatus;
                        topParentAccountUpdateMap.put(accountId, accnt);
                    }
                    else if (!status.equals('Active')) {
                        if (!status.equals('Dormant') && (childStatus.equals('Dormant'))) {
                            accnt.ACC_tx_Account_Status__c = childStatus;
                            topParentAccountUpdateMap.put(accountId, accnt);
                        }
                        else if (!status.equals('Dormant')) {
                            if (!status.equals('Reactivated') && (childStatus.equals('Reactivated'))) {
                                accnt.ACC_tx_Account_Status__c = childStatus;
                                topParentAccountUpdateMap.put(accountId, accnt);
                            }
                            else if (!status.equals('Reactivated')) {
                                if (!status.equals('Recovered') && (childStatus.equals('Recovered'))) {
                                    accnt.ACC_tx_Account_Status__c = childStatus;
                                    topParentAccountUpdateMap.put(accountId, accnt);
                                }
                                else if (!status.equals('Recovered')) {
                                    if (!status.equals('New customer') && (childStatus.equals('New customer'))) {
                                        accnt.ACC_tx_Account_Status__c = childStatus;
                                        topParentAccountUpdateMap.put(accountId, accnt);
                                    }
                                    else if (!status.equals('New customer')) {
                                        if (!status.equals('New customer to EC') && (childStatus.equals('New customer to EC'))) {
                                            accnt.ACC_tx_Account_Status__c = childStatus;
                                            topParentAccountUpdateMap.put(accountId, accnt);
                                        }
                                        else if (!status.equals('New customer to EC')) {
                                            if (!status.equals('Lost') && (childStatus.equals('Lost'))) {
                                                accnt.ACC_tx_Account_Status__c = childStatus;
                                                topParentAccountUpdateMap.put(accountId, accnt);
                                            }
                                            else if (!status.equals('Lost')) {
                                                if (!status.equals('Prospect') && (childStatus.equals('Prospect'))) {
                                                    accnt.ACC_tx_Account_Status__c = childStatus;
                                                    topParentAccountUpdateMap.put(accountId, accnt);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
                
            	//System.debug('Top Parent Account Update Map: ' + topParentAccountUpdateMap);
            
            return topParentAccountUpdateMap;
        }
        
        return null;
    }
    */
}