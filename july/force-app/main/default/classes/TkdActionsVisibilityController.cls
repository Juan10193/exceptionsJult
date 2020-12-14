public with sharing class TkdActionsVisibilityController {
    
    public static Boolean getVisibility(list<Id> newWorkItemIds){
        Id userId = UserInfo.getUserId();
        Id profileId = UserInfo.getProfileId();

        list<Id>actorIds = Data_Access_ProcessInstanceWorkitem.getActorIdsByWorkItemIds(newWorkItemIds);
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;

        
        list<Id>queueUserIds =Data_Access_GroupMember.getUserGroupsIdsByIds(actorIds);
        system.debug('queueUserIds:' + queueUserIds);
        system.debug('userId: '  + userId);
        if(actorIds.contains(userId) || queueUserIds.contains(userId) ){
            return true;
        }else if(profileName =='System Administrator' || profileName =='Administrador del Sistema' || profileName=='Administrator'){
            return true;
        }else {
            return false;
        }
    }


    public static Id getWorkingItemByUserId(list<Id> newWorkItemIds){
        Id userId = UserInfo.getUserId();
        Id profileId = UserInfo.getProfileId();

        list<Id>actorIds = Data_Access_ProcessInstanceWorkitem.getActorIdsByWorkItemIds(newWorkItemIds);
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;

        
        list<Id>queueUserIds =Data_Access_GroupMember.getUserGroupsIdsByIds(actorIds);
        System.debug('Queueuserids:');
        system.debug(queueUserIds);
        
        Id networdId;
        if(queueUserIds.contains(userId)){
            system.debug('QUEUESIDSCONTAIN');
            networdId = newWorkItemIds[0];
            return networdId;
        }else if(actorIds.contains(userId) ){
            SYSTEM.debug('actorscontains');
            networdId = Data_Access_ProcessInstanceWorkitem.gWorkItemIdByActorId(newWorkItemIds, userId );
             return networdId;
        }else if(profileName =='System Administrator' || profileName =='Administrador del Sistema' || profileName=='Administrator'){
            networdId = newWorkItemIds[0];
            return networdId;
        }
        return networdId;
    }

}