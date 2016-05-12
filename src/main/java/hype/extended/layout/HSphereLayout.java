/*
 * HSphereLayout - Class for HYPE
 * Tested using processing 3.0.1
 * If you find any issues or make anything cool with this, let me know on twitter at @Garth_D
 * 
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013-2016 Joshua Davis
 *
 * Distributed under the BSD License. See LICENSE.txt for details.
 *
 * All rights reserved.
 *
 */

package hype.extended.layout;

import hype.H;
import hype.HDrawable;
import hype.HDrawable3D;
import hype.interfaces.HLayout;
import processing.core.PVector;

import static processing.core.PApplet.*;

public class HSphereLayout implements HLayout {

	private int radius;
	private int hDetail; //detail level for latitude
	private int vDetail; //detail level for longitude
	private int thetaStart;
	private int thetaEnd;
	private int phiStart;
	private int phiEnd;
	private int theta;
	private int phi;
	private int thetaMax;
	private int phiMax;
	private float offsetX, offsetY, offsetZ;

	public HSphereLayout() {
		radius = 100;
		hDetail = 5;
		vDetail = 10;
		offsetX = H.app().width/2;
		offsetY = H.app().height/2;
		offsetZ = 0;
		thetaStart=0;
		phiStart=0;
		theta=thetaStart;
		phi=phiStart;
		thetaMax=360;
		thetaEnd=thetaMax;
		phiMax=180;
		phiEnd=phiMax;
	}

 	//set the offset coords
	public HSphereLayout offset(float x, float y, float z) {
		offsetX = x;
		offsetY = y;
		offsetZ = z;
		return this;
	}

	public HSphereLayout offsetX(float f) {
		offsetX = f;
		return this;
	}

	public float offsetX() {
		return offsetX;
	}

	public HSphereLayout offsetY(float f) {
		offsetY = f;
		return this;
	}

	public float offsetY() {
		return offsetY;
	}

	public HSphereLayout offsetZ(float f) {
		offsetZ = f;
		return this;
	}

	public float offsetZ() {
		return offsetZ;
	}

	//set the radius
	public HSphereLayout radius(int r) {
		radius = Math.abs(r);
		return this;
	}

	public int radius() {
		return radius;
	}

	public HSphereLayout detail(int i) {
		hDetail = vDetail = Math.abs(i);
		return this;
	}

	public HSphereLayout hDetail(int i) {
		hDetail = Math.abs(i);
		return this;
	}

	public float hDetail() {
		return hDetail;
	}

	public HSphereLayout vDetail(int i) {
		vDetail = Math.abs(i);
		return this;
	}

	public float vDetail() {
		return vDetail;
	}

	public HSphereLayout thetaAngles(int s, int e) {
		PVector temp = forceNumberRange(s, e, thetaMax);
		thetaStart = (int)temp.x;
		thetaEnd = (int)temp.y;
		theta = thetaStart;
		return this;
	}

	public HSphereLayout phiAngles(int s, int e) {
		PVector temp = forceNumberRange(s, e, phiMax);
		phiStart = (int)temp.x;
		phiEnd = (int)temp.y;
		phi = phiStart;
		return this;
	}

	private PVector forceNumberRange(int start, int end, int max) {
	//force two numbers to be within a given range, and ensures the two numbers are different
		start = constrain(start, 0, max);
		end = constrain(end, 0, max);

		if (start==end) {
			if (start==0 || start==max) {
				if (start==0) {
					end=max;
				}
				if (start==max) {
					start=0;
				}
			} else
			{
				end++;
			}
		}

		if (end < start) {
			int temp = start;
			int temp2 = end;
			end = temp;
			start = temp2;
		}

		return new PVector(start, end);
	}

	@Override
	public PVector getNextPoint() {

		PVector pt = new PVector();

		pt.x = radius * sin(radians(phi)) * cos(radians(theta))+offsetX;
		pt.y = radius * sin(radians(phi)) * sin(radians(theta))+offsetY;
		pt.z = radius * cos(radians(phi))+offsetZ;

		phi+=vDetail;
		if (phi > phiEnd)
		{
			phi = phiStart;
			theta+=hDetail;
		}

		return pt;
	}

	@Override
	public void applyTo(HDrawable target) {

		if (theta < thetaEnd) {

			target.loc(getNextPoint());

			if(target instanceof HDrawable3D==false){
				target.rotationZ(theta); //can't work out x and y rotations...maybe others can help
			} 
		} else {
			//we have excess items
			H.remove(target);
		}
	}
}
