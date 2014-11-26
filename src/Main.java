import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import model.Dataset;
import model.Walk;
import parser.DataParser;
import weka.classifiers.Classifier;
import weka.classifiers.trees.J48;
import weka.core.Option;
import wekaImpl.ClassificationResult;
import wekaImpl.WekaImpl;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		Classifier classifier = null;
		String testPath = "test";
		String trainPath = "train";
		boolean listOptions = false;
		boolean printDetails = false;
		boolean printConfusionMatrix = false;


		// Argument loop
		for (int i = 0; i < args.length; i++) {
			if ("-h".equals(args[i].toLowerCase())
					|| "--help".equals(args[i].toLowerCase())) {
				System.out.println("This java program allows a user to classify unseen walking data using training data.\n"
						+ "Multiple classifiers can be used with their available options in Weka.\n"
						+ "\n"
						+ "usage: java -jar MLCode.jar [options] [classifier] [classifier options]\n"
						+ "\n"
						+ "Options:\n"
						+ "-h --help                   Prints this message.\n"
						+ "-test                       Path to the folder containing the test csv-files.\n"
						+ "-train                      Path to the folder containing the test csv-files.\n"
						+ "-lo --listoptions           Lists the available options given the classifier.\n"
						+ "-d --details                Prints the details of the classification.\n"
						+ "-cm --confusion             Prints the confusion matrix of the training set.\n"
						+ "-v --version                Prints the version of this build.\n"
						+ "\n"
						+ "Classifier:\n"
						+ "-c --classifier             The classifier to be used for the classification.\n"
						+ "\n"
						+ "Classifier Options:\n"
						+ "Additional options to be passed to the classifier can be specified here.\n"
						+ "e.g. java -jar MLCode.jar -c knn -k 15 \n"
						+ "For a list of available options use -lo -c <classifier>.\n"
						+ "\n"
						+ "Example Usage:\n"
						+ "java -jar MLCode.jar -test testFolder -train trainFolder -d -cm -c tree");
			} else if ("-c".equals(args[i].toLowerCase())
					|| "--classifier".equals(args[i].toLowerCase())) {
				i++;
				if (i < args.length) {
					String className = args[i];
					className = getClassNameFor(className);
					try {
						classifier = (Classifier) Class.forName(className).getConstructor().newInstance();
						classifier.setOptions(Arrays.copyOfRange(args, i + 1, args.length));
					} catch (ClassNotFoundException cnfe) {
						classifier = null;
					}
				}
				if (i >= args.length || classifier == null) {
					getClassNameFor(""); // avoids nullpointerexception on the classNames map
					System.out.println("-c usage:");
					System.out.println("java -jar MLCode -c <Class Name>");
					System.out.println("java -jar MLCode -c <Classifier description>");
					System.out.println("With <Classifier description> one of: ");

					int col = 0;
					String line = "";
					for (String name : classNames.keySet()) {
						if (line.length() + name.length() > 80) {
							System.out.println(line);
							line = "";
						}
						line = line + name;
					}
					if (!"".equals(line))
						System.out.println(line);
					return;
				}
			} else if ("-train".equals(args[i].toLowerCase())) {
				i++;
				if (i < args.length) {
					trainPath = args[i];
				} else {
					System.out.println("-train usage:");
					System.out.println("java -jar MLCode -train <Training instance folder>");
					return;
				}
			} else if ("-test".equals(args[i].toLowerCase())) {
				i++;
				if (i < args.length) {
					testPath = args[i];
				} else {
					System.out.println("-test usage:");
					System.out.println("java -jar MLCode -test <Testing instance folder>");
					return;
				}
			} else if ("--details".equals(args[i].toLowerCase())
					|| "-d".equals(args[i].toLowerCase())) {
				printDetails = true;
			} else if ("--confusion".equals(args[i].toLowerCase())
					|| "-cm".equals(args[i].toLowerCase())) {
				printConfusionMatrix = true;
			} else if ("--listoptions".equals(args[i].toLowerCase())
					|| "-lo".equals(args[i].toLowerCase())) {
				listOptions = true;
			}
		}

		if (classifier == null) {
			classifier = new J48();
		}

		if (listOptions) {
			System.out.println("Options of classifier " + classifier.getClass().toString());
			Enumeration<Option> lo = classifier.listOptions();
			while (lo.hasMoreElements()) {
				Option o = lo.nextElement();
				System.out.println(o.synopsis());
				System.out.println(o.description());
			}
			return;
		}

		startClassification(trainPath, testPath, classifier, printDetails, printConfusionMatrix);
	}

	private static void startClassification(String trainPath, String testPath, Classifier classifier, boolean printDetails, boolean printConfusionMatrix) throws IOException {
		ArrayList<Walk> trainWalks = DataParser.parseFiles(trainPath);
		Dataset ds = new Dataset(trainWalks);
		ds.extractFeatures();

		ArrayList<Walk> testWalksList = DataParser.parseFiles(testPath);
		Dataset testWalksDS = new Dataset(testWalksList);
		testWalksDS.extractFeatures();

		WekaImpl wekaImpl = new WekaImpl(ds);
		wekaImpl.run(classifier, printDetails, printConfusionMatrix);
		Map<Walk, ClassificationResult> result = wekaImpl.classify(testWalksDS);

		for (Walk walk : result.keySet()) {
			ClassificationResult cr = result.get(walk);
			cr.print();
		}
	}

	static Map<String, String> classNames = null;

	static String getClassNameFor(String name) {
		if (classNames == null) {
			classNames = new HashMap<>();
			classNames.put("tree", "weka.classifiers.trees.J48"); // Decision Tree
			classNames.put("svm", "weka.classifiers.functions.SMO"); //Support Vector Machines
			classNames.put("knn", "weka.classifiers.lazy.IBk"); // K nearest Neighbours (takes as arguments -k )
			classNames.put("nbayes", "weka.classifiers.bayes.NaiveBayes"); // NaiveBayes
		}

		if (classNames.containsKey(name.toLowerCase()))
			return classNames.get(name);
		return name;
	}
}
