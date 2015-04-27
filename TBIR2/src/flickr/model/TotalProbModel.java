package flickr.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import flickr.Query;

public class TotalProbModel extends Model {

	protected Map<String,Double> probabilities;

	public TotalProbModel(String image) {
		super(image);
	}

	@Override
	public double rank(Query query) {
		List<String> words = query.getWords();
		double ranking =1.0;
		for(String word:words){
			if(probabilities.containsKey(word.toLowerCase())){
				double prob = probabilities.get(word.toLowerCase());
				ranking=ranking*prob;
			}
			else{
				ranking=ranking*NO_OCCURENCE;
			}
		}
		return ranking;
	}

	@Override
	public void generateValues() {
		Map<String,Double> occurences = new HashMap<String,Double>();
		Map<String,Double> result = new HashMap<String,Double>();
		Double totalOccurences=0.0;
		for(String sentence:sentences){
			sentence = sentence.substring(0, sentence.length()-2);
			String[] elements = sentence.split(" ");
			for(String element: elements){
				element=element.toLowerCase();
				if(occurences.containsKey(element)){
					double value = occurences.get(element);
					value ++;
					occurences.put(element, value);
				}
				else{
					occurences.put(element,1.0);
				}
			}
		removeCommonWords(occurences);
		for(String word:occurences.keySet()){ // get total word occurences
			totalOccurences += occurences.get(word);
		}
		}
		for(String word:occurences.keySet()){ // generate probabilities
			result.put(word,(occurences.get(word)/totalOccurences));
		}
		probabilities=result;
	}

}
