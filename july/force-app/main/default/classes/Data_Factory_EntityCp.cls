@Istest
public class Data_Factory_EntityCp {
    public static Entity_CP__c createEntityCP(string name, string rfcTin){
        Entity_CP__c enttityCP = new Entity_CP__c();
        enttityCP.Name = name;
        enttityCP.CPI_tx_RFC_TIN__c =rfcTin;
        insert enttityCP;
        return enttityCP;
    }
}