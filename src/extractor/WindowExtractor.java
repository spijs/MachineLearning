package extractor;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import model.Walk;

public class WindowExtractor {

	private int windowSize; // in miliseconds
	private int averageTime;

	public WindowExtractor(int size, int averageTime) {
		this.windowSize=size;
		this.averageTime = averageTime;
	}

	/**
	 * @param walk
	 * @return
	 */
	public List<Walk> createWindows(Walk walk) {
		List<Walk> result = new ArrayList<Walk>();
		ArrayList<Double> xValues = walk.getXValues();
		ArrayList<Double> yValues = walk.getYValues();
		ArrayList<Double> zValues = walk.getZValues();
		ArrayList<BigInteger> tValues = walk.getTValues();
		int totalTime = walk.getZValues().size()*averageTime;
		int averageNbWindows = totalTime/windowSize;
		if(averageNbWindows == 0){
			System.out.println("0");
			return result;
			} // No dividing by zero
		int averageNbElementsInWindow = xValues.size()/averageNbWindows;
		int offset = (totalTime - averageNbWindows*windowSize)/(2*windowSize); // Start at which element
		List<ArrayList<Double>> splittedXValues = splitInWindows(xValues,averageNbWindows,offset,averageNbElementsInWindow);
		List<ArrayList<Double>> splittedYValues = splitInWindows(yValues,averageNbWindows,offset,averageNbElementsInWindow);
		List<ArrayList<Double>> splittedZValues = splitInWindows(zValues,averageNbWindows,offset,averageNbElementsInWindow);
		List<ArrayList<BigInteger>> splittedTValues = splitInWindows(tValues,averageNbWindows,offset,averageNbElementsInWindow);
		int i = 0;
		for(ArrayList<Double> windowXValues: splittedXValues){
			List<Double> windowYValues = splittedYValues.get(i);
			System.out.println(windowYValues.size());
			List<Double> windowZValues = splittedZValues.get(i);
			List<BigInteger> windowTValues = splittedTValues.get(i);
			Walk window = new Walk(walk.getName(),walk.getFileName(),windowTValues,windowXValues,windowYValues,windowZValues);
			result.add(window);
			i++;
		}
	
		return result;
	}

	public <T> List<ArrayList<T>> splitInWindows(ArrayList<T> values, int NbOfWindows, int offSet, int avg){
		List<ArrayList<T>> result = new ArrayList<ArrayList<T>>();
		int i = offSet;
		int j = 0;
		while(i+offSet<values.size()){
			ArrayList<T> window = (ArrayList<T>) range(values,i, i+avg-1);
			if(window==null){
				break;
			}
			result.add(window);
			i = i + avg/2;
			j++;
		}
		return result;
	}

	/**
	 * Returns the min'th until the max'ed element of the list
	 * @param list
	 * @param min
	 * @param max
	 * @return
	 */
	public static <T> ArrayList<T> range(ArrayList<T> list, int min, int max){
		ArrayList<T> newList = new ArrayList<T>();
		try{
			for (int i=min;i<=max;i++){
				newList.add(list.get(i));
			}
			return newList;
		}
		catch(IndexOutOfBoundsException e){
			return null;	
		}
	}


}
