
package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import extractor.FeatureExtractor;

/**
 *
 * @author bram
 */
public class Dataset {
	private final List<Walk> walks;
	private final Map<Walk, Map<String, Feature>> features;

	public Dataset(List<Walk> walks) {
		this.walks = walks;
		this.features = new HashMap<>();
	}

	public int numWalks() {
		return walks.size();
	}

	public Walk getWalk(int i) {
		return walks.get(i);
	}

	public void removeWalk(Walk walk) {
		walks.remove(walk);
		features.remove(walk);
	}

	public void extractFeatures() {
		for (Walk walk : walks) {
			if (!features.containsKey(walk)) {
				FeatureExtractor extractor = new FeatureExtractor(walk);
				features.put(walk, extractor.extractFeatures());
			}
		}
	}

	public void setFeature(Walk walk, String name, Feature feature) {
		if (!features.containsKey(walk)) {
			features.put(walk, new HashMap());
		}
		features.get(walk).put(name, feature);
	}

	public Map<String, Feature> getFeatures(int i) {
		return features.get(walks.get(i));
	}

	public Map<String, Feature> getFeatures(Walk walk) {
		return features.get(walk);
	}

	public Dataset clone() {
		return new Dataset(walks);
	}
}
