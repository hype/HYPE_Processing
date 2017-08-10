/*
	TODO:
	- expand start/end angles to work with all layouts, not just Garth's proportional sin(phi)
	- clean up rotation method. It works, but looks messy
	Possible additions:
	- R Bauer method?
	- icosahedron split method (i.e. geodesic sphere)?
*/

package hype.extended.layout;

import hype.interfaces.HLayout;

import hype.H;
import hype.HDrawable;
import hype.HDrawable3D;
import hype.HWarnings;

import processing.core.PVector;
import processing.core.PConstants;

import java.util.ArrayList;

import static processing.core.PApplet.*;

public class HSphereLayout implements HLayout {

	private PVector loc;
	private float radius;
	private float radiusMod;
	private int currentIndex = 0;
	private boolean rotateTarget = false;
	private boolean warned = false;

	private int whichLayout = 0;//0 - grid, 1 - spiral, 2 - proportional to sin(phi)
	private int extensionMethod = 0;

	/*
		UV Sphere vars
	*/
	private int numCols;
	private int numRows;
	private boolean avoidPoles = false;
	private boolean oddRowOffset = false;

	/*
		Fibonacci spiral vars
	*/
	private float phiMod;
	private int n;
	private float increment;
	private float off;


	/*
		Proportional sin(phi) method vars
	*/
	private int detail;
	private ArrayList<PVector> positions;
	private float phi_start;
	private float phi_end;
	private float theta_start;
	private float theta_end;

	

	public HSphereLayout() {
		loc = new PVector(0, 0, 0);
		radius = 100.0f;
		radiusMod = 100.0f;

		//UV defaults
		numCols = 10;
		numRows = 10;

		//fibonacci defaults
		n = 100;
		off = 2.0f / n;
		phiMod = 6.0f;
		increment = PConstants.PI * (3.0f - (float) Math.sqrt(5.0f));

		//proportional sin(phi) defaults
		detail = 6;
		positions = new ArrayList<PVector>();
		phi_start = 0.0f;
		phi_end = PConstants.PI;
		theta_start = 0.0f;
		theta_end = PConstants.TWO_PI;
	}

	public HSphereLayout(float x, float y, float z) {
		this();
		loc = new PVector(x, y, z);
	}


	/*
		Deal with internal index
	*/
	public HSphereLayout currentIndex(int i) {
		currentIndex = i;
		return this;
	}

	public int currentIndex() {
		return currentIndex;
	}

	public HSphereLayout resetIndex() {
		currentIndex = 0;
		return this;
	}


	/*
		Sphere center point location
	*/
	public HSphereLayout x(float x) {
		loc.x = x;
		return this;
	}
	public HSphereLayout y(float y) {
		loc.y = y;
		return this;
	}
	public HSphereLayout z(float z) {
		loc.z = z;
		return this;
	}
	public HSphereLayout loc(float x, float y, float z) {
		loc.x = x;
		loc.y = y;
		loc.z = z;
		return this;
	}

	public float x() {
		return loc.x;
	}
	public float y() {
		return loc.y;
	}
	public float z() {
		return loc.z;
	}
	public PVector loc() {
		return loc;
	}


	/*
		Sphere radius
	*/
	public HSphereLayout radius(float r) {
		radius = r;
		radiusMod = r;
		return this;
	}

	public float radius() {
		return radius;
	}


	/*
		Rotate target to align with center
	*/
	public HSphereLayout rotate(boolean b) {
		rotateTarget = b;
		return this;
	}

	boolean rotate() {
		return rotateTarget;
	}


	/*
		Set the layout method
	*/
	public HSphereLayout useUV() {
		return setLayout(0);
	}
	public HSphereLayout useSpiral() {
		return setLayout(1);
	}
	public HSphereLayout useProportional() {
		return setLayout(2);
	}
	public HSphereLayout setLayout(int i) {
		whichLayout = i;
		return this;
	}


	/*
		Infinite extension on radius, or x,y,z 
		values taken from HConstants
	*/
	public HSphereLayout extendX() {
		setExtension(4);
		return this;
	}
	public HSphereLayout extendNegativeX() {
		setExtension(-4);
		return this;
	}
	public HSphereLayout extendY() {
		setExtension(5);
		return this;
	}
	public HSphereLayout extendNegativeY() {
		setExtension(-5);
		return this;
	}
	public HSphereLayout extendZ() {
		setExtension(6);
		return this;
	}
	public HSphereLayout extendNegativeZ() {
		setExtension(-6);
		return this;
	}

	public HSphereLayout extendRadius() {
		return extendRadius(radiusMod);
	}
	public HSphereLayout extendRadius(float r) {
		radiusMod = r;
		setExtension(19);
		return this;
	}
	public HSphereLayout extendNegativeRadius(float r) {
		radiusMod = r;
		setExtension(-19);
		return this;
	}

