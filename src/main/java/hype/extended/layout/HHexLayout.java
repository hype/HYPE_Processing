/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * HHexLayout
 * by Russell Hay / cordandruss.com / github.com/RussTheAerialist
 *
 * Creates a grid layout that is hex based spiraling out from the center of the sketch
 *
 * References:
 *    www.redblobgames.com/grids/hexagons/
 *    gamedev.stackexchange.com/questions/51264/get-ring-of-tiles-in-hexagon-grid
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.extended.layout;

import hype.H;
import hype.HDrawable;
import hype.interfaces.HLayout;
import processing.core.PApplet;
import processing.core.PVector;

public class HHexLayout implements HLayout {
	protected int currentDistanceFromCenter, currentIndex, direction;
	protected float spacing, offsetX, offsetY, adjustX, adjustY;
	protected PVector lastPoint;

	public HHexLayout() {
		spacing = 16;
		currentIndex = 0;
		direction = 0;
		currentDistanceFromCenter = 0;
		offsetX = (float) (H.app().width / 2.0);
		offsetY = (float) (H.app().height / 2.0);
		adjustX = (float) (spacing * 1.25);
		adjustY = (float) (spacing * 0.25);
		lastPoint = null;
	}

	public HHexLayout spacing(float size) {
		spacing = size;

		return this;
	}

	public float spacing() {
		return spacing;
	}

	public HHexLayout offsetX(float value) {
		adjustX = value;
		return this;
	}

	public HHexLayout offsetY(float value) {
		adjustY = value;
		return this;
	}

	public float offsetX() { return adjustX; }
	public float offsetY() { return adjustY; }

	protected PVector north(PVector in) {
		return north(in, 1);
	}

	protected PVector north(PVector in, int distance) {
		return new PVector(in.x, in.y-distance);
	}

	protected PVector south(PVector in) {
		return new PVector(in.x, in.y+1);
	}

	protected PVector northeast(PVector in) {
		return new PVector(in.x+1, in.y-1);
	}

	protected PVector northwest(PVector in) {
		return new PVector(in.x-1, in.y);
	}

	protected PVector southeast(PVector in) {
		return new PVector(in.x+1, in.y);
	}

	protected PVector southwest(PVector in) {
		return new PVector(in.x-1, in.y+1);
	}

	protected void updateLastPoint() {

		// We've reached the end of the current direction, switch directions
		if (currentIndex > currentDistanceFromCenter -1) {
			currentIndex = 0;
			direction++;
		}

		// We've reached the end of the current ring, increase distance
		if (direction > 5) {
			direction = 0;
			currentDistanceFromCenter++;
			currentIndex = 0;
			lastPoint = north(new PVector(0,0), currentDistanceFromCenter);
			// return;
		}


		if (lastPoint != null) {
			switch(direction) {
				case 0:
					lastPoint = southeast(lastPoint);
					// PApplet.println(Integer.toString(currentIndex) + ": SE : " + lastPoint);
					break;
				case 1:
					lastPoint = south(lastPoint);
					// PApplet.println(Integer.toString(currentIndex) + ": S  : " + lastPoint);
					break;
				case 2:
					lastPoint = southwest(lastPoint);
					// PApplet.println(Integer.toString(currentIndex) + ": SW : " + lastPoint);
					break;
				case 3:
					lastPoint = northwest(lastPoint);
					// PApplet.println(Integer.toString(currentIndex) + ": NW : " + lastPoint);
					break;
				case 4:
					lastPoint = north(lastPoint);
					// PApplet.println(Integer.toString(currentIndex) + ": N : " + lastPoint);
					break;
				case 5:
					lastPoint = northeast(lastPoint);
					// PApplet.println(Integer.toString(currentIndex) + ": NE : " + lastPoint);
					break;
			}

		} else {
			// First point
			lastPoint = new PVector(0,0);
			currentIndex = currentDistanceFromCenter +1;
			direction = 7;
		}
	}

	@Override
	public PVector getNextPoint() {
		++currentIndex;
		updateLastPoint();

		float x, y;
		x = y = 0;

		x = (float) (spacing * 3.0/2.0 * lastPoint.x);
		y = (float) (spacing * PApplet.sqrt((float) 3.0) * (lastPoint.y + lastPoint.x/2.0));

		return new PVector(
			x + offsetX - adjustX,
			y + offsetY - adjustY
		);
	}

	@Override
	public void applyTo(HDrawable target) {
		target.loc(getNextPoint());
	}
}
