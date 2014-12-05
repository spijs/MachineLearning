package model;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class Walk {

	final private String name;
	final private ArrayList<Point> points;
	final private String fileName;

	public Walk(String name,String fileName) {
		this.name = name;
		this.fileName=fileName;
		this.points = new ArrayList<>();
	}

	public Walk(String name, String fileName, ArrayList<Point> points) {
		this.name = name;
		this.points = points;
		this.fileName= fileName;
	}
	
	public Walk(String name, String fileName, List<BigInteger> t, List<Double> x, List<Double> y, List<Double> z){
		int i = 0;
		ArrayList<Point> newPoints = new ArrayList<Point>();
		for(Double xValue:x){
			Point p = new Point(t.get(i), xValue, y.get(i),z.get(i));
			i++;
			newPoints.add(p);
		}
		this.name=name;
		this.points=newPoints;
		this.fileName=fileName;
	}

	public String getName() {
		return name;
	}
	
	public String getFileName(){
		return fileName;
	}

	public Point getPoint(int i) {
		return points.get(i);
	}

	public int getSize() {
		return points.size();
	}

	public void addPoint(Point p) {
		points.add(p);
	}

	public ArrayList<BigInteger> getTValues() {
		ArrayList<BigInteger> returnList = new ArrayList<>();
		for (Point point : points) {
			returnList.add(point.t);
		}
		return returnList;
	}

	public ArrayList<Double> getXValues() {
		ArrayList<Double> returnList = new ArrayList<>();
		for (Point point : points) {
			returnList.add(point.x);
		}
		return returnList;
	}

	public ArrayList<Double> getYValues() {
		ArrayList<Double> returnList = new ArrayList<>();
		for (Point point : points) {
			returnList.add(point.y);
		}
		return returnList;
	}

	public ArrayList<Double> getZValues() {
		ArrayList<Double> returnList = new ArrayList<>();
		for (Point point : points) {
			returnList.add(point.z);
		}
		return returnList;
	}

}
