package flickr;

/**
 * @author Thijs D.
 * Element of a Ranking containing zero or one next RankElement.
 */
public class RankElement {
	private String image;
	private double ranking;
	private RankElement next;
	
	public RankElement(String image, double ranking){
		this.image=image;
		this.ranking=ranking;
	}
	
	public String getImage() {
		return image;
	}
	public double getRanking() {
		return ranking;
	}
	public RankElement getNext() {
		return next;
	}
	
	/**
	 * @return True if this RankElement has a next RankElement linked to it.
	 */
	public boolean hasNext(){
		return next!=null;
	}

	public void setNext(RankElement next){
		this.next=next;
	}
	
	/**
	 * inserts the given RankElement between this rankElement and its previous next rankElement
	 * @param re The given RankElement
	 */
	public void insert(RankElement re){
		if (hasNext()){
			RankElement old = next;
			this.next = re;
			re.setNext(old);
		}
		else{
			this.next=re;
		}
	}
	
	/**
	 * Inserts the ranked element between this and the next element, if the given element's ranking lies between them.
	 * @param re Given RankElement
	 */
	public void insertSorted(RankElement re){
		if(hasNext() && re.getRanking()<next.getRanking()){
			next.insertSorted(re);
		}
		else{
			insert(re);
		}
	}

	/**
	 * Recursively searches for the rank of the given image.
	 * Returns the currentRank if this Element's image is the given image. Otherwise highers the currentRank and passes on
	 * the request to the next RankElement.
	 * @param imageName
	 * @param currentRank
	 */
	public int getRankOfImage(String imageName, int currentRank) {
		if(imageName.equals(image)){
			return currentRank;
		}
		else{
			currentRank++;
			return next.getRankOfImage(imageName, currentRank);
		}
	}
	
	/**
	 * Recursively determines the recall of the given image.
	 * @param current Current level in the ranking
	 * @param max The maximal recall (N in R@N)
	 * @param imageName
	 */
	public boolean getRecall(int current, int max, String imageName){
		if(imageName.equals(image)){
			return true;
		}
		else if(current+1>max){
			return false;
		}
		else{
			current++;
			return next.getRecall(current,max,imageName);
		}
	}
}
