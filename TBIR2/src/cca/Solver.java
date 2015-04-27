package cca;

import java.util.Map;

import matlabcontrol.MatlabInvocationException;
import matlabcontrol.MatlabProxy;

public class Solver {
	private MatlabProxy mlp;
	private String trainV;
	private String testV;
	private String trainImages;
	private String testImages;

	public Solver(MatlabProxy mlp, Map<String,String> options){
		this.mlp=mlp;
		this.trainV= options.get("train");
		this.testV= options.get("test");
		this.trainImages = options.get("trainImages");
		this.testImages = options.get("testImages");
	}

	public void solve() throws MatlabInvocationException {
		mlp.eval("[projectedQ, projectedI] = preprocess("+trainV+", "+trainImages+"+, "+testV+", "+testImages+")");
	}
}
