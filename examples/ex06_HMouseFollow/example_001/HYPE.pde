

public static class H implements HConstants {
	private static H _self;
	private static PApplet _app;
	private static HStage _stage;
	private static boolean _usingTempSeed;
	private static int _resetSeedValue;
	
	
	// INIT & INSTANCES //
	
	public static H init(PApplet applet) {
		_app = applet;
		if(_self == null) _self = new H();
		if(_stage == null) _stage = new HStage(_app);
		
		return _self;
	}
	
	public static HStage stage() {
		return _stage;
	}
	
	public static PApplet app() {
		return _app;
	}
	
	
	// STAGE //
	
	public static H background(int clr) {
		_stage.background(clr);
		return _self;
	}
	
	public static H backgroundImg(Object arg) {
		_stage.backgroundImg(arg);
		return _self;
	}
	
	public static H autoClear(boolean b) {
		_stage.autoClear(b);
		return _self;
	}
	
	public static boolean autoClear() {
		return _stage.autoClear();
	}
	
	public static H clearStage() {
		_stage.clear();
		return _self;
	}
	
	public static H drawStage() {
		_stage.paintAll(_app,0);
		return _self;
	}
	
	public static HDrawable add(HDrawable stageChild) {
		return _stage.add(stageChild);
	}
	
	public static HDrawable remove(HDrawable stageChild) {
		return _stage.remove(stageChild);
	}
	
	public static H addBehavior(HBehavior b) {
		_stage.behaviors().add(b);
		return _self;
	}
	
	public static H removeBehavior(HBehavior b) {
		_stage.behaviors().remove(b);
		return _self;
	}
	
	public static boolean mouseStarted() {
		return _stage.mouseStarted();
	}
	
	
	// MATH //
	
	public static float yAxisAngle(float x1, float y1, float x2, float y2) {
		return _app.atan2(x2-x1, y2-y1);
	}
	
	public static float xAxisAngle(float x1, float y1, float x2, float y2) {
		return _app.atan2(y2-y1, x2-x1);
	}
	
	public static int randomInt32() {
		float f = _app.random(1);
		f = _app.map(f, 0, 1, -2147483648, 2147483647);
		return _app.round(f);
	}
	
	public static void tempSeed(long seed) {
		if(!_usingTempSeed) {
			_resetSeedValue = randomInt32();
			_usingTempSeed = true;
		}
		_app.randomSeed(seed);
	}
	
	public static void removeTempSeed() {
		_app.randomSeed(_resetSeedValue);
	}
	
	public static boolean containsBits(int target, int val) {
		return ( (target & val) == val );
	}
	
	
	// STRING //
	
	public static boolean endsWith(String haystack, String needle) {
		return (haystack.indexOf(needle,haystack.length()-needle.length()) > 0);
	}
	
	private H() {}
}


public static abstract class HBehavior {
	public HBehavior() {
		// Register this by default
		H.addBehavior(this);
	}
	
	public HBehavior register() {
		H.addBehavior(this);
		return this;
	}
	
	public HBehavior unregister() {
		H.removeBehavior(this);
		return this;
	}
	
	public abstract void runBehavior();
}


public static class HBundle {
	private HashMap<String,Object> objectContents;
	private HashMap<String,Float> numberContents;
	
	public HBundle() {
		objectContents = new HashMap<String,Object>();
		numberContents = new HashMap<String,Float>();
	}
	
	public HBundle obj(String key, Object value) {
		objectContents.put(key,value);
		return this;
	}
	
	public HBundle num(String key, float value) {
		numberContents.put(key,value);
		return this;
	}
	
	public Object obj(String key) {
		return objectContents.get(key);
	}
	
	public float num(String key) {
		return numberContents.get(key);
	}
	
	public int numI(String key) {
		return H.app().round(numberContents.get(key));
	}
	
	public boolean numB(String key) {
		return (numberContents.get(key) != 0);
	}
}

public static interface HCallback {
	public void run(Object obj);
}


public static class HChildSet extends HLinkedHashSet<HDrawable> {
	private HDrawable _parent;
	
	public HChildSet(HDrawable parent) {
		_parent = parent;
	}
	
	protected HLinkNode<HDrawable> register(HDrawable d) {
		HDrawable dparent = d.parent();
		if(dparent != null)
			dparent.remove(d);
		d._set_parent_(_parent);
		return super.register(d);
	}
	
	protected HDrawable unregister(HDrawable d) {
		if(contains(d))
			d._set_parent_(null);
		return super.unregister(d);
	}
}




public static class HColorField implements HColorist {
	protected ArrayList<HColorPoint> colorPoints;
	protected float maxDist;
	protected boolean fillFlag, strokeFlag;
	
	public HColorField() {
		this(H.app().width, H.app().height);
	}
	
	public HColorField(float xBound, float yBound) {
		this(H.app().sqrt(xBound*xBound + yBound*yBound));
	}
	
	public HColorField(float maximumDistance) {
		colorPoints = new ArrayList<HColorField.HColorPoint>();
		maxDist = maximumDistance;
		fillAndStroke();
	}
	
	public HColorField addPoint(PVector loc, int clr, float radius) {
		return addPoint(loc.x,loc.y, clr, radius);
	}
	
	public HColorField addPoint(float x, float y, int clr, float radius) {
		HColorPoint pt = new HColorPoint();
		pt.x = x;
		pt.y = y;
		pt.radius = radius;
		pt.clr = clr;
		colorPoints.add(pt);
		return this;
	}
	
	public int getColor(float x, float y, int baseColor) {
		PApplet app = H.app();
		int[] baseClrs = HColorUtil.explode(baseColor);
		int[] maxClrs = new int[4];
		
		for(int i=0; i<colorPoints.size(); i++) {
			HColorPoint pt = colorPoints.get(i);
			
			int[] ptClrs = HColorUtil.explode(pt.clr);
			
			float distLimit = maxDist * pt.radius;
			float dist = app.dist(x,y, pt.x,pt.y);
			if(dist > distLimit)
				dist = distLimit;
			
			for(int j=0; j<4; j++) {
				int newClrVal = app.round(
					app.map(dist, 0,distLimit, ptClrs[j], baseClrs[j]));
				if(newClrVal > maxClrs[j])
					maxClrs[j] = newClrVal;
			}
		}
		return HColorUtil.merge(maxClrs[0],maxClrs[1],maxClrs[2],maxClrs[3]);
	}

	public HColorField fillOnly() {
		fillFlag = true;
		strokeFlag = false;
		return this;
	}

	public HColorField strokeOnly() {
		fillFlag = false;
		strokeFlag = true;
		return this;
	}

	public HColorField fillAndStroke() {
		fillFlag = strokeFlag = true;
		return this;
	}
	
	public boolean appliesFill() {
		return fillFlag;
	}
	
	public boolean appliesStroke() {
		return strokeFlag;
	}
	
