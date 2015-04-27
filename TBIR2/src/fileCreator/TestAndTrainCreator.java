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

	public static void main(String[] args) {
		try {
			generateFile(TRAIN, TRAINVECTORS);
			generateFile(TEST, TESTVECTORS);
		} catch (IOException e) {
			System.out.println("Error occured");
			e.printStackTrace();
		}
	}

	private static void generateFile(File file, File output) throws IOException {
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
		}
		br.close();
		writer.close();
	}

}
