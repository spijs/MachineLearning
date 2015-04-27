package flickr;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import logger.Logger;
import embeddings.Vector;
import flickr.model.Model;
import flickr.model.ModelType;
import flickr.model.SentenceEmbedModel;
import flickr.model.SentenceProbModel;
import flickr.model.TotalEmbedModel;
import flickr.model.TotalProbModel;

/**
 * @author Thijs D
 * 
 * This class is responsible for creating models and queries out of the given file and starting workers that will
 * check how the chosen models perform.
 */
public class Solver {
	
	private String train;
	private ModelType modelType;
	private String vectorsFile;
	private int nbOfThreads=1;
	private int nbOfQueries=0;
	private String test;
	private String imageNamesFile;
	private String imagesVectorFile;

	/**
	 * Creates a solver based on a map containing options.
	 * @param options
	 * @throws IOException
	 */
	public Solver(Map<String, String> options){
		setOptions(options);
	}
	
	public void solve() throws IOException{
		Logger.getInstance(vectorsFile,modelType.toString(),nbOfQueries,nbOfThreads);
		List<Model>models = createModels();
		List<Query>queries = createQueries();
		Map<String,Vector>images = createImages();
		Map<String, Vector> trainImages = getUsedImages(images, train);
		Map<String, Vector> testImages = getUsedImages(images, test);
		prepareModels(models);
		solve(queries,models,trainImages, testImages);		
	}


	private Map<String, Vector> getUsedImages(Map<String, Vector> images, String fileName) throws IOException, FileNotFoundException {
		Map<String, Vector> result = new HashMap<String, Vector>();
		File training = new File(fileName);
		FileReader fr = new FileReader(training);
		BufferedReader br = new BufferedReader(fr);
		while(true)	{
			String line = br.readLine();
			if(line == null) {break;}
			String filename = line.split("#")[0];
			result.put(filename, images.get(filename));
		}
		return result;
	}

	private Map<String,Vector> createImages() throws IOException, FileNotFoundException{
		Map<String, Vector> images = new HashMap<String, Vector>();
		File names = new File(imageNamesFile);
		FileReader namesFReader = new FileReader(names);
		BufferedReader namesReader = new BufferedReader(namesFReader);
		File vectors = new File(imagesVectorFile);
		FileReader vectorFReader = new FileReader(vectors);
		BufferedReader vectorReader = new BufferedReader(vectorFReader);
		while(true) {
			String name = namesReader.readLine();
			if(name == null) {break;}
			String vectorString = vectorReader.readLine();
			Vector vector = new Vector(vectorString);
			images.put(name, vector);
		}
		namesReader.close();
		vectorReader.close();
		return images;
	}


	/**
	 * Configures the solver based on the given options.
	 * @param options
	 */
	private void setOptions(Map<String, String> options) {
		train=options.get("train");
		test=options.get("test");
		imagesVectorFile=options.get("images");
		imageNamesFile=options.get("names");
		modelType = ModelType.fromString(options.get("model"));

		if(options.containsKey("vectors")){
			this.vectorsFile=options.get("vectors");
		}
		if(options.containsKey("threads")){
			this.nbOfThreads=Integer.parseInt(options.get("threads"));
		}
		if(options.containsKey("nbOfQueries")){
			this.nbOfQueries=Integer.parseInt(options.get("nbOfQueries"));
		}
		
		
	}
	
	/**
	 * Creates different threads that will each take on a subset of the queries.
	 * @param images 
	 * @param models 
	 * @param queries 
	 * @param testImages 
	 * @throws IOException
	 */
	public void solve(List<Query> queries, List<Model> models, Map<String,Vector> trainImages, Map<String, Vector> testImages) throws IOException {
		int totalQueries = queries.size();
		int queriesCovered = 0;
		int queriesPerThread = totalQueries/nbOfThreads;
		int i = 0;
		if(nbOfQueries==0){
			nbOfQueries=queriesPerThread;
		}
		while(queriesCovered<totalQueries-1 && i<nbOfThreads){
			i++;
			System.out.println("creating worker "+i);
			List<Query> threadQueries = new ArrayList<Query>();
			for(int j=queriesCovered;j<(Math.min(queriesCovered+nbOfQueries,queries.size()-1));j++){
				threadQueries.add(queries.get(j));
			}
			System.out.println("Worker starts at "+queriesCovered+" until "+(queriesCovered+nbOfQueries));
			Worker worker = new Worker(threadQueries, models, testImages, trainImages);
			Thread t = new Thread(worker,"worker"+i);
			t.start();
			queriesCovered +=queriesPerThread;
		}
		
	}
	
	/**
	 * Selects queries out of each model.
	 * @return 
	 * @throws IOException, FileNotFoundException 
	 */
	private List<Query> createQueries() throws IOException, FileNotFoundException {
		List<Query> queries = new ArrayList<Query>();
		File testFile = new File(test);
		FileReader fr = new FileReader(testFile);
		BufferedReader br = new BufferedReader(fr);
		Random r = new Random(System.currentTimeMillis());
		boolean end = false;
		while (!end) {
			String filename = "";
			Integer i = r.nextInt(5);
			for (int j = 0; j < 5; j++) {
				String line = br.readLine();
				if (line == null) {
					end = true;
					break;
				}
				String[] splitHash = line.split("#");
				filename = splitHash[0];
				String query = line.split(" ", 2)[1];
				if (splitHash[1].startsWith(i.toString())) {
					queries.add(new Query(query.toLowerCase().trim(), filename));
				}
			}
		}
		br.close();
		return queries;
	}
	
	/**
	 *  Creates a model for each image in the dataset.
	 * @return 
	 */
	private List<Model> createModels() {
		System.out.println("Creating models...");
		List<Model> models = new ArrayList<Model>();
		FileInputStream fs;
		try {
			fs = new FileInputStream(train);
			BufferedReader br = new BufferedReader(new InputStreamReader(fs));
			String line;
			int i = 0;
			Model currentModel=null;
			while((line=br.readLine())!=null){
				String image = line.split("#")[0];
				String[] elements = line.split("	");
				String sentence = elements[1];
				if(i%5==0){
					currentModel = createModel(image,vectorsFile);
					models.add(currentModel);
				}
				currentModel.addSentence(sentence);
				i++;
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return models;
	}
	
	
	/**
	 * Returns the right model based on the model type of this solver.
	 * @param image Title of the image
	 * @param vectorsFile File containing vectors (this is optional but required for the embeddings model)
	 * @return a new Model based on the modeltype
	 */
	private Model createModel(String image,String vectorsFile){
		if(modelType==ModelType.P_TOTAL){
			return new TotalProbModel(image);
		}
		else if (modelType==ModelType.P_AGG || modelType==ModelType.P_MAX){
			return new SentenceProbModel(image,modelType);
		}
		else if (modelType==ModelType.E_TOTAL){
			return new TotalEmbedModel(image, vectorsFile);
		}
		else if(modelType==ModelType.E_AGG||modelType==ModelType.E_MAX){
			return new SentenceEmbedModel(image, vectorsFile,modelType);
		}
		else{
			return new TotalProbModel(image);
		}
	}
	
	/**
	 * 'Trains' the models i.e. generates the probabilities for the unigram models or prepares the vectors for an embeddings model.
	 * @param models 
	 */
	private void prepareModels(List<Model> models) {
		double i = 1;
		for(Model m:models){
			if(i%10==0){
				System.out.println("Creating models progress:"+100*(i/(models.size()))+"%");
			}
			i++;
			m.generateValues();
		}
	}

	
}