	public HDrawable applyColor(HDrawable drawable) {
		float x = drawable.x();
		float y = drawable.y();
		
		if(fillFlag) {
			int baseFill = drawable.fill();
			drawable.fill( getColor(x,y, baseFill) );
		}
		if(strokeFlag) {
			int baseStroke = drawable.stroke();
			drawable.stroke( getColor(x,y, baseStroke) );
		}
		return drawable;
	}
	
	public static class HColorPoint {
		float x, y, radius;
		int clr;
	}
}




public static class HColorPool implements HColorist {
	protected ArrayList<Integer> _colorList;
	protected boolean _fillFlag, _strokeFlag;
	
	public HColorPool(int... colors) {
		_colorList = new ArrayList<Integer>();
		for(int i=0; i<colors.length; i++) add(colors[i]);
		
		fillAndStroke();
	}
	
	public HColorPool createCopy() {
		HColorPool copy = new HColorPool();
		copy._fillFlag = _fillFlag;
		copy._strokeFlag = _strokeFlag;
		
		for(int i=0; i<_colorList.size(); i++) {
			int clr = _colorList.get(i);
			copy._colorList.add( clr );
		}
		return copy;
	}
	
	public int size() { 
		return _colorList.size();
	}
	
	public HColorPool add(int clr) {
		_colorList.add(clr);
		return this;
	}
	
	public HColorPool add(int clr, int freq) {
		while(freq-- > 0) _colorList.add(clr);
		return this;
	}
	
	public int getColor() {
		if(_colorList.size() <= 0) return 0;
		
		PApplet app = H.app();
		int index = app.round(app.random(_colorList.size()-1));
		return _colorList.get(index);
	}
	
	public int getColor(int seed) {
		H.tempSeed(seed);
		int clr = getColor();
		H.removeTempSeed();
		return clr;
	}

	public HColorPool fillOnly() {
		_fillFlag = true;
		_strokeFlag = false;
		return this;
	}
	
	public HColorPool strokeOnly() {
		_fillFlag = false;
		_strokeFlag = true;
		return this;
	}
	
	public HColorPool fillAndStroke() {
		_fillFlag = _strokeFlag = true;
		return this;
	}
	
	public boolean appliesFill() {
		return _fillFlag;
	}
	
	public boolean appliesStroke() {
		return _strokeFlag;
	}
	
	public HDrawable applyColor(HDrawable drawable) {
		if(_fillFlag)
			drawable.fill(getColor());
		if(_strokeFlag)
			drawable.stroke(getColor());
		return drawable;
	}
}


public static class HColorTransform implements HColorist {
	public float _percA, _percR, _percG, _percB;
	public int _offsetA, _offsetR, _offsetG, _offsetB;
	protected boolean fillFlag, strokeFlag;
	
	public HColorTransform() {
		_percA = _percR = _percG = _percB = 1;
		fillAndStroke();
	}
	
	public HColorTransform offset(int off) {
		_offsetA = _offsetR = _offsetG = _offsetB = off;
		return this;
	}
	
	public HColorTransform offset(int r, int g, int b, int a) {
		_offsetA = a;
		_offsetR = r;
		_offsetG = g;
		_offsetB = b;
		return this;
	}
	
	public HColorTransform offsetA(int a) {
		_offsetA = a;
		return this;
	}
	
	public int offsetA() {
		return _offsetA;
	}
	
	public HColorTransform offsetR(int r) {
		_offsetR = r;
		return this;
	}
	
	public int offsetR() {
		return _offsetR;
	}
	
	public HColorTransform offsetG(int g) {
		_offsetG = g;
		return this;
	}
	
	public int offsetG() {
		return _offsetG;
	}
	
	public HColorTransform offsetB(int b) {
		_offsetB = b;
		return this;
	}
	
	public int offsetB() {
		return _offsetB;
	}
	
	public HColorTransform perc(float percentage) {
		_percA = _percR = _percG = _percB = percentage;
		return this;
	}
	
	public HColorTransform perc(int r, int g, int b, int a) {
		_percA = a;
		_percR = r;
		_percG = g;
		_percB = b;
		return this;
	}
	
	public HColorTransform percA(float a) {
		_percA = a;
		return this;
	}
	
	public float percA() {
		return _percA;
	}
	
	public HColorTransform percR(float r) {
		_percR = r;
		return this;
	}
	
	public float percR() {
		return _percR;
	}
	
	public HColorTransform percG(float g) {
		_percG = g;
		return this;
	}
	
	public float percG() {
		return _percG;
	}
	
	public HColorTransform percB(float b) {
		_percB = b;
		return this;
	}
	
	public float percB() {
		return _percB;
	}
	
	public HColorTransform mergeWith(HColorTransform other) {
		if(other != null) {
			_percA *= other._percA;
			_percR *= other._percR;
			_percG *= other._percG;
			_percB *= other._percB;
			_offsetA += other._offsetA;
			_offsetR += other._offsetR;
			_offsetG += other._offsetG;
			_offsetB += other._offsetB;
		}
		return this;
	}
	
	public HColorTransform createCopy() {
		HColorTransform copy = new HColorTransform();
		copy._percA = _percA;
		copy._percR = _percR;
		copy._percG = _percG;
		copy._percB = _percB;
		copy._offsetA = _offsetA;
		copy._offsetR = _offsetR;
		copy._offsetG = _offsetG;
		copy._offsetB = _offsetB;
		return copy;
	}
	
	public HColorTransform createNew(HColorTransform other) {
		return createCopy().mergeWith(other);
	}

	public int getColor(int origColor) {
		PApplet app = H.app();
		int[] clrs = HColorUtil.explode(origColor);
		clrs[0] = app.round(clrs[0] * _percA) + _offsetA;
		clrs[1] = app.round(clrs[1] * _percR) + _offsetR;
		clrs[2] = app.round(clrs[2] * _percG) + _offsetG;
		clrs[3] = app.round(clrs[3] * _percB) + _offsetB;
		return HColorUtil.merge(clrs[0],clrs[1],clrs[2],clrs[3]);
	}

	public HColorTransform fillOnly() {
		fillFlag = true;
		strokeFlag = false;
		return this;
	}

	public HColorTransform strokeOnly() {
		fillFlag = false;
		strokeFlag = true;
		return this;
	}

	public HColorTransform fillAndStroke() {
		fillFlag = strokeFlag = true;
		return this;
	}
	
	public boolean appliesFill() {
		return fillFlag;
	}
	
	public boolean appliesStroke() {
		return strokeFlag;
	}
	
	public HDrawable applyColor(HDrawable drawable) {
		if(fillFlag) {
			int fill = drawable.fill();
			drawable.fill( getColor(fill) );
		}
		if(strokeFlag) {
			int stroke = drawable.stroke();
			drawable.stroke( getColor(stroke) );
		}
		return drawable;
	}
}


public static class HColorUtil {
	public static int[] explode(int clr) {
		int[] explodedColors = new int[4];
		for(int i=0; i<4; i++) explodedColors[3-i] = (clr >>> (i*8)) & 0xFF;
		return explodedColors;
	}
	
