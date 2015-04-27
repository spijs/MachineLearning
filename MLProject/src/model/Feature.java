
package model;

/**
 *
 * @author bram
 */
public class Feature {
	
	public Feature(Object value, Feature.Type type) {
		this.value = value;
		this.type = type;
	}

	public enum Type {

		DOUBLE,
		NOMINAL
	};

	public final Object value;
	public final Feature.Type type;
}
