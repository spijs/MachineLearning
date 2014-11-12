
package model;

/**
 *
 * @author bram
 */
public class Feature {
	
	public Feature(Object value) {
		this.value=value;
	}

	public enum Type {

		BOOLEAN,
		DOUBLE,
		NOMINAL
	};

	public Object value;
	public Feature.Type type;
}
