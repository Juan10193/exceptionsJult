public class PPF_userClass {
     public void actualizarOps(){
        PPF_scheludableClass s = new PPF_scheludableClass();
        String sch = '0 0 4 * * ?';
        String jobID = system.schedule('fee', sch, s);
        system.debug('job' + jobID);
    }
}