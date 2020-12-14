@RestResource (urlMapping='/TakedownAPI/*')
global class Takedown_seguro {
    
    private Wrapper_Takedown_seguro[] takedownBlock = new Wrapper_Takedown_seguro[]{};
    private final integer listLimit;
    
    global Takedown_seguro() {
        listLimit = 999;
    }
      
    @HttpGet
    global static Wrapper_Takedown_seguro[] getTakedownCP() {
		RestRequest restReq = RestContext.request;
        RestResponse restRes = RestContext.response;
        String statusTakedown = restReq.params.get('statusTakedown');
        System.debug(statusTakedown);
        
		Takedown_seguro takeDown = new Takedown_seguro();
		takeDown.takedownBlock = new Wrapper_Takedown_seguro[]{};    
		Integer counter = 0;
		Integer lookCount = 0;
		Takedowns_Contingency_plan__c [] tmpTakedownCP = new Takedowns_Contingency_plan__c[]{};
	
		for(Takedowns_Contingency_plan__c queryTakedownCP : [SELECT Id,
                                                             Name,
                                                             TKD_ls_takedown_stage__c
                                                             FROM Takedowns_Contingency_plan__c WHERE TKD_ls_takedown_stage__c =: (statusTakedown).replace('_',' ')]) {
			if(counter < takeDown.listLimit) {
				tmpTakedownCP.add(queryTakedownCP);
				counter++;
			}
			else {
				lookCount++;
				takeDown.takedownBlock.add(new Wrapper_Takedown_seguro(tmpTakedownCP, lookCount));
				tmpTakedownCP = new Takedowns_Contingency_plan__c[]{};
				tmpTakedownCP.add(queryTakedownCP);
				counter = 0;
			}
		}
 
		if(tmpTakedownCP.size() != 0) {
			lookCount++;
			takeDown.takedownBlock.add(new Wrapper_Takedown_seguro(tmpTakedownCP, lookCount));
		}
   
		return takeDown.takedownBlock;
	}
}