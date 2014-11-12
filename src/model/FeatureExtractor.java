package model;

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
		Feature meanX = new Feature("meanOfX", getMeanX());
		Feature meanY = new Feature("meanOfY", getMeanY());
		Feature meanZ = new Feature("meanOfZ", getMeanZ());

		Feature standDevX = new Feature("standDevX", getStandardDeviationX()); 
		Feature standDevY = new Feature("standDevY", getStandardDeviationY());
		Feature standDevZ = new Feature("standDevZ", getStandardDeviationZ());
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
