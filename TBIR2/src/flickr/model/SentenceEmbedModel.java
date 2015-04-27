package flickr.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import embeddings.Vector;
import embeddings.Worker;
import flickr.Query;

public class SentenceEmbedModel extends Model {

	private HashMap<String, Vector> vectors;
	private String file;
	private ModelType aggType;

	/**
	 * @param image
	 * @param file The file containing the word vectors.
	 * @param modelType The aggregation method to be used.
	 */
	public SentenceEmbedModel(String image,String file,ModelType modelType) {
		super(image);
		this.file = file;
		this.aggType=modelType;
		this.vectors = new HashMap<String,Vector>();
	}

	/* 
	 * Ranks according to the word vector model.
	 */
	@Override
	public double rank(Query q) {
		double rank = 0;
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
		for(String s: vectors.keySet()){
			double distance = qVector.cosineDist(vectors.get(s));
			rank = aggregationMethod(rank, distance);
		} 
		return rank;
	}

	/**
	 * Changes the given ranking based on the chosen aggregation method.
	 * @param ranking
	 * @param distance
	 */
	private double aggregationMethod(double ranking, double distance) {
		if(aggType==ModelType.E_AGG){
			ranking += distance;
		}
		else{
			ranking = Math.max(ranking,distance);
		}
		return ranking;
	}
	
	@Override
	public void generateValues() {
		for(String sentence:sentences){
			List<String> words = getWords(sentence);
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
			vectors.put(sentence, vector);
		}
	}

	/**
	 * @param sentence
	 * @return the relevant words in the sentence as a list.
	 */
	private List<String> getWords(String sentence) {
		String substring = sentence.substring(0, sentence.length()-2);
		String[] elements = substring.split(" ");
		List<String> words = new ArrayList<String>(Arrays.asList(elements));
		words = removeCommonWords(words);
		return words;
	}

}
