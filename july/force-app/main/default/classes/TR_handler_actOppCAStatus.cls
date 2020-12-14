public class TR_handler_actOppCAStatus {
    public boolean addErrorUpdate(map<id,Credit_approval_CP__c> newPricings_In_CA){
        for(id idCP : newPricings_In_CA.keyset()){
                if(newPricings_In_CA.get(idCP).CPL_ls_StageName__c.equals('Approved')){
                    for(Credit_approval_CP__c CP : newPricings_In_CA.values()){
                       // CP.addError('Sorry, you can\'t edit the pricings pricings from credit approval when stage field is "Approved"');
                       // return false;
                    }
                    
                }               
            
            if(string.isNotBlank(newPricings_In_CA.get(idCP).ES3_ls_EBO__c)){
                if(newPricings_In_CA.get(idCP).ES3_ls_EBO__c.equals('YES')){
                    if(string.isEmpty(newPricings_In_CA.get(idCP).ES3_tl_EBO_Description__c)){
                        for(Credit_approval_CP__c CP : newPricings_In_CA.values()){
                            CP.addError('Please, write an EBO description');
                            return false;
                        }
                    }
                }
            }
            
        }
        return true;    	    
    }
    
}