/**
 * @File Name          : Takedown_ChildChain_Execution.cls 
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 10/8/2019 22:02:21
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    10/8/2019 16:44:35   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class Takedown_ChildChain_Execution_cls implements Queueable, Database.AllowsCallouts{
    public List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> 	listSATValRequest 	{get;set;}
    public id AccountID		 														{get;set;} 
    
    public Takedown_ChildChain_Execution_cls(List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listSATValRequest, id AccountID) {
        this.listSATValRequest = listSATValRequest;
        this.AccountID = AccountID;
    } 
    public void execute(QueueableContext context) {
        if(!test.isRunningTest()){
            Takedown_Chain_Execution_cls chain_Execution = new Takedown_Chain_Execution_cls(listSATValRequest.get(0), this.AccountID);
            chain_Execution.procesing_Chain();
        }
        listSATValRequest.remove(0);
        if(this.listSATValRequest.size() > 0){            
            id EnqueueJob_ID = System.enqueueJob(new Takedown_ParentChain_Execution_cls(this.listSATValRequest,this.AccountID));
            System.debug('EnqueueJob_ID ' + EnqueueJob_ID);
        }else{
            System.debug(LoggingLevel.INFO, 'Ha concluido la conexión asincrona');
        }
    }
}