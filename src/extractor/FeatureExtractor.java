package extractor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Feature;
import model.Walk;
import model.Feature.Type;

public class FeatureExtractor {

	private Walk walk;
	private Map<String, Feature> features;

	public FeatureExtractor(Walk walk){
		this.walk = walk;
		features = new HashMap<String,Feature>();
	}

	public static Map<String, Feature.Type> getFeatures() {
		Map<String, Feature.Type> returnMap = new HashMap<>();
		//Mean and SD
		returnMap.put("meanOfX",Feature.Type.DOUBLE);
		returnMap.put("meanOfY",Feature.Type.DOUBLE);
		returnMap.put("meanOfZ",Feature.Type.DOUBLE);
		returnMap.put("standDevX",Feature.Type.DOUBLE);
		returnMap.put("standDevY",Feature.Type.DOUBLE);
		returnMap.put("standDevZ",Feature.Type.DOUBLE);
		//Percentiles
		returnMap.put("medianX",Feature.Type.DOUBLE);
		returnMap.put("medianY",Feature.Type.DOUBLE);
		returnMap.put("medianZ",Feature.Type.DOUBLE);
		returnMap.put("firstPercentileX",Feature.Type.DOUBLE);
		returnMap.put("firstPercentileY",Feature.Type.DOUBLE);
		returnMap.put("firstPercentileZ",Feature.Type.DOUBLE);
		returnMap.put("thirdPercentileX",Feature.Type.DOUBLE);
		returnMap.put("thirdPercentileY",Feature.Type.DOUBLE);
		returnMap.put("thirdPercentileZ",Feature.Type.DOUBLE);
		
		return returnMap;
	}

	public Map<String,Feature> extractFeatures(){
		extractMeans();
		extractStandardDeviations();
		extractMedians();
		extractFirstPercentiles();
		extractThirdPercentiles();		
		return features;
	}


	private void extractStandardDeviations() {
		features.put("standDevX",new Feature(getStandardDeviation(walk.getXValues()),Feature.Type.DOUBLE));
		features.put("standDevY",new Feature(getStandardDeviation(walk.getYValues()),Feature.Type.DOUBLE));
		features.put("standDevZ",new Feature(getStandardDeviation(walk.getZValues()),Feature.Type.DOUBLE));
	}

	private void extractMeans() {
		features.put("meanOfX",new Feature(mean(walk.getXValues()),Feature.Type.DOUBLE));
		features.put("meanOfY",new Feature(mean(walk.getYValues()),Feature.Type.DOUBLE));
		features.put("meanOfZ",new Feature(mean(walk.getZValues()),Feature.Type.DOUBLE));
	}

	private void extractMedians(){
		features.put("medianX",new Feature(getPercentile(walk.getXValues(),0.5),Feature.Type.DOUBLE));
		features.put("medianY",new Feature(getPercentile(walk.getYValues(),0.5),Feature.Type.DOUBLE));
		features.put("medianZ",new Feature(getPercentile(walk.getZValues(),0.5),Feature.Type.DOUBLE));
	}
	
	
	private void extractFirstPercentiles(){
		features.put("firstPercentileX",new Feature(getPercentile(walk.getXValues(),0.25),Feature.Type.DOUBLE));
		features.put("firstPercentileY",new Feature(getPercentile(walk.getYValues(),0.25),Feature.Type.DOUBLE));
		features.put("firstPercentileZ",new Feature(getPercentile(walk.getZValues(),0.25),Feature.Type.DOUBLE));
	}
	
	private void extractThirdPercentiles(){
		features.put("thirdPercentileX",new Feature(getPercentile(walk.getXValues(),0.75),Feature.Type.DOUBLE));
		features.put("thirdPercentileY",new Feature(getPercentile(walk.getYValues(),0.75),Feature.Type.DOUBLE));
		features.put("thirdPercentileZ",new Feature(getPercentile(walk.getZValues(),0.75),Feature.Type.DOUBLE));
	}
	
	
	private void extractFFT(){
		
	}
	
	public double[] fftX() //TODO slechts de 5 grootste waarden teruggeven. + terug private zetten
	{
		  int size = 128; //TODO fixen
		  FFT fft = new FFT(size); 

		  double[] window = fft.getWindow();
		  double re[] = new double[size];
		  double im[] = new double[size];
		  for(int i=0; i<size; i++){
			  re[i] = walk.getXValues().get(i);
			  im[i] = 0;
		  }
		    
		 double [] result =  fft.fft(re, im);
		 return result;
	}
	/**
	 * @param a
	 * @param percentile : bvb 0.25 of 0.75
	 * @return
	 */
	public double getPercentile(List<Double> a, double percentile){
		int middle = (int) (a.size()*percentile);
		if (a.size() % 2 == 1) {
			return a.get(middle);
		} else {
			return (a.get(middle-1) + a.get(middle)) / 2.0;
		}
	}
	private double getStandardDeviation(List<Double> values){
		
		double sum = 0.0;
		double mean = mean(values);
		
		for (double i : values)
			sum += Math.pow((i - mean), 2);
		return Math.sqrt( sum / ( values.size() - 1 ) ); // sample
		
	}
	
	public double sum (List<Double> a){
		if (a.size() > 0) {
			double sum = 0;
			
			for (double i : a) {
				sum += i;
			}
			return sum;
		}
		return 0;
	}
	
	public double mean (List<Double> a){
		double sum = sum(a);
		double mean = 0;
		mean = sum / (a.size() * 1.0);
		return mean;
	}
}
