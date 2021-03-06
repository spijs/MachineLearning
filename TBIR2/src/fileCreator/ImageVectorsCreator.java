package fileCreator;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import embeddings.Vector;
import embeddings.Worker;
import flickr.model.TotalEmbedModel;


/**
 * @author Thijs
 * 
 * This class turns a token file into a file that contains the additive wordvectors corresponding to the sentences.
 *
 */
public class ImageVectorsCreator {

	public final static String TRAIN = "files//testToken.txt";
	private static String fileName = "files//testVectors50test.txt";
	private static File images = new File(fileName);
	private static BufferedWriter writer;
	private static String file;

	public static void main(String[] args) {
		file = args[0];
		try {
			double i = 0;
			images.delete();
			writer = new BufferedWriter(new FileWriter(fileName, true));
			FileInputStream fs = new FileInputStream(TRAIN);
			BufferedReader br = new BufferedReader(new InputStreamReader(fs));
			String line;
			while((line=br.readLine())!=null){
				String[] words = line.split("	");
				String sentence = words[1];
				System.out.println(sentence);
				String nextLine=processString(sentence);
				if(nextLine!=null){
					writer.write(nextLine);
				}
				else{
					writer.write("0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"+
							"0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"+
							"0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"+
							"0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"+
							"0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"
							);
				}
				writer.write("\n");
				System.out.println("Progress: "+100*i/30000);
				i++;
			}
			br.close();
			writer.close();
		} catch (IOException e) {
			System.out.println("Error occured");
			e.printStackTrace();
		}
	}

	/**
	 * Returns a wordvector by adding the wordvector of each word in it.
	 * 
	 * @param sentence
	 * @return the word vector corresponding to the given sentence.
	 */
	private static String processString(String sentence){

		List<String> words = TotalEmbedModel.getWords(sentence);
		Vector vector = null;
		for(String element: words){
			try {
				if(vector!=null){
					vector = vector.add(Worker.getVector(element, file));}
				else{
					vector = Worker.getVector(element, file);
				}
			} catch (Exception e) {
			//Do nothing
				}
		}
		if(vector==null){return null;}
		return vector.toString();

	}

}
