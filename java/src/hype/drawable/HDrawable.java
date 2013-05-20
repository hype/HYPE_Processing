package hype.drawable;

import hype.collection.HIterator;
import hype.collection.HNode;
import hype.interfaces.HHittable;
import hype.interfaces.HSwarmer;
import hype.util.HBundle;
import hype.util.HColors;
import hype.util.HConstants;
import hype.util.HMath;
import hype.util.HWarnings;
import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PVector;

/**
 * Abcd. Efgh.
 * 
 * Ijk lmno.
 * 
 * @author james
 */
public abstract class HDrawable extends HNode<HDrawable>
		implements HSwarmer, HHittable {
	
	protected HDrawable
		_parent,
		_firstChild,
		_lastChild;
	protected HBundle
		_extras;
	protected float
		_x,
		_y,
		_z,
		_anchorPercX,
		_anchorPercY,
		_width,
		_height,
		_rotationRad,
		_strokeWeight,
		_alphaPerc,
		_sizeProportion;
	protected int
		_numChildren,
		_fill,
		_stroke,
		_strokeCap,
		_strokeJoin;
	protected boolean
		_proportional;
	
	
	// COPY & CREATE //
	
	/**
	 * The default constructor for HDrawable.
	 * 
	 * It sets several fields into their proper default values:
	 * - alpha percentage = 1 (100%)
	 * - fill = white
	 * - stroke = black
	 * - stroke cap = round
	 * - stroke join = miter
	 * - stroke weight = 1
	 * - width = 100
	 * - height = 100
	 */
	public HDrawable() {
		_alphaPerc = 1;
		
		_fill = HConstants.DEFAULT_FILL;
		_stroke = HConstants.DEFAULT_STROKE;
		_strokeCap = PConstants.ROUND;
		_strokeJoin = PConstants.MITER;
		_strokeWeight = 1;
		
		_width = HConstants.DEFAULT_WIDTH;
		_height = HConstants.DEFAULT_HEIGHT;
	}
	
	/**
	 * Copies the values of `other`'s basic HDrawable fields.
	 * 
	 * This method is primarily used for implementing createCopy().
	 * It copies the following fields from `other`:
	 * - x & y coordinates
	 * - x & y anchors
	 * - width & height
	 * - rotation
	 * - alpha
	 * - stroke & fill properties
	 * 
	 * @see createCopy()
	 * @param other    The drawable to copy its properties from. 
	 */
	public void copyPropertiesFrom(HDrawable other) {
		_x = other._x;
		_y = other._y;
		_anchorPercX = other._anchorPercX;
		_anchorPercY = other._anchorPercY;
		_width = other._width;
		_height = other._height;
		_rotationRad = other._rotationRad;
		_alphaPerc = other._alphaPerc;
		_strokeWeight = other._strokeWeight;
		_fill = other._fill;
		_stroke = other._stroke;
		_strokeCap = other._strokeCap;
		_strokeJoin = other._strokeJoin;
	}
	
	/**
	 * Creates a copy of this drawable.
	 * 
	 * This method is abstract and is meant to be implemented by the children
	 * of this class.
	 * 
	 * @return A copy of this drawable.
	 */
	public abstract HDrawable createCopy();
	
	
	// PARENT & CHILD //
	
	private boolean invalidDest(HDrawable dest, String warnLoc) {
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
	
	/**
	 * Returns the parent of this drawable.
	 * 
	 * @return The parent of this drawable, or null if there's none.
	 */
	public HDrawable parent() {
		return _parent;
	}
	
	/**
	 * Returns the first child of this drawable.
	 * 
	 * If this drawable has only one child, then the first child is also
	 * considered as the last child.
	 * 
	 * @return The first child of this drawable, or null if there's none.
	 */
	public HDrawable firstChild() {
		return _firstChild;
	}
	
	/**
	 * Returns the last child of this drawable.
	 * 
	 * If this drawable has only one child, then the last child is also
	 * considered as the first child.
	 * 
	 * @return The last child of this drawable, or null if there's none.
	 */
	public HDrawable lastChild() {
		return _lastChild;
	}
	
	/**
	 * Checks if the given drawable is the parent of this drawable.
	 * 
	 * @param d    The drawable to be checked
	 * @return True if this drawable is the parent of `d`
	 */
	public boolean parentOf(HDrawable d) {
		return (d != null) && (d._parent != null) && (d._parent.equals(this));
	}
	
	/**
	 * Returns the number of children of this drawable.
	 * 
	 * @return The number of children of this drawable.
	 */
	public int numChildren() {
		return _numChildren;
	}
	
	/**
	 * Adds the passed drawable as this drawable's child.
	 * 
	 * If `child` is already a child of another drawable, it removes itself from
	 * its current parent and gets added to this drawable.
	 * 
	 * @param child    The child to be added to this drawable.
	 * @return The drawable passed through this method.
	 */
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
	
	/**
	 * Removes a child from this drawable.
	 * 
	 * If `child` isn't a child of this drawable, this method will do nothing.
	 * Regardless, it will still return `child`.
	 * 
	 * @param child    The child to be removed from this drawable
	 * @return The drawable passed through this method.
	 */
	public HDrawable remove(HDrawable child) {
		if( parentOf(child) ) child.popOut();
		else HWarnings.warn("Not a Child", "HDrawable.remove()", null);
		return child;
	}
	
	/**
	 * Creates a new HIterator for this drawable.
	 * 
	 * Note that while HIterator has similar functions for java.util.Iterator,
	 * the former does _not_ extend the latter. This is due to js mode
	 * compatibility issues.
	 * 
	 * @see HDrawableIterator, HIterator
	 * @return A new HIterator for this drawable
	 */
	public HDrawableIterator iterator() {
		return new HDrawableIterator(this);
	}
	
	
	// POSITION //
	
	/**
	 * Sets the x and y position of this drawable.
	 * 
	 * @chainable
	 * @param newX    The new x coordinate for this drawable.
	 * @param newY    The new y coordinate for this drawable.
	 * @return This drawable.
	 */
	public HDrawable loc(float newX, float newY) {
		_x = newX;
		_y = newY;
		return this;
	}
	
	/**
	 * Sets the x, y and z position of this drawable.
	 * 
	 * @chainable
	 * @param newX    The new x coordinate for this drawable. 
	 * @param newY    The new y coordinate for this drawable.
	 * @param newZ    The new z coordinate for this drawable.
	 * @return This drawable.
	 */
	public HDrawable loc(float newX, float newY, float newZ) {
		_x = newX;
		_y = newY;
		_z = newZ;
		return this;
	}
	
	/**
	 * Sets the position of this drawable via PVector.
	 * 
	 * @chainable
	 * @param pt    A PVector containing the new coordinates for this drawable.
	 * @return This drawable.
	 */
	public HDrawable loc(PVector pt) {
		_x = pt.x;
		_y = pt.y;
		_z = pt.z;
		return this;
	}
	
	/**
	 * Returns the position of this drawable as a PVector.
	 * 
	 * @return A new PVector containing the coordinates of this drawable.
	 */
	public PVector loc() {
		return new PVector(_x,_y,_z);
	}
	
	@Override
	public HDrawable x(float newX) {
		_x = newX;
		return this;
	}
	
	@Override
	public float x() {
		return _x;
	}
	
	@Override
	public HDrawable y(float newY) {
		_y = newY;
		return this;
	}
	
	@Override
	public float y() {
		return _y;
	}
	
	@Override
	public HDrawable z(float newZ) {
		_z = newZ;
		return this;
	}
	
	@Override
	public float z() {
		return _z;
	}
	
	/**
	 * Moves this drawable from its original x & y position.
	 * 
	 * @chainable
	 * @param dx    The amount this drawable will be moved on the x-axis.
	 * @param dy    The amount this drawable will be moved on the y-axis.
	 * @return This drawable.
	 */
	public HDrawable move(float dx, float dy) {
		_x += dx;
		_y += dy;
		return this;
	}
	
	/**
	 * Moves this drawable from its original x, y & z position.
	 * 
	 * @chainable
	 * @param dx    The amount this drawable will be moved on the x-axis.
	 * @param dy    The amount this drawable will be moved on the y-axis.
	 * @param dz    The amount this drawable will be moved on the z-axis.
	 * @return This drawable.
	 */
	public HDrawable move(float dx, float dy, float dz) {
		_x += dx;
		_y += dy;
		_z += dz;
		return this;
	}
	
	/**
	 * Positions this drawable at the defined location in relation to its
	 * parent, or (0,0) if the parent is null.
	 * 
	 * The `where` parameter can be any of the following HConstants values:
	 * - `HConstants.NONE` (does nothing)
	 * - `HConstants.LEFT`
	 * - `HConstants.RIGHT`
	 * - `HConstants.CENTER_X`
	 * - `HConstants.TOP`
	 * - `HConstants.BOTTOM`
	 * - `HConstants.CENTER_Y`
	 * - `HConstants.CENTER`
	 * - `HConstants.TOP_LEFT`
	 * - `HConstants.TOP_RIGHT`
	 * - `HConstants.BOTTOM_LEFT`
	 * - `HConstants.BOTTOM_RIGHT`
	 * - `HConstants.CENTER_LEFT`
	 * - `HConstants.CENTER_RIGHT`
	 * - `HConstants.CENTER_TOP`
	 * - `HConstants.CENTER_BOTTOM`
	 * 
	 * These values can be combined via bitwise OR, so `H.TOP | H.LEFT` would be
	 * equal to `H.TOP_LEFT`.
	 * 
	 * @chainable
	 * @see anchorAt(int)
	 * @param where    The value that represents the location for this drawable.
	 * @return This drawable.
	 */
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
	
	/**
	 * Sets the anchor of this drawable by pixels.
	 * 
	 * Note that HDrawable stores its anchor coordinates as a percentage of its
	 * width and height. So if the current size of this drawable is `(100,100)`,
	 * setting the anchor to `(75,75)` will be stored as `(0.75,0.75)`.
	 * 
	 * In case that the current width or height is 0, then the width or height
	 * is assumed to be 100 when computing the anchor in this method.
	 * 
	 * @chainable
	 * @see anchor(PVector), anchorX(float), anchorY(float)
	 * @param pxX    The desired x anchor for this drawable, in pixels.
	 * @param pxY    The desired y anchor for this drawable, in pixels.
	 * @return This drawable.
	 */
	public HDrawable anchor(float pxX, float pxY) {
		return anchorX(pxX).anchorY(pxY);
	}
	
	/**
	 * Sets the anchor of this drawable by pixels via a PVector.
	 * 
	 * This method calls anchor(float,float) with `pt`'s x and y fields as the
	 * arguments.
	 * 
	 * @chainable
	 * @see anchor(float,float)
	 * @param pt    The PVector containing the desired x and y anchor for this drawable, in pixels
	 * @return This drawable.
	 */
	public HDrawable anchor(PVector pt) {
		return anchor(pt.x, pt.y);
	}
	
	/**
	 * Returns the anchor of this drawable in pixels.
	 * 
	 * The result of this method is the product of its width & height and its
	 * x & y anchor percentages respectively. So if this drawable is anchored at
	 * the center, this method will return `(50,50)` when the size is
	 * `(100,100)`, `(30,30)` when the size is `(60,60)` and `(0,0)` when size
	 * is `(0,0)`.
	 * 
	 * @see anchorX(), anchorY()
	 * @return A new PVector containing the anchor of this drawable, in pixels.
	 */
	public PVector anchor() {
		return new PVector( anchorX(), anchorY() );
	}
	
	/**
	 * Sets the x anchor of this drawable by pixels.
	 * 
	 * Note that HDrawable stores its x anchor coordinates as a percentage of
	 * its width. If the width of this drawable is 0, it is assumed as 100 when
	 * computing the x anchor in this method.
	 * 
	 * @chainable
	 * @see anchor(float,float), anchor(PVector), anchorY(float)
	 * @param pxX    The desired x anchor for this drawable, in pixels.
	 * @return This drawable.
	 */
	public HDrawable anchorX(float pxX) {
		_anchorPercX = pxX / (_width==0? 100 : _width);
		return this;
	}
	
	/**
	 * Returns the x anchor of this drawable in pixels.
	 * 
	 * The result of this method is the product of its width and x anchor
	 * percentage.
	 * 
	 * @see anchor(), anchorY()
	 * @return The x anchor of this drawable, in pixels.
	 */
	public float anchorX() {
		return _width * _anchorPercX;
	}
	
	/**
	 * Sets the y anchor of this drawable by pixels.
	 * 
	 * Note that HDrawable stores its y anchor coordinates as a percentage of
	 * its height. If the height of this drawable is 0, it is assumed as 100
	 * when computing the y anchor in this method
	 * 
	 * @chainable
	 * @see anchor(float,float), anchor(PVector), anchorX(float)
	 * @param pxY    The desired y anchor for this drawable, in pixels.
	 * @return This drawable.
	 */
	public HDrawable anchorY(float pxY) {
		_anchorPercY = pxY / (_height==0? 100 : _height);
		return this;
	}
	
	/**
	 * Returns the y anchor of this drawable in pixels.
	 * 
	 * The result of this method is the product of its height and y anchor
	 * percentage.
	 * 
	 * @see anchor(), anchorX()
	 * @return The y anchor of this drawable, in pixels.
	 */
	public float anchorY() {
		return _height * _anchorPercY;
	}
	
	/**
	 * Sets the anchor of this drawable as percentage of its width and height.
	 * 
	 * 0 is equivalent to 0% and 1 is equivalent to 100%
	 * 
	 * @chainable
	 * @see anchorPercX(float), anchorPercY(float)
	 * @param percX    The desired x anchor for this drawable, as percentage.
	 * @param percY    The desired y anchor for this drawable, as percentage.
	 * @return This drawable.
	 */
	public HDrawable anchorPerc(float percX, float percY) {
		return anchorPercX(percX).anchorPercY(percY);
	}
	
	/**
	 * Returns the x & y anchor of this drawable, as percentage of its width and
	 * height respectively.
	 * 
	 * @see anchorPercX(), anchorPercY()
	 * @return A new PVector containing this drawable's anchor as percentage
	 */
	public PVector anchorPerc() {
		return new PVector(_anchorPercX, _anchorPercY);
	}
	
	/**
	 * Sets the x anchor of this drawable, as percentage of its width.
	 * 
	 * @chainable
	 * @see anchorPerc(float,float), anchorPercY(float)
	 * @param percX    The desired x anchor for this drawable, as percentage.
	 * @return This drawable.
	 */
	public HDrawable anchorPercX(float percX) {
		_anchorPercX = percX;
		return this;
	}
	
	/**
	 * Returns the x anchor of this drawable, as percentage of its width.
	 * 
	 * @see anchorPerc(), anchorPercY()
	 * @return The x anchor of this drawable, as percentage.
	 */
	public float anchorPercX() {
		return _anchorPercX;
	}
	
	/**
	 * Sets the y anchor of this drawable, as percentage of its height.
	 * 
	 * @chainable
	 * @see anchorPerc(), anchorPercX()
	 * @param percY    The desired y anchor for this drawable, as percentage.
	 * @return This drawable.
	 */
	public HDrawable anchorPercY(float percY) {
		_anchorPercY = percY;
		return this;
	}
	
	/**
	 * Returns the y anchnor of this drawable, as percentage of its height.
	 * 
	 * @see anchorPerc(), anchorPercX()
	 * @return The y anchor of this drawable.
	 */
	public float anchorPercY() {
		return _anchorPercY;
	}
	
	/**
	 * Sets the anchor of this drawable at the defined location in relation to
	 * itself.
	 * 
	 * The `where` parameter can be any of the following HConstants values:
	 * - `HConstants.NONE` (does nothing)
	 * - `HConstants.LEFT`
	 * - `HConstants.RIGHT`
	 * - `HConstants.CENTER_X`
	 * - `HConstants.TOP`
	 * - `HConstants.BOTTOM`
	 * - `HConstants.CENTER_Y`
	 * - `HConstants.CENTER`
	 * - `HConstants.TOP_LEFT`
	 * - `HConstants.TOP_RIGHT`
	 * - `HConstants.BOTTOM_LEFT`
	 * - `HConstants.BOTTOM_RIGHT`
	 * - `HConstants.CENTER_LEFT`
	 * - `HConstants.CENTER_RIGHT`
	 * - `HConstants.CENTER_TOP`
	 * - `HConstants.CENTER_BOTTOM`
	 * 
	 * These values can be combined via bitwise OR, so `H.TOP | H.LEFT` would be
	 * equal to `H.TOP_LEFT`.
	 * 
	 * @chainable
	 * @see locAt(int)
	 * @param where    The value that represents the anchor for this drawable.
	 * @return This drawable.
	 */
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
	
	public PVector boundingSize() {
		// TODO boundingBox()
		// this code probably needs some *actual* optimization too.
		
		// !!CAUTION!! Maths ahead! 
		float cosVal = (float)Math.cos(_rotationRad);
		float sinVal = (float)Math.sin(_rotationRad);
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
		_fill = HColors.setAlpha(clr,alpha);
		return this;
	}
	
	public HDrawable fill(int r, int g, int b) {
		_fill = HColors.merge(255,r,g,b);
		return this;
	}
	
	public HDrawable fill(int r, int g, int b, int a) {
		_fill = HColors.merge(a,r,g,b);
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
		_stroke = HColors.setAlpha(clr,alpha);
		return this;
	}
	
	public HDrawable stroke(int r, int g, int b) {
		_stroke = HColors.merge(255,r,g,b);
		return this;
	}
	
	public HDrawable stroke(int r, int g, int b, int a) {
		_stroke = HColors.merge(a,r,g,b);
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
	
	public int alpha() {
		return Math.round( alphaPerc()*255 );
	}
	
	public HDrawable alphaPerc(float aPerc) {
		_alphaPerc = (aPerc<0)? 0 : (aPerc>1)? 1 : aPerc;
		return this;
	}
	
	public float alphaPerc() {
		return (_alphaPerc<0)? 0 : _alphaPerc;
	}
	
	public HDrawable visibility(boolean v) {
		if(v && _alphaPerc == 0) {
			_alphaPerc = 1;
		} else if(v == _alphaPerc < 0) {
			_alphaPerc = -_alphaPerc;
		}
		return this;
	}
	
	public boolean visibility() {
		return _alphaPerc > 0;
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
		return alphaPerc(_alphaPerc + daPerc);
	}
	
	
	// UTILITY //
	
	public HDrawable extras(HBundle b) {
		_extras = b;
		return this;
	}
	
	public HBundle extras() {
		return _extras;
	}
	
	public HDrawable obj(String key, Object value) {
		if(_extras == null) _extras = new HBundle();
		_extras.obj(key,value);
		return this;
	}
	
	public HDrawable num(String key, float value) {
		_extras.num(key,value);
		return this;
	}
	
	public Object obj(String key) {
		if(_extras == null)
			return null;
		return _extras.obj(key);
	}
	
	public String str(String key) {
		if(_extras == null)
			return null;
		return _extras.str(key);
	}
	
	public float num(String key) {
		if(_extras == null)
			return 0;
		return _extras.num(key);
	}
	
	public int numI(String key) {
		if(_extras == null)
			return 0;
		return _extras.numI(key);
	}
	
	public boolean bool(String key) {
		if(_extras == null)
			return false;
		return _extras.bool(key);
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
	
	protected void applyStyle(PGraphics g, float currAlphaPerc) {
		float faPerc = currAlphaPerc * (_fill >>> 24);
		g.fill(_fill | 0xFF000000, Math.round(faPerc));
		
		if(_strokeWeight > 0) {
			float saPerc = currAlphaPerc * (_stroke >>> 24);
			g.stroke(_stroke | 0xFF000000, Math.round(saPerc));
			g.strokeWeight(_strokeWeight);
			g.strokeCap(_strokeCap);
			g.strokeJoin(_strokeJoin);
		} else g.noStroke();
	}
	
	public void paintAll(PGraphics g, boolean usesZ, float currAlphaPerc) {
		if(_alphaPerc<=0) return;
		g.pushMatrix();
			// Rotate and translate
			if(usesZ) g.translate(_x,_y,_z);
			else g.translate(_x,_y);
			g.rotate(_rotationRad);
			
			// Compute current alpha
			currAlphaPerc *= _alphaPerc;
			
			// Draw self
			draw(g, usesZ,-anchorX(),-anchorY(),currAlphaPerc);
			
			// Draw children
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, currAlphaPerc);
				child = child._next;
			}
		g.popMatrix();
	}
	
	public abstract void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float currAlphaPerc);
	
	
	
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