	public static int merge(int a, int r, int g, int b) {
		PApplet app = H.app();
		a = app.constrain(a, 0, 0xFF);
		r = app.constrain(r, 0, 0xFF);
		g = app.constrain(g, 0, 0xFF);
		b = app.constrain(b, 0, 0xFF);
		return (a<<24) | (r<<16) | (g<<8) | b;
	}
	
	public static int setAlpha(int clr, int newAlpha) {
		newAlpha = H.app().constrain(newAlpha, 0, 0xFF);
		return clr & 0x00FFFFFF | (newAlpha << 24);
	}
	
	public static int setRed(int clr, int newRed) {
		newRed = H.app().constrain(newRed, 0, 0xFF);
		return clr & 0xFF00FFFF | (newRed << 16);
	}
	
	public static int setGreen(int clr, int newGreen) {
		newGreen = H.app().constrain(newGreen, 0, 0xFF);
		return clr & 0xFFFF00FF | (newGreen << 8);
	}
	
	public static int setBlue(int clr, int newBlue) {
		newBlue = H.app().constrain(newBlue, 0, 0xFF);
		return clr & 0xFFFFFF00 | newBlue;
	}
	
	public static int getAlpha(int clr) {
		return clr >>> 24;
	}
	
	public static int getRed(int clr) {
		return (clr >>> 16) & 255;
	}
	
	public static int getGreen(int clr) {
		return (clr >>> 8) & 255;
	}
	
	public static int getBlue(int clr) {
		return clr & 255;
	}
	
	public static int multiply(int c1, int c2) {
		return H.app().round(c1 * c2 / 255f);
	}
	
	public static int multiplyAlpha(int clr, int a) {
		return clr & 0x00FFFFFF | ( multiply(getAlpha(clr),a) << 24 );
	}
	
	public static int multiplyRed(int clr, int r) {
		return clr & 0xFF00FFFF | ( multiply(getRed(clr),r) << 16 );
	}
	
	public static int multiplyGreen(int clr, int g) {
		return clr & 0xFFFF00FF | ( multiply(getGreen(clr),g) << 8 );
	}

	public static int multiplyBlue(int clr, int b) {
		return clr & 0xFFFFFF00 | multiply(getBlue(clr),b);
	}
}


public static interface HColorist {
	public HColorist fillOnly();
	public HColorist strokeOnly();
	public HColorist fillAndStroke();
	public boolean appliesFill();
	public boolean appliesStroke();
	public HDrawable applyColor(HDrawable drawable);
}


public static interface HConstants {
	public static final int
		// Generic constants
		NONE = 0,
		SIN = 1,
		COS = 2,
		TAN = 3,
		
		// "where" constants (as used in locAt() & anchorAt())
		LEFT   = 1, // 0b0001
		RIGHT  = 2, // 0b0010
		TOP    = 4, // 0b0100
		BOTTOM = 8, // 0b1000
		CENTER_X = 3, // 0b0011
		CENTER_Y = 12, // 0b1100
		CENTER = 15, // 0b1111
		
		DEFAULT_BACKGROUND_COLOR = 0xFFECF2F5,
		
		// Oscillation types
		SAW = 0,
		SINE = 1,
		TRIANGLE = 2,
		SQUARE = 3,
		
		// HDrawable property identifiers
		WIDTH = 0,
		HEIGHT = 1,
		SIZE = 2,
		ALPHA = 3,
		X = 4,
		Y = 5,
		LOCATION = 6,
		ROTATION = 7,
		DROTATION = 8,
		DX = 9,
		DY = 10,
		DLOC = 11;
	
	public static final float
		// Degree-Radians conversion shortcuts
		D2R = PConstants.PI / 180f,
		R2D = 180f / PConstants.PI;
}


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




public static class HDrawablePool {
	protected HLinkedHashSet<HDrawable> activeDrawables, inactiveDrawables;
	protected ArrayList<HDrawable> prototypes;
	public HCallback onCreateCallback, onRequestCallback, onReleaseCallback;
	public HPoolListener currentListener;
	protected HLayout currentLayout;
	protected HColorist currentColorist;
	protected HDrawable currentAutoParent;
	protected int maxDrawables;
	
	public HDrawablePool() {
		this(64);
	}
	
	public HDrawablePool(int maximumDrawables) {
		maxDrawables = maximumDrawables;
		activeDrawables = new HLinkedHashSet<HDrawable>();
		inactiveDrawables = new HLinkedHashSet<HDrawable>();
		prototypes = new ArrayList<HDrawable>();
	}
	
	public int max() {
		return maxDrawables;
	}
	
	public HDrawablePool max(int m) {
		maxDrawables = m;
		return this;
	}
	
	public int numActive() {
		return activeDrawables.getLength();
	}
	
	public int numInactive() {
		return inactiveDrawables.getLength();
	}
	
	public int currentIndex() {
		return activeDrawables.getLength() - 1;
	}
	
	public HLayout layout() {
		return currentLayout;
	}
	
	public HDrawablePool layout(HLayout newLayout) {
		currentLayout = newLayout;
		return this;
	}
	
	public HColorist colorist() {
		return currentColorist;
	}
	
	public HDrawablePool colorist(HColorist newColorist) {
		currentColorist = newColorist;
		return this;
	}
	
	public HDrawablePool setOnCreate(HCallback callback) {
		onCreateCallback = callback;
		return this;
	}
	
	public HDrawablePool listener(HPoolListener newListener) {
		currentListener = newListener;
		return this;
	}
	
	public HPoolListener listener() {
		return currentListener;
	}
	
	public HDrawablePool setOnRequest(HCallback callback) {
		onRequestCallback = callback;
		return this;
	}
	
	public HDrawablePool setOnRelease(HCallback callback) {
		onReleaseCallback = callback;
		return this;
	}
	
	public HDrawablePool autoParent(HDrawable parent) {
		currentAutoParent = parent;
		return this;
	}
	
	public HDrawablePool autoAddToStage() {
		currentAutoParent = H.stage();
		return this;
	}
	
	public HDrawable autoParent() {
		return currentAutoParent;
	}
	
	public boolean isFull() {
		return maxDrawables <= count();
	}
	
	public int count() {
		return activeDrawables.getLength() + inactiveDrawables.getLength();
	}
	
	public HDrawablePool destroy() {
		activeDrawables.removeAll();
		inactiveDrawables.removeAll();
		prototypes.clear();
		
		onCreateCallback = onRequestCallback = onReleaseCallback = null;
		currentLayout = null;
		currentAutoParent = null;
		maxDrawables = 0;
		
		return this;
	}
	
	public HDrawablePool add(HDrawable prototype, int frequency) {
		if(prototype == null) {
			H.app().println("Invalid Argument on HObjectPool.add(): " +
				"Your prototype is null!");
		} else {
			prototypes.add(prototype);
			while(frequency-- > 0) prototypes.add(prototype);
		}
		return this;
	}
	
	public HDrawablePool add(HDrawable prototype) {
		return add(prototype,1);
	}
	
