/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.core.interfaces;

public interface HHittable {
	public boolean contains(float absX, float absY, float absZ);
	public boolean contains(float absX, float absY);
	public boolean containsRel(float relX, float relY, float relZ);
	public boolean containsRel(float relX, float relY);
}
