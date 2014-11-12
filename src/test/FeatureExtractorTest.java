package test;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;

import model.Feature;
import model.Walk;

import org.junit.Before;
import org.junit.Test;

import extractor.FeatureExtractor;

import parser.DataParser;

public class FeatureExtractorTest {

	private ArrayList<Walk> walks;
	private Walk testWalk;
	private FeatureExtractor fe;
	private Map<String,Feature> features;

	@Before
	public void setUp() throws Exception {
		this.walks = DataParser.parseFiles("junitTest");
		this.testWalk = walks.get(0); //Wannes 58
		this.fe = new FeatureExtractor(testWalk);
		this.features = fe.extractFeatures();
	}

	@Test
	public void testGetMeanX() {
		double mean = (double) features.get("meanOfX").value;
		double expected = 0.057507084;
		assertEquals(expected,mean,0.00000001);
	}
	
	@Test
	public void testGetMeanY() {
		double mean = (double) features.get("meanOfY").value;
		double expected = 0.560643316;
		assertEquals(expected,mean,0.00000001);
	}
	
	@Test
	public void testGetMeanZ() {
		double mean = (double) features.get("meanOfZ").value;
		double expected = -0.759161934;
		assertEquals(expected,mean,0.00000001);
	}

	@Test
	public void getDeviationX(){
		double dev = (double) features.get("standDevX").value;
		double expected = 3.071810958;
		assertEquals(expected,dev,0.00000001);
	}
}