	public HDrawable request() {
		if(prototypes.size() <= 0) {
			H.app().println("HDrawablePool.request(): " +
				"can't create a new object without a prototype.");
			return null;
		}
		
		HDrawable drawable;
		boolean onCreateFlag = false;
		
		if(inactiveDrawables.getLength() > 0) {
			drawable = inactiveDrawables.pull();
		} else if(count() < maxDrawables) {
			drawable = createRandomDrawable();
			onCreateFlag = true;
		} else return null;
		
		activeDrawables.add(drawable);
		if(currentAutoParent != null)
			currentAutoParent.add(drawable);
		if(currentLayout != null)
			currentLayout.applyTo(drawable);
		if(currentColorist != null)
			currentColorist.applyColor(drawable);
		if(currentListener != null) {
			int index = currentIndex();
			if(onCreateFlag)
				currentListener.onCreate(drawable, index, this);
			currentListener.onRequest(drawable, index, this);
		}
		if(onCreateFlag && onCreateCallback != null)
			onCreateCallback.run(drawable);
		if(onRequestCallback != null)
			onRequestCallback.run(drawable);
		return drawable;
	}
	
	public HDrawablePool requestAll() {
		while(count() < maxDrawables) request();
		return this;
	}
	
	public boolean release(HDrawable d) {
		if(activeDrawables.remove(d)) {
			inactiveDrawables.add(d);
			
			if(currentAutoParent != null)
				currentAutoParent.remove(d);
			
			if(currentListener != null)
				currentListener.onRelease(d, currentIndex(), this);
			if(onReleaseCallback != null)
				onReleaseCallback.run(d);
			return true;
		}
		return false;
	}
	
	public HLinkedHashSet<HDrawable> activeSet() {
		return activeDrawables;
	}
	
	public HLinkedHashSet<HDrawable> inactiveSet() {
		return inactiveDrawables;
	}
	
	protected HDrawable createRandomDrawable() {
		PApplet app = H.app();
		int numPrototypes = prototypes.size();
		int index = app.round( app.random(numPrototypes-1) );
		return prototypes.get(index).createCopy();
	}

	public HIterator<HDrawable> iterator() {
		return activeDrawables.iterator();
	}
}


public static class HEllipse extends HDrawable {
	public HEllipse() {
		radius(8);
	}
	
	public HEllipse(float ellipseRadius) {
		radius(ellipseRadius);
	}
	
	public HEllipse(float radiusX, float radiusY) {
		radius(radiusX,radiusY);
	}
	
	public HEllipse createCopy() {
		HEllipse copy = new HEllipse();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	public HEllipse radius(float r) {
		size(r*2);
		return this;
	}
	
	public HEllipse radius(float radiusX, float radiusY) {
		size(radiusX*2,radiusY*2);
		return this;
	}
	
	public HEllipse radiusX(float radiusX) {
		width(radiusX * 2);
		return this;
	}
	
	public float radiusX() {
		return _width/2;
	}
	
	public HEllipse radiusY(float radiusY) {
		height(radiusY * 2);
		return this;
	}
	
	public float radiusY() {
		return _height/2;
	}
	
	public boolean isCircle() {
		return _width == _height;
	}
	
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {
		applyStyle(app,currAlpha);
		app.ellipse(drawX+_width/2, drawY+_height/2, _width, _height);
	}
}


public static class HFollow extends HBehavior {
	protected float _ease, _spring, _dx, _dy;
	protected HFollowable _goal;
	protected HFollower _follower;
	
	public HFollow() {
		this(1);
	}
	
	public HFollow(float ease) {
		this(ease,0);
	}
	
	public HFollow(float ease, float spring) {
		this(ease, spring, H.stage());
	}
	
	public HFollow(float ease, float spring, HFollowable goal) {
		_ease = ease;
		_spring = spring;
		_goal = goal;
		
		H.addBehavior(this);
	}
	
	public HFollow ease(float f) {
		_ease = f;
		return this;
	}
	
	public float ease() {
		return _ease;
	}
	
	public HFollow spring(float f) {
		_spring = f;
		return this;
	}
	
	public float spring() {
		return _spring;
	}
	
	public HFollow goal(HFollowable g) {
		_goal = g;
		return this;
	}
	
	public HFollowable goal() {
		return _goal;
	}
	
	public HFollow followMouse() {
		_goal = H.stage();
		return this;
	}
	
	public HFollow target(HFollower f) {
		_follower = f;
		return this;
	}
	
	public HFollower target() {
		return _follower;
	}
	
	public void runBehavior() {
		if(_follower==null || ! H.stage().mouseStarted()) return;
		
		_dx = _dx*_spring +
			(_goal.followableX()-_follower.followerX()) * _ease;
		
		_dy = _dy*_spring +
			(_goal.followableY()-_follower.followerY()) * _ease;
		
		_follower.follow(_dx,_dy);
	}
	
	public HFollow register() {
		return (HFollow) super.register();
	}
	
	public HFollow unregister() {
		return (HFollow) super.unregister();
	}
}

public static interface HFollowable {
	public float followableX();
	public float followableY();
}

public static interface HFollower {
	public float followerX();
	public float followerY();
	public void follow(float dx, float dy);
}


public static class HGridLayout implements HLayout {
	protected int _currentIndex, _numCols;
	protected float _startX, _startY, _xSpace, _ySpace;

	public HGridLayout() {
		_xSpace = _ySpace = _numCols = 16;
	}
	
	public HGridLayout(int numOfColumns) {
		this();
		_numCols = numOfColumns;
	}
	
	public HGridLayout currentIndex(int i) {
		_currentIndex = i;
		return this;
	}
	
	public int currentIndex() {
		return _currentIndex;
	}
	
	public HGridLayout resetIndex() {
		_currentIndex = 0;
		return this;
	}
	
	public HGridLayout cols(int numOfColumns) {
		_numCols = numOfColumns;
		return this;
	}
	
	public int cols() {
		return _numCols;
	}
	
	public PVector startLoc() {
		return new PVector(_startX, _startY);
	}
	
	public HGridLayout startLoc(float x, float y) {
		_startX = x;
		_startY = y;
		return this;
	}
	
	public float startX() {
		return _startX;
	}
	
	public HGridLayout startX(float x) {
		_startX = x;
		return this;
	}
	
	public float startY() {
		return _startY;
	}
	
	public HGridLayout startY(float y) {
		_startY = y;
		return this;
	}
	
	public PVector spacing() {
		return new PVector(_xSpace, _ySpace);
	}
	
	public HGridLayout spacing(float xSpacing, float ySpacing) {
		_xSpace = xSpacing;
		_ySpace = ySpacing;
		return this;
	}
	
	public float spacingX() {
		return _xSpace;
	}
	
	public HGridLayout spacingX(float xSpacing) {
		_xSpace = xSpacing;
		return this;
	}
	
	public float spacingY() {
		return _ySpace;
	}
	
	public HGridLayout spacingY(float ySpacing) {
		_ySpace = ySpacing;
		return this;
	}
	
	public PVector getNextPoint() {
		int currentRow = H.app().floor(_currentIndex / _numCols);
		int currentCol = _currentIndex % _numCols;
		
		_currentIndex++;
		return new PVector(
			currentCol*_xSpace + _startX,
			currentRow*_ySpace + _startY
		);
	}

