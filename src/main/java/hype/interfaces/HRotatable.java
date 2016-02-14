/*
 *
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013-2015 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 *
 * ----- *
 * HRotatable - updated by GD on 4/2/16 to support X,Y and Z rotations. Also see corresponding changes to HRotate *
 * Tested using processing 3.0.1 (It may break on newer versions of processing) *
 * If you find any issues or make anything cool with this * 
 * let me know on twitter at @Garth_D *
 *
 */

package hype.interfaces;

public interface HRotatable {
	public float rotationRad();
	public HRotatable rotationRad(float rad); //retained for backwards compatibility
  	public float rotationXRad();
	public HRotatable rotationXRad(float radx);
	public float rotationYRad();
	public HRotatable rotationYRad(float radx);
	public float rotationZRad();
	public HRotatable rotationZRad(float radz);
}

