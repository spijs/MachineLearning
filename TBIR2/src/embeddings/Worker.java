package embeddings;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

/**
 * @author Thijs D.
 *
 * This class represents a worker thread responsible for processing analogy queries and finding the closest word.
 */
public class Worker{
	/**
	 * Returns the wordvector for the given word.
	 * @param word
	 * @return
	 * @throws Exception
	 */
	public static Vector getVector(String word, String file) throws Exception{
		FileInputStream fs;
		fs = new FileInputStream(file);
		BufferedReader br = new BufferedReader(new InputStreamReader(fs));
		String line;
		while((line=br.readLine())!=null){
			String[] elements = line.split(" ");
			if(elements[0].equalsIgnoreCase(word)){
				br.close();
				return new Vector(line, 1);
			}
		}
		br.close();
		throw new IllegalArgumentException("given word '"+word+"' does not exist in vocabulary");		
	}

}
