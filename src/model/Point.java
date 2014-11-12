package model;

import java.math.BigInteger;

/**
 *
 * @author bram
 */
public class Point {

	public BigInteger t;
	public double x;
	public double y;
	public double z;

	public Point(BigInteger t, double x, double y, double z) {
		this.t = t;
		this.x = x;
		this.y = y;
		this.z = z;
	}

}
