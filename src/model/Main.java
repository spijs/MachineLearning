package model;

import java.util.ArrayList;
import parser.DataParser;
import wekaImpl.WekaImpl;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		ArrayList<Walk> trainWalks = DataParser.parseFiles("train");
		Dataset ds = new Dataset(trainWalks);
		ds.extractFeatures();
		new WekaImpl(ds).run();
	}
}
