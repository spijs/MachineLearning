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

	// map walk -> name

	public Map<Walk, String> classify(Dataset dataset) {
		Map returnMap = new HashMap();
		return returnMap;
	}
}


/*
Step 1: Express the problem with features
This step corresponds to the engineering task needed to write an .arff file.
Let’s put all our features in a weka.core.FastVector.
Each feature is contained in a weka.core.Attribute object.

Here, we have two numeric features, one nominal feature (blue, gray, black) and a nominal class (positive, negative).
 // Declare two numeric attributes
 Attribute Attribute1 = new Attribute(“firstNumeric”);
 Attribute Attribute2 = new Attribute(“secondNumeric”);

 // Declare a nominal attribute along with its values
 FastVector fvNominalVal = new FastVector(3);
 fvNominalVal.addElement(“blue”);
 fvNominalVal.addElement(“gray”);
 fvNominalVal.addElement(“black”);
 Attribute Attribute3 = new Attribute(“aNominal”, fvNominalVal);

 // Declare the class attribute along with its values
 FastVector fvClassVal = new FastVector(2);
 fvClassVal.addElement(“positive”);
 fvClassVal.addElement(“negative”);
 Attribute ClassAttribute = new Attribute(“theClass”, fvClassVal);

 // Declare the feature vector
 FastVector fvWekaAttributes = new FastVector(4);
 fvWekaAttributes.addElement(Attribute1);
 fvWekaAttributes.addElement(Attribute2);
 fvWekaAttributes.addElement(Attribute3);
 fvWekaAttributes.addElement(ClassAttribute);

 Step 2: Train a Classifier
Training requires 1) having a training set of instances and 2) choosing a classifier.

Let’s first create an empty training set (weka.core.Instances).
We named the relation “Rel”.
The attribute prototype is declared using the vector from step 1.
We give an initial set capacity of 10.
We also declare that the class attribute is the fourth one in the vector (see step 1)
 // Create an empty training set
 Instances isTrainingSet = new Instances("Rel", fvWekaAttributes, 10);
 // Set class index
 isTrainingSet.setClassIndex(3);

Now, let’s fill the training set with one instance (weka.core.Instance):
 // Create the instance
 Instance iExample = new Instance(4);
 iExample.setValue((Attribute)fvWekaAttributes.elementAt(0), 1.0);
 iExample.setValue((Attribute)fvWekaAttributes.elementAt(1), 0.5);
 iExample.setValue((Attribute)fvWekaAttributes.elementAt(2), "gray");
 iExample.setValue((Attribute)fvWekaAttributes.elementAt(3), "positive");

 // add the instance
 isTrainingSet.add(iExample);

Finally, Choose a classifier (weka.classifiers.Classifier) and create the model. Let’s, for example, create a naive Bayes classifier (weka.classifiers.bayes.NaiveBayes)
 // Create a naïve bayes classifier
 Classifier cModel = (Classifier)new NaiveBayes();
 cModel.buildClassifier(isTrainingSet);

 Step 3: Test the classifier
Now that we create and trained a classifier, let’s test it. To do so, we need an evaluation module (weka.classifiers.Evaluation) to which we feed a testing set (see section 2, since the testing set is built like the training set).
 // Test the model
 Evaluation eTest = new Evaluation(isTrainingSet);
 eTest.evaluateModel(cModel, isTestingSet);

The evaluation module can output a bunch of statistics:
 // Print the result à la Weka explorer:
 String strSummary = eTest.toSummaryString();
 System.out.println(strSummary);

 // Get the confusion matrix
 double[][] cmMatrix = eTest.confusionMatrix();

 Step 4: use the classifier
For real world applications, the actual use of the classifier is the ultimate goal. Here’s the simplest way to achieve that. Let’s say we’ve built an instance (named iUse) as explained in step 2:
 // Specify that the instance belong to the training set
 // in order to inherit from the set description
 iUse.setDataset(isTrainingSet);

 // Get the likelihood of each classes
 // fDistribution[0] is the probability of being “positive” 
 // fDistribution[1] is the probability of being “negative”
 double[] fDistribution = cModel.distributionForInstance(iUse);
*/
