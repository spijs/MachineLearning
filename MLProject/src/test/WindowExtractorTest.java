package test;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import model.Feature;
import model.Walk;

import org.junit.Before;
import org.junit.Test;

import parser.DataParser;
import extractor.FeatureExtractor;
import extractor.WindowExtractor;

public class WindowExtractorTest {

	private ArrayList<Walk> walks;
	private Walk testWalk;
	private FeatureExtractor fe;
	private Map<String,Feature> features;

	@Before
	public void setUp() throws Exception {
		this.walks = DataParser.parseFiles("junitTest");
		this.testWalk = walks.get(0); //Wannes 58
	}
	@Test
	public void testSplitWindows() {
		int numbersInList = 25;
		int NbOfWindows =5;
		int offset = 2;
		int avg = 4;
		ArrayList<Double> beginList = new ArrayList<Double>();
		for(int i=0;i<numbersInList;i++){
			beginList.add(i*1.0);
		}
		WindowExtractor we = new WindowExtractor(0,0);

		List<ArrayList<Double>> resultList = we.splitInWindows(beginList, NbOfWindows, offset, avg);

		for(ArrayList<Double> sublist: resultList){
			assertEquals(avg,sublist.size());
		}
		
		List<Double>resultList1 = resultList.get(0);
		assertEquals((double)2,(Double)resultList1.get(0),0.001);
		assertEquals((double)3,(Double)resultList1.get(1),0.001);
		assertEquals((double)4,(Double)resultList1.get(2),0.001);
		assertEquals((double)5,(Double)resultList1.get(3),0.001);
		
		List<Double>resultList2 = resultList.get(1);
		assertEquals((double)4,(Double)resultList2.get(0),0.001);
		assertEquals((double)5,(Double)resultList2.get(1),0.001);

	}

	/*	public <T> List<ArrayList<T>> splitInWindows(ArrayList<T> values, int NbOfWindows, int timeOffSet, int avg){
		List<ArrayList<T>> result = new ArrayList<ArrayList<T>>();
		int i = timeOffSet;
		while(i+timeOffSet<values.size()){
			ArrayList<T> window = (ArrayList<T>) values.subList(i, i+avg-1);
			result.add(window);
			i = i + windowSize/2;
		}
		return result;
	}*/

	@Test
	public void testRange(){
		int numbersInList=20;
		ArrayList<Integer> beginList = new ArrayList<Integer>();
		for(int i=0;i<numbersInList;i++){
			beginList.add(i);
		}

		List<Integer> result = WindowExtractor.range(beginList,5,7);
		assertTrue(5==result.get(0));
		assertTrue(6==result.get(1));
		assertTrue(7==result.get(2));
	}
}
