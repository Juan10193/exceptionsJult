@isTest
public class Takedown_Table_AB_Service_Test {
	@isTest
    public static void Takedown_Table_AB_Service_cls (){
        list<string> labelfields = new list <string>();
        list<string> apifields = new list <string>();
        string base64Data = 'WQEWWE';
        Takedown_Table_AB_Service_cls Test = new Takedown_Table_AB_Service_cls(labelfields,apifields,base64Data);
        Test.updateAssetsWithCSV();
    }
}