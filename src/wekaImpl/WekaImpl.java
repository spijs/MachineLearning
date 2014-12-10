package wekaImpl;

import extractor.FeatureExtractor;
import java.awt.BorderLayout;
import java.awt.HeadlessException;
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
import weka.gui.treevisualizer.PlaceNode2;
import weka.gui.treevisualizer.TreeVisualizer;

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

	public void run(Classifier classifier, boolean printDetails, boolean printConfusionMatrix) {
		makeHeader();
		makeInstances();
		prepareClassifier(classifier, printDetails, printConfusionMatrix);
	}

	public void makeHeader() {
		this.attributes = new HashMap<>();

		Map<String, Feature> extractedFeatures = dataset.getFeatures(0);

		this.wekaAttributes = new FastVector(extractedFeatures.size() + 1);

		for (String name : extractedFeatures.keySet()) {
			Attribute attribute = null;

			if (extractedFeatures.get(name).type == Feature.Type.NOMINAL) {
				FastVector wekaValues = getNominalValues(dataset, name);
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

	public static FastVector getNominalValues(Dataset dataset, String name) {
		Set<String> values = new HashSet<>();
		FastVector wekaValues = new FastVector();
		for (int i = 0; i < dataset.numWalks(); i++) {
			Walk w = dataset.getWalk(i);
			if (dataset.getFeatures(w).get(name) == null)
				System.out.print("");
			Object value = dataset.getFeatures(w).get(name).value;
			if (!values.contains(value.toString())) {
				values.add(value.toString());
				wekaValues.addElement(value.toString());
			}
		}
		return wekaValues;
	}

	public void makeInstances() {
		wekaTrainingSet = new Instances("TrainingSet", wekaAttributes, dataset.numWalks());

		for (int i = 0; i < dataset.numWalks(); i++) {
			Walk walk = dataset.getWalk(i);
			Map<String, Feature> features = dataset.getFeatures(walk);

			Instance instance = new Instance(features.size() + 1);

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

	public void prepareClassifier(Classifier classifier, boolean printSummary, boolean printConfusionMatrix) {
		this.classifier = classifier;
		try {
			wekaTrainingSet.setClassIndex(wekaTrainingSet.numAttributes() - 1);
			classifier.buildClassifier(wekaTrainingSet);

			// everything following this should be moved to "useClassifier"
			Evaluation evaluation = new Evaluation(wekaTrainingSet);
			evaluation.evaluateModel(classifier, wekaTrainingSet);

			if (printSummary)
				System.out.println(evaluation.toSummaryString());

			if (printConfusionMatrix)
				System.out.println(evaluation.toMatrixString());

			if (classifier instanceof J48) {
				visualizeTree(classifier);
			}
		} catch (Exception ex) {
			Logger.getLogger(WekaImpl.class.getName()).log(Level.SEVERE, null, ex);
		}
	}

	private void visualizeTree(Classifier classifier1) throws Exception, HeadlessException {
		final javax.swing.JFrame jf
				= new javax.swing.JFrame("Weka Classifier Tree Visualizer: J48");
		jf.setSize(1000, 700);
		jf.getContentPane().setLayout(new BorderLayout());
		TreeVisualizer tv = new TreeVisualizer(null, ((J48) classifier1).graph(), new PlaceNode2());
		jf.getContentPane().add(tv, BorderLayout.CENTER);
		jf.addWindowListener(new java.awt.event.WindowAdapter() {
			public void windowClosing(java.awt.event.WindowEvent e) {
				jf.dispose();
			}
		});
		jf.setVisible(true);
//		tv.fitToScreen();
	}

	// map walk -> name
	public Map<Walk, ClassificationResult> classify(Dataset dataset) {
		Map<Walk, ClassificationResult> returnMap = new HashMap<>();

		for (int i = 0; i < dataset.numWalks(); i++) {
			Walk walk = dataset.getWalk(i);
			Map<String, Feature> features = dataset.getFeatures(walk);

			// make the instance
			Instance instance = new Instance(features.size());

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
				ClassificationResult classificationResult = new ClassificationResult(walk, wekaNames, distribution);
				returnMap.put(walk, classificationResult);

			} catch (Exception ex) {
				Logger.getLogger(WekaImpl.class.getName()).log(Level.SEVERE, null, ex);
			}
		}

		return returnMap;
	}
}
