package fileCreator;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;


/**
 * @author Thijs
 * 
 * This class turns a large file of tokens (token.txt)into a smaller subset based 
 * on another file (testImages.txt) that contains the names of the necessary images.
 *
 */
public class TestFileCreator {

	public final static String TEST = "Flickr8k_text//Flickr_8k.trainImages.txt";
	public final static String TOKENS = "Flickr8k_text//Flickr8k.token.txt";
	private static String fileName = "Flickr8k_text//trainToken.txt";
	private static File testfile = new File(fileName);
	private static BufferedWriter writer;
	
	public static void main(String[] args) {
		try {
		testfile.delete();
		writer = new BufferedWriter(new FileWriter(fileName, true));
		FileInputStream fs = new FileInputStream(TOKENS);
		BufferedReader br = new BufferedReader(new InputStreamReader(fs));
		String line;
			while((line=br.readLine())!=null){
				String[] elements = line.split("#");
				String file = elements[0];
				FileInputStream testStream = new FileInputStream(TEST);
				BufferedReader testReader = new BufferedReader(new InputStreamReader(testStream));
				String nextLine;
				while((nextLine = testReader.readLine())!=null){
					if(nextLine.equalsIgnoreCase(file)){
						writer.write(line);
						writer.write("\n");
						break;
					}
				}
				testReader.close();

			}
			br.close();
			writer.close();
		} catch (IOException e) {
			System.out.println("Error occured");
			e.printStackTrace();
		}
	}

}
