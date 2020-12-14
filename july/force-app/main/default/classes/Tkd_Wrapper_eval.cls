/*
	EVAL data parsing class
*/
public class Tkd_Wrapper_eval {
    public Request request;
	public Detail detail; 

    public class Header {
		public String requestId;
		public String requestType;
		public String applicationCode;
		public String partyId;
		public String requestStatus;
		public String requestedBy;
		public String startDate;
		public String endDate;
		public String rootRequestId;
		public String assignedTo;
		public String ndaType;
		public String sourceAccountId;
		public String sourceAccountName;
		public String sourceTopParentId;
		public String sourceTopParentName;
		public String partyName;
		public String egPartyId;
		public String egPartyName;
		public String sourceOpId;
		public String sourceCAId;
		public String createdBy;
		public String assignedGroup;
		public String assignedDate;
		public String activeFlag;
		public String creationDate;
		public String updatedBy;
		public String lastUpdateDate;
		public String solvedBy;
		public String solvedDate;
		public String finantialEntity;
	}

    public class Request {
		public Header header;
	}

    public class EvalHeader {
		public String evEvalType;
		public String evInsuranceReqFlag;
		public String evEfaReqFlag;
		public String evSlbFlag;
		public String evImportsReqFlag;
		public String evProgressPayFlag;
		public String evShowFMVFlag;
		public String evFreezeEvalFlag;
		public String evFreezeStartDate;
		public String evFreezeEndDate;
		public String evProgressPayTermMonths;
		public String evEquipmentAmount;
		public String evEquipmentAmountTax;
		public String evEquipmentAmountPercent;
		public String evCostAmount;
		public String evCostAmountTax;
		public String evCostAmountPercent;
		public String evCurrencyType;
		public String evExchangeRate;
		public String evAssetCount;
		public String evProductType;
		public String evResidualMaxTermMonths;
		public String evSpecialTermMonths01;
		public String evSpecialTermMonths02;
		public String evSpecialTermMonths03;
		public String evEndorsementComment;
	}

    public class Eval {
		public EvalHeader evalHeader;
	}

	public class Detail {
		public Eval eval;
		public SicCode sicCode;
		public AmlHit amlHit;
		public String laActiveFlag;
		public String laCreatedBy;
		public String laCreationDate;
		public String laLastUpdatedBy;
		public String laLastUpdateDate;
	}

	public class SicCode {
		public String sicProposedId;
		public String sicProposedDescription;
		public String sicId;
		public String sicDescription;
	}

	public class AmlHit {
		public String hitRFC;
		public String hitEntityName;
		public String hitFlag;
		public String hitUwStatus;
		public String hitUwComments;
		public String hitAMLStatus;
		public String hitAMLComments;
		public String hitAMLMaxPercent;
	}
    /*public static Tkd_Wrapper_eval parse() {
        return (Tkd_Wrapper_eval) System.JSON.deserialize(json, Tkd_Wrapper_eval.class);
    }*/
}