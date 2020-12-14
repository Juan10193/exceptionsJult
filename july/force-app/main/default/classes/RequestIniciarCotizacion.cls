/**
 * @File Name          : RequestIniciarCotizacion.cls
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 19/2/2020 22:53:18
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    19/2/2020   angel87ambher@gmail.com     Initial Version
**/
public with sharing class RequestIniciarCotizacion {
    
    String ssoid {get;set;}
    String key {get;set;}

    public static User getUser(id recordId){

        if (Schema.sObjectType.User.isAccessible()){
             User usuario = [SELECT Id, EmployeeNumber FROM User where id = :recordId];

            return usuario;
        } else {
            
            System.debug(LoggingLevel.ERROR,'You dont have permission');
            return null;
        }
    }


    public RequestIniciarCotizacion(String key, String ssoid){

        this.key = key;
        this.ssoid = ssoid; /* getUser(recordId).EmployeeNumber;*/
    }
}