trigger ES3_tr_deleteRelatedOppInCa on Opportunity_in_Credit_approval_CP__c (before delete) {
    
    if(Trigger.isDelete) 
    {        
        for(Opportunity_in_Credit_approval_CP__c oppInCa: Trigger.old) 
        {            
            ES3_OpportunitiesInCaWraper wraper = new ES3_OpportunitiesInCaWraper(oppInCa);
            
            if(wraper.pricings.size()>0) 				{Delete wraper.pricings;		}           
            if(wraper.entityInCa.size()>0) 				{Delete wraper.entityInCa;		}
            if(wraper.specialCondition.size()>0)		{Delete wraper.specialCondition;}
            if(wraper.covenants.size()>0)				{Delete wraper.covenants;		}
        }        
    }
}