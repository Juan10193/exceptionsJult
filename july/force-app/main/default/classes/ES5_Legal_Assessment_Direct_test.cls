@isTest
private class ES5_Legal_Assessment_Direct_test {
    @isTest 
    static void runTestPF(){
        ES5_Legal_Assessment_Direct inst = new ES5_Legal_Assessment_Direct();
        inst.req.LAH.pOutEntidadtype = 'INDIVIDUAL';
        inst.Cancel();
        inst.pasnull('hola');
        inst.newLA();
    }
    
        @isTest 
    static void runTestPM(){
        ES5_Legal_Assessment_Direct inst = new ES5_Legal_Assessment_Direct();
        inst.req.LAH.pOutEntidadtype = 'ORGANIZATION';
        inst.req.LAH.pOutnacionalidad = 'MEX';
        inst.Cancel();
        inst.pasnull('hola');
        inst.newLA();
    }
     @isTest 
    static void runTestPME(){
        ES5_Legal_Assessment_Direct inst = new ES5_Legal_Assessment_Direct();
        inst.req.LAH.pOutEntidadtype = 'ORGANIZATION';
        inst.req.LAH.pOutnacionalidad = 'ESP';
        inst.Cancel();
        inst.pasnull('hola');
        inst.newLA();
    }
    
}