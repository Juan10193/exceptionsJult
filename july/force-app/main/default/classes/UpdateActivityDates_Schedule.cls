global class UpdateActivityDates_Schedule implements Schedulable{
   global void execute(SchedulableContext sc){
   		UpdateLastMeetingDate_Batch lastMeetingDateBatch = new UpdateLastMeetingDate_Batch();
   		Database.executeBatch(lastMeetingDateBatch, 200);
       
   		UpdateLastCallDate_Batch lastCallDateBatch = new UpdateLastCallDate_Batch();
   		Database.executeBatch(lastCallDateBatch, 200);
   } 
}