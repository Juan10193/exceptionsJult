@IsTest
public class Takedown_XLS_CI_Helper_test {
	@istest
    static void getLegalEntity(){
        Takedown_XLS_CI_Helper_cls.getLegalEntity('UO_397 HOLDING');
        Takedown_XLS_CI_Helper_cls.getLegalEntity('UO_798 SOFOM');
        Takedown_XLS_CI_Helper_cls.getLegalEntity('UO_XA7 ENGECAP');
        Takedown_XLS_CI_Helper_cls.getLegalEntity('other');
    }
    @istest
    static void getContractTemplate(){
        Takedown_XLS_CI_Helper_cls.getContractTemplate('OPERFIN-FIJA');
        Takedown_XLS_CI_Helper_cls.getContractTemplate('AFINAN-FIJA');
        Takedown_XLS_CI_Helper_cls.getContractTemplate('AFINAN-VAR');
        Takedown_XLS_CI_Helper_cls.getContractTemplate('PRESTAMO-FIJA');
        Takedown_XLS_CI_Helper_cls.getContractTemplate('PRESTAMO-VAR');
        Takedown_XLS_CI_Helper_cls.getContractTemplate('PROGRESIVO_FIJA');        
        Takedown_XLS_CI_Helper_cls.getContractTemplate('other');
    }
    @istest
    static void getFinanceProduct(){
        Takedown_XLS_CI_Helper_cls.getFinanceProduct('OPERFIN-FIJA');
        Takedown_XLS_CI_Helper_cls.getFinanceProduct('AFINAN-FIJA');
        Takedown_XLS_CI_Helper_cls.getFinanceProduct('AFINAN-VAR');
        Takedown_XLS_CI_Helper_cls.getFinanceProduct('PRESTAMO-FIJA');
        Takedown_XLS_CI_Helper_cls.getFinanceProduct('PRESTAMO-VAR');
        Takedown_XLS_CI_Helper_cls.getFinanceProduct('PROGRESIVO_FIJA');        
        Takedown_XLS_CI_Helper_cls.getFinanceProduct('other');
    }
    @istest
    static void removeDoubleQuotationMarks(){
        Takedown_XLS_CI_Helper_cls.removeDoubleQuotationMarks('OPERFIN-"FIJA');
    }
    @istest
    static void dateToStringFormatDate(){
        Date myDate = date.newinstance(1960, 2, 17);
        Takedown_XLS_CI_Helper_cls.dateToStringFormatDate(myDate);
    }
    @istest
    static void dateToStringFormatDateTime(){
        Long longtime = 1341828183000L;
        DateTime dt = DateTime.newInstance(longtime);
        Takedown_XLS_CI_Helper_cls.dateToStringFormatDate(dt);
    }
    @istest
    static void stringToStringFormatDate(){
        Takedown_XLS_CI_Helper_cls.stringToStringFormatDate('2015-12-31');
    }
}