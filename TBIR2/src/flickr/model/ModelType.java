package flickr.model;

/**
 * @author Thijs D.
 * 
 * enum representing all types of models.
 */
public enum ModelType {
	P_TOTAL
	{
		@Override
		public String toString() {
			return "P_TOTAL";
		}
	},

	P_AGG
	{
		@Override
		public String toString() {
			return "P_AGG";
		}
	},

	P_MAX{
		@Override
		public String toString() {
			return "P_MAX";
		}
	},
	E_TOTAL
	{
		@Override
		public String toString() {
			return "E_TOTAL";
		}
	},

	E_AGG
	{
		@Override
		public String toString() {
			return "E_AGG";
		}
	},

	E_MAX{
		@Override
		public String toString() {
			return "E_MAX";
		}
	};

	public abstract String toString();
	
	/**
	 * Returns the modeltype according to the given string.
	 */
	public static ModelType fromString(String s) {
		ModelType result;
		switch (s) {
		case "P_TOTAL":
			result = ModelType.P_TOTAL;
			break;
		case "P_AGG":
			result = ModelType.P_AGG;
			break;
		case "P_MAX":
			result = ModelType.P_MAX;
			break;
		case "E_TOTAL":
			result = ModelType.E_TOTAL;
			break;
		case "E_AGG":
			result = ModelType.E_AGG;
			break;
		case "E_MAX":
			result = ModelType.E_MAX;
			break;
		default:
			throw new IllegalArgumentException("Unknown modeltype \""+s+"\"");
		}
		return result;
	}

}

