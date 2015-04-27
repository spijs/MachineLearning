package filterGui;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import javax.swing.JButton;
import javax.swing.JPanel;
import model.Dataset;
import model.Walk;

/**
 *
 * @author bram
 */
public class EvaluationPanel extends JPanel {
	/*
	 +---------------+
	 |     graph     |
	 |               |
	 +---------------+
	 |   |   |   |   | features
	 +---------------+
	 */

	private final Dataset dataset;
	private final Walk walk;
	private final Object toNotify;
	private boolean accepted = false;

	public EvaluationPanel(Dataset dataset, Walk walk, final Object toNotify) {
		super(new GridBagLayout());
		this.dataset = dataset;
		this.walk = walk;
		this.toNotify = toNotify;

		GridBagConstraints gbc = new GridBagConstraints(
				0, 0, // gridx gridy
				2, 1, // gridwidth gridheight
				1, 1, // weight
				GridBagConstraints.CENTER, // anchor
				GridBagConstraints.BOTH, // fill
				new Insets(5, 5, 5, 5), // insets (margin)
				5, 5);// padding

		add(new graphPanel(walk), gbc);

		gbc.gridy++;
		gbc.gridwidth = 1;
		gbc.weighty = 0;

		JButton acceptButton = new JButton("Accept");
		acceptButton.setMnemonic(KeyEvent.VK_A);
		acceptButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				synchronized (toNotify) {
					accepted = true;
					toNotify.notify();
				}
			}
		});
		add(acceptButton, gbc);

		gbc.gridx++;

		JButton rejectButton = new JButton("Reject");
		rejectButton.setMnemonic(KeyEvent.VK_R);
		rejectButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				synchronized (toNotify) {
					accepted = false;
					toNotify.notify();
				}
			}
		});
		add(rejectButton, gbc);
	}

	boolean accepted() {
		return accepted;
	}
}
