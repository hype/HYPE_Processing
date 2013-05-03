package hype.drawable;

import hype.collection.HIterator;
import hype.collection.HNode;
import hype.interfaces.HHittable;
import hype.interfaces.HSwarmer;
import hype.util.H;
import hype.util.HBundle;
import hype.util.HColorUtil;
import hype.util.HConstants;
import hype.util.HMath;
import hype.util.HWarnings;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PVector;

public abstract class HDrawable extends HNode<HDrawable>
		implements HSwarmer, HHittable {
	
	protected HDrawable _parent, _firstChild, _lastChild;
	protected HBundle _extras;
	protected float
		_x, _y,
		_anchorPercX, _anchorPercY,
		_width, _height,
		_rotationRad, _strokeWeight, _alpha, _sizeProportion;
	protected int _numChildren, _fill, _stroke, _strokeCap, _strokeJoin;
	protected boolean _proportional;
	
	
	// COPY & CREATE //
	
	public HDrawable() {
		_alpha = 1;
		
		_fill = HConstants.DEFAULT_FILL;
		_stroke = HConstants.DEFAULT_STROKE;
		_strokeCap = PConstants.ROUND;
		_strokeJoin = PConstants.MITER;
		_strokeWeight = 1;
		
		_width = HConstants.DEFAULT_WIDTH;
		_height = HConstants.DEFAULT_HEIGHT;
	}
	
	public void copyPropertiesFrom(HDrawable other) {
		_x = other._x;
		_y = other._y;
		_anchorPercX = other._anchorPercX;
		_anchorPercY = other._anchorPercY;
		_width = other._width;
		_height = other._height;
		_rotationRad = other._rotationRad;
		_alpha = other._alpha;
		_strokeWeight = other._strokeWeight;
		_fill = other._fill;
		_stroke = other._stroke;
		_strokeCap = other._strokeCap;
		_strokeJoin = other._strokeJoin;
	}
	
	public abstract HDrawable createCopy();
	
	
	// PARENT & CHILD //
	
	protected boolean invalidDest(HDrawable dest, String warnLoc) {
		String warnType;
		String warnMsg;
		
		if( dest == null ) {
			warnType = "Null Destination";
			warnMsg = HWarnings.NULL_ARGUMENT;
		} else if( dest._parent == null ) {
			warnType = "Invalid Destination";
			warnMsg = HWarnings.INVALID_DEST;
		} else if( dest._parent.equals(this) ) {
			warnType = "Recursive Child";
			warnMsg = HWarnings.CHILDCEPTION;
		} else if( dest.equals(this) ) {
			warnType = "Invalid Destination";
			warnMsg = HWarnings.DESTCEPTION;
		} else return false;
		
		HWarnings.warn(warnType, warnLoc, warnMsg);
		return true;
	}
	
	@Override
	public boolean poppedOut() {
		return (_parent == null);
	}
	
	@Override
	public void popOut() {
		if(_parent == null) return;
		
		if(_prev == null) _parent._firstChild = _next;
		if(_next == null) _parent._lastChild = _prev;
		--_parent._numChildren;
		_parent = null;
		super.popOut();
	}
	
	@Override
	public void putBefore(HDrawable dest) {
		if(invalidDest(dest,"HDrawable.putBefore()")) return;
		
		popOut();
		super.putBefore(dest);
		_parent = dest._parent;
		if(_prev == null) _parent._firstChild = this;
		++_parent._numChildren;
	}
	
	@Override
	public void putAfter(HDrawable dest) {
		if(invalidDest(dest,"HDrawable.putAfter()")) return;
		
		popOut();
		super.putAfter(dest);
		_parent = dest._parent;
		if(_next == null) _parent._lastChild = this;
		++_parent._numChildren;
	}
	
	@Override
	public void swapLeft() {
		boolean isLast = (_next == null);
		
		super.swapLeft();
		
		if(_prev == null) _parent._firstChild = this;
		if(_next != null && isLast) _parent._lastChild = _next;
	}
	
	@Override
	public void swapRight() {
		boolean isFirst = (_prev == null);
		
		super.swapRight();
		
		if(_next == null) _parent._lastChild = this;
		if(_prev != null && isFirst) _parent._firstChild = _prev;
	}
	
	@Override
	public void replaceNode(HDrawable dest) {
		if(invalidDest(dest,"HDrawable.replaceNode()")) return;
		
		super.replaceNode(dest);
		
		_parent = dest._parent;
		dest._parent = null;
		
		if(_prev == null) _parent._firstChild = this;
		if(_next == null) _parent._lastChild = this;
	}
	
	public HDrawable parent() {
		return _parent;
	}
	
	public boolean parentOf(HDrawable d) {
		return (d != null) && (d._parent != null) && (d._parent.equals(this));
	}
	
	public int numChildren() {
		return _numChildren;
	}
	
	public HDrawable add(HDrawable child) {
		if(child == null) {
			HWarnings.warn("An Empty Child", "HDrawable.add()",
					HWarnings.NULL_ARGUMENT);
		} else if( !parentOf(child) ) {
			if(_lastChild == null) {
				_firstChild = _lastChild = child;
				child.popOut();
				child._parent = this;
				++_numChildren;
			} else child.putAfter(_lastChild);
		}
		return child;
	}
	
	public HDrawable remove(HDrawable child) {
		if( parentOf(child) ) child.popOut();
		else HWarnings.warn("Not a Child", "HDrawable.remove()", null);
		
		return child;
	}
	
	public HDrawableIterator iterator() {
		return new HDrawableIterator(this);
	}
	
	
	// POSITION //
	
	public HDrawable loc(float newX, float newY) {
		_x = newX;
		_y = newY;
		return this;
	}
	
	public HDrawable loc(PVector pt) {
		_x = pt.x;
		_y = pt.y;
		return this;
	}
	
	public PVector loc() {
		return new PVector(_x,_y);
	}
	
	public HDrawable x(float newX) {
		_x = newX;
		return this;
	}
	
	public float x() {
		return _x;
	}
	
	public HDrawable y(float newY) {
		_y = newY;
		return this;
	}
	
	public float y() {
		return _y;
	}
	
	@Override
	public HDrawable move(float dx, float dy) {
		_x += dx;
		_y += dy;
		return this;
	}
	
	public HDrawable locAt(int where) {
		if(_parent!=null) {
			if(HMath.hasBits(where, HConstants.CENTER_X)) {
				_x = _parent.width()/2 - _parent.anchorX();
			} else if(HMath.hasBits(where, HConstants.LEFT)) {
				_x = -_parent.anchorX();
			} else if(HMath.hasBits(where, HConstants.RIGHT)) {
				_x = _parent.width() - _parent.anchorX();
			}
			if(HMath.hasBits(where, HConstants.CENTER_Y)) {
				_y = _parent.height()/2 - _parent.anchorY();
			} else if(HMath.hasBits(where, HConstants.TOP)) {
				_y = -_parent.anchorY();
			} else if(HMath.hasBits(where, HConstants.BOTTOM)) {
				_y = _parent.height() - _parent.anchorY();
			}
		}
		return this;
	}
	
	
	// ANCHOR //
	
	public HDrawable anchor(float pxX, float pxY) {
		if(_height == 0 || _width == 0) {
			HWarnings.warn("Division by 0", "HDrawable.anchor()",
					HWarnings.ANCHORPX_ERR);
		} else {
			_anchorPercX = pxX / _width;
			_anchorPercY = pxY / _height;
		}
		return this;
	}
	
	public HDrawable anchor(PVector pt) {
		return anchor(pt.x, pt.y);
	}
	
	public PVector anchor() {
		return new PVector( anchorX(), anchorY() );
	}
	
	public HDrawable anchorX(float pxX) {
		if(_width == 0) {
			HWarnings.warn("Division by 0", "HDrawable.anchorX()",
					HWarnings.ANCHORPX_ERR);
		} else {
			_anchorPercX = pxX / _width;
		}
		return this;
	}
	
	public float anchorX() {
		return _width * _anchorPercX;
	}
	
	public HDrawable anchorY(float pxY) {
		if(_height == 0) {
			HWarnings.warn("Division by 0", "HDrawable.anchorY()",
					HWarnings.ANCHORPX_ERR);
		} else {
			_anchorPercY = pxY / _height;
		}
		return this;
	}
	
	public float anchorY() {
		return _height * _anchorPercY;
	}
	
	public HDrawable anchorPerc(float percX, float percY) {
		_anchorPercX = percX;
		_anchorPercY = percY;
		return this;
	}
	
	public PVector anchorPerc() {
		return new PVector(_anchorPercX, _anchorPercY);
	}
	
	public HDrawable anchorPercX(float percX) {
		_anchorPercX = percX;
		return this;
	}
	
	public float anchorPercX() {
		return _anchorPercX;
	}
	
	public HDrawable anchorPercY(float percY) {
		_anchorPercY = percY;
		return this;
	}
	
	public float anchorPercY() {
		return _anchorPercY;
	}
	
	public HDrawable anchorAt(int where) {
		if(HMath.hasBits(where, HConstants.CENTER_X))
			_anchorPercX = 0.5f;
		else if(HMath.hasBits(where, HConstants.LEFT))
			_anchorPercX = 0;
		else if(HMath.hasBits(where, HConstants.RIGHT))
			_anchorPercX = 1;
		
		if(HMath.hasBits(where, HConstants.CENTER_Y))
			_anchorPercY = 0.5f;
		else if(HMath.hasBits(where, HConstants.TOP))
			_anchorPercY = 0;
		else if(HMath.hasBits(where, HConstants.BOTTOM))
			_anchorPercY = 1;
		return this;
	}
	
	
	// SIZE //
	
	public HDrawable size(float w, float h) {
		width(w);
		height(h);
		return this;
	}
	
	public HDrawable size(float s) {
		size(s,s);
		return this;
	}
	
	public PVector size() {
		return new PVector(_width,_height);
	}
	
	public HDrawable width(float w) {
		if(_proportional) _height = w/_sizeProportion;
		_width = w;
		return this;
	}
	
	public float width() {
		return _width;
	}
	
	public HDrawable height(float h) {
		if(_proportional) _width = h*_sizeProportion;
		_height = h;
		return this;
	}
	
	public float height() {
		return _height;
	}
	
	public HDrawable scale(float s) {
		size(_width*s, _height*s);
		return this;
	}
	
	public HDrawable scale(float sw, float sh) {
		size(_width*sw, _height*sh);
		return this;
	}
	
	public HDrawable proportional(boolean b) {
		_proportional = b;
		if(_proportional) {
			_sizeProportion = _width/_height;
		}
		return this;
	}
	
	public boolean proportional() {
		return _proportional;
	}
	
	@SuppressWarnings("static-access")
	public PVector boundingSize() {
		// TODO boundingBox()
		// this code probably needs some *actual* optimization too.
		
		// !!CAUTION!! Maths ahead! 
		PApplet app = H.app();
		
		float cosVal = app.cos(_rotationRad);
		float sinVal = app.sin(_rotationRad);
		float drawX = -anchorX();
		float drawY = -anchorY();
		
		float x1 = drawX;			// left x
		float x2 = _width + drawX;	// right x
		float y1 = drawY;			// top y
		float y2 = _height + drawY;	// bottom y
		
		float[] xCoords = new float[4];
		float[] yCoords = new float[4];
		
		// top-left
		xCoords[0] = x1*cosVal + y1*sinVal;
		yCoords[0] = x1*sinVal + y1*cosVal;
		
		// top-right
		xCoords[1] = x2*cosVal + y1*sinVal;
		yCoords[1] = x2*sinVal + y1*cosVal;
		
		// bottom-left
		xCoords[2] = x1*cosVal + y2*sinVal;
		yCoords[2] = x1*sinVal + y2*cosVal;
		
		// bottom-right
		xCoords[3] = x2*cosVal + y2*sinVal;
		yCoords[3] = x2*sinVal + y2*cosVal;
		
		// get the min/max x & y with one loop 
		float minX = xCoords[3];
		float maxX = minX;
		float minY = yCoords[3];
		float maxY = maxX;
		for(int i=0; i<3; ++i) {
			float x = xCoords[i];
			float y = yCoords[i];
			
			if(x < minX) minX = x;
			else if(x > maxX) maxX = x;
			
			if(y < minY) minY = y;
			else if(y > maxY) maxY = y;
		}
		
		return new PVector(maxX-minX, maxY-minY);
	}
	
	
	// STYLE //
	
	public HDrawable fill(int clr) {
		if(0 <= clr && clr <= 255) clr |= clr<<8 | clr<<16 | 0xFF000000;
		_fill = clr;
		return this;
	}
	
	public HDrawable fill(int clr, int alpha) {
		if(0 <= clr && clr <= 255) clr |= clr<<8 | clr<<16;
		_fill = HColorUtil.setAlpha(clr,alpha);
		return this;
	}
	
	public HDrawable fill(int r, int g, int b) {
		_fill = HColorUtil.merge(255,r,g,b);
		return this;
	}
	
	public HDrawable fill(int r, int g, int b, int a) {
		_fill = HColorUtil.merge(a,r,g,b);
		return this;
	}
	
	public int fill() {
		return _fill;
	}
	
	public HDrawable noFill() {
		return fill(HConstants.CLEAR);
	}

	public HDrawable stroke(int clr) {
		if(0 <= clr && clr <= 255) clr |= clr<<8 | clr<<16 | 0xFF000000;
		_stroke = clr;
		return this;
	}
	
	public HDrawable stroke(int clr, int alpha) {
		if(0 <= clr && clr <= 255) clr |= clr<<8 | clr<<16;
		_stroke = HColorUtil.setAlpha(clr,alpha);
		return this;
	}
	
	public HDrawable stroke(int r, int g, int b) {
		_stroke = HColorUtil.merge(255,r,g,b);
		return this;
	}
	
	public HDrawable stroke(int r, int g, int b, int a) {
		_stroke = HColorUtil.merge(a,r,g,b);
		return this;
	}

	public int stroke() {
		return _stroke;
	}
	
	public HDrawable noStroke() {
		return stroke(HConstants.CLEAR);
	}

	public HDrawable strokeCap(int type) {
		_strokeCap = type;
		return this;
	}

	public int strokeCap() {
		return _strokeCap;
	}

	public HDrawable strokeJoin(int type) {
		_strokeJoin = type;
		return this;
	}

	public int strokeJoin() {
		return _strokeJoin;
	}
	
	public HDrawable strokeWeight(float f) {
		_strokeWeight = f;
		return this;
	}
	
	public float strokeWeight() {
		return _strokeWeight;
	}
	
	
	// ROTATION //
	
	public HDrawable rotation(float deg) {
		_rotationRad = deg * HConstants.D2R;
		return this;
	}
	
	public float rotation() {
		return _rotationRad * HConstants.R2D;
	}
	
	@Override
	public HDrawable rotationRad(float rad) {
		_rotationRad = rad;
		return this;
	}
	
	@Override
	public float rotationRad() {
		return _rotationRad;
	}
	
	public HDrawable rotate(float deg) {
		_rotationRad += deg * HConstants.D2R;
		return this;
	}
	
	public HDrawable rotateRad(float rad) {
		_rotationRad += rad;
		return this;
	}
	
	
	// VISIBILITY //
	
	public HDrawable alpha(int a) {
		return alphaPerc(a/255f);
	}
	
	@SuppressWarnings("static-access")
	public int alpha() {
		return H.app().round( alphaPerc()*255 );
	}
	
	public HDrawable alphaPerc(float aPerc) {
		_alpha = (aPerc<0)? 0 : (aPerc>1)? 1 : aPerc;
		return this;
	}
	
	public float alphaPerc() {
		return (_alpha<0)? 0 : _alpha;
	}
	
	public HDrawable visibility(boolean v) {
		if(v && _alpha == 0) {
			_alpha = 1;
		} else if(v == _alpha < 0) {
			_alpha = -_alpha;
		}
		return this;
	}
	
	public boolean visibility() {
		return _alpha > 0;
	}
	
	public HDrawable show() {
		return visibility(true);
	}
	
	public HDrawable hide() {
		return visibility(false);
	}
	
	public HDrawable alphaShift(int da) {
		return alphaShiftPerc( da/255f );
	}
	
	public HDrawable alphaShiftPerc(float daPerc) {
		return alphaPerc(_alpha + daPerc);
	}
	
	
	// UTILITY //
	
	public HDrawable extras(HBundle b) {
		_extras = b;
		return this;
	}
	
	public HBundle extras() {
		return _extras;
	}
	
	@Override
	public boolean contains(float absX, float absY) {
		float[] rel = HMath.relLocArr(this, absX, absY);
		rel[0] += anchorX();
		rel[1] += anchorY();
		return containsRel(rel[0], rel[1]);
	}
	
	@Override
	public boolean containsRel(float relX, float relY) {
		return (0 <= relX) && (relX <= width()) &&
			(0 <= relY) && (relY <= height());
	}
	
	
	// DRAWING //
	
	@SuppressWarnings("static-access")
	protected void applyStyle(PGraphics g, float currAlphaPerc) {
		PApplet app = H.app();
		float faPerc = currAlphaPerc * (_fill >>> 24);
		g.fill(_fill | 0xFF000000, app.round(faPerc));
		
		if(_strokeWeight > 0) {
			float saPerc = currAlphaPerc * (_stroke >>> 24);
			g.stroke(_stroke | 0xFF000000, app.round(saPerc));
			g.strokeWeight(_strokeWeight);
			g.strokeCap(_strokeCap);
			g.strokeJoin(_strokeJoin);
		} else g.noStroke();
	}
	
	public void paintAll(PGraphics g, float currAlphaPerc) {
		if(_alpha<=0 || _width<0 || _height<0) return;
		g.pushMatrix();
			// Rotate and translate
			g.translate(_x,_y);
			g.rotate(_rotationRad);
			
			// Compute current alpha
			currAlphaPerc *= _alpha;
			
			// Draw self
			draw(g,-anchorX(),-anchorY(),currAlphaPerc);
			
			// Draw children
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g,currAlphaPerc);
				child = child._next;
			}
		g.popMatrix();
	}
	
	public abstract void draw(
		PGraphics g, float drawX, float drawY, float currAlphaPerc);
	
	
	
	public static class HDrawableIterator implements HIterator<HDrawable> {
		private HDrawable parent, d1, d2;
		
		public HDrawableIterator(HDrawable parentDrawable) {
			parent = parentDrawable;
			d1 = parent._firstChild;
			if(d1 != null) d2 = d1._next;
		}
		
		@Override
		public boolean hasNext() {
			return (d1 != null);
		}
		
		@Override
		public HDrawable next() {
			HDrawable nxt = d1;
			d1 = d2;
			if(d2 != null) d2 = d2._next;
			return nxt;
		}
		
		@Override
		public void remove() {
			if(d1 != null) d1.popOut();
		}
		
	}
}
