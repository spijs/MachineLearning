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
 * @author Thijs D & Wout V
 * 
 * This class is responsible for creating models and queries out of the given file and starting workers that will
 * check how the chosen models perform.
 */
public class Solver {
	
	private final static String train = "files/trainToken.txt";
	private ModelType modelType;
	private String vectorsFile;
	private int nbOfThreads=1;
	private int nbOfQueries=0;
	private String trainImageVectors;
	private String testImageVectors;
	private final static String test = "files/testToken.txt";

	/**
	 * Creates a solver based on a map containing options.
	 * @param options
	 * @throws IOException
	 */
	public Solver(Map<String, String> options){
		setOptions(options);
	}
	
	/**
	 * Creates models for each trainimage, creates queries for the test, prepares the models
	 * and finally solves the image retrieval task.
	 * 
	 * @throws IOException
	 */
	public void solve() throws IOException{
		Logger.getInstance(vectorsFile,modelType.toString(),nbOfQueries,nbOfThreads);
		Map<String,Vector> wordVectors = createWordVectors();
		List<Model>models = createModels(wordVectors);
		List<Query>queries = createQueries();
		Map<String,Vector>testImages = createTestImages();
		Map<String,Vector>trainImages = createTrainImages();
		prepareModels(models);
		solve(queries,models,trainImages, testImages);		
	}


	/**
	 * creates the image vectors based on the right file.
	 * @return a mapping between each image name and their vector.
	 * 
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	private Map<String, Vector> createTrainImages() throws FileNotFoundException, IOException {
		return createImages("files/Flickr_8k.trainImages.txt",trainImageVectors);
	}

	/**
	 * creates the image vectors based on the right file.
	 * @return a mapping between each image name and their vector.
	 * 
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	private Map<String, Vector> createTestImages() throws FileNotFoundException, IOException {
		return createImages("files/Flickr_8k.testImages.txt",testImageVectors);
	}

	/**
	 * Creates a mapping between the image names and its vector.
	 * @param names - file containing the image names.
	 * @param vectors - file containing the corresponding image vectors.
	 * @return - the mapping between the names and the vectors
	 * @throws IOException
	 */
	private Map<String,Vector> createImages(String names, String vectors) throws IOException{
		Map<String, Vector> images = new HashMap<String, Vector>();
		File namesF = new File(names);
		FileReader namesFReader = new FileReader(namesF);
		BufferedReader namesReader = new BufferedReader(namesFReader);
		File vectorsF = new File(vectors);
		FileReader vectorFReader = new FileReader(vectorsF);
		BufferedReader vectorReader = new BufferedReader(vectorFReader);
		while(true) {
			String name = namesReader.readLine();
			String vectorString = vectorReader.readLine();
			if(name == null || vectorString == null) {break;}
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
		
		if(options.containsKey("trainImageVectors")){
			this.trainImageVectors=options.get("trainImageVectors");
		}
		
		if(options.containsKey("testImageVectors")){
			this.testImageVectors=options.get("testImageVectors");
		}
		
		
	}
	

	/**
	 * Creates different threads that will each take on a subset of the queries.
	 * @param queries The list of queries that need to be solved.
	 * @param models The list of models for the training images.
	 * @param trainImages The mapping between name and image vector for the training images.
	 * @param testImages The mapping between name and image vector for the test images.
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
	 * Creates a query for each image in the test set.
	 * @return the list of queries that need to be solved from the test set.
	 * @throws IOException 
	 */
	private List<Query> createQueries() throws IOException {
		List<Query> queries = new ArrayList<Query>();
		File testFile = new File(test);
		FileReader fr = new FileReader(testFile);
		BufferedReader br = new BufferedReader(fr);
		Random r = new Random(300);
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
	 *  Creates a model for each image in the training set.
	 * @param wordVectors The mapping between a word and its word vector.
	 * @return a list containing a model for each image in the training set.
	 */
	private List<Model> createModels(Map<String, Vector> wordVectors) {
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
					currentModel = createModel(image,wordVectors);
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
	 * @param wordVectors File containing vectors (this is optional but required for the embeddings model)
	 * @return a new Model based on the modeltype
	 */
	private Model createModel(String image,Map<String, Vector> wordVectors){
		if(modelType==ModelType.P_TOTAL){
			return new TotalProbModel(image);
		}
		else if (modelType==ModelType.P_AGG || modelType==ModelType.P_MAX){
			return new SentenceProbModel(image,modelType);
		}
		else if (modelType==ModelType.E_TOTAL){
			return new TotalEmbedModel(image, wordVectors);
		}
		else if(modelType==ModelType.E_AGG||modelType==ModelType.E_MAX){
			return new SentenceEmbedModel(image, wordVectors,modelType);
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

	/**
	 * Reads the file containing the word vectors and creates a mapping that can be stored in main memory.
	 * @return The mapping between each word and its word vector.
	 * @throws IOException
	 */
	public Map<String,Vector> createWordVectors() throws IOException{
		Map<String,Vector> wordVectors = new HashMap<String,Vector>();
		FileInputStream fs;
		fs = new FileInputStream(vectorsFile);
		BufferedReader br = new BufferedReader(new InputStreamReader(fs));
		String line;
		while((line=br.readLine())!=null){
			String[] elements = line.split(" ");
			String word = elements[0];
			wordVectors.put(word,new Vector(line, 1));
		}
		br.close();
		return wordVectors;
	}
	
}
