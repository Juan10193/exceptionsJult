trigger ACC_tgr_TopParent_AccountStatus on Account (after insert, after update) {    
    Map<Id, Account> customerStatusAccountMap;
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        if (Trigger.isAfter) {
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(Trigger.new);
            customerStatusAccountMap = customerStatus.setTopParentAccountListStatus();
            
            if (customerStatusAccountMap == null) {
                customerStatusAccountMap = new Map<Id, Account>();
            }
            
            customerStatusAccountMap.putAll(customerStatus.setParentChildAccountListStatus());
        }
    }    
    
    if (customerStatusAccountMap != null) {
        if (customerStatusAccountMap.size() > 0) {
            update customerStatusAccountMap.values();
        }
    }
}