	public void applyTo(HDrawable target) {
		target.loc(getNextPoint());
	}
}


public static class HImage extends HDrawable {
	protected PImage _image;

	public HImage() {}
	
	public HImage(Object imgArg) {
		image(imgArg);
	}
	
	public HImage createCopy() {
		HImage copy = new HImage(_image);
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	public HImage resetSize() {
		if(_image == null) {
			size(0f,0f);
		} else {
			size(_image.width, _image.height);
		}
		return this;
	}
	
	public HImage image(Object imgArg) {
		if(imgArg instanceof PImage) {
			_image = (PImage) imgArg;
		} else if(imgArg instanceof String) {
			_image = H.app().loadImage((String) imgArg);
		} else if(imgArg instanceof HImage) {
			_image = ((HImage) imgArg)._image;
		} else if(imgArg == null) {
			_image = null;
		}
		return resetSize();
	}
	
	public PImage image() {
		return _image;
	}
	
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {
		if(_image==null) return;
		app.tint(currAlpha);
		app.image(_image,drawX,drawY);
	}
}

public static interface HIterator<U> {
	public boolean hasNext();
	public U next();
	public void remove();
}


public static interface HLayout {
	public void applyTo(HDrawable target);
	public abstract PVector getNextPoint();
}

public static class HLinkNode<T> {
	private HLinkNode<T> prev, next;
	private T content;
	
	public HLinkNode(T o) {
		content = o;
	}
	
	public T getContent() {
		return content;
	}
	
	public HLinkNode<T> getPrev() {
		return prev;
	}
	
	public HLinkNode<T> getNext() {
		return next;
	}
	
	public void replaceWith(HLinkNode<T> otherNode) {
		popOut();
		
		if(otherNode != null) {
			HLinkNode<T> otherPrev = otherNode.prev;
			HLinkNode<T> otherNext = otherNode.next;
			stitchTogether(otherPrev,this);
			stitchTogether(this,otherNext);
		}
	}
	
	public void putBefore(HLinkNode<T> otherNode) {
		popOut();
		
		if(otherNode != null) {
			HLinkNode<T> otherPrev = otherNode.prev;
			stitchTogether(otherPrev,this);
			stitchTogether(this,otherNode);
		}
	}
	
	public void putAfter(HLinkNode<T> otherNode) {
		popOut();
		if(otherNode != null) {
			HLinkNode<T> otherNext = otherNode.next;
			stitchTogether(otherNode,this);
			stitchTogether(this,otherNext);
		}
	}
	
	public void popOut() {
		stitchTogether(prev,next);
	}
	
	
	
	public static void swap(HLinkNode node1, HLinkNode node2) {
		if(node1 == null || node2 == null) return;
		
		HLinkNode prev1 = node1.prev;
		HLinkNode next1 = node1.next;
		HLinkNode prev2 = node2.prev;
		HLinkNode next2 = node2.next;
		
		stitchTogether(prev1,node2);
		stitchTogether(node2,next1);
		
		stitchTogether(prev2,node1);
		stitchTogether(node1,next2);
	}
	
	public static void stitchTogether(HLinkNode leftNode, HLinkNode rightNode) {
		if(leftNode != null) {
			if(leftNode.next != null) leftNode.next.prev = null;
			leftNode.next = rightNode;
		}
		if(rightNode != null) {
			if(rightNode.prev != null) rightNode.prev.next = null;
			rightNode.prev = leftNode;
		}
	}
}


public static class HLinkedHashSet<T> extends HLinkedList<T> {
	protected HashMap<T,HLinkNode<T>> nodeMap;
	
	public HLinkedHashSet() {
		nodeMap = new HashMap<T, HLinkNode<T>>();
	}
	
	public boolean add(T obj) {
		if(contains(obj))
			return false;
		return addNode(register(obj));
	}
	
	// LATER peekAfter
	// LATER peekBefore
	// LATER putAfter
	// LATER putBefore
	// LATER iterator obj
	
	public boolean remove(T obj) {
		HLinkNode<T> node = nodeMap.get(obj);
		if(node == null) return false;
		
		if(node.equals(firstNode)) {
			pop();
		} else if(node.equals(lastNode)) {
			pull();
		} else {
			unregister(obj);
			node.popOut();
			length--;
		}
		return true;
	}
	
	public T pull() {
		return unregister(super.pull());
	}
	
	public boolean push(T obj) {
		if(contains(obj))
			return false;
		return pushNode(register(obj));
	}
	
	public T pop() {
		return unregister(super.pop());
	}
	
	public void removeAll() {
		nodeMap.clear();
		super.removeAll();
	}
	
	public boolean contains(T obj) {
		return nodeMap.get(obj) != null;
	}
	
	protected HLinkNode<T> register(T obj) {
		if(obj == null) return null;
		
		HLinkNode<T> node = new HLinkNode<T>(obj);
		nodeMap.put(obj,node);
		return node;
	}
	
	protected T unregister(T obj) {
		nodeMap.remove(obj);
		return obj;
	}
}


public static class HLinkedList<T> {
	protected HLinkNode<T> firstNode, lastNode;
	protected int length;
	
	public int getLength() {
		return length;
	}
	
	public T peekFirst() {
		if(firstNode == null)
			return null;
		return firstNode.getContent();
	}
	
	public T peekLast() {
		if(lastNode == null)
			return null;
		return lastNode.getContent();
	}
	
	public T peekAt(int index) {
		HLinkNode<T> n = getNode(index);
		
		if(n == null)
			return null;
		return n.getContent();
	}
	
	protected boolean addNode(HLinkNode<T> node) {
		if(node == null) return false;
		
		node.popOut();
		if(length <= 0) {
			lastNode = firstNode = node;
			length = 1;
		} else {
			node.putAfter(lastNode);
			lastNode = node;
			length++;
		}
		return true;
	}
	
	public boolean add(T obj) {
		return addNode(new HLinkNode<T>(obj));
	}
	
	public T pull() {
		if(length <= 0) return null;
		
		HLinkNode<T> ln = lastNode;
		
		lastNode = ln.getPrev();
		ln.popOut();
		
		length--;
		if(length <= 0) lastNode = firstNode = null;
		return ln.getContent();
	}
	
	protected boolean pushNode(HLinkNode<T> node) {
		if(node == null) return false;
		
		node.popOut();
		if(length <= 0) {
			firstNode = lastNode = node;
			length = 1;
		} else {
			node.putBefore(firstNode);
			firstNode = node;
			length++;
		}
		return true;
	}
	
	public boolean push(T obj) {
		return pushNode(new HLinkNode<T>(obj));
	}
	
	public T pop() {
		if(length <= 0) return null;
		
		HLinkNode<T> fn = firstNode;
		
		firstNode = fn.getNext();
		fn.popOut();
		
		length--;
		if(length <= 0) lastNode = firstNode = null;
		return fn.getContent();
	}
	
	public void removeAll() {
		firstNode = lastNode = null;
		length = 0;
	}
	
