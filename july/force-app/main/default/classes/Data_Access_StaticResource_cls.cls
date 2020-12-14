/**
 * @File Name          : Data_Access_StaticResource_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 28/1/2020 12:18:17
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    28/1/2020   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class Data_Access_StaticResource_cls {
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/1/2020 
    * @param name 
    * @return StaticResource 
    **/
    public static StaticResource getStaticResource(String name) {
        
        StaticResource static_resource = [SELECT Id, SystemModStamp, Name
                                  FROM StaticResource 
                                  WHERE Name = :name
                                  LIMIT 1];

        return static_resource;
    }
}