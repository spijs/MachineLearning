package model;

import java.util.ArrayList;
import java.util.List;

public class FeatureExtractor {

	private Walk walk;

	public FeatureExtractor(Walk walk){
		this.walk = walk;
	}

	public List<String> getFeatures(){
		return null;
	}

	public List<Feature> extractFeatures(){
		// Mean and SD
		ArrayList<Feature> features = new ArrayList<Feature>();
		features.add(new Feature("meanOfX", getMeanX()));
		features.add(new Feature("meanOfY", getMeanY()));
		features.add(new Feature("meanOfZ", getMeanZ()));

		features.add(new Feature("standDevX", getStandardDeviationX())); 
		features.add(new Feature("standDevY", getStandardDeviationY()));
		features.add(new Feature("standDevZ", getStandardDeviationZ()));
		
		return features;
		
	}

	private double getStandardDeviation(List<Double> values){

		int sum = 0;
		double mean = mean(values);

		for (double i : values)
			sum += Math.pow((i - mean), 2);
		return Math.sqrt( sum / ( values.size() - 1 ) ); // sample

	}

	public double sum (List<Double> a){
		if (a.size() > 0) {
			int sum = 0;

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
