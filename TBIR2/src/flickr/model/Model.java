package flickr.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Random;

import flickr.Query;

/**
 * @author Thijs D
 * Class representing an image model containing the image andthe describing sentences.
 */
public abstract class Model {
	protected static final double NO_OCCURENCE = 0.0001;
	private String image;
	protected List<String> sentences;
	public static List<String> commonWords = new ArrayList<String>(Arrays.asList("the", "be", "to", "of","and","in","that","a",","));
	
	/**
	 * Creates a model
	 * @param image
	 */
	public Model(String image){
		this.image=image;
		sentences = new ArrayList<String>();
	}
	
	
	/**
	 * Removes a random sentence from the set of sentences and returns it.
	 * @return
	 */
	public Query createQuery() {
		int total = sentences.size()-1;
		Random r = new Random();
		int i = r.nextInt(total);
		String sentence = sentences.get(i);
		Query q = new Query(sentence,this.image);
		sentences.remove(i);
		return q;
	}

	public String getImage() {
		return image;
	}
	
	/**
	 * Removes the common words out of the keys of a Map.
	 * @param occurences
	 */
	protected void removeCommonWords(Map<String, Double> occurences){
		for(String common:commonWords){
			occurences.remove(common);
		}
	}
	

	/**
	 * Removes the common words out of a list of words.
	 * @param occurences
	 */
	public static List<String> removeCommonWords(List<String> occurences){
		List<String> result = new ArrayList<String>();
		for(String occurence:occurences)
			if(!commonWords.contains(occurence)){
				result.add(occurence);
			}
		return result;
	}
	

	/**
	 * Ranks the query
	 * @param q
	 * @return the ranking of this query.
	 */
	public abstract double rank(Query q);

	/**
	 * Generates the necessary values e.g. probabilities or word vectors to be able to rank.
	 */
	public abstract void generateValues();

	public void addSentence(String sentence) {
		sentences.add(sentence);
	}
}