	protected HLinkNode<T> getNode(int index) {
		// this will be used if searching from the tail backwards is faster
		int reverseIndex;
		
		if(index < 0) {
			reverseIndex = index;
			index = length + index;
		} else {
			reverseIndex = index - length;
		}
		
		// if the indexes are out of range, then return null.
		if(index < 0 || reverseIndex > -1) return null;
		
		HLinkNode<T> n;
		if(index <= reverseIndex) {
			// search, starting from the head
			n = firstNode;
			while(0 < index--) {
				n = n.getNext();
			}
			return  n;
		} else {
			// search, starting from the tail
			n = lastNode;
			while(-1 > reverseIndex++) {
				n = n.getPrev();
			}
			return n;
		}
	}
	
	public void foreach(HCallback callback) {
		HLinkNode<T> n = firstNode;
		while(n != null) {
			HLinkNode<T> nextNode = n.getNext();
			callback.run(n.getContent());
			n = nextNode;
		}
	}

	public HIterator<T> iterator() {
		return new HLinkedListIterator<T>(this);
	}
	
	public static class HLinkedListIterator<U> implements HIterator<U> {
		boolean started;
		HLinkedList<U> parentList;
		HLinkNode<U> currentNode;
		
		public HLinkedListIterator(HLinkedList<U> parent) {
			parentList = parent;
		}

		public boolean hasNext() {
			if(!started)
				return parentList.firstNode != null;
			return currentNode != null && currentNode.getNext() != null;
		}

		public U next() {
			if(!started) started = true;
			
			if(currentNode == null) currentNode = parentList.firstNode;
			else currentNode = currentNode.getNext();
			
			return currentNode.getContent();
		}

		public void remove() {
			// TODO
		}
	}
}




public static class HMagnetField extends HBehavior {
	protected ArrayList<HMagnetPole> poles;
	protected int _rotStyle;
	
	public HMagnetField() {
		poles = new ArrayList<HMagnetField.HMagnetPole>();
	}
	
	public HMagnetField(int rotStyle) {
		this();
		_rotStyle = rotStyle;
	}
	
	public HMagnetField rotationStyle(int rotStyle) {
		_rotStyle = rotStyle;
		return this;
	}
	
	public int rotationStyle() {
		return _rotStyle;
	}
	
	public HMagnetPole pole(int index) {
		return poles.get(index);
	}
	
	public HMagnetField pole(float x, float y, boolean isSouth) {
		HMagnetPole p = new HMagnetPole();
		p.x = x;
		p.y = y;
		p.isSouth = isSouth;
		poles.add(p);
		return this;
	}
	
	public float getRotation(float targetX, float targetY, float targetRot) {
		float rotation = getRotationRad(targetX, targetY, targetRot*H.D2R);
		return rotation * H.R2D;
	}
	
	public float getRotationRad(float tx, float ty, float tr) {
		PApplet app = H.app();
		
		HMagnetPole north = pole(0);
		HMagnetPole south = pole(1);
		float t;
		if(north.x == south.x) {
			t = ty / (south.y-north.y);
		} else if(north.y == south.y) {
			t = tx / (south.x-north.x);
		} else {
			float tmpDist = app.dist(north.x,north.y, south.x,south.y);
			float xdist = south.x - north.x;
			t = (xdist*(north.x-tx) / xdist) / tmpDist;
		}
		
		float tmp = (2*(1-t)*t);
		float midx = (tx - app.sq(1-t)*north.x - t*t*south.x) / tmp;
		float midy = (ty - app.sq(1-t)*north.y - t*t*south.y) / tmp;
		
		float tanX1 = app.lerp(north.x,midx, t);
		float tanY1 = app.lerp(north.y,midy, t);
		float tanX2 = app.lerp(midx,south.x, t);
		float tanY2 = app.lerp(midy,south.y, t);
		
		return H.xAxisAngle(tanX1,tanY1, tanX2,tanY2);
		/*int numPoles = poles.size();
		float accumRots = 0;
		float[] dists = new float[numPoles];
		float maxDist = 0;
		
		for(int i=0; i<numPoles; i++) {
			HMagnetPole p = poles.get(i);
			
			float d = app.dist(tx,ty, p.x,p.y);
			if(d > maxDist) maxDist = d;
			
			dists[i] = d;
		}
		
		for(int j=0; j<numPoles; j++) {
			HMagnetPole p = poles.get(j);
			
			// Get the angle difference bet the pole and the current rotation
			float dRot = H.xAxisAngle(tx,ty, p.x,p.y) - tr;
			if(p.isSouth) dRot += app.PI;
			dRot %= app.TWO_PI;
			
			// Make sure that -180deg < dRot < 180deg
			if(dRot > app.PI)
				dRot = -app.TWO_PI + dRot;
			else if(dRot < -app.PI)
				dRot = app.TWO_PI + dRot;
			
			// Add weighted to the dRot via distance
			app.println(dists[j]/maxDist);//TEST
			accumRots += dRot * (dists[j]/maxDist);
		}
		
		float rotation = tr + accumRots/numPoles;
		switch(_rotStyle) {
		default: break;
		case H.SIN: rotation = app.sin(rotation); break;
		case H.COS: rotation = app.cos(rotation); break;
		case H.TAN: rotation = app.tan(rotation); break;
		}
		return rotation;*/
	}
	
//	public void run(HDrawable target) {
//		float r = getRotationRad(
//			target.getX(), target.getY(),
//			target.getRotationRad());
//		target.setRotationRad(r);
//	}
	
	public class HMagnetPole {
		public boolean isSouth;
		public float x, y;
	}

	public void runBehavior() {
		// TODO Auto-generated method stub
		
	}
}


public static class HOscillator extends HBehavior {
	protected HDrawable _target;
	protected float _stepDeg, _speed, _min, _max, _freq, _relValue;
	protected int _propertyId, _waveform;
	
	public HOscillator() {
		_speed = 1;
		_min = -1;
		_max = 1;
		_freq = 1;
		_propertyId = H.Y;
		_waveform = H.SINE;
		
		H.addBehavior(this);
	}
	
	public HOscillator(HDrawable target) {
		this();
		_target = target;
	}
	
	public HOscillator createCopy() {
		HOscillator osc = new HOscillator()
			.currentStep(_stepDeg)
			.speed(_speed)
			.range(_min, _max)
			.freq(_freq)
			.relativeVal(_relValue)
			.property(_propertyId)
			.waveform(_waveform);
		return osc;
	}
	
	public HOscillator target(HDrawable newTarget) {
		_target = newTarget;
		return this;
	}
	
	public HDrawable target() {
		return _target;
	}
	
	public HOscillator currentStep(float stepDegrees) {
		_stepDeg = stepDegrees;
		return this;
	}
	
	public float currentStep() {
		return _stepDeg;
	}
	
	public HOscillator speed(float spd) {
		_speed = spd;
		return this;
	}
	
	public float speed() {
		return _speed;
	}
	
	public HOscillator range(float minimum, float maximum) {
		_min = minimum;
		_max = maximum;
		return this;
	}
	
