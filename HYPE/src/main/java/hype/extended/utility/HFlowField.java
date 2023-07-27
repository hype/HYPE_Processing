package hype.extended.utility;

import hype.H;
import hype.HMath;

import processing.core.PConstants;
import processing.core.PVector;

import static processing.core.PApplet.cos;
import static processing.core.PApplet.sin;
import static processing.core.PApplet.map;
import static processing.core.PApplet.constrain;

public class HFlowField {

	//TODO: 3D grid of directional forces
	PVector[] field;

	int cols, rows;
	int resolution;

	float w;
	float h;
	float x;
	float y;

	float noiseIncX = 0.1f;
	float noiseIncY = 0.1f;
	float noiseIncZ = 0.02f;
	float noiseZ = 0.0f;

	// boolean normalize = true;
	// boolean turbulence = false;
	boolean animate = false;

	int noiseType = 0;//perlin, random, etc.

	public HFlowField() {
		size(H.app().width, H.app().height);
		resolution(50);
	}//end constructor

	public HFlowField size(float myW, float myH) {

		if (myW <= 0 || myH <= 0) return this;

		float scale = myW/w;

		w = myW;
		h = myH;
		x = 0;
		y = 0;

		resolution *= scale;

        return this;
	}

	public HFlowField cols(int c) {
		return columns(c);
	}
	public HFlowField columns(int c) {
		cols       = c;
		resolution = (int) Math.ceil(w/cols);
		rows       = (int) Math.ceil(h/resolution);
		init();
        return this;
	}

	public HFlowField rows(int r) {
		rows       = r;
		resolution = (int) Math.ceil(h/rows);
		cols       = (int) Math.ceil(w/resolution);
		init();
        return this;
	}

	public HFlowField resolution(int r) {
		resolution = r;
		cols       = (int) Math.ceil(w/resolution);
		rows       = (int) Math.ceil(h/resolution);
		init();
        return this;
	}

	public HFlowField center() {
		//calc w and h of grid
		w = cols * resolution;
		h = rows * resolution;
		x = (H.app().width - w)/2;
		y = (H.app().height - h)/2;
        return this;
	}

	public HFlowField noiseX(float n) {
		noiseIncX = n;
        return this;
	}

	public HFlowField noiseY(float n) {
		noiseIncY = n;
        return this;
	}

	public HFlowField noiseZ(float n) {
		noiseIncZ = n;
        return this;
	}

	public HFlowField animate(boolean b) {
		animate = b;
        return this;
	}

	public HFlowField init() {
		field = new PVector[cols * rows];
		generate();
        return this;
	}

	public HFlowField update() {
		if (animate) {
			noiseZ += noiseIncZ;
			generate();
		}
        return this;
	}
	
	public HFlowField regenerate() {
		// Reseed noise so we get a new flow field every time
		H.app().noiseSeed((int)H.app().random(10000));
		generate();
        return this;
	}

	public int fieldLength() {
		return field.length;
	}

	public int numCols() {
		return cols;
	}

	public int numRows() {
		return rows;
	}

	public HFlowField setField(int idx, PVector val) {
		if (idx >= 0 && idx < field.length) {
			field[idx] = val;
		}
        return this;
	}

	public HFlowField generate() {
		
		for (int i = 0; i < cols * rows; i++) {

			int col = i % cols;
			int row = (int) Math.floor(i / cols);

			float noiseX = col * noiseIncX;
			float noiseY = row * noiseIncY;

			float theta = map(H.app().noise(noiseX,noiseY,noiseZ), 0.0f, 1.0f, 0.0f, PConstants.TWO_PI);
			field[i] = new PVector(cos(theta), sin(theta));

			// field[i].mult(random(0, 4));
		}//end for

        return this;
	}//end generate

	public PVector getVector(float myX, float myY) {
		int col = (int) Math.floor(constrain((float) Math.floor(myX - x)/resolution, 0, cols-1));
		int row = (int) Math.floor(constrain((float) Math.floor(myY - y)/resolution, 0, rows-1));
		int idx = row * cols + col;
		return field[idx].get();
	}

	public float getRotation(float myX, float myY) {
		return getVector(myX, myY).heading2D();
	}

	public HFlowField display() {
		
		for (int i = 0; i < cols * rows; i++) {

			H.app().stroke(200);
			H.app().fill(25);

			int col = i % cols;
			int row = (int) Math.floor(i / cols);

			H.app().pushMatrix();
				H.app().translate(x + col * resolution, y + row * resolution);
				H.app().rect(0, 0, resolution, resolution);
			H.app().popMatrix();

			H.app().pushMatrix();
				H.app().translate(x + col * resolution + resolution/2, y + row * resolution + resolution/2);
				
				H.app().rotate(field[i].heading2D());

				float l = field[i].mag() * (resolution/2);
				H.app().line(-l/2, 0, l/2, 0);
				H.app().fill(255, 0, 0);
				H.app().noStroke();
				H.app().ellipse(l/2, 0, 10, 10);
			H.app().popMatrix();
		}

		return this;
	}//end display

}//end Class