	public HSphereLayout setExtension(int i) {
		extensionMethod = i;
		return this;
	}

	private HSphereLayout extendLayout(int newIndex) {
		currentIndex = newIndex;

		if (warned == false) {
			warned = true;
			HWarnings.warn("Drawable index out of bounds", "HSphereLayout", "This layout supports a maximum of " + numPoints() +" drawable objects on the sphere surface. Consider reducing the number of drawables applied to this layout.");
		}

		switch(extensionMethod) {
			case 4:
				loc.x += radius * 2;
				break;
			case -4:
				loc.x -= radius * 2;
				break;
			case 5:
				loc.y += radius * 2;
				break;
			case -5:
				loc.y -= radius * 2;
				break;
			case 6:
				loc.z += radius * 2;
				break;
			case -6:
				loc.z -= radius * 2;
				break;
			case -19:
				radius -= radiusMod;
				break;
			case 19:
			default:
				radius += radiusMod;
				break;
		}
		return this;
	}


	/*******************************************************************/
	/*
		helper functions
	*/
	public int numPoints() {
		int points = 0;
		switch (whichLayout) {
			
			case 1:
				points = n;
				break;

			case 2:
				if (positions.size() > 0) {
					points = positions.size();
				} else {
					//same calc as in the getProportionalPoint method, just trimmed to count points
					int tDetail = (int) Math.floor(detail/2);
					float pi_inc = (float) (phi_end - phi_start)/detail;
					for (int i = 0; i <= detail; i++) {
						float phi = (float) phi_start + (i * pi_inc);
						float theta = 0.0f;
						float theta_inc = (float) 1.0f/(tDetail*sin(phi));
						if (theta_inc > 0.0f && theta_inc < 1.0f) {
							int tSteps = (int) Math.floor((theta_end - theta_start) / theta_inc);
							for (int j = 0; j <= tSteps; j++) {
								points++;
							}

						} else {
							points++;
						}
					}
				}
				break;

			case 0:
			default:
				points = numRows * numCols;
				break;
		}

		return points;
	}


	/*******************************************************************/

	/*
		UV Sphere related methods
	*/
	public HSphereLayout cols(int i) {
		numCols = i;
		return this;
	}

	public HSphereLayout rows(int i) {
		numRows = i;
		return this;
	}

	public int cols() {
		return numCols;
	}

	public int rows() {
		return numRows;
	}

	public HSphereLayout ignorePoles() {
		avoidPoles = true;
		return this;
	}
	public HSphereLayout includePoles() {
		avoidPoles = false;
		return this;
	}
	public HSphereLayout offsetRows(boolean b) {
		oddRowOffset = b;
		return this;
	}
	boolean offsetRows() {
		return oddRowOffset;
	}


	/*******************************************************************/

	/*
		Fibonacci spiral related methods
	*/
	public HSphereLayout phiModifier(float f) {
		phiMod = f;
		return this;
	}

	public HSphereLayout numPoints(int i) {
		n = i;
		off = 2.0f / n;
		return this;
	}


	/*******************************************************************/	

	/* Proportional sin(phi) methods */
	public HSphereLayout detail(int d) {
		if (d > 4) {
			detail = d;
		}
		return this;
	}

	public int detail() {
		return detail;
	}

	public HSphereLayout phiStart(float a) {
		phi_start = radians(a);
		return this;
	}

	public HSphereLayout phiEnd(float a) {
		phi_end = radians(a);
		return this;
	}

	public HSphereLayout thetaStart(float a) {
		theta_start = radians(a);
		return this;
	}

	public HSphereLayout thetaEnd(float a) {
		theta_end = radians(a);
		return this;
	}


	/*******************************************************************/

	/*
		different methods to determine point
	*/
	private PVector getUVPoint() {
		//handle infinite layout
		if (currentIndex >= (numCols * numRows)) {
			extendLayout(0);
		}

		int col = currentIndex % numCols;
		int row = (int) Math.floor(currentIndex / numCols) % numRows;

		float lon;

		if (avoidPoles == true || numRows == 1) {
			lon = map(row, -1, numRows, -PConstants.HALF_PI, PConstants.HALF_PI);
		} else {
			lon = map(row, 0, numRows-1, -PConstants.HALF_PI, PConstants.HALF_PI);
		}

		float lat = map(col, 0, numCols, 0, PConstants.TWO_PI);

		if (oddRowOffset == true && row % 2 > 0) {
			//adds an offset to give a diamond pattern
			lat += radians((360.0f / numCols) / 2);
		}

		float x = (float)(radius * cos(lon)*cos(lat));
		float y = (float)(radius * sin(lon));
		float z = (float)(radius * cos(lon) * sin(lat));

		return new PVector(x, y, z);
	}

