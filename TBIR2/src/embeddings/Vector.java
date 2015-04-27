package embeddings;

/**
 * @author Thijs D
 * This class represents vectors containing doubles. It allows for basic operations on those vectors.
 *
 */
public class Vector {
	private double[] values;
	public Vector(double[] values){
		this.values=values;
	}

	public Vector(String str, int start){
		String[] elements = str.split(" ");
		double[] result = new double[elements.length-start];
		for(int i=start;i<elements.length;i++){
			result[i-start] =  Double.parseDouble(elements[i]);
		}
		this.values=result;
	}

	public Vector(String str) {
		String[] elements = str.split(",");
		double[] result = new double[elements.length];
		for(int i=0;i<elements.length;i++){
			result[i] =  Double.parseDouble(elements[i]);
		}
		this.values=result;
	}

	/**
	 * Adds this vector to the given vector v and returns a new vector containing the result.
	 * @param v Vector with the same size as this vector.
	 * @return New vector containing the sum of this vector and the given vector.
	 */
	public Vector add(Vector v){
		if(checkLength(v)){
			double[] secValues = v.getValues();
			double[] newValues = new double[values.length];
			for(int i=0;i<values.length;i++){
				newValues[i] = values[i]+secValues[i];
			}
			return new Vector(newValues);
		}
		else{
			throw new IllegalArgumentException("vectors should be of the same length");
		}
	}
	
	/**
	 * Substracts this vector to the given vector v and returns a new vector containing the result.
	 * @param v Vector with the same size as this vector.
	 * @return New vector containing the difference of this vector and the given vector.
	 */
	public Vector subtract(Vector v){
		if(checkLength(v)){
			double[] secValues = v.getValues();
			double[] newValues = new double[values.length];
			for(int i=0;i<values.length;i++){
				newValues[i] = values[i]-secValues[i];
			}
			return new Vector(newValues);
		}
		else{
			throw new IllegalArgumentException("vectors should be of the same length");
		}
	}
	
	/**
	 * Computes the dotproduct of this vector and the given vector v.
	 * @param v Vector with the same size as this vector.
	 */
	public double dotProduct(Vector v){
		if(checkLength(v)){
			double result = 0;
			for(int i=0;i<values.length;i++){
				result +=values[i]*v.getValues()[i];
			}
			return result;
		}
		else{
			throw new IllegalArgumentException("vectors should be of the same length");
		}
	}

	/**
	 * @return The norm of this vector
	 */
	public double norm(){
		double sum = 0;
		for(double d:values){
			sum += d*d;
		}
		return Math.sqrt(sum);
	}

	/**
	 * Computes the cosine distance of this vector to the given vector v.
	 */
	public double cosineDist(Vector v){
		if(checkLength(v)){
			return dotProduct(v)/(v.norm()*this.norm());
		}
		else{
			throw new IllegalArgumentException("vectors should be of the same length");
		}
	}

	public double[] getValues(){
		return this.values;
	}

	/**
	 * Returns true if this vector and the given vector have the same length.
	 */
	public boolean checkLength(Vector v){
		return v.getValues().length==this.getValues().length;
	}
	
	@Override
	public String toString(){
		String result = "";
		int i=0;
		for(double value:values){
			i++;
			result += value;
			if(i!=values.length){
				result+=" ";
			}
		}
		return result;
	}
}
