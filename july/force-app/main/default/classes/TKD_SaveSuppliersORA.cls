/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-01-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-01-2020   eduardo.amiens@outlook.com   Initial Version
**/
public class TKD_SaveSuppliersORA { 
    
    
    public static void saveSuppliers(set<Id> suppliersInAppIds){

        if(suppliersInAppIds.size()>0){
            TKD_PostSuppliersToOracle postOracle = new TKD_PostSuppliersToOracle(suppliersInAppIds);
            Id bactchId = Database.executeBatch(postOracle, 20);
        }else{
            system.debug(LoggingLevel.INFO, 'No hay suppliers In approval approvados');
        }
    }
}