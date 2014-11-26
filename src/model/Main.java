package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import parser.DataParser;
import weka.classifiers.Classifier;
import weka.classifiers.trees.J48;
import wekaImpl.WekaImpl;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {

		Classifier classifier = null;

		// Argument loop
		for (int i = 0; i < args.length; i++) {
			if ("-c".equals(args[i])) {
				i++;
				if (i < args.length) {
					String className = args[i];
					className = getClassNameFor(className);
					try {
						classifier = (Classifier) Class.forName(className).getConstructor().newInstance();
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
			} else if ("-h".equals(args[i])) {

			}
		}

		if (classifier == null) {
			classifier = new J48();
		}

		ArrayList<Walk> trainWalks = DataParser.parseFiles("train");
		Dataset ds = new Dataset(trainWalks);
		ds.extractFeatures();

		ArrayList<Walk> testWalksList = DataParser.parseFiles("test");
		Dataset testWalksDS = new Dataset(testWalksList);
		testWalksDS.extractFeatures();

		WekaImpl wekaImpl = new WekaImpl(ds);
		wekaImpl.run(classifier);
		wekaImpl.classify(testWalksDS);
	}

	static Map<String, String> classNames = null;

	static String getClassNameFor(String name) {
		if (classNames == null) {
			classNames = new HashMap<>();
			classNames.put("tree", "weka.classifiers.trees.J48"); // Decision Tree
			classNames.put("SVM","weka.classifiers.functions.SMO"); //Support Vector Machines
			classNames.put("kNN","weka.classifiers.lazy.IBk"); // K nearest Neighbours (takes as arguments -k )
			classNames.put("nBayes","weka.classifiers.bayes.NaiveBayes"); // NaiveBayes
		}

		if (classNames.containsKey(name))
			return classNames.get(name);
		return name;
	}
}