	private PVector getFibPoint() {
		//handle infinite layout
		if (currentIndex >= n) {
			extendLayout(0);
		}

		float y = currentIndex * off - 1 + (off / 3);
		float r = sqrt(1 - y*y);
		float phi = currentIndex * increment * phiMod;

		PVector p = new PVector(cos(phi)*r, y, sin(phi)*r);
		p.normalize();
		p.mult(radius);

		return p;
	}

	private PVector getProportionalPoint() {
		/*
			Not a big fan of pre calculating angles...
			...can it be converted linearly based on currentIndex?
		*/
		if (positions.size()==0) {
			//set up the angles....
			int tDetail = (int) Math.floor(detail/2);

			//float pi_inc = (float) PConstants.PI/detail;
			float pi_inc = (float) (phi_end - phi_start)/detail;

			for (int i = 0; i <= detail; i++) {

				float phi = (float) phi_start + (i * pi_inc);
				float theta = 0.0f;
				float theta_inc = (float) 1.0f/(tDetail*sin(phi));

				if (theta_inc > 0.0f && theta_inc < 1.0f) {
					//not a pole...
					int tSteps = (int) Math.floor((theta_end - theta_start) / theta_inc);

					//only do things if we have 1+ steps, avoids division by zero issues on the theta_inc
					if (tSteps > 0) {

						//mod to even out the weird spacing that sometimes happens
						theta_inc = (float) (theta_end - theta_start) / tSteps;
						
						for (int j = 0; j <= tSteps; j++) {
							theta = (float) theta_start + (j * theta_inc);

							if (oddRowOffset == true && i % 2 > 0) {
								//adds an offset to give a diamond pattern
								theta += theta_inc/2;
							}

							positions.add(new PVector(phi, theta));
						}
					}

				} else {
					//is a pole... should we draw it?
					if (avoidPoles == false) {
						if (theta_inc < 0.0f) {
							theta = 0.0f;
						} else {
							theta = PConstants.HALF_PI;
						}
						positions.add(new PVector(phi, theta));
					}
				}
			}
		}// end angle set up


		//handle infinite layout
		if (currentIndex >= positions.size()) {
			extendLayout(0);
		}

		PVector p = new PVector();

		PVector angle = positions.get(currentIndex);

		// p.x = radius * sin(angle.x) * cos(angle.y);
		// p.y = radius * cos(angle.x);
		// p.z = radius * sin(angle.x) * sin(angle.y);

		//change from original code above to make it draw from top of sphere, not bottom
		p.x = radius * cos(angle.x - PConstants.HALF_PI) * cos(angle.y);
		p.y = radius * sin(angle.x - PConstants.HALF_PI);
		p.z = radius * cos(angle.x - PConstants.HALF_PI) * sin(angle.y);

		return p;
	}


	/*******************************************************************/

	private void applyRotation(HDrawable t, PVector p) {
			
       		float xR;
       		float yR;
			
			PVector force = PVector.sub(p, loc);
			force.normalize();

			PVector p1 = new PVector();
			PVector p2 = new PVector();
			PVector d = new PVector();
			p1.x = 0;
			p1.y = 0;
			p2.x = sqrt(1 - (force.y * force.y));
			p2.y = force.y;
			d = PVector.sub(p2, p1);
			d.normalize();

			xR = PVector.angleBetween(d, new PVector(1, 0, 0));
			if (p1.y < p2.y) {
				xR *= -1;
			}

			PVector yAxisAdjust = new PVector(0, sin(xR + radians(90)), cos(xR + radians(90)));
			
			p1.x = 0;
			p1.y = 0;
			p2.x = force.x;
			p2.y = force.z;
			d = PVector.sub(p2, p1);
			d.normalize();

			yR = PVector.angleBetween(d, new PVector(0, 1, 0));
			if (p2.x < p1.x) {
				yR = -yR;
			}

			t.rotationXRad(xR);
			t.rotationOnAxisRad(yR, yAxisAdjust.x, yAxisAdjust.y, yAxisAdjust.z);
	}


	@Override
	public PVector getNextPoint() {

		PVector point;

		switch (whichLayout) {
			
			case 0 :
				point = getUVPoint();
				break;

			case 1:
				point = getFibPoint();
				break;

			case 2:
				point = getProportionalPoint();
				break;

			default:
				point = getUVPoint();
				break;
		}

		//add center location of layout
		point.add(loc);

		++currentIndex;

		return point;
	}

	@Override
	public void applyTo(HDrawable target) {
		PVector pos = getNextPoint();
		target.loc(pos);

		//check for rotation
		if (rotateTarget == true) {
			applyRotation(target, pos);
		}

	}
}
