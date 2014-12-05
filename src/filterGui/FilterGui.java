package filterGui;

import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.JFrame;
import model.Dataset;
import model.Feature;
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

	private final Dataset dataset;
	private final JFrame frame;
	private boolean exit = false;

	public FilterGui(Dataset dataset) {
		this.dataset = dataset;
		frame = new JFrame();

		frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				exit = true;
				synchronized (FilterGui.this) {
					FilterGui.this.notify();
				}
			}
		});
	}

	private synchronized Dataset run() {
		int i;
		for (i = 0; i < dataset.numWalks(); i++) { //TODO 10 -> dataset.numWalks()
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

			if (exit) {
				break;
			}

			if (ep.accepted()) {
				dataset.setFeature(walk, "filter", new Feature("accepted", Feature.Type.NOMINAL));
			} else {
				dataset.setFeature(walk, "filter", new Feature("rejected", Feature.Type.NOMINAL));
			}
		}

		for (i = i; i < dataset.numWalks(); i++) {
			Walk walk = dataset.getWalk(i);
			dataset.setFeature(walk, "filter", new Feature("unfiltered", Feature.Type.NOMINAL));
		}

		frame.setVisible(false);
		return dataset;
	}
}
