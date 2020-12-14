public class Data_Access_OpportunityContactRole {
    public static List<OpportunityContactRole> getOpportunityContactRoleByOppID(set<id> setOpportunities){
        List<OpportunityContactRole> listOpportunityContactRole = new List<OpportunityContactRole>();
        if(Schema.sObjectType.OpportunityContactRole.isAccessible()){
            listOpportunityContactRole = [SELECT OpportunityId, Role 
                                          FROM OpportunityContactRole 
                                          WHERE OpportunityId in: setOpportunities AND ISPRIMARY = true];
        }else{
            system.debug('Error: User is unauthorized to access the Asset object');
        }
        return listOpportunityContactRole;
    }

}