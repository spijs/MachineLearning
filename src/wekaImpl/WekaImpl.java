package wekaImpl;

import java.util.HashMap;
import java.util.Map;
import model.Dataset;
import model.Walk;
import weka.core.Attribute;

/**
 *
 * @author bram
 */
public class WekaImpl {
	private final Dataset dataset;
	Map<String, Attribute> attributes;

	public WekaImpl(Dataset dataset) {
		this.dataset = dataset;
	}

	public void train() {
		this.attributes = new HashMap<>();
		for (int i = 0; i < dataset.numWalks(); i++) {
			Walk walk = dataset.getWalk(i);
			dataset.getFeatures(walk);
		}
	}
}
