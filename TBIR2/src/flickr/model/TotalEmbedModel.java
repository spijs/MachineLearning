package flickr.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import embeddings.Vector;
import embeddings.Worker;
import flickr.Query;

public class TotalEmbedModel extends Model {

	private String file;

	public TotalEmbedModel(String image,String file) {
		super(image);
		this.file=file;
	}

	private Vector vector;

	@Override
	public double rank(Query q) {
		List<String> words = q.getWords();
		Vector qVector = null;
		for(String element: words){
			if(qVector!=null){
				try {
					qVector = qVector.add(Worker.getVector(element,file));
				} catch (Exception e) {
					// Do nothing
				}
			}
			else{
				try {
					qVector = Worker.getVector(element,file);
				} catch (Exception e) {
					//Do Nothing
				}
			}
		}
		double distance = qVector.cosineDist(vector);
		return distance;
	}

	@Override
	public void generateValues() {
		Vector vector = null;
		for(String sentence:sentences){
			List<String> words = getWords(sentence);
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
			this.vector=vector;
		}

	}

	/**
	 * @param sentence
	 * @return the relevant words in the sentence as a list.
	 */
	public static List<String> getWords(String sentence) {
		String substring = sentence.substring(0, sentence.length()-2);
		String[] elements = substring.split(" ");
		List<String> words = new ArrayList<String>(Arrays.asList(elements));
		words = removeCommonWords(words);
		return words;
	}

}
