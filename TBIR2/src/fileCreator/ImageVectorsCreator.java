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
import flickr.model.Model;
import flickr.model.SentenceEmbedModel;
import flickr.model.TotalEmbedModel;


/**
 * @author Thijs
 * 
 * This class turns a large file of tokens (token.txt)into a smaller subset based 
 * on another file (testImages.txt) that contains the names of the necessary images.
 *
 */
public class ImageVectorsCreator {

	public final static String TRAIN = "files//trainToken.txt";
	private static String fileName = "files//trainVectors.txt";
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
				String nextLine=processString(sentence);
				writer.write(nextLine);
				writer.write("\n");
				System.out.println("Progress: "+100*i/5000);
				i++;
			}
			br.close();
			writer.close();
		} catch (IOException e) {
			System.out.println("Error occured");
			e.printStackTrace();
		}
	}

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
				// Do nothing
			}
		}
		return vector.toString();

	}

}
