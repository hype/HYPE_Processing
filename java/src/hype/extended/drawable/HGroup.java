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

package hype.extended.drawable;

import hype.core.drawable.HDrawable;
import processing.core.PGraphics;

public class HGroup extends HDrawable {
	
	public HGroup() {
		transformsChildren(true).stylesChildren(true);
	}
	
	@Override
	public HGroup createCopy() {
		HGroup copy = new HGroup();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	@Override
	public void paintAll(PGraphics g, boolean usesZ, float alphaPc) {
		if(_alphaPc<=0) return;
		
		// Perform a trimmed down version of super.paintAll()Ê
		g.pushMatrix();
			if(usesZ) g.translate(_x,_y,_z);
			else g.translate(_x,_y);
			g.rotate(_rotationZRad);
			
			alphaPc *= _alphaPc;
			
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, alphaPc);
				child = child.next();
			}
		g.popMatrix();
	}
	
	@Override
	public void draw(PGraphics g,boolean b,float x,float y,float f) {}
}
