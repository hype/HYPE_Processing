

public static abstract class HDrawable implements HFollower, HFollowable {
	protected HDrawable _parent;
	protected HBundle _extras;
	protected HChildSet _children;
	protected float _x, _y, _drawX, _drawY, _width, _height,
		_rotationRad, _strokeWeight;
	protected int _alpha, _fill, _stroke, _strokeCap, _strokeJoin;
	
	
	// COPY & CREATE //
	
	public HDrawable() {
		_alpha = 255;
		
		_fill = 0x00FFFFFF;
		_stroke = 0x00FFFFFF;
		_strokeCap = PConstants.ROUND;
		_strokeJoin = PConstants.MITER;
		_strokeWeight = 1;
	}
	
	public void copyPropertiesFrom(HDrawable other) {
		_x = other._x;
		_y = other._y;
		_drawX = other._drawX;
		_drawY = other._drawY;
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
	
	public void _set_parent_(HDrawable newParent) {
		_parent = newParent;
	}
	
	public HDrawable parent() {
		return _parent;
	}
	
	public HChildSet children() {
		return _children;
	}
	
	public int numChildren() {
		if(_children==null)
			return 0;
		return _children.getLength();
	}
	
	public boolean hasChildren() {
		return _children!=null && _children.getLength()>0;
	}
	
	public HDrawable add(HDrawable child) {
		if(_children==null)
			_children = new HChildSet(this);
		_children.add(child);
		return child;
	}
	
	public HDrawable remove(HDrawable child) {
		if(_children!=null)
			_children.remove(child);
		return child;
	}
	
	public HIterator<HDrawable> iterator() {
		return _children.iterator();
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
	
	public HDrawable move(float dx, float dy) {
		_x += dx;
		_y += dy;
		return this;
	}
	
	public HDrawable locAt(int where) {
		if(_parent!=null) {
			if(H.containsBits(where,H.CENTER_X))
				_x = _parent.width()/2 + _parent._drawX;
			else if(H.containsBits(where,H.LEFT))
				_x = _parent._drawX;
			else if(H.containsBits(where,H.RIGHT))
				_x = _parent.width() + _parent._drawX;
			
			if(H.containsBits(where,H.CENTER_Y))
				_y = _parent.height()/2 + _parent._drawY;
			else if(H.containsBits(where,H.TOP))
				_y = _parent._drawY;
			else if(H.containsBits(where,H.BOTTOM))
				_y = _parent.height() + _parent._drawY;
		}
		return this;
	}
	
	
	// ANCHOR //
	
	public HDrawable anchor(float ax, float ay) {
		_drawX = -ax;
		_drawY = -ay;
		return this;
	}
	
	public HDrawable anchor(PVector pt) {
		_drawX = -pt.x;
		_drawY = -pt.y;
		return this;
	}
	
	public PVector anchor() {
		return new PVector(-_drawX,-_drawY);
	}
	
	public HDrawable anchorX(float ax) {
		_drawX = -ax;
		return this;
	}
	
	public float anchorX() {
		return -_drawX;
	}
	
	public HDrawable anchorY(float ay) {
		_drawY = -ay;
		return this;
	}
	
	public float anchorY() {
		return -_drawY;
	}
	
	public HDrawable anchorAt(int where) {
		if(H.containsBits(where,H.CENTER_X))
			_drawX = -_width/2;
		else if(H.containsBits(where,H.LEFT))
			_drawX = 0;
		else if(H.containsBits(where,H.RIGHT))
			_drawX = -_width;
		
		if(H.containsBits(where,H.CENTER_Y))
			_drawY = -_height/2;
		else if(H.containsBits(where,H.TOP))
			_drawY = 0;
		else if(H.containsBits(where,H.BOTTOM))
			_drawY = -_height;
		return this;
	}
	
	
	// SIZE //
	
	public HDrawable size(float w, float h) {
		width(w);
		height(h);
		return this;
	}
	
	public HDrawable size(PVector pt) {
		size(pt.x,pt.y);
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
		if(_width != 0) // adjust the anchor
			_drawX *= w/_width;
		_width = w;
		return this;
	}
	
	public float width() {
		return _width;
	}
	
	public HDrawable height(float h) {
		if(_height != 0) // adjust the anchor
			_drawY *= h/_height;
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
	
	
	// STYLE //
	
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
	
	
	// VISIBILITY //
	
	public HDrawable alpha(int a) {
		_alpha = (a<0)? 0 : (a>255)? 255 : a;
		return this;
	}
	
	public int alpha() {
		if(_alpha < 0)
			return 0;
		return _alpha;
	}
	
	public HDrawable visibility(boolean v) {
		if(v && _alpha == 0) {
			_alpha = 255;
		} else if(v == _alpha < 0) {
			_alpha = -_alpha;
		}
		return this;
	}
	
	public boolean visibility() {
		return _alpha > 0;
	}
	
	public HDrawable show() {
		visibility(true);
		return this;
	}
	
	public HDrawable hide() {
		visibility(false);
		return this;
	}
	
	public HDrawable alphaShift(int da) {
		alpha(_alpha + da);
		return this;
	}
	
	
	// UTILITY //
	
	public float followerX() {
		return _x;
	}
	
	public float followerY() {
		return _y;
	}
	
	public float followableX() {
		return _x;
	}
	
	public float followableY() {
		return _y;
	}
	
	public void follow(float dx, float dy) {
		move(dx,dy);
	}
	
	public HDrawable extras(HBundle b) {
		_extras = b;
		return this;
	}
	
	public HBundle extras() {
		return _extras;
	}
	
	public PVector generateRandomPoint() {
		// LATER
		// Simple random rect point by default
		// HEllipse and others will override this
		return null;
	}
	
	public float[] abs2rel(float x, float y) {
		// LATER
		return null;
	}
	
	public float[] rel2abs(float x, float y) {
		// LATER
		return null;
	}
	
	public void set(int propId, float val) {
		switch(propId) {
		case H.WIDTH:		width(val); break;
		case H.HEIGHT:		height(val); break;
		case H.SIZE:		size(val); break;
		case H.ALPHA:		alpha(H.app().round(val)); break;
		case H.X:			x(val); break;
		case H.Y:			y(val); break;
		case H.LOCATION:	loc(val,val); break;
		case H.ROTATION:	rotation(val); break;
		case H.DROTATION:	rotate(val); break;
		case H.DX:			move(val,0); break;
		case H.DY:			move(0,val); break;
		case H.DLOC:		move(val,val); break;
		default: break;
		}
	}
	
	
	// DRAWING //
	
	protected void applyStyle(PApplet app, int currAlpha) {
		int currFill = HColorUtil.multiplyAlpha(_fill,currAlpha);
		app.fill(currFill);
		
		if(_strokeWeight>0) {
			int currStroke = HColorUtil.multiplyAlpha(_stroke,currAlpha);
			app.stroke(currStroke);
			app.strokeWeight(_strokeWeight);
			app.strokeCap(_strokeCap);
			app.strokeJoin(_strokeJoin);
		} else app.noStroke();
	}
	
	public void paintAll(PApplet app,int currAlpha) {
		if(_alpha<=0 || _width<=0 || _height<=0) return;
		
		app.pushMatrix();
			// Rotate and translate
			app.translate(_x,_y);
			app.rotate(_rotationRad);
			
			// Compute current alpha
			currAlpha = HColorUtil.multiply(_alpha,currAlpha);
			
			// Draw self
			draw(app,_drawX,_drawY,currAlpha);
			
			// Draw children
			if(hasChildren()) {
				HIterator<HDrawable> it = _children.iterator();
				while(it.hasNext()) it.next().paintAll(app,currAlpha);
			}
		app.popMatrix();
	}
	
	public abstract void draw(
		PApplet app, float drawX, float drawY, int currAlpha);
}
