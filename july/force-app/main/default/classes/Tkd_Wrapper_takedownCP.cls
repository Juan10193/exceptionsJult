public class Tkd_Wrapper_takedownCP {
   
    public class CreatedBy {
		public String Name;
		public String Id;
	}

	public String Name;
	public String SerialNumber;
	public Integer Quantity;
	public String Description;
	public String OwnerId;
	public Boolean TKD_ck_active_Tempc;
	public String TKD_tx_brand_Tempc;
	public String TKD_rb_Takedown_CP_Tempc;
	public String TKD_rb_collateral_Tempc;
	public String TKD_fm_collateral_description_Tempc;
	public String TKD_fm_collateral_type_Tempc;
	public String TKD_tx_asset_external_ID_Tempc;
	public String TKD_tx_Concept_ID_Tempc;
	public String TDK_tx_pediment_Tempc;
	public String TKD_tx_Model_Tempc;
	public String TKD_tx_model_year_Tempc;
	public Decimal TDK_dv_Unit_cost_Tempc;
	public Decimal TKD_dv_total_cost_Tempc;
	public String TKD_tx_openlegacy_created_by_Tempc;
	public Boolean TKD_ca_welcome_kit_sent_Tempc;
	public String TKD_tx_OpenLegacy_modified_by_Tempc;
	public String TKD_ls_asset_type_Tempc;
	public String TKD_rb_takedown_Invoice_Tempc;
	public String Id;
	public String CreatedDate;
	public String CreatedById;
	public String LastModifiedDate;
	public String LastModifiedById;
	public String CurrencyIsoCode;
    public String TKD_fm_collateral_id_oracle_Tempc;
	public TKD_rb_takedown_Invoice_Tempr TKD_rb_takedown_Invoice_Tempr;
	public CreatedBy CreatedBy;
	public CreatedBy LastModifiedBy;
	public TKD_rb_Takedown_CP_Tempr TKD_rb_Takedown_CP_Tempr;

	public class TKD_rb_takedown_Invoice_Tempr {
		public String TKD_txt_RFC_Tempc;
		public String Name;
		public String CreatedDate;
		public String Id;
	}

	public class TKD_rb_Takedown_CP_Tempr {
		public String TD_fm_Party_Id_Tempc;
		public String Eval_top_parentID_Tempc;
		public String Eval_top_parentname_Tempc;
		public String Id;
	}

    public static List<Tkd_Wrapper_takedownCP> parse(String json) {
		return (List<Tkd_Wrapper_takedownCP>) System.JSON.deserialize(json.replace('__c','_Tempc').replace('__r','_Tempr'), List<Tkd_Wrapper_takedownCP>.class);
	}
}