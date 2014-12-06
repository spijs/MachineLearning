package wekaImpl;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import model.Walk;
import weka.core.FastVector;

/**
 *
 * @author bram
 */
public class ClassificationResult {

	private final Walk walk;
	private final Map<String, Double> map;
	private String best;

	public ClassificationResult(Walk walk, FastVector names, double[] distribution) {
		this.walk = walk;
		this.map = new HashMap<>();

		if (names.size() != distribution.length)
			return;

		best = null;
		for (int i = 0; i < names.size(); i++) {
			String name = (String) names.elementAt(i);
			double d = distribution[i];
			map.put(name, d);

			if (best == null || distribution[i] > map.get(best)) {
				best = name;
			}
		}
	}

	public Set<String> getNames() {
		return map.keySet();
	}

	public Double resultFor(String name) {
		return map.get(name);
	}

	public Walk getWalk(){
		return walk;
	}
	public String getBest() {
		return best;
	}

	public void print() {
		System.out.println("Classification for Walk " + walk.getFileName() + ": ");
		for (Map.Entry<String, Double> entry : map.entrySet()) {
			String name = entry.getKey();
			Double d = entry.getValue();

			if (name.equals(best)) {
				System.out.println(name + "\t: *\t" + d);
			} else {
				System.out.println(name + "\t:\t" + d);
			}
		}

		System.out.println();
	}

	public double getBestConfidence() {
		return map.get(best);
	}
}
