package wekaImpl;

import extractor.FeatureExtractor;
import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Dataset;
import model.Feature;
import model.Walk;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.trees.J48;
import weka.core.Attribute;
import weka.core.FastVector;
import weka.core.Instance;
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
	private Instances wekaTrainingSet;
	private Classifier classifier;
	private FastVector wekaNames;

	public WekaImpl(Dataset dataset) {
		this.dataset = dataset;
	}

	public void run() {
		this.run(new J48());
	}

	public void run(Classifier classifier) {
		makeHeader();
		makeInstances();
		prepareClassifier(classifier);
	}

	public void makeHeader() {
		this.attributes = new HashMap<>();

		Map<String, Feature.Type> extractedFeatures = FeatureExtractor.getFeatures();

		this.wekaAttributes = new FastVector(extractedFeatures.size() + 1);

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

		// add the name attribute
		Set<String> names = new HashSet<>();
		for (int i = 0; i < dataset.numWalks(); i++)
			names.add(dataset.getWalk(i).getName());

		wekaNames = new FastVector(names.size());
		for (String name : names)
			wekaNames.addElement(name);
		wekaAttributes.addElement(new Attribute("walker", wekaNames));
	}

	public void makeInstances() {
		wekaTrainingSet = new Instances("TrainingSet", wekaAttributes, dataset.numWalks());
		Map<String, Feature.Type> extractedFeatures = FeatureExtractor.getFeatures();

		for (int i = 0; i < dataset.numWalks(); i++) {
			Walk walk = dataset.getWalk(i);
			Map<String, Feature> features = dataset.getFeatures(walk);

			Instance instance = new Instance(extractedFeatures.size() + 1);

			for (int j = 0; j < wekaAttributes.size() - 1; j++) {
				Attribute attribute = (Attribute) wekaAttributes.elementAt(j);
				String name = attribute.name();
				if (features.get(name).type == Feature.Type.DOUBLE) {
					instance.setValue(attribute, (double) features.get(attribute.name()).value);
				} else {
					instance.setValue(attribute, (String) features.get(attribute.name()).value);
				}
			}

			instance.setValue((Attribute) wekaAttributes.elementAt(wekaAttributes.size() - 1), (String) walk.getName());

			wekaTrainingSet.add(instance);
		}
	}

	public void prepareClassifier(Classifier classifier) {
		this.classifier = classifier;
		try {
			wekaTrainingSet.setClassIndex(wekaTrainingSet.numAttributes() - 1);
			classifier.buildClassifier(wekaTrainingSet);

			// everything following this should be moved to "useClassifier"
			Evaluation evaluation = new Evaluation(wekaTrainingSet);
			evaluation.evaluateModel(classifier, wekaTrainingSet);

			// Print the result à la Weka explorer:
			String strSummary = evaluation.toSummaryString();
			System.out.println(strSummary);

			// Get the confusion matrix
			System.out.println(evaluation.toMatrixString());
		} catch (Exception ex) {
			Logger.getLogger(WekaImpl.class.getName()).log(Level.SEVERE, null, ex);
		}
	}

	// map walk -> name
	public Map<Walk, String> classify(Dataset dataset) {
		Map<Walk, String> returnMap = new HashMap<>();
		Map<String, Feature.Type> extractedFeatures = FeatureExtractor.getFeatures();

		for (int i = 0; i < dataset.numWalks(); i++) {
			Walk walk = dataset.getWalk(i);
			Map<String, Feature> features = dataset.getFeatures(walk);

			// make the instance
			Instance instance = new Instance(extractedFeatures.size());

			for (int j = 0; j < wekaAttributes.size() - 1; j++) {
				Attribute attribute = (Attribute) wekaAttributes.elementAt(j);
				String name = attribute.name();
				if (features.get(name).type == Feature.Type.DOUBLE) {
					instance.setValue(attribute, (double) features.get(attribute.name()).value);
				} else {
					instance.setValue(attribute, (String) features.get(attribute.name()).value);
				}
			}
			instance.setDataset(wekaTrainingSet);

			try { // classify the instance
				double[] distribution = classifier.distributionForInstance(instance);

				// get the best match
				int maxj = 0;
				for (int j = maxj + 1; j < distribution.length; j++) {
					if (distribution[j] > distribution[maxj]) {
						maxj = j;
					}
				}

				// add the best match to the returnmap
				String bestName = (String) wekaNames.elementAt(maxj);
				returnMap.put(walk, bestName);
				// System.out.println(bestName + " " + distribution[maxj]);

			} catch (Exception ex) {
				Logger.getLogger(WekaImpl.class.getName()).log(Level.SEVERE, null, ex);
			}
		}

		return returnMap;
	}
}
