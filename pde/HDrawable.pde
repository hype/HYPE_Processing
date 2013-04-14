public static abstract class HDrawable extends HNode<HDrawable>
		implements HMovable, HFollowable {
	protected HDrawable _parent, _firstChild, _lastChild;
	protected HBundle _extras;
	protected float
		_x, _y,
		_anchorPercX, _anchorPercY,
		_width, _height,
		_rotationRad, _strokeWeight, _alpha;
	protected int _numChildren, _fill, _stroke, _strokeCap, _strokeJoin;
	public HDrawable() {
		_alpha = 1;
		_fill = H.DEFAULT_FILL;
		_stroke = H.DEFAULT_STROKE;
		_strokeCap = PConstants.ROUND;
		_strokeJoin = PConstants.MITER;
		_strokeWeight = 1;
		_width = 64;
		_height = 64;
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
	public void popOut() {
		if(_parent == null) return;
		if(_prev == null) _parent._firstChild = _next;
		if(_next == null) _parent._lastChild = _prev;
		--_parent._numChildren;
		_parent = null;
		super.popOut();
	}
	public void putBefore(HDrawable dest) {
		if(dest._parent == null) {
			H.warn("No Parent", "HDrawable.putBefore()",
				"Putting this drawable to a parentless chain is not allowed");
			return;
		} else if(dest._parent == this) {
			H.warn("Recursive Child", "HDrawable.putBefore()",
				"You can't add this drawable as a child of itself.");
			return;
		}
		popOut();
		super.putBefore(dest);
		_parent = dest._parent;
		if(_prev == null) _parent._firstChild = this;
		++_parent._numChildren;
	}
	public void putAfter(HDrawable dest) {
		if(dest._parent == null) {
			H.warn("No Parent", "HDrawable.putAfter()",
				"Putting this drawable to a parentless chain is not allowed");
			return;
		} else if(dest._parent == this) {
			H.warn("Recursive Child", "HDrawable.putAfter()",
				"You can't add this drawable as a child of itself.");
			return;
		}
		popOut();
		super.putAfter(dest);
		_parent = dest._parent;
		if(_next == null) _parent._lastChild = this;
		++_parent._numChildren;
	}
	public HDrawable parent() {
		return _parent;
	}
	public int numChildren() {
		return _numChildren;
	}
	public HDrawable add(HDrawable child) {
		if(child == this) {
			H.warn("Recursive Child", "HDrawable.add()",
				"You can't add this drawable as a child of itself.");
			return child;
		}
		if(_lastChild == null) {
			_firstChild = _lastChild = child;
			child.popOut();
			child._parent = this;
			++_numChildren;
		} else child.putAfter(_lastChild);
		return child;
	}
	public HDrawable remove(HDrawable child) {
		if(this == child._parent) child.popOut();
		else H.warn("Not a Child", "HDrawable.remove()",
			"The drawable passed to remove() is not a child of this drawable.");
		return child;
	}
	public HDrawableIterator iterator() {
		return new HDrawableIterator(this);
	}
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
	public HDrawable move(float dx, float dy) {
		_x += dx;
		_y += dy;
		return this;
	}
	public HDrawable locAt(int where) {
		if(_parent!=null) {
			if(HMath.containsBits(where,H.CENTER_X))
				_x = _parent.width()/2 - _parent.anchorX();
			else if(HMath.containsBits(where,H.LEFT))
				_x = -_parent.anchorX();
			else if(HMath.containsBits(where,H.RIGHT))
				_x = _parent.width() - _parent.anchorX();
			if(HMath.containsBits(where,H.CENTER_Y))
				_y = _parent.height()/2 - _parent.anchorY();
			else if(HMath.containsBits(where,H.TOP))
				_y = -_parent.anchorY();
			else if(HMath.containsBits(where,H.BOTTOM))
				_y = _parent.height() + _parent.anchorY();
		}
		return this;
	}
	public HDrawable anchor(float pxX, float pxY) {
		if(_height == 0 || _width == 0) {
			H.warn("Division by 0", "HDrawable.anchor()",
				"Size must be greater than 0 before setting the Anchor " +
				"by pixel. Set the size for this drawable first, or set the " +
				"Anchor by percentage via HDrawable.anchorPerc() instead");
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
			H.warn("Division by 0", "HDrawable.anchorX()",
				"Width must be greater than 0 before setting the X Anchor " +
				"by pixel. Set the width for this drawable first, or set the " +
				"X Anchor by percentage via HDrawable.anchorPercX() instead");
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
			H.warn("Division by 0", "HDrawable.anchorY()",
				"Width must be greater than 0 before setting the Y Anchor " +
				"by pixel. Set the height for this drawable first, or set the " +
				"Y Anchor by percentage via HDrawable.anchorPercY() instead");
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
		if(HMath.containsBits(where,H.CENTER_X))
			_anchorPercX = 0.5f;
		else if(HMath.containsBits(where,H.LEFT))
			_anchorPercX = 0;
		else if(HMath.containsBits(where,H.RIGHT))
			_anchorPercX = 1;
		if(HMath.containsBits(where,H.CENTER_Y))
			_anchorPercY = 0.5f;
		else if(HMath.containsBits(where,H.TOP))
			_anchorPercY = 0;
		else if(HMath.containsBits(where,H.BOTTOM))
			_anchorPercY = 1;
		return this;
	}
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
		_width = w;
		return this;
	}
	public float width() {
		return _width;
	}
	public HDrawable height(float h) {
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
	public PVector boundingSize() {
		PApplet app = H.app();
		float cosVal = app.cos(_rotationRad);
		float sinVal = app.sin(_rotationRad);
		float drawX = -anchorX();
		float drawY = -anchorY();
		float x1 = drawX;			
		float x2 = _width + drawX;	
		float y1 = drawY;			
		float y2 = _height + drawY;	
		float[] xCoords = new float[4];
		float[] yCoords = new float[4];
		xCoords[0] = x1*cosVal + y1*sinVal;
		yCoords[0] = x1*sinVal + y1*cosVal;
		xCoords[1] = x2*cosVal + y1*sinVal;
		yCoords[1] = x2*sinVal + y1*cosVal;
		xCoords[2] = x1*cosVal + y2*sinVal;
		yCoords[2] = x1*sinVal + y2*cosVal;
		xCoords[3] = x2*cosVal + y2*sinVal;
		yCoords[3] = x2*sinVal + y2*cosVal;
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
	public HDrawable fill(int clr) {
		_fill = clr;
		return this;
	}
	public HDrawable fill(int clr, int alpha) {
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
		fill(0x00FFFFFF);
		return this;
	}
	public HDrawable stroke(int clr) {
		_stroke = clr;
		return this;
	}
	public HDrawable stroke(int clr, int alpha) {
		_stroke = HColorUtil.setAlpha(clr,alpha);
		return this;
	}
	public HDrawable stroke(int r, int g, int b) {
		_stroke = HColorUtil.merge(255,r,g,b);
		return this;
	}
	public HDrawable stroke(int r, int g, int b, int a) {
		_stroke = HColorUtil.merge(r,g,b,a);
		return this;
	}
	public int stroke() {
		return _stroke;
	}
	public HDrawable noStroke() {
		stroke(0x00FFFFFF);
		return this;
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
	public HDrawable rotation(float deg) {
		_rotationRad = deg * H.D2R;
		return this;
	}
	public float rotation() {
		return _rotationRad * H.R2D;
	}
	public HDrawable rotationRad(float rad) {
		_rotationRad = rad;
		return this;
	}
	public float rotationRad() {
		return _rotationRad;
	}
	public HDrawable rotate(float deg) {
		_rotationRad += deg * H.D2R;
		return this;
	}
	public HDrawable rotateRad(float rad) {
		_rotationRad += rad;
		return this;
	}
	public HDrawable alpha(int a) {
		return alphaPerc(a/255f);
	}
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
	public float followableX() {
		return _x;
	}
	public float followableY() {
		return _y;
	}
	public HDrawable extras(HBundle b) {
		_extras = b;
		return this;
	}
	public HBundle extras() {
		return _extras;
	}
	protected void applyStyle(PApplet app, float currAlphaPerc) {
		int falpha = _fill>>>24;
		falpha = app.round( currAlphaPerc * falpha ) << 24;
		int currFill = _fill & 0x00FFFFFF | falpha;
		app.fill(currFill);
		if(_strokeWeight > 0) {
			int salpha = _stroke>>>24;
			salpha = app.round( currAlphaPerc * salpha ) << 24;
			int currStroke = _stroke & 0x00FFFFFF | salpha;
			app.stroke(currStroke);
			app.strokeWeight(_strokeWeight);
			app.strokeCap(_strokeCap);
			app.strokeJoin(_strokeJoin);
		} else app.noStroke();
	}
	public void paintAll(PApplet app, float currAlphaPerc) {
		if(_alpha<=0 || _width<0 || _height<0) return;
		app.pushMatrix();
			app.translate(_x,_y);
			app.rotate(_rotationRad);
			currAlphaPerc *= _alpha;
			draw(app,-anchorX(),-anchorY(),currAlphaPerc);
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(app,currAlphaPerc);
				child = child._next;
			}
		app.popMatrix();
	}
	public abstract void draw(
		PApplet app, float drawX, float drawY, float currAlphaPerc);
	public static class HDrawableIterator implements HIterator<HDrawable> {
		private HDrawable parent, d1, d2;
		public HDrawableIterator(HDrawable parentDrawable) {
			parent = parentDrawable;
			d1 = parent._firstChild;
			if(d1 != null) d2 = d1._next;
		}
		public boolean hasNext() {
			return (d1 != null);
		}
		public HDrawable next() {
			HDrawable nxt = d1;
			d1 = d2;
			if(d2 != null) d2 = d2._next;
			return nxt;
		}
		public void remove() {
			d1.popOut();
			--parent._numChildren;
		}
	}
}
