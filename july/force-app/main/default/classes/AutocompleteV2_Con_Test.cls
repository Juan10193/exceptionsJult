/*
Copyright (c) 2013 avidev9@gmail.com
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, 
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
@isTest
private class AutocompleteV2_Con_Test{
    static testMethod void test_AutocompleteV2_Con(){
        List< TBO002_SIC_code__c> sicList = new List<TBO002_SIC_code__c>();
         for(Integer i =0 ; i < 90 ; i++){
            sicList.add(new TBO002_SIC_code__c(Name='T'+i));
        }
        insert sicList;
        
        
        Test.startTest();
            //System.assertEquals(accountList.size(),AutoCompleteV2_Con.getData('Account','Name','Id','T').size());
            System.assertEquals(sicList.size(),AutoCompleteV2_Con.getData('TBO002_SIC_code__c','Name','Id','T').size());
        
            //System.assertEquals(1, AutoCompleteV2_Con.getData('Account','Name','Id','Test111').size());
            System.assertEquals(1, AutoCompleteV2_Con.getData('TBO002_SIC_code__c','Name','Id','T11').size());
        
            //System.assertEquals(0, AutoCompleteV2_Con.getData('Account','Name','Id','xxxxxxx').size());
            System.assertEquals(0, AutoCompleteV2_Con.getData('Account','Name','Id','xxxxxxx').size());
            //AutoCompleteV2_Con controller = new AutoCompleteV2_Con ();
            AutoCompleteV2_Con controller = new AutoCompleteV2_Con ();
            //controller.setTargetFieldVar(accountList[0].Id);
            controller.setTargetFieldVar(sicList[0].Id);
            System.assertEquals(sicList[0].Id,controller.getTargetFieldVar());
            controller.setCacheField(null);
        Test.stopTest();
        
    }
}