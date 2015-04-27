
package filterGui;

import java.awt.Color;
import java.awt.Graphics;
import javax.swing.JPanel;
import model.Point;
import model.Walk;

/**
 *
 * @author bram
 */
class graphPanel extends JPanel {

	private final Walk walk;
	private final int numPoints;
	private double minX, minY, minZ;
	private double maxX, maxY, maxZ;

	public graphPanel(Walk walk) {
		super();
		this.walk = walk;
		this.numPoints = walk.getSize();

		if (numPoints == 0)
			return;

		maxX = minX = walk.getPoint(0).x;
		maxY = minY = walk.getPoint(0).y;
		maxZ = minZ = walk.getPoint(0).z;

		for (int i = 1; i < walk.getSize(); i++) {
			Point p = walk.getPoint(i);
			if (maxX < p.x)
				maxX = p.x;
			if (maxY < p.y)
				maxY = p.y;
			if (maxZ < p.z)
				maxZ = p.z;

			if (minX > p.x)
				minX = p.x;
			if (minY > p.y)
				minY = p.y;
			if (minZ > p.z)
				minZ = p.z;
		}
	}

	@Override
	protected void paintComponent(Graphics g) {
		int width = getWidth();
		int height = getHeight();

		g.setColor(Color.white);
		g.fillRect(0, 0, width, height);

		{
			g.setColor(Color.red);
			g.drawString("Min x: " + minX, 0, height - 32);
			g.drawString("Max x: " + maxX, 0, 16);

			g.setColor(Color.blue);
			g.drawString("Min y: " + minY, 0, height - 16);
			g.drawString("Max y: " + maxY, 0, 32);

			g.setColor(Color.green);
			g.drawString("Min z: " + minZ, 0, height);
			g.drawString("Max z: " + maxZ, 0, 48);
		}

		for (int i = 1; i < numPoints; i++) {
			Point p1 = walk.getPoint(i - 1);
			Point p2 = walk.getPoint(i);

			int x1 = (int) (width * (i - 1)) / numPoints;
			int x2 = (int) (width * i) / numPoints;

			//x
			g.setColor(Color.red);
			g.drawLine(
					x1, height - (int) (height * (p1.x - minX) / (maxX - minX)),
					x2, height - (int) (height * (p2.x - minX) / (maxX - minX)));

			//y
			g.setColor(Color.blue);
			g.drawLine(
					x1, height - (int) (height * (p1.y - minY) / (maxY - minY)),
					x2, height - (int) (height * (p2.y - minY) / (maxY - minY)));

			//z
			g.setColor(Color.green);
			g.drawLine(
					x1, height - (int) (height * (p1.z - minZ) / (maxZ - minZ)),
					x2, height - (int) (height * (p2.z - minZ) / (maxZ - minZ)));
		}
	}
}
