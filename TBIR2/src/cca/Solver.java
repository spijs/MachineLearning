package cca;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import logger.Logger;
import embeddings.Vector;
import flickr.RankElement;
import flickr.Ranking;

/**
 * @author Thijs D & Wout V
 * 
 * This class is reponsible for the image retrieval task based on CCA. *
 */
public class Solver {
	private List<String> testNames;
	private Logger logger;
	private int k=1;

	public Solver(Map<String,String> options) throws IOException{
		this.k = Integer.parseInt(options.get("k"));
		this.testNames = parseFile(options.get("testNames"));
		this.logger = new Logger("results_cca_k_"+k);
	}

	/**
	 * Returns a list containing each line of the given file.
	 * 
	 * @param fileName
	 * @return list containing each line of the given file.
	 * @throws IOException
	 */
	private List<String> parseFile(String fileName) throws IOException {
		List<String> result = new ArrayList<String>();
		File training = new File(fileName);
		FileReader fr = new FileReader(training);
		BufferedReader br = new BufferedReader(fr);
		while(true)	{
			String line = br.readLine();
			if(line == null) {break;}
			result.add(line);
		}
		br.close();
		return result;
	}

	
	/**
	 * Solves the image retrieval task and logs the results.
	 * 
	 */
	public void solve(){
		try {
		List<Vector> projQs;
			projQs = getProjectedQs(k);
			List<Vector> projIs = getProjectedIs(k);
			System.out.println("Started Ranking");
			List<Ranking> rankings = new ArrayList<Ranking>();
			for(int i=0;i<projQs.size();i++){
				Vector qVector = projQs.get(i);
				Ranking ranking = new Ranking();
				for(int j=0; j<projIs.size();j++){
					Vector iVector = projIs.get(j);
					double similarity = qVector.cosineDist(iVector);
					String imageTestName = testNames.get(j);
					ranking.addElement(new RankElement(imageTestName, similarity));
				}
				rankings.add(ranking);
				System.out.println("Ranked query "+(i+1));
				ranking.printHighest(5);
				System.out.println("Ranking progress: "+100.0*i/(projQs.size()));
			}
			logResults(rankings);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	/**
	 * @param k
	 * @return The List of k-rank approximated projected image vectors 
	 * @throws IOException
	 */
	private List<Vector> getProjectedIs(int k) throws IOException {
		File projFile = new File("files/projectedI_"+k+".txt");
		return processFile(projFile);
	}

	/**
	 * @param k
	 * @return The List of k-rank approximated projected query vectors 
	 * @throws IOException
	 */
	private List<Vector> getProjectedQs(int k) throws IOException {
		File projFile = new File("files/projectedQ_"+k+".txt");
		return processFile(projFile);
	}

	/**
	 * @param projFile
	 * @return A list containing each vector in the given projFile.
	 * @throws IOException
	 */
	private List<Vector> processFile(File projFile) throws IOException {
		List<Vector> result = new ArrayList<Vector>();
		FileReader fr = new FileReader(projFile);
		BufferedReader br = new BufferedReader(fr);
		while(true)	{
			String line = br.readLine();
			if(line == null) {break;}
			Vector v = new Vector(line);
			result.add(v);
		}
		br.close();
		return result;

	}

	/**
	 * @param rankings
	 * 
	 * Logs and prints the mmr and recall results of the given rankings.
	 */
	private void logResults(List<Ranking> rankings) {
		double mmr=0;
		double recall1=0;
		double recall5=0;
		double recall10=0;
		int n = 1;
		for(int i=0;i<rankings.size();i++){
			Ranking r=rankings.get(i);
			String q=testNames.get(n-1);
			if((i+1)%5==0){
				n++;
			}
			mmr+=r.reciprocal(q);
			if(r.recall(q,1)){
				recall1++;
			}
			if(r.recall(q,5)){
				recall5++;
			}
			if(r.recall(q,10)){
				recall10++;
			}
		}
		String results = "###################################################\n"+
				"MMR: "+mmr/rankings.size()+"\n"+
				"Recall@1:" +1.0*recall1/rankings.size()+"\n"+
				"Recall@5:" +1.0*recall5/rankings.size()+"\n"+
				"Recall@10:" +1.0*recall10/rankings.size();
		logger.log(results);
		System.out.println(results);
		logger.close();
	}
}
