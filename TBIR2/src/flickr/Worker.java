package flickr;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import logger.Logger;
import embeddings.Vector;
import flickr.model.Model;


/**
 * @author Thijs D
 * 
 * A thread which ranks the models for each query.
 */
public class Worker implements Runnable{

	private List<Model> models;
	private List<Query> queries;
	private Logger logger;
	private Map<String, Vector> testImages;
	private Map<String, Vector> trainImages;


	public Worker(List<Query> queries, List<Model> models,Map<String,Vector> testImages,Map<String,Vector> trainImages) {
		this.queries=queries;
		this.models=models;
		this.logger=Logger.getInstance();
		this.testImages = testImages;
		this.trainImages =trainImages;
	}


	private String getBestTraining(Query q) throws IOException{
		System.out.println("Started Ranking...");
		String bestImage="";
		double bestRanking=0.0;
		for(Model m: models){
			double rank = m.rank(q);
	//		System.out.println("Rank:"+ rank+" for image "+m.getImage());
			if(rank>bestRanking){
				bestRanking=rank;
				bestImage = m.getImage();
			}
		}
		System.out.println("#########################");
		System.out.println("Query for image "+q.getImage());
		System.out.println(bestImage);

		return bestImage;
	}


	private void logResults(List<Ranking> rankings) {
		double mmr=0;
		double recall1=0;
		double recall5=0;
		double recall10=0;
		for(int i=0;i<rankings.size();i++){
			Ranking r=rankings.get(i);
			Query q=queries.get(i);
			mmr+=r.reciprocal(q.getImage());
			if(r.recall(q.getImage(),1)){
				recall1++;
				}
			if(r.recall(q.getImage(),5)){
				recall5++;
				}
			if(r.recall(q.getImage(),10)){
				recall10++;
				}
		}
		String results = "###################################################\n"+
						 "MMR: "+mmr/queries.size()+"\n"+
						 "Recall@1:" +1.0*recall1/queries.size()+"\n"+
						 "Recall@5:" +1.0*recall5/queries.size()+"\n"+
						 "Recall@10:" +1.0*recall10/queries.size();
		logger.log(results);
		System.out.println(results);
	}


	@Override
	public void run() {
		try {
			List<Ranking> rankings = new ArrayList<Ranking>();
			double progress=0;
			for(Query q: queries){
				progress++;
				String image = getBestTraining(q);
				System.out.println("Ranking training images progress: "+100*(1.0*progress/queries.size())+"%");
				Vector best = trainImages.get(image);
				rankings.add(getClosestImages(best));	
				System.out.println("Ranking the images progress: "+100*(1.0*progress/queries.size())+"%");
			}
				logResults(rankings);
				logger.close();

		} catch (IOException e) {
			e.printStackTrace();
		}		
	}

	private Ranking getClosestImages(Vector best) {
		System.out.println("Started Ranking the images...");
		Ranking ranking = new Ranking();
		for(Entry<String, Vector> image:testImages.entrySet()){
			double rank = image.getValue().cosineDist(best);
			RankElement el = new RankElement(image.getKey(),rank);
			ranking.addElement(el);
			
		}	
		return ranking;
	}


}
