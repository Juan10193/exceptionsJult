public  class Data_Access_GroupMember {
    
    public static list<Id> getUserGroupsIdsByIds(list<Id>groupIds){
        
        list<Id>usersGroupsIds = new list<Id>();

        for(GroupMember gpm:[Select Group.Name, UserOrGroupId from GroupMember WHERE GroupId IN:groupIds]){
            usersGroupsIds.add(gpm.UserOrGroupId);
        }

        return usersGroupsIds;
    }
}