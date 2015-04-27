package flickr.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import flickr.Query;

public class SentenceProbModel extends Model{

	protected Map<String, Map<String, Double>> probabilities;
	private ModelType aggType;

	public SentenceProbModel(String image,ModelType modelType) {
		super(image);
		this.aggType=modelType;
	}

	@Override
	public double rank(Query query) {
		List<String> words = query.getWords();
		double ranking =0.0;
		for(String sentence : probabilities.keySet()){
			double stringRanking=1;
			for(String word:words){
				if(probabilities.get(sentence).containsKey(word.toLowerCase())){
					double prob = probabilities.get(sentence).get(word.toLowerCase());
					stringRanking=stringRanking*prob;
				}
				else{
					stringRanking=stringRanking*NO_OCCURENCE;
				}
			}
			ranking = aggregationMethod(ranking, sentence, stringRanking);
		}
		return ranking;
	}

	/**
	 * Changes the ranking based on the chosen aggregationmethod.
	 * @param ranking
	 * @param sentence
	 * @param stringRanking
	 * @return
	 */
	private double aggregationMethod(double ranking, String sentence,
			double stringRanking) {
		if(aggType==ModelType.P_AGG){
			ranking += stringRanking/(probabilities.get(sentence).size());
		}
		else{
			ranking = Math.max(ranking,stringRanking);
		}
		return ranking;
	}

	@Override
	public void generateValues() {
		Map<String,Map<String,Double>> occurences = new HashMap<String,Map<String,Double>>();
		Map<String,Map<String,Double>> result = new HashMap<String,Map<String,Double>>();
		for(String sentence:sentences){
			occurences.put(sentence, new HashMap<String,Double>());
			result.put(sentence, new HashMap<String,Double>());
			String substring = sentence.substring(0, sentence.length()-2);
			String[] elements = substring.split(" ");
			for(String element: elements){
				element=element.toLowerCase();
				if(occurences.get(sentence).containsKey(element)){
					double value = occurences.get(sentence).get(element);
					value ++;
					occurences.get(sentence).put(element, value);
				}
				else{
					occurences.get(sentence).put(element,1.0);
				}
			}
			removeCommonWords(occurences.get(sentence));
			int total=0;
			for(String word:occurences.get(sentence).keySet()){
				total += occurences.get(sentence).get(word);
			}
			for(String word:occurences.get(sentence).keySet()){
				result.get(sentence).put(word,(occurences.get(sentence).get(word)/total));
			}
		}
		probabilities=result;

	}
	
	

}
