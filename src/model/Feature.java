
package model;

/**
 *
 * @author bram
 */
public class Feature {
	
	public Feature(String name, Object value) {
		this.value=value;
	}

	public enum Type {

		BOOLEAN,
		DOUBLE,
		DOUBLE_LIST,
		STRING
	};

	public Object value;
	public Feature.Type type;
}
