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

package hype.core.layout;

import hype.core.drawable.HDrawable;
import processing.core.PVector;

public interface HLayout {
	public void applyTo(HDrawable target);
	public abstract PVector getNextPoint();
}
