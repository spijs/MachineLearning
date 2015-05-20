package fileCreator;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;

public class TestAndTrainCreator {

	public final static File TESTVECTORS = new File(
			"files//testImageVectors.txt");
	public final static File TRAINVECTORS = new File(
			"files//trainImageVectors.txt");
	private static String fileName = "files//imageOrder.txt";
	private static String images = "files//feats.txt";
	public final static File TRAIN = new File(
			"files//Flickr_8k.trainImages.txt");
	public final static File TEST = new File("files//Flickr_8k.testImages.txt");
	private static File order = new File(fileName);
	private static File imageFile = new File(images);
	private static BufferedWriter writer;

	/**
	 * Running this code turns the big image vector file 'feats.txt' into two separate files for
	 * train and test.
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			generateFile(TRAIN, TRAINVECTORS);
			generateFile(TEST, TESTVECTORS);
		} catch (IOException e) {
			System.out.println("Error occured");
			e.printStackTrace();
		}
	}

	/**
	 * Takes the feats.txt and selects the vectors that correspond to images in the given file. 
	 * 
	 * @param file - The file containing all the image names that need to be selected
	 * @param output - The file to which the results need to be written
	 * @throws IOException
	 */
	private static void generateFile(File file, File output) throws IOException {
		int i = 0;
		BufferedReader br = new BufferedReader(new InputStreamReader(
				new FileInputStream(file)));
		output.delete();
		writer = new BufferedWriter(new FileWriter(output, true));
		String line;
		while ((line = br.readLine()) != null) {
			FileInputStream fs = new FileInputStream(order);
			FileInputStream fsv = new FileInputStream(imageFile);
			BufferedReader orderReader = new BufferedReader(
					new InputStreamReader(fs));
			BufferedReader vectorReader = new BufferedReader(
					new InputStreamReader(fsv));
			String nextLine;
			String nextVector;
			while ((nextLine = orderReader.readLine()) != null
					&& (nextVector = vectorReader.readLine()) != null) {
				if (nextLine.equalsIgnoreCase(line)) {
					writer.write(nextVector);
					writer.write("\n");
					break;
				}
			}
			orderReader.close();
			vectorReader.close();
			System.out.println("Progress "+(100.0*i/5000));
			i++;
		}
		br.close();
		writer.close();
	}

}
