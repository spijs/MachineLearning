package logger;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;


/**
 * @author Thijs
 * 
 * Class responsible for writing generated output to a file.
 *
 */
public class Logger {

	private static Logger instance = null;
	private static BufferedWriter writer;
	private int threadsOpen;

	/**
	 * Constructor for the Logger of an analogy problem.
	 * @param analogy The chosen analogy method e.g. direction,addition,multiplication
	 * @param dataset The vectorset that is used.
	 * @param nbOfQueries The number of queries each thread should solve.
	 * @param nbOfThreads The number of threads used to solve the problem.
	 * @throws IOException Thrown when an error occurs opening or writing the outputfile.
	 */
	public Logger(String vectors, String method, int nbOfQueries, int nbOfThreads) throws IOException{
		String[] fileParts = vectors.split("/");
		String fileN = fileParts[fileParts.length-1];
		String fileName = ("results/results_images_"+method+"_"+fileN.substring(0, fileN.lastIndexOf('.'))+"_queries"+nbOfQueries+".txt");
		File file = new File(fileName);
		file.delete();
		this.writer = new BufferedWriter(new FileWriter(fileName, true));
		this.threadsOpen=nbOfThreads;
		this.log("################################################\nResults for method "+method+" for "+nbOfQueries+" queries on dataset "
		+fileN.substring(0, fileN.lastIndexOf('.'))+"\n##################################\n");
	}
	
	/**
		/**
	 * Returns an instance of the Logger based on the given parameters. 
	 * @param analogy The chosen analogy method e.g. direction,addition,multiplication
	 * @param dataset The vectorset that is used.
	 * @param nbOfQueries The number of queries each thread should solve.
	 * @param nbOfThreads The number of threads used to solve the problem.
	 */
	public static Logger getInstance(String vectors, String method,int nbOfQueries,int nbOfThreads) {
		if(instance == null) {
			try {
				instance = new Logger(vectors,method,nbOfQueries,nbOfThreads);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return instance;
	}
	
	/**
	 * @return this instance of Logger.
	 */
	public static Logger getInstance(){
		return instance;
	}

	/** 
	 * Writes the given string to the output file.
	 * @param text
	 */
	public void log(String text){
		try {
			writer.append(text+"\n");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Closes the writer if all threads are finished.
	 */
	public void close() {
		threadsOpen--;
		if(threadsOpen==0){
			try {
				writer.append("\n\n");
				writer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}		

		}
	}

}
