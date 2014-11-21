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

	public FeatureExtractor(Walk walk){
		this.walk = walk;
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
		returnMap.put("FirstPercentileX",Feature.Type.DOUBLE);
		returnMap.put("FirstPercentileY",Feature.Type.DOUBLE);
		returnMap.put("FirstPercentileZ",Feature.Type.DOUBLE);
		returnMap.put("ThirdPercentileX",Feature.Type.DOUBLE);
		returnMap.put("ThirdPercentileY",Feature.Type.DOUBLE);
		returnMap.put("ThirdPercentileZ",Feature.Type.DOUBLE);
		
		return returnMap;
	}

	public Map<String,Feature> extractFeatures(){
		// Mean and SD
		Map<String,Feature> features = new HashMap<String,Feature>();
		features.put("meanOfX",new Feature(getMeanX(),Feature.Type.DOUBLE));
		features.put("meanOfY",new Feature(getMeanY(),Feature.Type.DOUBLE));
		features.put("meanOfZ",new Feature(getMeanZ(),Feature.Type.DOUBLE));

		features.put("standDevX", new Feature(getStandardDeviationX(),Feature.Type.DOUBLE)); 
		features.put("standDevY", new Feature(getStandardDeviationY(),Feature.Type.DOUBLE));
		features.put("standDevZ",new Feature(getStandardDeviationZ(),Feature.Type.DOUBLE));
		
		//Percentiles
		features.put("MedianX", new Feature(getMedianX(),Feature.Type.DOUBLE)); 
		features.put("MedianY", new Feature(getMedianY(),Feature.Type.DOUBLE));
		features.put("MedianZ",new Feature(getMedianZ(),Feature.Type.DOUBLE));
		
		features.put("FirstPercentileX", new Feature(getFirstPercentileX(),Feature.Type.DOUBLE)); 
		features.put("FirstPercentileY", new Feature(getFirstPercentileY(),Feature.Type.DOUBLE));
		features.put("FirstPercentileZ", new Feature(getFirstPercentileZ(), Feature.Type.DOUBLE));
		
		features.put("ThirdPercentileX", new Feature(getThirdPercentileX(),Feature.Type.DOUBLE)); 
		features.put("ThirdPercentileY", new Feature(getThirdPercentileY(),Feature.Type.DOUBLE));
		features.put("ThirdPercentileZ", new Feature(getThirdPercentileZ(), Feature.Type.DOUBLE));
		
		return features;
		
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

	private double getStandardDeviationZ() {
		return getStandardDeviation(walk.getZValues());
	}

	private double getStandardDeviationY() {
		return getStandardDeviation(walk.getYValues());
	}

	private double getStandardDeviationX() {
		return getStandardDeviation(walk.getXValues());
	}

	private double getMeanZ() {
		return mean(walk.getZValues());
	}

	private double getMeanY() {
		return mean(walk.getYValues());
	}

	private double getMeanX() {
		return mean(walk.getXValues());
	}

	private double getMedianX(){
		return getPercentile(walk.getXValues(),0.5);
	}
	
	private double getMedianY(){
		return getPercentile(walk.getYValues(),0.5);
	}

	private double getMedianZ(){
		return getPercentile(walk.getZValues(),0.5);
	}
	
	private double getFirstPercentileX(){
		return getPercentile(walk.getXValues(),0.25);
	}
	
	private double getFirstPercentileY(){
		return getPercentile(walk.getYValues(),0.25);
	}

	private double getFirstPercentileZ(){
		return getPercentile(walk.getZValues(),0.25);
	}
	
	private double getThirdPercentileX(){
		return getPercentile(walk.getXValues(),0.75);
	}
	
	private double getThirdPercentileY(){
		return getPercentile(walk.getYValues(),0.75);
	}

	private double getThirdPercentileZ(){
		return getPercentile(walk.getZValues(),0.75);
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
}
