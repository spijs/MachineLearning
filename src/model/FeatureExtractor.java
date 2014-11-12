package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		features.put("standDevZ",new Feature( getStandardDeviationZ(),Feature.Type.DOUBLE));
		
		return features;
		
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

	private Object getMeanX() {
		return mean(walk.getXValues());
	}




}
