/**
 * @File Name          : Data_Access_ProcessInstanceWorkitem.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 26/11/2019 20:39:39
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    26/11/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public class Data_Access_ProcessInstanceWorkitem {
    public static list<Id> getActorIdsByWorkItemIds (list<Id> newWorkItemIds){
        list<Id>actorIds = new list<Id>();
        for( ProcessInstanceWorkitem pIW :[Select Id, ActorId from ProcessInstanceWorkitem where Id IN:newWorkItemIds]){
            actorIds.add(pIW.ActorId);
        }
        return actorIds;
    }


    public static Id gWorkItemIdByActorId (list<Id> newWorkItemIds, Id actorId){
        list<Id>piwIds = new list<Id>();
        for( ProcessInstanceWorkitem pIW :[Select Id, ActorId from ProcessInstanceWorkitem where Id IN:newWorkItemIds and ActorId=:actorId ]){
            piwIds.add(pIW.Id);
        }
        return piwIds.size()>0?piwIds.get(0):null;
    }  
}