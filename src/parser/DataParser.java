package parser;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import model.Point;
import model.Walk;

import com.opencsv.CSVReader;


public class DataParser {

	public static void main(String[] args) throws Exception {
		parseFiles("train");
	}

	public static ArrayList<Walk> parseFiles(String path) throws IOException{

		ArrayList<Walk> walks = new ArrayList<Walk>();
		File f = new File(path);
		ArrayList<String> names = new ArrayList<String>(Arrays.asList(f.list()));

		for(String name:names){
			CSVReader reader = new CSVReader(new FileReader(path+"/"+name));
		
			String[] parts = name.split("_");
			int length = parts.length;
			String walker = parts[length-1];
			String [] nextLine;
			Walk walk = new Walk(walker);
			while ((nextLine = reader.readNext()) != null) {
				// nextLine[] is an array of values from the line
				double time= Integer.parseInt(nextLine[0]);
				double x = Integer.parseInt(nextLine[1]]);
				double y = Integer.parseInt(nextLine[2]);
				double z = Integer.parseInt(nextLine[3]);
				Point point = new Point(time, x,y,z);
				walk.addPoint(point);
				
			}
			walks.add(walk);
		}
		return walks;
	}
}
