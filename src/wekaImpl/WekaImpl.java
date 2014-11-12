package wekaImpl;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import model.Dataset;
import model.Feature;
import model.FeatureExtractor;
import model.Walk;
import weka.core.Attribute;
import weka.core.FastVector;
import weka.core.Instances;

/**
 * http://weka.wikispaces.com/Programmatic+Use
 *
 * @author bram
 */
public class WekaImpl {
	private final Dataset dataset;
	private Map<String, Attribute> attributes;

	private FastVector wekaAttributes;
	private Instances trainingSet;

	public WekaImpl(Dataset dataset) {
		this.dataset = dataset;
	}

	public void run() {
		makeHeader();
//		makeInstances();

	}

	public void makeHeader() {
		this.attributes = new HashMap<>();

		Map<String, Feature.Type> extractedFeatures = FeatureExtractor.getFeatures();

		this.wekaAttributes = new FastVector(extractedFeatures.size());

		for (String name : extractedFeatures.keySet()) {
			Attribute attribute = null;

			if (extractedFeatures.get(name) == Feature.Type.NOMINAL) {
				Set<String> values = new HashSet<>();
				FastVector wekaValues = new FastVector();

				for (int i = 0; i < dataset.numWalks(); i++) {
					Walk w = dataset.getWalk(i);
					Object value = dataset.getFeatures(w).get(name).value;
					if (!values.contains(value.toString())) {
						values.add(name.toString());
						wekaValues.addElement(dataset.getFeatures(w).get(name).value);
					}
				}

				attribute = new Attribute(name, wekaValues);
			} else {
				attribute = new Attribute(name);
			}

			wekaAttributes.addElement(attribute);
			attributes.put(name, attribute);
		}
	}

}
