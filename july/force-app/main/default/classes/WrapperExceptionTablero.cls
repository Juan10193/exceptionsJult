public class WrapperExceptionTablero {
	public Integer aprobar {get; set;}
	public Integer revisarCerrar {get; set;}
	public Integer vencer {get; set;}
    
    public static WrapperExceptionTablero getDashboard() {
        WrapperExceptionTablero tablero = new WrapperExceptionTablero();
        Integer numberDays = 0;
        Integer porAprobar = 0;
        Integer porRevisar = 0;
        Integer porVencer = 0;    
        
        
        for(WaiverToGo__c waiver : [SELECT Id, Name, Takedown_CP__r.Name, Exception_Type__c, Stage__c, Service_Level_Agreement_Days__c FROM WaiverToGo__c WHERE Stage__c = 'Submitted' OR Stage__c = 'Expert Opinion']) {
            if(waiver.Stage__c == 'Submitted') {
                porAprobar += 1;
            }
            else if(waiver.Stage__c == 'Expert Opinion') {
                porRevisar += 1;
            }
        }
        
        for(WaiverToGo__c waiverSLA : [SELECT Id, Name, Takedown_CP__r.Name, Exception_Type__c, Stage__c, Service_Level_Agreement_Days__c, Due_Date__c FROM WaiverToGo__c]) {
            if(waiverSLA.Due_Date__c != null) {
                if(waiverSLA.Stage__c == 'Submitted' || waiverSLA.Stage__c == 'Risk Approval' || waiverSLA.Stage__c == 'Approved' || waiverSLA.Stage__c == 'Completed' || waiverSLA.Stage__c == 'Expert Opinion') {
            		Date startDate = Date.today();
            		Date endDate = waiverSLA.Due_Date__c;
            		numberDays = startDate.daysBetween(endDate);
            		if(numberDays <= 10) {
                		porVencer += 1;
            		}
                	numberDays = 0;
                }
            }
        }
        tablero.aprobar = porAprobar;
        tablero.revisarCerrar = porRevisar;
        tablero.vencer = porVencer;
        
        return tablero;
    }
}