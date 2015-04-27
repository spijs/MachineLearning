
package boxplotGui;

import extractor.FeatureExtractor;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.swing.BoxLayout;
import javax.swing.JCheckBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import model.Dataset;
import model.Walk;

/**
 *
 * @author bram
 */
public class FeaturePanel extends JPanel {
	private final Dataset dataset;
	private final String featureName;

	private final List<Double> values;
	private final double min, first, median, third, max;

	private final JCheckBox checkbox;

	public FeaturePanel(Dataset dataset, String featureName) {
		super();
		this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
		this.dataset = dataset;
		this.featureName = featureName;

		this.values = new ArrayList<>(dataset.numWalks());
		for (int i = 0; i < dataset.numWalks(); i++)
			values.add((Double) dataset.getFeatures(i).get(featureName).value);

		Collections.sort(values);

		first = FeatureExtractor.getPercentile(values, 0.25);
		median = FeatureExtractor.getPercentile(values, 0.50);
		third = FeatureExtractor.getPercentile(values, 0.75);

		min = first - 1.5 * (third - first);
		max = third + 1.5 * (third - first);

		int outsideBoxPlot = 0;

		for (Double value : values) {
			if (value < min || value > max) {
				outsideBoxPlot++;
			}
		}

		add(new JLabel(featureName));
		add(new JLabel("Inside boxPlot: " + (dataset.numWalks() - outsideBoxPlot)));
		add(new JLabel("Outside boxPlot: " + outsideBoxPlot));

		this.checkbox = new JCheckBox("Filter walks outside boxplot");
		add(this.checkbox);
	}

	/**
	 * @return a set with the walks that need to be filtered away. Returns an
	 * empty set id the filter is not applied.
	 */
	public Set<Walk> getFilteredWalks() {
		if (!checkbox.isSelected())
			return new HashSet<Walk>();

		Set<Walk> filteredWalks = new HashSet<>();

		for (int i = 0; i < dataset.numWalks(); i++) {
			double value = (double) dataset.getFeatures(i).get(featureName).value;
			if (value < min || value > max) {
				filteredWalks.add(dataset.getWalk(i));
			}
		}
		return filteredWalks;
	}
}
