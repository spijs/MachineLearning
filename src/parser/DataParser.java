package parser;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

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
			String [] nextLine;
			while ((nextLine = reader.readNext()) != null) {
				// nextLine[] is an array of values from the line
				double time= Integer.parseInt(nextLine[0]);
				double x = Integer.parseInt(nextLine[x]);
				double y = Integer.parseInt(nextLine[y]);
				double z = Integer.parseInt(nextLine[z]);
				Point point = new Point(x,y,z);
				System.out.println(nextLine[0] + nextLine[1] + "etc...");
			}

		}
		return null;
	}
}
