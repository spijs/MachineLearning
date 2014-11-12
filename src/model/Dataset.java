
package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author bram
 */
public class Dataset {
	private final List<Walk> walks;
	private final Map<Walk, List<Feature>> features;

	public Dataset(List<Walk> walks) {
		this.walks = walks;
		this.features = new HashMap<>();
	}

	public int getNumWalks() {
		return walks.size();
	}

	public Walk getWalk(int i) {
		return walks.get(i);
	}

	public void extractFeatures() {
		for (Walk walk : walks) {
			FeatureExtractor extractor = new FeatureExtractor(walk);
		}
	}

	public List<Feature> getFeature(int i) {
		return features.get(walks.get(i));
	}

	public List<Feature> getFeatures(Walk walk) {
		return features.get(walk);
	}
}
