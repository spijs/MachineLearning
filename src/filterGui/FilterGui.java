package filterGui;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import model.Dataset;
import model.Walk;

/**
 *
 * @author bram
 */
public class FilterGui {

	public static Dataset filterDataset(Dataset dataset) {
		FilterGui filterGui = new FilterGui(dataset);
		return filterGui.run();
	}

	private Dataset dataset;
	private JFrame frame;

	public FilterGui(Dataset dataset) {
		this.dataset = dataset;
		frame = new JFrame();

		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}

	private synchronized Dataset run() {
		List<Walk> acceptedWalks = new ArrayList<>();
		for (int i = 0; i < 10; i++) { //TODO 10 -> dataset.numWalks()
			Walk walk = dataset.getWalk(i);
			EvaluationPanel ep = new EvaluationPanel(dataset, walk, this);
			try {
				frame.getContentPane().removeAll();
				frame.getContentPane().add(ep);
				frame.setTitle("Evaluating walk " + (i + 1) + " of " + dataset.numWalks());

				frame.setSize(800, 600);
				frame.setVisible(true);
				wait();
			} catch (InterruptedException ex) {
			}
			if (ep.accepted()) {
				acceptedWalks.add(walk);
			}
		}

		frame.setVisible(false);
		return new Dataset(acceptedWalks);
	}
}
