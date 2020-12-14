/**
 * @File Name          : Wk_wrapper_resultsOperationsDt.cls
 * @Description        : Clase para mostrar los errores en lwc Table exposure
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 5/9/2019 21:58:50
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    5/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public class Wk_wrapper_resultsOperationsDt {
    
    public class saveRecords{
    @AuraEnabled public list<Results>results =new list<Results>();
    @AuraEnabled public list<Errores>errors = new list<Errores>();
   }

   public class Errores{
       @AuraEnabled public string error {get;set;}
       @AuraEnabled public string code {get;set;}
   }

   public class Results{
      @AuraEnabled public string resultId {get;set;}
   } 
}