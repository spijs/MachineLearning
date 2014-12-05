
package boxplotGui;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import model.Dataset;
import model.Feature;
import model.Walk;

/**
 *
 * @author bram
 */
public class BoxplotGui {
	private final Dataset dataset;

	public static Dataset filterDataset(Dataset dataset) {
		BoxplotGui boxplotGui = new BoxplotGui(dataset);
		return boxplotGui.run();
	}
	

	public BoxplotGui(Dataset dataset) {
		this.dataset = dataset;

	}

	private synchronized Dataset run() {
		if (dataset.numWalks() == 0)
			return dataset;

		Set<String> featureNames = dataset.getFeatures(0).keySet();

		JFrame frame = new JFrame("Select filtering features");

		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				synchronized (BoxplotGui.this) {
					BoxplotGui.this.notify();
				}
			}
		});

		List<String> numericalFeatures = new ArrayList<>();
		for (String name : dataset.getFeatures(0).keySet()) {
			if (dataset.getFeatures(0).get(name).type == Feature.Type.DOUBLE) {
				numericalFeatures.add(name);
			}
		}

		Collections.sort(numericalFeatures);

		int cols = (int) Math.ceil(Math.sqrt(numericalFeatures.size()));
		int rows = (int) Math.ceil(numericalFeatures.size() / cols);

		JPanel mainPanel = new JPanel(new GridBagLayout());
		frame.setContentPane(mainPanel);

		JPanel boxPlotPanel = new JPanel(new GridLayout(rows, cols, 10, 10));

		Set<FeaturePanel> panels = new HashSet();
		for (String feature : numericalFeatures) {
			FeaturePanel panel = new FeaturePanel(dataset, feature);
			panels.add(panel);
			boxPlotPanel.add(panel);
		}

		JButton acceptButton = new JButton("Filter Walks");
		acceptButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				synchronized (BoxplotGui.this) {
					BoxplotGui.this.notify();
				}
			}
		});

		GridBagConstraints gbc = new GridBagConstraints(
				0, 0, // gridx gridy
				2, 1, // gridwidth gridheight
				1, 0, // weight
				GridBagConstraints.WEST, // anchor
				GridBagConstraints.BOTH, // fill
				new Insets(5, 5, 5, 5), // insets (margin)
				5, 5);// padding

		mainPanel.add(
				new JLabel("Select the features that distinguish valid from invalid walks. The invalid walks will be removed from the dataset."),
				gbc
		);

		gbc.gridy++;
		gbc.weighty = 1;

		mainPanel.add(
				boxPlotPanel,
				gbc
		);

		gbc.gridy++;
		gbc.gridwidth = 1;

		mainPanel.add(acceptButton, gbc);

		gbc.gridx++;

		frame.pack();
		frame.setVisible(true);

		synchronized (this) {
			try {
				wait();
			} catch (InterruptedException ex) {
			}
		}

		frame.setVisible(false);

		Set<Walk> filteredWalks = new HashSet();

		for (FeaturePanel featurePanel : panels) 
			filteredWalks.addAll(featurePanel.getFilteredWalks());

		for (Walk walk : filteredWalks)
			dataset.removeWalk(walk);

		return dataset;
	}
}
