/**
 * @File Name          : Takedown_Table_AB_Service_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 29/8/2019 9:38:52
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    28/8/2019 15:57:31   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class Takedown_Table_AB_Service_cls {
    public string base64Data    {get;set;}
    public List<String> labelFields  {get;set;}
    public List<String> apiFields  {get;set;}
    public Takedown_Table_AB_Service_cls(List<String> labelFields,List<String> apiFields,string base64Data) {
        this.labelFields = labelFields;
        this.apiFields = apiFields;
        this.base64Data = base64Data;
    }
    public void updateAssetsWithCSV(){
        System.debug(LoggingLevel.INFO,'Inicia updateAssetsWithCSV  ');
        string csv = EncodingUtil.base64Decode(this.base64Data).toString();
        Helper_Upsert_CSV_cls help = new Helper_Upsert_CSV_cls();
        help.upsertCSVFileFinal(csv, this.apiFields ,'Asset');
    }    
}