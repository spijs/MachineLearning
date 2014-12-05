import java.util.HashMap;
import java.util.Map.Entry;


public class Result {

	private String name;
	private double numberOfWindows;
	private HashMap<String, Double> votes;
	
	
	public Result(String name){
		this.name = name;
		votes= new HashMap<String,Double>();
	}
	
	public void addVote(String vote, double confidence){
		this.numberOfWindows++;
		if(votes.containsKey(vote)){
			double currentValue = votes.get(vote);
			currentValue += confidence;
			votes.put(vote, currentValue);
		}
		else{
			votes.put(vote, confidence);
		}
	}
	
	private String getBest(){
		double best=0.0;
		String bestS = "";
		for (Entry<String,Double> entry : votes.entrySet()){
			if(entry.getValue()>best){
				best = entry.getValue();
				bestS = entry.getKey();
			}
		}
		return bestS;
	}
	
	public String toString(){
		String result = "";
		result = result + ("File : "+name+"\n");
		result = result + ("---------------\n");
		for(Entry<String,Double> entry : votes.entrySet()){
			if(entry.getKey().equals(getBest())){
				result = result+"*";
			}
			result = result + entry.getKey()+ " : " + entry.getValue()/numberOfWindows+"\n";
		}
		return result;
	}

}
