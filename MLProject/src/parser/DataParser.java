package parser;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;

import model.Point;
import model.Walk;

import com.opencsv.CSVReader;


public class DataParser {

	public static ArrayList<Walk> parseFiles(String path) throws IOException{

		ArrayList<Walk> walks = new ArrayList<Walk>();
		File f = new File(path);
		ArrayList<String> names = new ArrayList<String>(Arrays.asList(f.list()));

		for(String fileName:names){
			if (!fileName.endsWith(".csv"))
				continue;
			CSVReader reader = new CSVReader(new FileReader(path+"/"+fileName));

			String[] parts = fileName.split("_");
			int length = parts.length;
			String walker = parts[length - 1].split("\\.")[0];
			String [] nextLine;
			Walk walk = new Walk(walker,fileName);
			reader.readNext(); //Do not read first line
			while ((nextLine = reader.readNext()) != null) {
				// nextLine[] is an array of values from the line
				BigInteger time= new BigInteger(nextLine[0].trim());
				double x = Double.parseDouble(nextLine[1].trim());
				double y = Double.parseDouble(nextLine[2].trim());
				double z = Double.parseDouble(nextLine[3].trim());
				Point point = new Point(time, x,y,z);
				walk.addPoint(point);

			}
			if (walk.getSize() > 0)
				walks.add(walk);
		}
		return walks;
	}
}
