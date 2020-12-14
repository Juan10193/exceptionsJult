public class UpdateAmountCA {
    
    private List<Opportunity> newListOpportunity;
    private Map<Id, Opportunity> oldMapOpportunity;
    
    public UpdateAmountCA(List<Opportunity> newListOpportunity,  Map<Id, Opportunity> oldMapOpportunity){
        this.newListOpportunity = newListOpportunity;
        this.oldMapOpportunity = oldMapOpportunity;    	    
    }
    
    public map<id,TBO014_Credit_Approval__c> searchCAToUpdate(){
        set<id> setCAIds = new set<id>();
        //Valida si cambiaron los montos de las oportunidades
        for(Opportunity opp : newListOpportunity) {
            string recordtypeid = string.valueOf(opp.RecordTypeId);
            string devname = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(recordtypeid).getDeveloperName();
        	if (opp.Amount != oldMapOpportunity.get(opp.Id).Amount && devname !='OPP_LMM') {
            	setCAIds.add(opp.OPP_rb_Credit_Approval__c);
            }            
        }
        set<id> setOppIds = new set<id>();
        //Busca los CA de las oportunidades cuales cambiaron sus montos
        //extrae los ids de las oportunidades de las mismas 
        map<id,TBO014_Credit_Approval__c> mapCA = Data_Access_TBO014_Credit_Approval.getCABysetID(setCAIds);
        for(TBO014_Credit_Approval__c ca : mapCA.values()){
        	setOppIds.add(ca.id);    
        }
        //En base a los CA que se localizaron, busca todas las oportunidades de los mismos para recalcular los montos
        for(Opportunity opp : Data_Access_Opportunity_cls.getOpportunityBySetId(setOppIds)){
        	TBO014_Credit_Approval__c selectedCA= mapCA.get(opp.OPP_rb_Credit_Approval__c);
            if(opp.CurrencyIsoCode.equals('MXN') && selectedCA.TBO014_un_Amount_MXN__c != null){
            	selectedCA.TBO014_un_Amount_MXN__c = selectedCA.TBO014_un_Amount_MXN__c + opp.Amount;    
            } else if(opp.CurrencyIsoCode.equals('USD') && selectedCA.TBO014_un_Amount_USD__c != null){
            	selectedCA.TBO014_un_Amount_USD__c = selectedCA.TBO014_un_Amount_USD__c + opp.Amount;    
            }
    	}
		return mapCA;
    }
    public void updateCA(map<id,TBO014_Credit_Approval__c> mapCA){
        //Termina de realizar los cálculos de todos los CA que se encontraron para actualizar
        Decimal usdCurrencyRate = [SELECT ConversionRate FROM CurrencyType WHERE IsActive=TRUE AND IsoCode='MXN'].ConversionRate;
        for(TBO014_Credit_Approval__c ca : mapCA.values()){
            ca.TBO014_un_Amount_USD__c = ca.TBO014_un_Amount_USD__c == null ? 0 : ca.TBO014_un_Amount_USD__c;
            ca.TBO014_un_Amount_MXN__c = ca.TBO014_un_Amount_MXN__c == null ? 0 : ca.TBO014_un_Amount_MXN__c;
        	Decimal totalUSD = 0;
            totalUSD = ca.TBO014_un_Amount_USD__c + ca.TBO014_un_Amount_MXN__c;
            ca.TBO014_un_Amount_MXN__c = ca.TBO014_un_Amount_MXN__c * usdCurrencyRate;  
            ca.TBO014_un_Amount_USD__c = ca.TBO014_un_Amount_USD__c;
            ca.TBO014_un_Total_Amount_USD_Converted__c = totalUSD;
        }
        if(mapCA.isEmpty()){
        	update mapCA.values();    
        } 
    }
}