global class FileShareExternal_cls {

    public static string orgtype {
        get {
            if (orgtype == null) {
               orgtype = String.valueOf(System.Url.getOrgDomainUrl()).replace('Url:[delegate=','').replace(']','');
            }
            return orgtype ;
        }
        set;
    }
    
    public static String sharingType {
        get {
            if (sharingType == null) {
                sharingType = '{'+
		'   					\"sharingType\" : \"V\"'+
							  '}';
            }
            return sharingType ;
        }
        set;
    }
}