	public HOscillator min(float minimum) {
		_min = minimum;
		return this;
	}
	
	public float min() {
		return _min;
	}
	
	public HOscillator max(float maximum) {
		_max = maximum;
		return this;
	}
	
	public HOscillator freq(float frequency) {
		_freq = frequency;
		return this;
	}
	
	public float freq() {
		return _freq;
	}
	
	public HOscillator relativeVal(float relativeValue) {
		_relValue = relativeValue;
		return this;
	}
	
	public float relativeVal() {
		return _relValue;
	}
	
	public HOscillator property(int propertyId) {
		_propertyId = propertyId;
		return this;
	}
	
	public int property() {
		return _propertyId;
	}
	
	public HOscillator waveform(int form) {
		_waveform = form;
		return this;
	}
	
	public int waveform() {
		return _waveform;
	}
	
	public float next() {
		float currentDeg = _stepDeg * _freq;
		
		float outVal = 0;
		switch(_waveform) {
		case H.SINE:	outVal = sineWave(currentDeg);		break;
		case H.TRIANGLE:outVal = triangleWave(currentDeg);	break;
		case H.SAW:		outVal = sawWave(currentDeg);		break;
		case H.SQUARE:	outVal = squareWave(currentDeg);	break;
		}
		outVal = H.app().map(outVal, -1,1, _min,_max) + _relValue;
		
		_stepDeg += speed();
		_stepDeg %= 360;
		return outVal;
	}
	
	public void runBehavior() {
		if(_target != null)
			_target.set(_propertyId, next());
	}
	
	public HOscillator register() {
		return (HOscillator) super.register();
	}
	
	public HOscillator unregister() {
		return (HOscillator) super.unregister();
	}
	
	
	
	public static float sineWave(float stepDegrees) {
		PApplet app = H.app();
		return app.sin(app.radians(stepDegrees));
	}
	
	public static float triangleWave(float stepDegrees) {
		float outVal = (stepDegrees % 180) / 90;
		if(outVal > 1)
			outVal = 2-outVal;
		if(stepDegrees % 360 > 180)
			outVal = -outVal;
		return outVal;
	}
	
	public static float sawWave(float stepDegrees) {
		float outVal = (stepDegrees % 180) / 180;
		if(stepDegrees % 360 >= 180)
			outVal -= 1;
		return outVal;
	}
	
	public static float squareWave(float stepDegrees) {
		return (stepDegrees % 360 > 180)? -1 : 1;
	}
}


public static class HPixelColorist implements HColorist {
	protected PImage img;
	protected boolean fillFlag, strokeFlag;
	
	public HPixelColorist() {
		fillAndStroke();
	}
	
	public HPixelColorist(Object imgArg) {
		this();
		setImage(imgArg);
	}
	
	public HPixelColorist setImage(Object imgArg) {
		if(imgArg instanceof PImage) {
			img = (PImage) imgArg;
		} else if(imgArg instanceof HImage) {
			img = ((HImage) imgArg).image();
		} else if(imgArg instanceof String) {
			img = H.app().loadImage((String) imgArg);
		} else if(imgArg == null) {
			img = null;
		}
		return this;
	}
	
	public PImage getImage() {
		return img;
	}
	
	public int getColor(float x, float y) {
		if(img == null)
			return 0;
		PApplet app = H.app();
		return img.get(app.round(x), app.round(y));
	}

	public HPixelColorist fillOnly() {
		fillFlag = true;
		strokeFlag = false;
		return this;
	}

	public HPixelColorist strokeOnly() {
		fillFlag = false;
		strokeFlag = true;
		return this;
	}

	public HPixelColorist fillAndStroke() {
		fillFlag = strokeFlag = true;
		return this;
	}
	
	public boolean appliesFill() {
		return fillFlag;
	}
	
	public boolean appliesStroke() {
		return strokeFlag;
	}
	
	public HDrawable applyColor(HDrawable drawable) {
		int clr = getColor(drawable.x(), drawable.y());
		if(fillFlag)
			drawable.fill(clr);
		if(strokeFlag)
			drawable.stroke(clr);
		return drawable;
	}
}


public static class HPoolAdapter implements HPoolListener {
	public void onCreate(HDrawable d, int index, HDrawablePool pool) {}

	public void onRequest(HDrawable d, int index, HDrawablePool pool) {}

	public void onRelease(HDrawable d, int index, HDrawablePool pool) {}
}


public static interface HPoolListener {
	public void onCreate(HDrawable d, int index, HDrawablePool pool);
	public void onRequest(HDrawable d, int index, HDrawablePool pool);
	public void onRelease(HDrawable d, int index, HDrawablePool pool);
}


public static class HRect extends HDrawable {
	public float _tl, _tr, _bl, _br;
	
	public HRect() {
		size(16);
	}
	
	public HRect(float s) {
		size(s);
	}
	
	public HRect(float w, float h) {
		size(w,h);
	}
	
	public HRect(float w, float h, float roundingRadius) {
		size(w,h);
		rounding(roundingRadius);
	}
	
	public HRect createCopy() {
		HRect copy = new HRect();
		copy._tl = _tl;
		copy._tr = _tr;
		copy._bl = _bl;
		copy._br = _br;
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	public HRect rounding(float radius) {
		_tl = _tr = _bl = _br = radius;
		return this;
	}
	
	public HRect rounding(
		float topleft, float topright,
		float bottomright, float bottomleft
	) {
		_tl = topleft;
		_tr = topright;
		_br = bottomright;
		_bl = bottomleft;
		return this;
	}
	
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {
		applyStyle(app,currAlpha);
		app.rect(drawX,drawY, _width,_height, _tl,_tr,_br,_bl);
	}
}


public static class HShape extends HDrawable {
	protected PShape _shape;
	protected HColorPool _randomColors;
	
