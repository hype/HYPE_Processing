package hype;

import hype.extended.colorist.HColorPool;
import processing.core.PGraphics;
import processing.core.PShape;

public class HShape extends HDrawable {
	private PShape shape;
	private int[] randomFills, randomStrokes;

	public HShape() {
		shape(null);
	}

	public HShape(Object shapeArg) {
		shape(shapeArg);
	}

	@Override
	public HShape createCopy() {
		HShape copy = new HShape(shape);
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public HShape resetSize() {
		if(shape == null) {
			size(0,0);
		} else {
			size(shape.width, shape.height);
		}
		return this;
	}

	public HShape shape(Object shapeArg) {
		if(shapeArg instanceof PShape) {
			shape = (PShape) shapeArg;
		} else if(shapeArg instanceof String) {
			shape = H.app().loadShape((String) shapeArg);
		} else if(shapeArg instanceof HShape) {
			shape = ((HShape) shapeArg).shape;
		} else if(shapeArg == null) {
			shape = null;
		}
		return resetSize();
	}

	public PShape shape() {
		return shape;
	}

	public HShape enableStyle(boolean b) {
		if(b) shape.enableStyle();
		else shape.disableStyle();
		return this;
	}

	public HShape randomColors(HColorPool colors) {
		int numChildren = shape.getChildCount();
		boolean isFill = colors.appliesFill();
		boolean isStroke = colors.appliesStroke();
		if(isFill) {
			if(randomFills ==null || randomFills.length<numChildren)
				randomFills = new int[numChildren];
		} else {
			randomFills = null;
		}
		if(isStroke) {
			if(randomStrokes ==null || randomStrokes.length<numChildren)
				randomStrokes = new int[numChildren];
		} else {
			randomStrokes = null;
		}
		for(int i=0; i<numChildren; ++i) {
			if(isFill) randomFills[i] = colors.getColor();
			if(isStroke) randomStrokes[i] = colors.getColor();
		}
		shape.disableStyle();
		return this;
	}

	public HShape resetRandomColors() {
		shape.enableStyle();
		randomFills = null;
		randomStrokes = null;
		return this;
	}

	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX,float drawY,float alphaPc
	) {
		if(shape == null) return;

		// Determine if this shape would be flipped
		int wscale = 1;
		int hscale = 1;
		float w = width;
		float h = height;
		if(width < 0) {
			w = -width;
			wscale = -1;
			drawX = -drawX;
		}
		if(height < 0) {
			h = -height;
			hscale = -1;
			drawY = - drawY;
		}

		applyStyle(g, alphaPc);

		g.pushMatrix();
		g.scale(wscale, hscale);

		if(randomFills ==null && randomStrokes ==null) {
			g.shape(shape, drawX,drawY, w,h);
		} else for(int i=0; i< shape.getChildCount(); ++i) {
			PShape childShape = shape.getChild(i);

			// HACK Workaround for children having 0 size
			childShape.width = shape.width;
			childShape.height = shape.height;

			if(randomFills != null) g.fill(randomFills[i]);
			if(randomStrokes != null) g.stroke(randomStrokes[i]);
			g.shape(childShape, drawX,drawY, w,h);
		}
		g.popMatrix();
	}
}
