public class JsonQuote {

	public List<Data> data;

	public class Quote_Z {
		public String razonSocialConsulta;
		public JsonQuote quote;
	}

	public class Data {
		public Integer periodo;
		public String moneda;
		public Integer clavePromotor;
		public String conservarCotizacion;
		public Coberturas coberturas;
	}

	public class Bien {
		public String claveBienRiesgo;
		public Integer sumaAsegurada;
	}

	public class Coberturas {
		public List<Bien> bien;
	}
}