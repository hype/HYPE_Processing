/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HShape extends HDrawable {
	private PShape _shape;
	private int[] _randomFills, _randomStrokes;
	public HShape() {
		shape(null);
	}
	public HShape(Object shapeArg) {
		shape(shapeArg);
	}
	public HShape createCopy() {
		HShape copy = new HShape(_shape);
		copy.copyPropertiesFrom(this);
		return copy;
	}
	public HShape resetSize() {
		if(_shape == null) {
			size(0,0);
		} else {
			size(_shape.width,_shape.height);
		}
		return this;
	}
	public HShape shape(Object shapeArg) {
		if(shapeArg instanceof PShape) {
			_shape = (PShape) shapeArg;
		} else if(shapeArg instanceof String) {
			_shape = H.app().loadShape((String) shapeArg);
		} else if(shapeArg instanceof HShape) {
			_shape = ((HShape) shapeArg)._shape;
		} else if(shapeArg == null) {
			_shape = null;
		}
		return resetSize();
	}
	public PShape shape() {
		return _shape;
	}
	public HShape enableStyle(boolean b) {
		if(b) _shape.enableStyle();
		else _shape.disableStyle();
		return this;
	}
	public HShape randomColors(HColorPool colors) {
		int numChildren = _shape.getChildCount();
		boolean isFill = colors.appliesFill();
		boolean isStroke = colors.appliesStroke();
		if(isFill) {
			if(_randomFills==null || _randomFills.length<numChildren)
				_randomFills = new int[numChildren];
		} else {
			_randomFills = null;
		}
		if(isStroke) {
			if(_randomStrokes==null || _randomStrokes.length<numChildren)
				_randomStrokes = new int[numChildren];
		} else {
			_randomStrokes = null;
		}
		for(int i=0; i<numChildren; ++i) {
			if(isFill) _randomFills[i] = colors.getColor();
			if(isStroke) _randomStrokes[i] = colors.getColor();
		}
		_shape.disableStyle();
		return this;
	}
	public HShape resetRandomColors() {
		_shape.enableStyle();
		_randomFills = null;
		_randomStrokes = null;
		return this;
	}
	public void draw( PGraphics g, boolean usesZ,
		float drawX,float drawY,float alphaPc
	) {
		if(_shape == null) return;
		int wscale = 1;
		int hscale = 1;
		float w = _width;
		float h = _height;
		if(_width < 0) {
			w = -_width;
			wscale = -1;
			drawX = -drawX;
		}
		if(_height < 0) {
			h = -_height;
			hscale = -1;
			drawY = - drawY;
		}
		applyStyle(g,alphaPc);
		g.pushMatrix();
		g.scale(wscale, hscale);
		if(_randomFills==null && _randomStrokes==null) {
			g.shape(_shape, drawX,drawY, w,h);
		} else for(int i=0; i<_shape.getChildCount(); ++i) {
			PShape childShape = _shape.getChild(i);
			childShape.width = _shape.width;
			childShape.height = _shape.height;
			if(_randomFills != null) g.fill(_randomFills[i]);
			if(_randomStrokes != null) g.stroke(_randomStrokes[i]);
			g.shape(childShape, drawX,drawY, w,h);
		}
		g.popMatrix();
	}
}
