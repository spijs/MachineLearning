package filterGui;

import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import model.Dataset;
import model.Feature;
import model.Walk;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.trees.J48;
import weka.core.Attribute;
import weka.core.FastVector;
import weka.core.Instance;
import weka.core.Instances;
import wekaImpl.WekaImpl;

/**
 *
 * @author bram
 */
public class FilterGui {

	private final static String ACCEPTED = "accepted";
	private final static String REJECTED = "rejected";
	private static final String FILTER = "filter";
	private Instances trainingSet;
	private Classifier classifier;

	private final Dataset dataset;
	private final JFrame frame;
	private boolean exit = false;

	public FilterGui(Dataset dataset) {
		this.dataset = dataset;
		frame = new JFrame();

		frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				exit = true;
				synchronized (FilterGui.this) {
					FilterGui.this.notify();
				}
			}
		});
	}

	public synchronized Dataset run() {
		int removedManually = 0;
		int removedByClassifying = 0;
		try {
			int i;
			for (i = 0; i < dataset.numWalks(); i++) { //TODO 10 -> dataset.numWalks()
				Walk walk = dataset.getWalk(i);
				EvaluationPanel ep = new EvaluationPanel(dataset, walk, this);
				frame.getContentPane().removeAll();
				frame.getContentPane().add(ep);
				frame.setTitle("Evaluating walk " + (i + 1) + " of " + dataset.numWalks());

				frame.setSize(800, 600);
				frame.setVisible(true);
				wait();

				if (exit) {
					break;
				}

				if (ep.accepted()) {
					dataset.setFeature(walk, FILTER, new Feature(ACCEPTED, Feature.Type.NOMINAL));
				} else {
					removedManually++;
					dataset.setFeature(walk, FILTER, new Feature(REJECTED, Feature.Type.NOMINAL));
				}
			}

			frame.setVisible(false);

			FastVector attributes = makeAttributeVector();

			FastVector classes = new FastVector(2);
			classes.addElement(ACCEPTED);
			classes.addElement(REJECTED);
			attributes.addElement(new Attribute(FILTER, classes));

			trainingSet = new Instances("FilterRelationship", attributes, dataset.numWalks());
			trainingSet.setClassIndex(attributes.size() - 1);

			for (int j = 0; j < i; j++) {
				trainingSet.add(makeInstanceForWalk(attributes, dataset, dataset.getWalk(j)));
			}

			classifier = (Classifier) new J48();
			classifier.buildClassifier(trainingSet);
			writeClassifier();

			for (int j = dataset.numWalks() - 1; j >= i; j--) {
				Instance instance = makeInstanceForWalk(attributes, dataset, dataset.getWalk(j));
				instance.setDataset(trainingSet);
				double[] distribution = classifier.distributionForInstance(instance);
				if (distribution[classes.indexOf(REJECTED)] > 0.5) {
					dataset.removeWalk(j);
					removedByClassifying++;
				}
			}

			// remove the manually filtered walks
			for (int j = i - 1; j >= 0; j--) {
				if (REJECTED.equals(dataset.getFeatures(j).get(FILTER).value)) {
					dataset.removeWalk(j);
				}
			}

			dataset.removeFeature(FILTER);

			System.out.println("Usage of FilterGUI:");
			System.out.println("Removed manually       : " + removedManually + " / " + i);
			System.out.println("Removed by classifying : " + removedByClassifying + " / " + (dataset.numWalks() - i));
			System.out.println("Total removed          : " + (removedByClassifying + removedManually) + " / " + dataset.numWalks());
		} catch (Exception ex) {
			Logger.getLogger(FilterGui.class.getName()).log(Level.SEVERE, null, ex);
		}

		return dataset;
	}

	private FastVector makeAttributeVector() {
		FastVector attributes = new FastVector();
		for (String name : dataset.getFeatures(0).keySet()) {
			if (FILTER.equals(name))
				continue;

			Feature feature = dataset.getFeatures(0).get(name);
			Attribute attribute = null;

			if (feature.type == Feature.Type.NOMINAL) {
				FastVector values = WekaImpl.getNominalValues(dataset, name);
				attribute = new Attribute(name, values);
			} else {
				attribute = new Attribute(name);
			}

			attributes.addElement(attribute);
		}
		return attributes;
	}

	private Instance makeInstanceForWalk(FastVector attributes, Dataset dataset, Walk walk) {
		Instance instance = new Instance(attributes.size());
		for (int i = 0; i < attributes.size(); i++) {
			Attribute attribute = (Attribute) attributes.elementAt(i);
			Feature feature = dataset.getFeatures(walk).get(attribute.name());

			instance.setDataset(trainingSet);
			if (feature == null)
				continue;

			if (feature.type == Feature.Type.NOMINAL) {
				instance.setValue(i, (String) feature.value);
			} else {
				instance.setValue(i, (double) feature.value);
			}
		}
		return instance;
	}

	public void useLastClassifier(Dataset dataset) {
		if (classifier == null) {
			classifier = readClassifier();
			if (classifier == null) {
				return;
			}
		}

		int previousNumWalks = dataset.numWalks();

		FastVector attributes = makeAttributeVector();

		FastVector classes = new FastVector(2);
		classes.addElement(ACCEPTED);
		classes.addElement(REJECTED);

		try {
			for (int j = dataset.numWalks() - 1; j >= 0; j--) {
				Instance instance = makeInstanceForWalk(attributes, dataset, dataset.getWalk(j));
				double[] distribution = classifier.distributionForInstance(instance);

				if (distribution[classes.indexOf(REJECTED)] > 0.5) {
					dataset.removeWalk(j);
				}
			}
			System.out.println("Removed from testset   : " + (previousNumWalks - dataset.numWalks()) + " / " + previousNumWalks);
		} catch (Exception ex) {
			Logger.getLogger(FilterGui.class.getName()).log(Level.SEVERE, null, ex);
		}

	}

	private void writeClassifier() {
		try {
			weka.core.SerializationHelper.write("manualfilter.model", classifier);
		} catch (Exception ex) {
			Logger.getLogger(FilterGui.class.getName()).log(Level.SEVERE, null, ex);
		}
	}

	private Classifier readClassifier() {
		try {
			return (Classifier) weka.core.SerializationHelper.read("manualfilter.model");
		} catch (Exception ex) {
			Logger.getLogger(FilterGui.class.getName()).log(Level.SEVERE, null, ex);
		}
		return null;
	}
}
