package cca;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import matlabcontrol.MatlabConnectionException;
import matlabcontrol.MatlabInvocationException;


public class CCAMain {
	public static void main(String[] args) throws MatlabConnectionException, MatlabInvocationException {
		System.out.println("Running :)...");
		Map<String,String> options = getOptions(args);
		Solver solver;
		try {
			solver = new Solver(options);
			solver.solve();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	private static Map<String,String> getOptions(String[] args){
		HashMap<String, String> result = new HashMap<String, String>();
		int size = args.length;
		int i;
		for(i=0;i<size;i++){
			
			if ("-ntest".equals(args[i].toLowerCase())) {
				i++;
				result.put("testNames", args[i]);			
			}
			else if ("-k".equals(args[i].toLowerCase())){
				i++;
				result.put("k",args[i]);
			}
				
		}
		return result;
	}
}
