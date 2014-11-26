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
		ArrayList<Walk> trainWalks = DataParser.parseFiles("train");
		Dataset ds = new Dataset(trainWalks);
		ds.extractFeatures();

		ArrayList<Walk> testWalksList = DataParser.parseFiles("test");
		Dataset testWalksDS = new Dataset(testWalksList);
		testWalksDS.extractFeatures();

		Classifier classifier = null;

		// Argument loop
		for (int i = 0; i < args.length; i++) {
			System.out.println("" + i + " " + args[i]);

			if ("-c".equals(args[i])) {
				i++;
				if (i < args.length) {
					String className = args[i];

					classifier = (Classifier) Class.forName(className).getConstructor().newInstance();
				}
				if (i >= args.length || classifier == null) {
					System.out.println("-c usage:");
					System.out.println("java Main -c <ClassName>");
					System.out.println("");
				}
			} else if ("-h".equals(args[i])) {

			}
		}

		if (classifier == null) {
			classifier = new J48();
		}

		WekaImpl wekaImpl = new WekaImpl(ds);
		wekaImpl.run(classifier);
		wekaImpl.classify(testWalksDS);
	}

	static Map<String, String> classNames = null;

	static String getClassNameFor(String name) {
		if (classNames == null) {
			classNames = new HashMap<>();
			classNames.put("tree", "weka.classifiers.trees.J48");

		}

		if (classNames.containsKey(name))
			return classNames.get(name);
		return name;
	}
}
