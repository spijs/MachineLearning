package flickr.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import embeddings.Vector;
import embeddings.Worker;
import flickr.Query;

public class TotalEmbedModel extends Model {

	private Map<String, Vector> vectors;

	public TotalEmbedModel(String image,Map<String, Vector> wordVectors) {
		super(image);
		this.vectors=wordVectors;
	}

	private Vector vector;

	@Override
	public double rank(Query q) {
		List<String> words = q.getWords();
		Vector qVector = null;
		for(String element: words){
			if(qVector!=null){
				try {
					qVector = qVector.add(vectors.get(element));
				} catch (Exception e) {
					// Do nothing
				}
			}
			else{
				try {
					qVector = vectors.get(element);
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
						vector = vector.add(vectors.get(element)); }
					else{
						vector = vectors.get(element);
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
