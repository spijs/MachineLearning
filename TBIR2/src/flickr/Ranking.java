package flickr;

/**
 * @author Thijs D.
 *
 * Represents a ranking of the images as a linked list.
 */
public class Ranking {
	
	RankElement start;
	
	/**
	 * Inserts the given RankedElement sorted in the ranking.
	 * @param re
	 */
	public void addElement(RankElement re){
		if (start==null){ // first element in ranking
			start=re;
		}
		else if(start.getRanking()<re.getRanking()){ // higher ranked than first element
			RankElement old = start;
			start=re;
			re.insert(old);
			start.insert(re);
		}
		else{
			start.insertSorted(re); // recursively inserts in the list
		}
	}
	/**
	 * Prints the highest N ranked items in the ranking.
	 * @param nb The given N.
	 */
	public void printHighest(int nb) {
		int i = 1;
		RankElement current =start;
		while (i<=nb){
			System.out.println(i+". "+current.getImage() + " with probability "+current.getRanking());
			current = current.getNext();
			i++;
			
		}
		
	}
	
	/**
	 * @return the first element of the ranking.
	 */
	public RankElement getFirst(){
		return start;
	}
	
	/**
	 * @param image
	 * @return the reciprocal rank of the image.
	 */
	public double reciprocal(String image){
		double rank = 1.0*start.getRankOfImage(image,1);
		return 1/rank;
	}
	
	/**
	 * @param image
	 * @param number the N in the R@N
	 * @return the R@N recall of the given image.
	 */
	public boolean recall(String image, int number){
		return start.getRecall(1, number, image);
	}

}
