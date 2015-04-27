package flickr;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Thijs D.
 * This class should be called when the textual image retrieval task needs to be run.
 */
public class ImagesMain {

	public static void main(String[] args) {
		Map<String,String> options = getOptions(args);
		try {
			Solver solver = new Solver(options);
			solver.solve();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @param args
	 * @return the Map with as key the name of the option and as value the chosen option value.
	 */
	private static Map<String,String> getOptions(String[] args){
		HashMap<String, String> result = new HashMap<String, String>();
		int size = args.length;
		int i;
		for(i=0;i<size;i++){
			if("-m".equals(args[i])){
				i++;
				if(i<size){
					result.put("model", args[i]);
				}
				else{
					System.out.println("You need to provide a valid model.");
					break;
				}
			}	
			else if ("-h".equals(args[i].toLowerCase())
					|| "--help".equals(args[i].toLowerCase())) {
				printHelp();			
			}
			else if ("-test".equals(args[i].toLowerCase())) {
				i++;
				result.put("test", args[i]);			
			}
			else if ("-train".equals(args[i].toLowerCase())) {
				i++;
				result.put("train", args[i]);			
			}
			else if ("-images".equals(args[i].toLowerCase())) {
				i++;
				result.put("images", args[i]);			
			}
			else if ("-names".equals(args[i].toLowerCase())) {
				i++;
				result.put("names", args[i]);			
			}
			else if ("-v".equals(args[i].toLowerCase())) {
				i++;
				result.put("vectors", args[i]);			
			}
			else if ("-t".equals(args[i].toLowerCase())) {
				i++;
				result.put("threads", args[i]);			
			}
			else if ("-nq".equals(args[i].toLowerCase())) {
				i++;
				result.put("nbOfQueries", args[i]);			
			}
			
			
			
			
			
		}
		return result;
	}
	
	private static void printHelp(){
		System.out.println(
				"This java program allows a user to create models and queries for retrieving images.\n"
				+ "\n"
				+ "usage: java -jar flickr.jar [options]\n"
				+ "\n"
				+ "Options:\n"
				+ "-h --help                 Prints this message.\n"
				+ "-q                     	 Path to query file. \n"
				+ "-nq                       Number of queries to be processed.\n"
				+ "-t						 Number of threads that need to be run.\n"
				+ "-m		          		 Specifies the chosen type of model: options are E_AGG,E_TOTAL,E_MAX,P_AGG,P_TOTAL and P_MAX."
				+ "-v						 Path to the vector file (in case of the use of embeddings)"
				+ "Example Usage:\n"
				+ "java -jar flickr.jar google.txt -q test.txt -m P_MAX -nq -100 -t 4");
	}

}
