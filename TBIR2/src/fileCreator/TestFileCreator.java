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

	public final static String TEST = "files//Flickr_8k.testImages.txt";
	public final static String TOKENS = "files//Flickr8k.token.txt";
	private static String fileName = "files//testToken.txt";
	private static File testfile = new File(fileName);
	private static BufferedWriter writer;

	public static void main(String[] args) {
		try {
			testfile.delete();
			writer = new BufferedWriter(new FileWriter(fileName, true));
			FileInputStream testStream = new FileInputStream(TEST);
			BufferedReader testReader = new BufferedReader(new InputStreamReader(testStream));
			String line;
			int i=1;
			while((line=testReader.readLine())!=null){
				FileInputStream fs = new FileInputStream(TOKENS);
				BufferedReader br = new BufferedReader(new InputStreamReader(fs));
				String nextLine;
				while((nextLine = br.readLine())!=null){
					String[] elements = nextLine.split("#");
					String file = elements[0];
					if(line.equalsIgnoreCase(file)){
						System.out.println("Progress: "+ 100.0*(i*1.0/1000));
						writer.write(nextLine);
						writer.write("\n");
						
						String l2 = br.readLine();
						String l3 = br.readLine();
						String l4 = br.readLine();
						String l5 = br.readLine();
						
						writer.write(l2);
						writer.write("\n");
						
						writer.write(l3);
						writer.write("\n");
						
						writer.write(l4);
						writer.write("\n");
						
						writer.write(l5);
						writer.write("\n");
						
						break;
					}
				}
				br.close();
				i++;

			}
			testReader.close();
			writer.close();
		} catch (IOException e) {
			System.out.println("Error occured");
			e.printStackTrace();
		}
	}

}
