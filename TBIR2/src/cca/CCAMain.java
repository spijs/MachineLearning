package cca;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import matlabcontrol.MatlabConnectionException;
import matlabcontrol.MatlabInvocationException;
import matlabcontrol.MatlabProxy;
import matlabcontrol.MatlabProxyFactory;


public class CCAMain {
	public static void main(String[] args) throws MatlabConnectionException, MatlabInvocationException {
		MatlabProxyFactory factory = new MatlabProxyFactory();
		MatlabProxy proxy = factory.getProxy();
		Map<String,String> options = getOptions(args);
		Solver solver;
		try {
			solver = new Solver(proxy,options);
			solver.solve();
		} catch (IOException e) {
			e.printStackTrace();
		}
		 finally{
			 proxy.disconnect();			 
		 }
	}
	
	private static Map<String,String> getOptions(String[] args){
		HashMap<String, String> result = new HashMap<String, String>();
		int size = args.length;
		int i;
		for(i=0;i<size;i++){
			if ("-vtest".equals(args[i].toLowerCase())) {
				i++;
				result.put("test", args[i]);			
			}
			else if ("-vtrain".equals(args[i].toLowerCase())) {
				i++;
				result.put("train", args[i]);			
			}
			else if ("-itest".equals(args[i].toLowerCase())) {
				i++;
				result.put("testImages", args[i]);			
			}
			else if ("-itrain".equals(args[i].toLowerCase())) {
				i++;
				result.put("trainImages", args[i]);			
			}
			else if ("-ntrain".equals(args[i].toLowerCase())) {
				i++;
				result.put("trainNames", args[i]);			
			}
			else if ("-ntest".equals(args[i].toLowerCase())) {
				i++;
				result.put("testNames", args[i]);			
			}
			
				
		}
		return result;
	}
}
