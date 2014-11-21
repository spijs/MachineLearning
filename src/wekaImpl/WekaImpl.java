package wekaImpl;

import extractor.FeatureExtractor;
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

		FastVector wekaNames = new FastVector(names.size());
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
}
