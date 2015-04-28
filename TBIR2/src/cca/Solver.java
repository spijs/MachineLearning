package cca;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import logger.Logger;
import matlabcontrol.MatlabInvocationException;
import matlabcontrol.MatlabProxy;
import embeddings.Vector;
import flickr.RankElement;
import flickr.Ranking;

public class Solver {
	private MatlabProxy mlp;
	private String trainV;
	private String testV;
	private String trainImages;
	private String testImages;
	private List<String> testNames;
	private List<String> trainNames;
	private Logger logger;

	public Solver(MatlabProxy mlp, Map<String,String> options) throws IOException{
		this.mlp=mlp;
		this.trainV= options.get("train");
		this.testV= options.get("test");
		this.trainImages = options.get("trainImages");
		this.testImages = options.get("testImages");
		this.testNames = parseFile(options.get("testNames"));
		this.trainNames = parseFile(options.get("trainNames"));
		this.logger = new Logger(trainV,testV);
	}

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

	public void solve() throws MatlabInvocationException {
		System.out.println("Starting Matlab computations..");
		mlp.eval("[projectedQ, projectedI] = preprocess('"+trainV+"', '"+trainImages+"', '"+testV+"', '"+testImages+"');");
		double[][] projQs = (double[][])  mlp.getVariable("projectedQ");
		double[][] projIs = (double[][])  mlp.getVariable("projectedI");
		System.out.println("Matlab computations finished..");
		System.out.println("Started Ranking");
		List<Ranking> rankings = new ArrayList<Ranking>();
		for(int i=0;i<projQs.length;i++){
			double[] query = projQs[i];
			Ranking ranking = new Ranking();
			for(int j=0;j<projIs.length;j++){
				double[] image = projIs[j];
				Vector qVector = new Vector(query);
				Vector iVector = new Vector(image);
				double similarity = qVector.cosineDist(iVector);
				String imageTrainName = trainNames.get(j);
				ranking.addElement(new RankElement(imageTrainName, similarity));
			}
			rankings.add(ranking);
			System.out.println("Ranking progress: "+100.0*i/(projQs.length));
		}
		logResults(rankings);
	}
	
	
	private void logResults(List<Ranking> rankings) {
		double mmr=0;
		double recall1=0;
		double recall5=0;
		double recall10=0;
		for(int i=0;i<rankings.size();i++){
			Ranking r=rankings.get(i);
			String q=testNames.get(i);
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
