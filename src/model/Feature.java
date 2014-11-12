
package model;

/**
 *
 * @author bram
 */
public class Feature {
	public enum Type {

		BOOLEAN,
		DOUBLE,
		DOUBLE_LIST,
		STRING
	};

	public String name;
	public Object value;

	public Feature.Type type;
}
