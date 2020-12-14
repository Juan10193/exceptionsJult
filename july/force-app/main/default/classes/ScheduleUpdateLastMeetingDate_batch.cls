global class ScheduleUpdateLastMeetingDate_batch implements Schedulable{
   global void execute(SchedulableContext sc){
   		UpdateLastMeetingDate_Batch batch = new UpdateLastMeetingDate_Batch();
   		Database.executeBatch(batch, 200);
   } 
}