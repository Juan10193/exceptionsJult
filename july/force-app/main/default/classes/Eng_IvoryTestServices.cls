@IsTest
public with sharing class Eng_IvoryTestServices {
    
    static Integer fakeIdNumber = 0;
    static Integer[] charset {
        get{
            if (charset == null){
                charset = new Integer[0];
                for (Integer i = 48; i < 58; i++) charset.add(i);// 0-9
                for (Integer i = 65; i < 91; i++) charset.add(i);// A-Z
                for (Integer i = 97; i < 123; i++) charset.add(i);// a-z
            }
            return charset;
        }
        private set;
    }
    
    public static Id getFakeId(DescribeSObjectResult describeObj){
        String result = String.valueOf(fakeIdNumber++);
        String fakeId = describeObj.getKeyPrefix() + '0'.repeat(12 - result.length()) + result;
        return Id.valueOf(fakeId);
    }
}