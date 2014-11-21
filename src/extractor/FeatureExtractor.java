package extractor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Feature;
import model.Feature.Type;
import model.Walk;

public class FeatureExtractor {

	private Walk walk;
	private Map<String, Feature> features;
	private static Map<String, Type> availableFeatures;

	public FeatureExtractor(Walk walk){
		this.walk = walk;
		features = new HashMap<String,Feature>();
		availableFeatures = new HashMap<String,Feature.Type>();
	}

	public static Map<String, Feature.Type> getFeatures() {
		return availableFeatures;
	}
	
	public void addFeature(String featureName,Feature.Type type){
		availableFeatures.put(featureName+"X",type);
		availableFeatures.put(featureName+"Y",type);
		availableFeatures.put(featureName+"Z",type);
	}

	public Map<String,Feature> extractFeatures(){
		extractMeans();
		extractStandardDeviations();
		extractMedians();
		extractFirstPercentiles();
		extractThirdPercentiles();
		extractFFT();
		return features;
	}


	private void extractStandardDeviations() {
		Feature.Type type = Feature.Type.DOUBLE;
		String name = "standDev";
		addFeature(name, type);
		features.put(name+"X",new Feature(getStandardDeviation(walk.getXValues()),type));
		features.put(name+"Y",new Feature(getStandardDeviation(walk.getYValues()),type));
		features.put(name+"Z",new Feature(getStandardDeviation(walk.getZValues()),type));
	}

	private void extractMeans() {
		Feature.Type type = Feature.Type.DOUBLE;
		String name = "mean";
		addFeature(name, type);
		features.put(name+"X",new Feature(mean(walk.getXValues()),type));
		features.put(name+"Y",new Feature(mean(walk.getYValues()),type));
		features.put(name+"Z",new Feature(mean(walk.getZValues()),type));
	}

	private void extractMedians(){
		Feature.Type type = Feature.Type.DOUBLE;
		String name = "median";
		addFeature(name, type);
		features.put(name+"X",new Feature(getPercentile(walk.getXValues(),0.5),type));
		features.put(name+"Y",new Feature(getPercentile(walk.getYValues(),0.5),type));
		features.put(name+"Z",new Feature(getPercentile(walk.getZValues(),0.5),type));
	}
	
	
	private void extractFirstPercentiles(){
		Feature.Type type = Feature.Type.DOUBLE;
		String name = "firstPercentile";
		addFeature(name, type);
		features.put(name+"X",new Feature(getPercentile(walk.getXValues(),0.25),type));
		features.put(name+"Y",new Feature(getPercentile(walk.getYValues(),0.25),type));
		features.put(name+"Z",new Feature(getPercentile(walk.getZValues(),0.25),type));
	}
	
	private void extractThirdPercentiles(){
		Feature.Type type = Feature.Type.DOUBLE;
		String name = "thirdPercentile";
		addFeature(name, type);
		features.put(name+"X",new Feature(getPercentile(walk.getXValues(),0.75),type));
		features.put(name+"Y",new Feature(getPercentile(walk.getYValues(),0.75),type));
		features.put(name+"Z",new Feature(getPercentile(walk.getZValues(),0.75),type));
	}
	
	private void extractFFT(){
		extractFFT("X",walk.getXValues());
		extractFFT("Y",walk.getYValues());
		extractFFT("Z",walk.getZValues());
	}
	
	private void extractFFT(String direction, List<Double> values){
		Feature.Type type = Feature.Type.DOUBLE;
		int n=5;
		double[] fftValues = getFirstNComponents(fft(values), n);
		for (int i=0;i<n;i++){
			String name = "FFT"+i;
			addFeature(name, type);
			features.put(name+direction, new Feature(fftValues[i],type));
		}
	}
	
	
	public double[] fft(List<Double> values)
	{
		int size = 2; //TODO fixen
		while (size * 2 < values.size())
			size *= 2;
		  FFT fft = new FFT(size); 

		  double[] window = fft.getWindow();
		  double re[] = new double[size];
		  double im[] = new double[size];
		  for(int i=0; i<size; i++){
			  re[i] = values.get(i);
			  im[i] = 0;
		  }
		    
		 double [] result =  fft.fft(re, im);
		 Arrays.sort(result);
		 return result;
	}
	
	public double[] getFirstNComponents (double[] elements, int n){
		double[] result = new double[n];
		for (int i =0; i<n; i++){
			result[i]=(elements[i]);
		}
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
