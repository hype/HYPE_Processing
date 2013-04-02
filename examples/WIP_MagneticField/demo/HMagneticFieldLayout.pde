public class HMagneticFieldLayout{
	protected int cols;
	protected int rows;
	protected int resolution;
	protected String rotation_style;

	public int grid_total;

	public int noOfPositivePoles=0;
	public int noOfNegativePoles=0;
	
	private  ArrayList<ArrayList<PVector>> magnets;

	//r = resolution of grid i.e. pixel size of each cell
	//w = grid width
	//h = grid height
	//rotational can be 'cos', 'sin', 'tan', defaults to '' which is normal magnetic field
	HMagneticFieldLayout(int r, int w, int h, String rotational){
		resolution = r;//the spacing of cells w/h
		cols = w/resolution;
		rows = h/resolution;
		magnets = new ArrayList<ArrayList<PVector>>();
		grid_total = cols * rows;
		
		magnets.add( new ArrayList<PVector>() );	//add positives
		magnets.add( new ArrayList<PVector>() );	//add negatives
		
		rotation_style = rotational;	
	}

	HMagneticFieldLayout(int r, int w, int h) {
		resolution = r;//the spacing of cells w/h
		cols = w/resolution;
		rows = h/resolution;
		magnets = new ArrayList<ArrayList<PVector>>();
		grid_total = cols * rows;
		
		magnets.add( new ArrayList<PVector>() );
		magnets.add( new ArrayList<PVector>() );
		
		rotation_style = "";

	}

	public float getAngle(PVector loc){

		PVector field = new PVector();

		float posRad = 0; float negRad = 0;

		for (PVector magnetLoc : magnets.get(0)) posRad += setAngle( loc, magnetLoc, 1);
		posRad = posRad / magnets.get(0).size();

		for (PVector magnetLoc : magnets.get(1)) negRad += setAngle( loc, magnetLoc, -1);
		negRad = negRad / magnets.get(0).size();

		field = new PVector(cos(posRad - negRad), sin(posRad - negRad));

		return radians( atan2( field.y, field.x ) * 180/PI );

	}

	private float setAngle(PVector mid, PVector pole, float polarity) {
			//distance from mid point to the pole
			PVector magn = new PVector(pole.x - mid.x, pole.y - mid.y);
			float radians;

			//this is the angle in radians
			if (rotation_style.equals("cos") )      radians = polarity * (cos(atan2(magn.y, magn.x)));
			else if (rotation_style.equals("sin") ) radians = polarity * (sin(atan2(magn.y, magn.x)));
			else if (rotation_style.equals("tan") ) radians = polarity * (tan(atan2(magn.y, magn.x)));
			else                                    radians = polarity * atan2(magn.y, magn.x);

			return radians;
	}

	//ADD, SET, and MOVE positive/negative poles in our magnetic field
	public void movePositivePole(int i, PVector offset){
		if( i >= noOfPositivePoles)	return;
		PVector orgPos = magnets.get(0).get(i);
		magnets.get(0).set(i, PVector.add( orgPos, offset ));
	}
	public void moveNegativePole(int i, PVector offset){
		if( i >= noOfNegativePoles)	return;
		PVector orgPos = magnets.get(1).get(i);
		magnets.get(1).set(i, PVector.add( orgPos, offset ));		
	}
	public void setPositivePole(int i, PVector p){
		if( i >= noOfPositivePoles) return;
		magnets.get(0).set(i, p);
	}
	public void setNegativePole(int i, PVector n){
		if( i >= noOfNegativePoles) return;
		magnets.get(1).set(i, n);		
	}	
	public void addPositivePole(PVector p) {
		magnets.get(0).add(p);
		noOfPositivePoles++;
	}
	public void addNegativePole(PVector n) {
		magnets.get(1).add(n);
		noOfNegativePoles++;
	}

}

