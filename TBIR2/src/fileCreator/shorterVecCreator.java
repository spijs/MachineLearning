package fileCreator;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import flickr.model.Model;


public class shorterVecCreator {

	public final static File TEST = new File("files//testToken.txt");
	public final static File TRAIN = new File("files//trainToken.txt");
	private static String fileName = "files//glove.6B.50d.txt";
	public final static File OUTPUT = new File(
			"files//shorter_glove50.txt");

	public static void main(String[] args) {
		HashMap<String,String> vectors = new HashMap<String,String>();
		try {
			vectors = fillMap(TEST,vectors);
			vectors = fillMap(TRAIN,vectors);
			writeVectors(vectors);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private static void writeVectors(Map<String,String> vectors) throws IOException {
		BufferedWriter writer = new BufferedWriter(new FileWriter(OUTPUT, true));
		for(String word: vectors.keySet()){
			System.out.println(vectors.get(word));
		}
		writer.close();
	}

	private static HashMap<String, String> fillMap(File file, HashMap<String, String> vectors) throws Exception {
		FileInputStream fs = new FileInputStream(file);
		BufferedReader br = new BufferedReader(new InputStreamReader(fs));
		String line;
		while ((line = br.readLine()) != null) {
			String[] elements = line.split("	");
			String sentence = elements[1];
			String[] words = sentence.split(" ");
			List<String> wordList = Arrays.asList(words);
			wordList = Model.removeCommonWords(wordList);
			
			for(String word: wordList){
				if (!vectors.containsKey(word)){
					try{
					String v = getVector(word, fileName);
					vectors.put(word, v);
					System.out.println(v);
					}
					catch(Exception e){
						// Do nothing, word not available
					}
				}
			}
		
		}		
		br.close();
		return vectors;
	}
	
	/**
	 * Returns the wordvector for the given word.
	 * @param word
	 * @return
	 * @throws Exception
	 */
	public static String getVector(String word, String file) throws Exception{
		FileInputStream fs;
		fs = new FileInputStream(file);
		BufferedReader br = new BufferedReader(new InputStreamReader(fs));
		String line;
		while((line=br.readLine())!=null){
			String[] elements = line.split(" ");
			if(elements[0].equalsIgnoreCase(word)){
				br.close();
				return line;
			}
		}
		br.close();
		throw new IllegalArgumentException("given word '"+word+"' does not exist in vocabulary");		
	}

}


