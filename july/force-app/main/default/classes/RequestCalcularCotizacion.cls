/**
 * @File Name          : RequestCalcularCotizacion.cls
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 19/2/2020 22:57:38
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    19/2/2020   angel87ambher@gmail.com     Initial Version
**/
public with sharing class RequestCalcularCotizacion {

    String userId {get;set;}
    String programId {get;set;}
    String json {get;set;}
    
    public RequestCalcularCotizacion(String userId, String programId, String json) {

        this.userId = userId;
        this.programId = programId;
        this.json = json;

    }
}