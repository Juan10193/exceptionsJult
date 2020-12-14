@RestResource (urlMapping='/exceptionToGoTablero/*')
global class TakedownExceptionTablero {

    @HttpGet
    global static void getExceptionTablero() {
		RestResponse restRes = RestContext.response;
		restRes.addHeader('Content-Type', 'application/json;charset=UTF-8');
		restRes.responseBody = Blob.valueOf(JSON.serialize(WrapperExceptionTablero.getDashboard(), true));
    }
}