	public HShape() {}
	
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
	
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {
		if(_shape == null) return;
		
		applyStyle(app,currAlpha);
		if(_randomColors == null) {
			app.shape(_shape, drawX,drawY, _width,_height);
		} else for(int i=0; i<_shape.getChildCount(); i++) {
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


public static class HStage extends HDrawable {
	protected PApplet _app;
	protected HLinkedHashSet<HBehavior> _behaviors;
	protected PImage _bgImg;
	protected int _bgColor;
	protected boolean _autoClearFlag, _mouseStarted;
	
	public HStage(PApplet papplet) {
		_app = papplet;
		
		_children = new HChildSet(this);
		_behaviors = new HLinkedHashSet<HBehavior>();
		
		_bgColor = H.DEFAULT_BACKGROUND_COLOR;
		_autoClearFlag = true;
	}
	
	public HLinkedHashSet<HBehavior> behaviors() {
		return _behaviors;
	}
	
	public HDrawable createCopy() {
		return null;
	}
	
	public void background(int clr) {
		_bgColor = clr;
		clear();
	}
	
	public void backgroundImg(Object arg) {
		if(arg instanceof String) {
			_bgImg = _app.loadImage((String) arg);
		} else if(arg instanceof PImage) {
			_bgImg = (PImage) arg;
		}
		clear();
	}
	
	public HStage autoClear(boolean b) {
		_autoClearFlag = b;
		return this;
	}
	
	public boolean autoClear() {
		return _autoClearFlag;
	}
	
	public HStage clear() {
		if(_bgImg == null) _app.background(_bgColor);
		else _app.background(_bgImg);
		return this;
	}
	
	public PVector size() {
		return new PVector(_app.width,_app.height);
	}
	
	public float width() {
		return _app.width;
	}
	
	public float height() {
		return _app.height;
	}
	
	public float followableX() {
		return _app.mouseX;
	}
	
	public float followableY() {
		return _app.mouseY;
	}
	
	public boolean mouseStarted() {
		return _mouseStarted;
	}
	
	public void paintAll(PApplet app, int currAlpha) {
		if(!_mouseStarted && _app.pmouseX+_app.pmouseY > 0)
			_mouseStarted = true;
		
		if(_behaviors.getLength()>0) {
			HIterator<HBehavior> bIt = _behaviors.iterator();
			while(bIt.hasNext()) bIt.next().runBehavior();
		}
		
		app.pushStyle();
			if(_autoClearFlag) clear();
			
			if(_children.getLength()>0) {
				HIterator<HDrawable> cIt = _children.iterator();
				while(cIt.hasNext()) cIt.next().paintAll(app,255);
			}
		app.popStyle();
	}
	
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {}

}




public static class HSwarm extends HBehavior implements HFollower, HFollowable {
	protected float _goalX, _goalY, _speed, _turnEase, _twitch;
	protected ArrayList<HDrawable> _swarmers;
	
	public HSwarm() {
		_speed = 1;
		_turnEase = 1;
		_twitch = 16;
		_swarmers = new ArrayList<HDrawable>();
		
		H.addBehavior(this);
	}
	
	public HSwarm addTarget(HDrawable swarmer) {
		_swarmers.add(swarmer);
		return this;
	}
	
	public HDrawable target(int i) {
		return _swarmers.get(i);
	}
	
	public HSwarm goal(float x, float y) {
		_goalX = x;
		_goalY = y;
		return this;
	}
	
	public PVector goal() {
		return new PVector(_goalX,_goalY);
	}
	
	public HSwarm goalX(float x) {
		_goalX = x;
		return this;
	}
	
	public float goalX() {
		return _goalX;
	}
	
	public HSwarm goalY(float y) {
		_goalY = y;
		return this;
	}
	
	public float goalY() {
		return _goalY;
	}
	
	public HSwarm speed(float s) {
		_speed = s;
		return this;
	}
	
	public float speed() {
		return _speed;
	}
	
	public HSwarm turnEase(float e) {
		_turnEase = e;
		return this;
	}
	
	public float turnEase() {
		return _turnEase;
	}
	
	public HSwarm twitch(float deg) {
		_twitch = deg * H.D2R;
		return this;
	}
	
	public HSwarm twitchRad(float rad) {
		_twitch = rad;
		return this;
	}
	
	public float twitch() {
		return _twitch * H.R2D;
	}
	
	public float twitchRad() {
		return _twitch;
	}

	public float followerX() {
		return _goalX;
	}

	public float followerY() {
		return _goalY;
	}
	
	public float followableX() {
		return _goalX;
	}

	public float followableY() {
		return _goalY;
	}
	
	public void follow(float dx, float dy) {
		_goalX += dx;
		_goalY += dy;
	}

	public void runBehavior() {
		PApplet app = H.app();
		
		int numSwarmers = _swarmers.size();
		for(int i=0; i<numSwarmers; i++) {
			HDrawable swarmer = _swarmers.get(i);
			
			float rot = swarmer.rotationRad();
			float tx = swarmer.x();
			float ty = swarmer.y();
			
			// Get rotation that points towards the goal, plus easing
			float tmp = H.xAxisAngle(tx,ty, _goalX,_goalY) - rot;
			float dRot = app.atan2(app.sin(tmp),app.cos(tmp)) * _turnEase;
			rot += dRot;
			
			// Add some random twitching to the rotation via perlin noise
			float noise = app.noise(i*numSwarmers + app.frameCount/8f);
			rot += app.map(noise, 0,1, -_twitch,_twitch);
			
			// Apply the rotation and move to the direction of its rotation
			swarmer.rotationRad(rot);
			swarmer.move(app.cos(rot)*_speed, app.sin(rot)*_speed);
		}
	}
	
	public HSwarm register() {
		return (HSwarm) super.register();
	}
	
	public HSwarm unregister() {
		return (HSwarm) super.unregister();
	}
}


public static class HText extends HDrawable {
	protected PFont _font;
	protected String _text;
	protected float _descent;
	
	public HText() {
		this(null,16);
	}
	
	public HText(String textString) {
		this(textString,16,null);
	}
	
	public HText(String textString, float size) {
		this(textString,size,null);
	}
	
	public HText(String textString, float size, Object fontArg) {
		_text = textString;
		height(size);
		font(fontArg);
	}
	
	public HText createCopy() {
		HText copy = new HText(_text,_height,_font);
		copy.copyPropertiesFrom(this);
		copy.adjustMetrics();
		return copy;
	}
	
	public HText text(String txt) {
		_text = txt;
		adjustMetrics();
		return this;
	}
	
	public String text() {
		return _text;
	}
	
	public HText font(Object arg) {
		PApplet app = H.app();
		
		if(arg instanceof PFont) {
			_font = (PFont) arg;
		} else if(arg instanceof String) {
			String str = (String) arg;
			_font = H.endsWith(str,".vlw")?
				app.loadFont(str) : app.createFont(str,_height);
		} else if(arg instanceof HText) {
			_font = ((HText) arg)._font;
		} else if(arg == null) {
			_font = null;
		}
		adjustMetrics();
		return this;
	}
	
	public PFont font() {
		return _font;
	}
	
	public HText fontSize(float f) {
		return height(f);
	}
	
	public float fontSize() {
		return _height;
	}
	
	protected void adjustMetrics() {
		PApplet app = H.app();
		app.pushStyle();
		
		if(_font == null) app.textSize(_height);
		else app.textFont(_font,_height);
		
		_descent = app.textDescent();
		super.width( (_text==null)? 0 : app.textWidth(_text) );
		
		app.popStyle();
	}

	public HText width(float w) {
		return this;
	}

	public HText height(float h) {
		super.height(h);
		adjustMetrics();
		return this;
	}
	
	public HText size(float w, float h) {
		return height(h);
	}
	
	public HText size(float s) {
		return height(s);
	}
	
	public HText scale(float s) {
		super.scale(s);
		adjustMetrics();
		return this;
	}
	
	public HText scale(float sw, float sh) {
		return scale(sh);
	}
	
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {
		if(_text == null) return;
		
		applyStyle(app,currAlpha);
		if(_font == null) app.textSize(_height);
		else app.textFont(_font,_height);
		
		app.text(_text,drawX,drawY+_height-_descent);
	}
}
