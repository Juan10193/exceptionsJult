@isTest
public class MetadataUrls_Test {
    @isTest
    public static void qagetUrlDocs(){
        MetadataUrls.getUrlDocs();
        MetadataUrls.getUrlDocsDetail();
    }
    
    @isTest
    public static void qagetUrlDocs2(){
        MetadataUrls.sandbox ='QA';
        MetadataUrls.getUrlDocs();
        MetadataUrls.getUrlDocsDetail();
    }
    
     @isTest
    public static void qagetUrlDocs3(){
        MetadataUrls.sandbox ='PROD';
        MetadataUrls.getUrlDocs();
        MetadataUrls.getUrlDocsDetail();
    }
}