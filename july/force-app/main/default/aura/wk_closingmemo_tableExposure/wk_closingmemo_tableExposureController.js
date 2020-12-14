({
    init: function (cmp, event, helper) {
        		var nameCA  = cmp.get("v.nameCA");
        		var  EGId = cmp.get("v.EGId");
        		helper.isRecordTypeWK(cmp, event, helper,nameCA);
                helper.getData(cmp, event, helper,EGId);       	               
            }
})