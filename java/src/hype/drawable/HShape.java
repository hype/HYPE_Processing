package hype.drawable;

import hype.colorist.HColorPool;
import hype.util.H;
import processing.core.PApplet;
import processing.core.PShape;

public class HShape extends HDrawable {
	protected PShape _shape;
	protected HColorPool _randomColors;
	
	public HShape() {}
	
	public HShape(Object shapeArg) {
		shape(shapeArg);
	}
	
	@Override
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
	
	public HColorPool randomColors(HColorPool colorPool) {
		return randomColors(colorPool,true);
	}
	
	public HColorPool randomColors(HColorPool colorPool, boolean isCopy) {
		if(isCopy)
			colorPool = colorPool.createCopy();
		_shape.disableStyle();
		_randomColors = colorPool;
		return _randomColors;
	}
	
	public HColorPool randomColors() {
		return _randomColors;
	}
	
	public HShape resetRandomColors() {
		_shape.enableStyle();
		_randomColors = null;
		return this;
	}
	
	@Override
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {
		if(_shape == null) return;
		
		applyStyle(app,currAlpha);
		if(_randomColors == null) {
			app.shape(_shape, drawX,drawY, _width,_height);
		} else for(int i=0; i<_shape.getChildCount(); ++i) {
			PShape childShape = _shape.getChild(i);
			
			// HACK Workaround for children having 0 size
			childShape.width = _shape.width;
			childShape.height = _shape.height;
			
			if(_randomColors.appliesFill())
				app.fill(_randomColors.getColor());
			if(_randomColors.appliesStroke())
				app.stroke(_randomColors.getColor());
			
			app.shape(childShape, drawX,drawY, _width,_height);
		}
	}
}
