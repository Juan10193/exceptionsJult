/**
 * @File Name          : TakedownCPTgrServiceUnlockTD.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/11/2019 20:41:28
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/11/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class TakedownCPTgrServiceUnlockTD {         
    
    public List<Takedowns_Contingency_plan__c> newListTakedownCP {get;set;}
    public List<Takedowns_Contingency_plan__c> oldListTakedownCP {get;set;}
    
    public TakedownCPTgrServiceUnlockTD(List<Takedowns_Contingency_plan__c> newListTakedownCP, List<Takedowns_Contingency_plan__c> oldListTakedownCP){
    	this.newListTakedownCP = newListTakedownCP;
        this.oldListTakedownCP = oldListTakedownCP;
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 11/11/2019 
    * @return void 
    **/
    public void unlockApprovalData(){
        for(Integer i=0; i< this.newListTakedownCP.size(); i++){
            if(this.newListTakedownCP[i].CPL_ls_Stage__c != this.oldListTakedownCP[i].CPL_ls_Stage__c){
                if(this.newListTakedownCP[i].CPL_ls_Stage__c == 'Ready to send to the approval of Tollgate 1'){
                    Approval.unlock(this.newListTakedownCP[i].id);
                }
                
            }
        }        
    }
}