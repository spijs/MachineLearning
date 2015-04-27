package flickr;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Thijs
 * Class representing a query containing the string and the image to which it belongs.
 */
public class Query {

	private String image;
	private String sentence;

	public Query(String sentence, String image) {
		this.sentence=sentence;
		this.image=image;
	}

	/**
	 * @return the words that occur in this query.
	 */
	public List<String> getWords(){
		List<String> result = new ArrayList<String>();
		String shortened = sentence.substring(0, sentence.length()-2);
		String[] elements = shortened.split(" ");
		for(String element: elements){
			result.add(element);		
		}
		return result;
	}

	public String getImage() {
		return this.image;
	}

	public String getSentence(){
		return this.sentence;
	}
}
