public class Takedown_XLS_CI_Helper_cls {
    public static string getLegalEntity(String operating_Unit){
        string legalEntity;
        switch on operating_Unit{
            when 'UO_397 HOLDING'{
                legalEntity = 'Engencap Holding, S. de R.L. de C.V.';                
            }
            when 'UO_798 SOFOM'{
            	legalEntity = 'Engencap Holding, S. de R.L. de C.V.';    
            }
            when 'UO_XA7 ENGECAP'{
                legalEntity = 'Engencap, S. de R.L. de C.V.';
            }
            when else{
            	legalEntity = '';    
            }
        }
        return legalEntity;        
    }
    public static string getContractTemplate(String product){
        string ContractTemplate;
        switch on product{
            when 'OPERFIN-FIJA'{
                ContractTemplate = 'EC 397 OPERFIN FIJA';                
            }
            when 'AFINAN-FIJA'{
            	ContractTemplate = 'EC 397 AFINAN FIJA';    
            }
            when 'AFINAN-VAR'{
                ContractTemplate = 'EC 397 AFINAN VAR';
            }
            when 'PRESTAMO-FIJA'{
                ContractTemplate = 'EC 397 PRESTAMO FIJA';                
            }
            when 'PRESTAMO-VAR'{
            	ContractTemplate = 'EC 397 PRESTAMO VAR';    
            }
            when 'PROGRESIVO_FIJA'{
                ContractTemplate = 'EC 397 PPROGRESIVO FIJA';
            }
            when else{
            	ContractTemplate = '';    
            }
        }
        return ContractTemplate;        
    }
    
    public static string getFinanceProduct(String product){
        string ContractTemplate;
        switch on product{
            when 'OPERFIN-FIJA'{
                ContractTemplate = 'OPERFIN-FIJA_397';                
            }
            when 'AFINAN-FIJA'{
            	ContractTemplate = 'AFINAN-FIJA_397';    
            }
            when 'AFINAN-VAR'{
                ContractTemplate = 'AFINAN-VAR_397';
            }
            when 'PRESTAMO-FIJA'{
                ContractTemplate = 'PRESTAMO-FIJA_397';                
            }
            when 'PRESTAMO-VAR'{
            	ContractTemplate = 'PRESTAMO-VAR_397';    
            }
            when 'PROGRESIVO_FIJA'{
                ContractTemplate = 'PPROGRESIVO-FIJA_397';
            }
            when else{
            	ContractTemplate = '';    
            }
        }
        return ContractTemplate;        
    }
    public static string removeDoubleQuotationMarks(String data){        
        return String.isNotEmpty(data) ? data.remove('"') : '';
    }
    public static string dateToStringFormatDate(date fecha){
        return fecha != null ? String.valueof(DateTime.newInstance(fecha.year(),fecha.month(),fecha.day()).format('dd/MM/YYYY')) : '';        
    }
    public static string dateToStringFormatDate(datetime fecha){
        return fecha != null ? String.valueof(DateTime.newInstance(fecha.year(),fecha.month(),fecha.day()).format('dd/MM/YYYY')) : '';        
    }
    public static string stringToStringFormatDate(string fecha){        
		date parseDate = string.isNotEmpty(fecha) ? date.valueof(fecha) : null;
        return parseDate != null ? String.valueof(DateTime.newInstance(parseDate.year(),parseDate.month(),parseDate.day()).format('dd/MM/YYYY')) : '';        
    }

}