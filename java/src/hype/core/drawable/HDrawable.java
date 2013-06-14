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

package hype.core.drawable;

import hype.core.collection.HIterator;
import hype.core.collection.HNode;
import hype.core.interfaces.HDirectable;
import hype.core.interfaces.HHittable;
import hype.core.util.H;
import hype.core.util.HBundle;
import hype.core.util.HColors;
import hype.core.util.HConstants;
import hype.core.util.HMath;
import hype.core.util.HWarnings;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PVector;

/**
 * The superclass of all HDrawables.
 * 
 * TODO
 * 
 * @author james
 */
public abstract class HDrawable extends HNode<HDrawable>
		implements HDirectable, HHittable {
	
	public static final int DEFAULT_FILL = 0xFFFFFFFF;
	public static final int DEFAULT_STROKE = 0xFF000000;
	public static final int DEFAULT_WIDTH = 100;
	public static final int DEFAULT_HEIGHT = 100;
	public static final byte BITMASK_PROPORTIONAL = 1;		// 0b0001
	public static final byte BITMASK_TRANSFORMS_CHILDREN = 2;// 0b0010
	public static final byte BITMASK_STYLES_CHILDREN = 4;	// 0b0100
	public static final byte BITMASK_ROTATES_CHILDREN = 8;	// 0b1000
	
	/** The parent of this drawable @see parent() */
	protected HDrawable _parent;
	/** The first child of this drawable @see firstChild() */
	protected HDrawable _firstChild;
	/** The last child of this drawable @see lastChild() */
	protected HDrawable _lastChild;
	
	/** The extras bundle of this drawable @see extras() */
	protected HBundle _extras;
	
	/** The x location of this drawable @see x() */
	protected float _x;
	/** The y location of this drawable @see y() */
	protected float _y;
	/** The z location of this drawable @see z() */
	protected float _z;
	/** The x anchor percentage of this drawable @see anchorU() */
	protected float _anchorU;
	/** The y anchor percentage of this drawable @see anchorV() */
	protected float _anchorV;
	/** The width of this drawable @see width() */
	protected float _width;
	/** The height of this drawable @see height() */
	protected float _height;
	/** The rotation of this drawable, in radians @see rotationRad() */
	protected float _rotationRad;
	/** The stroke width of this drawable, in pixels @see strokeWeight() */
	protected float _strokeWeight;
	/** The alpha of this drawable, in percentage @see alphaPc() */
	protected float _alphaPc;
	/** The width-to-height ratio used for proportional resizing @see proportional() */
	
	/** The number of this drawable's children @see numChildren() */
	protected int _numChildren;
	/** The fill color of this drawable @see fill() */
	protected int _fill;
	/** The stroke color of this drawable @see stroke() */
	protected int _stroke;
	/** The stroke cap of this drawable @see strokeCap() */
	protected int _strokeCap;
	/** The stroke join of this drawable @see strokeJoin() */
	protected int _strokeJoin;
	
	/** The bitset that determines proportional resizing, and child transforms */
	protected byte _flags;
	
	
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
		_alphaPc = 1;
		
		_fill = DEFAULT_FILL;
		_stroke = DEFAULT_STROKE;
		_strokeCap = PConstants.ROUND;
		_strokeJoin = PConstants.MITER;
		_strokeWeight = 1;
		
		_width = DEFAULT_WIDTH;
		_height = DEFAULT_HEIGHT;
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
		_anchorU = other._anchorU;
		_anchorV = other._anchorV;
		_width = other._width;
		_height = other._height;
		_rotationRad = other._rotationRad;
		_alphaPc = other._alphaPc;
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
	
	public boolean invalidChild(HDrawable destParent) {
		if(destParent == null) return true;
		if(destParent.equals(this)) return true;
		return false;
	}
	
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
	 * If `child` is already a child of this drawable, then it does nothing.
	 * 
	 * @param child    The child to be added to this drawable.
	 * @return The drawable passed through this method.
	 */
	public HDrawable add(HDrawable child) {
		if(child == null) {
			HWarnings.warn("An Empty Child", "HDrawable.add()",
					HWarnings.NULL_ARGUMENT);
		} else if( child.invalidChild(this) ) {
			HWarnings.warn("Invalid Child", "HDrawable.add()",
					HWarnings.INVALID_CHILD);
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
	 * Creates a new iterator for this drawable to iterate through its children.
	 * 
	 * Note that while HIterator has similar functionalities with
	 * java.util.Iterator, the former does _not_ extend the latter. This is due
	 * to js mode compatibility issues.
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
		_anchorU = pxX / (_width==0? 100 : _width);
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
		return _width * _anchorU;
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
		_anchorV = pxY / (_height==0? 100 : _height);
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
		return _height * _anchorV;
	}
	
	/**
	 * Sets the anchor of this drawable in UV coordinates.
	 * 
	 * @chainable
	 * @see anchorU(float), anchorV(float)
	 * @param u    The desired `u` coordinate for this drawable's anchor.
	 * @param v    The desired `v` coordinate for this drawable's anchor.
	 * @return This drawable.
	 */
	public HDrawable anchorUV(float u, float v) {
		return anchorU(u).anchorV(v);
	}
	
	/**
	 * Returns the UV coordinates of this drawable's anchor.
	 * 
	 * @see anchorU(), anchorV()
	 * @return A new PVector containing this drawable's anchor as percentage
	 */
	public PVector anchorUV() {
		return new PVector(_anchorU, _anchorV);
	}
	
	/**
	 * Sets the `u` coordinate for this drawable's anchor.
	 * 
	 * @chainable
	 * @see anchorUV(float,float), anchorV(float)
	 * @param u    The desired `u` coordinate for this drawable's anchor.
	 * @return This drawable.
	 */
	public HDrawable anchorU(float u) {
		_anchorU = u;
		return this;
	}
	
	/**
	 * Returns the `u` coordinate of this drawable's anchor.
	 * 
	 * @see anchorUV(), anchorV()
	 * @return The `u` coordinate of this drawable's anchor.
	 */
	public float anchorU() {
		return _anchorU;
	}
	
	/**
	 * Sets the `u` coordinate for this drawable's anchor.
	 * 
	 * @chainable
	 * @see anchorUV(), anchorU()
	 * @param v    The desired `v` coordinate for this drawable's anchor.
	 * @return This drawable.
	 */
	public HDrawable anchorV(float v) {
		_anchorV = v;
		return this;
	}
	
	/**
	 * Returns the `v` coordinate of this draable's anchor.
	 * 
	 * @see anchorUV(), anchorU()
	 * @return The y anchor of this drawable.
	 */
	public float anchorV() {
		return _anchorV;
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
			_anchorU = 0.5f;
		else if(HMath.hasBits(where, HConstants.LEFT))
			_anchorU = 0;
		else if(HMath.hasBits(where, HConstants.RIGHT))
			_anchorU = 1;
		
		if(HMath.hasBits(where, HConstants.CENTER_Y))
			_anchorV = 0.5f;
		else if(HMath.hasBits(where, HConstants.TOP))
			_anchorV = 0;
		else if(HMath.hasBits(where, HConstants.BOTTOM))
			_anchorV = 1;
		return this;
	}
	
	
	// SIZE //
	
	/**
	 * Sets the size of this drawable.
	 * 
	 * If this drawable is set to resize proportionally, the new width will be
	 * adjusted according to the new height by default. (The exception to this
	 * is if the new height is the same as the old height, then the new height
	 * will be adjusted according to the new width instead.)
	 * 
	 * @chainable
	 * @see size(float), width(float), height(float)
	 * @param w    The new width for this drawable.
	 * @param h    The new height for this drawable.
	 * @return This drawable.
	 */
	public HDrawable size(float w, float h) {
		onResize( _width, _height, _width=w, _height=h );
		return this;
	}
	
	/**
	 * Sets the size of this drawable.
	 * 
	 * This method delegates size(float,float).
	 * 
	 * @chainable
	 * @see size(float,float), width(float), height(float)
	 * @param s    The new width and height for this drawable.
	 * @return This drawable.
	 */
	public HDrawable size(float s) {
		return size(s,s);
	}
	
	/**
	 * Returns the size of this drawable.
	 * 
	 * @see width(), height()
	 * @return A new PVector containing the width and height of this drawable.
	 */
	public PVector size() {
		return new PVector(_width,_height);
	}
	
	/**
	 * Sets the width of this drawable.
	 * 
	 * If this drawable is set to resize proportionally, the height will also
	 * change accordingly via onResize(float,float,float,float).
	 * 
	 * @chainable
	 * @see size(float,float), size(float), height(float)
	 * @param w    The new width for this drawable
	 * @return This drawable.
	 */
	public HDrawable width(float w) {
		onResize( _width, _height, _width=w, _height );
		return this;
	}
	
	/**
	 * Returns the width of this drawable.
	 * 
	 * @see size(), height()
	 * @return This drawable's width.
	 */
	public float width() {
		return _width;
	}
	
	/**
	 * Sets the height of this drawable.
	 * 
	 * If this drawable is set to resize proportionally, the width will also
	 * change accordingly.
	 * 
	 * @chainable
	 * @see size(float,float), size(float), width(float)
	 * @param h    The new height for this drawable
	 * @return This drawable.
	 */
	public HDrawable height(float h) {
		onResize( _width, _height, _width, _height=h );
		return this;
	}
	
	/**
	 * Returns the height of this drawable.
	 * 
	 * @see size(), width()
	 * @return This drawable's height
	 */
	public float height() {
		return _height;
	}
	
	/**
	 * Multiplies the width and height of this drawable by the given scale
	 * factor.
	 * 
	 * This method delegates size(float,float).
	 * 
	 * @chainable
	 * @see scale(float,float)
	 * @param s    The scale factor for the width and height.
	 * @return This drawable.
	 */
	public HDrawable scale(float s) {
		return size(_width*s, _height*s);
	}
	
	/**
	 * Multiplies the width and height of this drawable by the given scale
	 * factors.
	 * 
	 * This method delegates size(float,float).
	 * 
	 * @chainable
	 * @see scale(float)
	 * @param sw    The scale factor for the width.
	 * @param sh    The scale factor for the height.
	 * @return This drawable.
	 */
	public HDrawable scale(float sw, float sh) {
		return size(_width*sw, _height*sh);
	}
	
	/**
	 * Sets whether or not this drawable will be resized proportionally.
	 * 
	 * If set to true, then this drawable will try to keep the width and height
	 * at the same ratio when you try to change either the width or height.
	 * 
	 * @chainable
	 * @param b    True, if this drawable will keep its size proportionally.
	 * @return This drawable.
	 */
	public HDrawable proportional(boolean b) {
		_flags = HMath.setBits(_flags, BITMASK_PROPORTIONAL, b);
		return this;
	}
	
	/**
	 * Returns whether or not this drawable is in proportional mode.
	 * 
	 * @return True if this drawable is in proportional mode, else false.
	 */
	public boolean proportional() {
		return HMath.hasBits(_flags,BITMASK_PROPORTIONAL);
	}
	
	public HDrawable transformsChildren(boolean b) {
		_flags = HMath.setBits(_flags,BITMASK_TRANSFORMS_CHILDREN,b);
		return this;
	}
	
	public boolean transformsChildren() {
		return HMath.hasBits(_flags,BITMASK_TRANSFORMS_CHILDREN);
	}
	
	/**
	 * Called after the size of this drawable is changed.
	 * 
	 * By default, this method handles proportional resizing, child
	 * transformations.
	 * 
	 * If you subclass HDrawable and want to execute code whenever your custom
	 * class changes size, override this method. But remember to call
	 * `super.onResize()` at the start of your override when you want to keep
	 * proportional resizing and child transforms.
	 * 
	 * @param oldW    The old width before being resize.
	 * @param oldH    The old height before being resize.
	 * @param newW    The new width after being resized.
	 * @param newH    The new height after being resized.
	 */
	protected void onResize(float oldW, float oldH, float newW, float newH) {
		if(proportional()) {
			if(newH != oldH) {
				if(oldH != 0) _width = oldW * newH/oldH;
			} else if(newW != oldW) {
				if(oldW != 0) _height = oldH * newW/oldW;
			}
		}
		if(transformsChildren()) {
			float scalew = (oldW==0)? 1 : _width/oldW;
			float scaleh = (oldH==0)? 1 : _height/oldH;
			HDrawable child = _firstChild;
			while(child != null) {
				child.loc(child._x*scalew, child._y*scaleh);
				child.scale(scalew,scaleh);
				child = child._next;
			}
		}
	}
	
	/**
	 * Returns the bounding size of this drawable based on this drawble's
	 * rotation.
	 * 
	 * @deprecated This will be replaced with boundingBox() in the future.
	 * @return The bounding size of this drawable.
	 */
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
	
	/**
	 * Sets the fill for this drawable.
	 * 
	 * This method takes in a standard Processing color integer, which are
	 * commonly represented as `0xAARRGGBB` or `#RRGGBB`.
	 * 
	 * @chainable
	 * @see fill(int,int), fill(int,int,int), fill(int,int,int,int)
	 * @param clr    The new fill for this drawable.
	 * @return This drawable.
	 */
	public HDrawable fill(int clr) {
		if(0 <= clr && clr <= 255) clr |= clr<<8 | clr<<16 | 0xFF000000;
		_fill = clr;
		onStyleChange();
		return this;
	}
	
	/**
	 * Sets the fill for this drawable.
	 * 
	 * The `clr` parameter is a standard Processing color integer and alpha is
	 * any number from 0 to 255.
	 * 
	 * Note that `alpha` would override the existing alpha value of `clr`. So if
	 * `clr` is `0x80FFFFFF` and `alpha` is `0x40`, the fill will become
	 * `0x40FFFFFF`.
	 * 
	 * @chainable
	 * @see fill(int), fill(int,int,int), fill(int,int,int,int), noFill()
	 * @param clr    The new fill for this drawable, excluding its alpha value.
	 * @param alpha  The alpha for the new fill for this drawable.
	 * @return This drawable.
	 */
	public HDrawable fill(int clr, int alpha) {
		if(0 <= clr && clr <= 255) clr |= clr<<8 | clr<<16;
		_fill = HColors.setAlpha(clr,alpha);
		onStyleChange();
		return this;
	}
	
	/**
	 * Sets the fill for this drawable.
	 * 
	 * The parameters `r`, `g` and `b` can be any number from 0 to 255.
	 * 
	 * @chainable
	 * @see fill(int), fill(int,int), fill(int,int,int,int), noFill()
	 * @param r    The red component for the new fill for this drawable
	 * @param g    The green component for the new fill for this drawable
	 * @param b    The blue component for the new fill for this drawable
	 * @return This drawable.
	 */
	public HDrawable fill(int r, int g, int b) {
		_fill = HColors.merge(255,r,g,b);
		onStyleChange();
		return this;
	}
	
	/**
	 * Sets the fill for this drawable.
	 * 
	 * The parameters `r`, `g`, `b` and `a` can be any number from 0 to 255.
	 * 
	 * @chainable
	 * @see fill(int), fill(int,int), fill(int,int,int), noFill()
	 * @param r    The red component for the new fill for this drawable
	 * @param g    The green component for the new fill for this drawable
	 * @param b    The blue component for the new fill for this drawable
	 * @param a    The alpha component for the new fill for this drawable
	 * @return This drawable.
	 */
	public HDrawable fill(int r, int g, int b, int a) {
		_fill = HColors.merge(a,r,g,b);
		onStyleChange();
		return this;
	}
	
	/**
	 * Returns the fill for this drawable.
	 * 
	 * The color returned by this method is a standard Processing color integer.
	 * 
	 * @return The fill of this drawable.
	 */
	public int fill() {
		return _fill;
	}
	
	/**
	 * Removes the fill of this drawable.
	 * 
	 * Technically, this method sets the fill to HConstants.CLEAR, which is
	 * `0x00FFFFFF` or fully transparent white.
	 * 
	 * @chainable
	 * @see fill(int), fill(int,int), fill(int,int,int), fill(int,int,int,int)
	 * @return This drawable.
	 */
	public HDrawable noFill() {
		return fill(HConstants.CLEAR);
	}

	/**
	 * Sets the stroke color for this drawable.
	 * 
	 * This method takes in a standard Processing color integer, which are
	 * commonly represented as `0xAARRGGBB` or `#RRGGBB`.
	 * 
	 * @chainable
	 * @see stroke(int,int), stroke(int,int,int), stroke(int,int,int,int), noStroke()
	 * @param clr    The new stroke color for this drawable.
	 * @return This drawable
	 */
	public HDrawable stroke(int clr) {
		if(0 <= clr && clr <= 255) clr |= clr<<8 | clr<<16 | 0xFF000000;
		_stroke = clr;
		onStyleChange();
		return this;
	}
	
	/**
	 * Sets the stroke color for this drawable.
	 * 
	 * The `clr` parameter is a standard Processing color integer and alpha is
	 * any number from 0 to 255.
	 * 
	 * Note that `alpha` would override the existing alpha value of `clr`. So if
	 * `clr` is `0x80FFFFFF` and `alpha` is `0x40`, the fill will become
	 * `0x40FFFFFF`.
	 * 
	 * @chainable
	 * @see stroke(int), stroke(int,int,int), stroke(int,int,int,int), noStroke()
	 * @param clr    The new stroke color for this drawable, excluding its alpha value.
	 * @param alpha  The alpha for the new stroke color for this drawable.
	 * @return This drawable.
	 */
	public HDrawable stroke(int clr, int alpha) {
		if(0 <= clr && clr <= 255) clr |= clr<<8 | clr<<16;
		_stroke = HColors.setAlpha(clr,alpha);
		onStyleChange();
		return this;
	}
	
	/**
	 * Sets the stroke color for this drawable.
	 * 
	 * The parameters `r`, `g` and `b` can be any number from 0 to 255.
	 * 
	 * @chainable
	 * @see stroke(int), stroke(int,int), stroke(int,int,int,int), noStroke()
	 * @param r    The red component for the new stroke color for this drawable
	 * @param g    The green component for the new stroke color for this drawable
	 * @param b    The blue component for the new stroke color for this drawable
	 * @return This drawable.
	 */
	public HDrawable stroke(int r, int g, int b) {
		_stroke = HColors.merge(255,r,g,b);
		onStyleChange();
		return this;
	}
	
	/**
	 * Sets the stroke color for this drawable.
	 * 
	 * The parameters `r`, `g` `b` and `a` can be any number from 0 to 255.
	 * 
	 * @chainable
	 * @see stroke(int), stroke(int,int), stroke(int,int,int), noStroke()
	 * @param r    The red component for the new stroke color for this drawable
	 * @param g    The green component for the new stroke color for this drawable
	 * @param b    The blue component for the new stroke color for this drawable
	 * @param a    The alpha component for the new stroke color for this drawable
	 * @return This drawable.
	 */
	public HDrawable stroke(int r, int g, int b, int a) {
		_stroke = HColors.merge(a,r,g,b);
		onStyleChange();
		return this;
	}

	/**
	 * Returns the stroke color for this drawable.
	 * 
	 * The color returned by this method is a standard Processing color integer.
	 * 
	 * @return The stroke color of this drawable.
	 */
	public int stroke() {
		return _stroke;
	}
	
	/**
	 * Removes the stroke color of this drawable.
	 * 
	 * Technically, this method sets the stroke color to HConstants.CLEAR, which
	 * is equalt to `0x00FFFFFF` or fully transparent white.
	 * 
	 * @chainable
	 * @see stroke(int), stroke(int,int), stroke(int,int,int), stroke(int,int,int,int)
	 * @return This drawable.
	 */
	public HDrawable noStroke() {
		return stroke(HConstants.CLEAR);
	}
	
	/**
	 * Sets the stroke cap for this drawable.
	 * 
	 * The stroke cap can be any of the following values:
	 * - `PConstants.SQUARE`
	 * - `PConstants.PROJECT`
	 * - `PConstants.ROUND`
	 * 
	 * @chainable
	 * @see Processing::strokeCap()
	 * @param type    The stroke cap type for this drawable.
	 * @return This drawable.
	 */
	public HDrawable strokeCap(int type) {
		_strokeCap = type;
		onStyleChange();
		return this;
	}

	/**
	 * Returns the stroke cap for this drawable.
	 * 
	 * @return The integer representing the stroke cap of this drawable.
	 */
	public int strokeCap() {
		return _strokeCap;
	}

	/**
	 * Sets the stroke join for this drawable.
	 * 
	 * The stroke join can be any of the following values:
	 * - `PConstants.MITER`
	 * - `PConstants.BEVEL`
	 * - `PConstants.ROUND`
	 * 
	 * @chainable
	 * @see Processing::strokeJoin()
	 * @param type    The stroke join type for this drawable.
	 * @return This drawable.
	 */
	public HDrawable strokeJoin(int type) {
		_strokeJoin = type;
		onStyleChange();
		return this;
	}

	/**
	 * Returns the stroke join for this drawable.
	 * 
	 * @return The integer representing the stroke join of this drawable.
	 */
	public int strokeJoin() {
		return _strokeJoin;
	}
	
	/**
	 * Sets the stroke weight, or thickness of this drawable.
	 * 
	 * @chainable
	 * @param f    The thickness for this drawable's stroke in pixels.
	 * @return This drawable
	 */
	public HDrawable strokeWeight(float f) {
		_strokeWeight = f;
		onStyleChange();
		return this;
	}
	
	/**
	 * Returns the stroke weight, or thickness of this drawable.
	 * 
	 * @return The stroke weight for this drawable, in pixels.
	 */
	public float strokeWeight() {
		return _strokeWeight;
	}
	
	public HDrawable stylesChildren(boolean b) {
		_flags = HMath.setBits(_flags, BITMASK_STYLES_CHILDREN, b);
		return this;
	}
	
	public boolean stylesChildren() {
		return HMath.hasBits(_flags, BITMASK_STYLES_CHILDREN);
	}
	
	protected void onStyleChange() {
		if(stylesChildren()) {
			HDrawable d = _firstChild;
			while(d!=null) {
				d._stroke = _stroke;
				d._strokeWeight = _strokeWeight;
				d._strokeJoin = _strokeJoin;
				d._strokeCap = _strokeCap;
				d._fill = _fill;
				d = d._next;
			}
		}
	}
	
	
	// ROTATION //
	
	/**
	 * Sets the rotation for this drawable, in degrees.
	 * 
	 * @chainable
	 * @param deg    The new rotation for this drawable, in degrees.
	 * @return This drawable.
	 */
	public HDrawable rotation(float deg) {
		_rotationRad = deg * HConstants.D2R;
		return this;
	}
	
	/**
	 * Returns the rotation for this drawable, in degrees.
	 * 
	 * @return This drawable's rotation in degrees.
	 */
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
	
	/**
	 * Shifts this drawable's current rotation by the passed value, in degrees.
	 * 
	 * @chainable
	 * @param deg    The amount of degrees for the current rotation to be shifted.
	 * @return This drawable.
	 */
	public HDrawable rotate(float deg) {
		_rotationRad += deg * HConstants.D2R;
		return this;
	}
	
	/**
	 * Shifts this drawable's current rotation by the passed value, in radians.
	 * 
	 * @chainable
	 * @param rad    The amount of radians for the current rotation to be shifted.
	 * @return This drawable.
	 */
	public HDrawable rotateRad(float rad) {
		_rotationRad += rad;
		return this;
	}
	
	// TODO rotatesChildren
	
	
	// VISIBILITY //
	
	/**
	 * Sets the transparency for this drawable.
	 * 
	 * The argument for this method can be any number from 0 to 255. Otherwise,
	 * if the argument is less than 0, the alpha will be 0; and if the argument
	 * is greater than 255, the alpha will be 255.
	 * 
	 * Note that transparency _is independent from fill and stroke color_, even
	 * if the fill and stroke can also have alpha values. And unlike fill and
	 * stroke, this transparency can be passed down to this drawable's children.
	 * 
	 * Also note that HDrawable actually stores `alpha` as a percentage ranging
	 * from 0 to 1 to keep the draw() and paintAll() methods a bit faster.
	 * 
	 * @chainable
	 * @see alphaPc(float)
	 * @param a    The new alpha for this drawable.
	 * @return This drawable.
	 */
	public HDrawable alpha(int a) {
		return alphaPc(a/255f);
	}
	
	/**
	 * Returns the transparency for this drawable, ranging at `[0,255]`.
	 * 
	 * You can be assured that the return value will only be in the
	 * aforementioned range.
	 * 
	 * @see alphaPc()
	 * @return The alpha for this drawable with range `(0,255)`.
	 */
	public int alpha() {
		return Math.round( alphaPc()*255 );
	}
	
	/**
	 * Sets the transparency for this drawable, as percentage.
	 * 
	 * The argument for this method can be any number from 0 to 1. Otherwise, if
	 * the argument is less than 0f, the alpha will be 0f; and if the argument
	 * is greater than 1f, the alpha will be 1f. 
	 * 
	 * @chainable
	 * @see alphaPc(float)
	 * @param aPerc    The new alpha for this drawable, as percentage.
	 * @return This drawable.
	 */
	public HDrawable alphaPc(float aPerc) {
		_alphaPc = (aPerc<0)? 0 : (aPerc>1)? 1 : aPerc;
		return this;
	}
	
	/**
	 * Returns the transparency for this drawable, ranging from 0 to 255.
	 * 
	 * You can be assured that the return value will only be in the
	 * aforementioned range.
	 * 
	 * @see alpha()
	 * @return The alpha for this drawable with range `(0f,1f)`.
	 */
	public float alphaPc() {
		return (_alphaPc<0)? 0 : _alphaPc;
	}
	
	/**
	 * Sets the visibility of this drawable.
	 * 
	 * Technically this method manipulates the alpha of this drawable. If `v` is
	 * false, the alpha will become the negative of the current alpha, making
	 * this drawable invisible. Otherwise, if `v` is true, the alpha will become
	 * the positive of the current alpha (or 1f if the current alpha is 0),
	 * making this drawable visible. 
	 * 
	 * @chainable
	 * @see show(), hide()
	 * @param v    True if this drawable will be visible, false if invisible.
	 * @return This drawable.
	 */
	public HDrawable visibility(boolean v) {
		if( v && (_alphaPc==0) ) {
			_alphaPc = 1;
		} else if( v == (_alphaPc<0) ) {
			_alphaPc = -_alphaPc;
		}
		return this;
	}
	
	/**
	 * Returns the visibility of this drawable.
	 * 
	 * @return True if this drawable is visible, otherwise false.
	 */
	public boolean visibility() {
		return _alphaPc > 0;
	}
	
	/**
	 * Makes this drawable visible by calling `visibility(true)`.
	 * 
	 * @chainable
	 * @see visibility(boolean), hide()
	 * @return This drawable.
	 */
	public HDrawable show() {
		return visibility(true);
	}
	
	/**
	 * Makes this drawable invisible by calling `visibility(false)`.
	 * 
	 * @chainable
	 * @see visibility(boolean), show()
	 * @return This drawable.
	 */
	public HDrawable hide() {
		return visibility(false);
	}
	
	/**
	 * Shifts the current alpha of this drawable by the given value.
	 * 
	 * @chainable
	 * @see alpha(int)
	 * @param da    The amount that the alpha will be shifted.
	 * @return This drawable.
	 */
	public HDrawable alphaShift(int da) {
		return alphaShiftPc( da/255f );
	}
	
	/**
	 * Shifts the current alpha of this drawable, by percentage.
	 * 
	 * @chainable.
	 * @see alphaPc(float)
	 * @param daPerc    The amount that alpha will be shifted, by percentage.
	 * @return This drawable.
	 */
	public HDrawable alphaShiftPc(float daPerc) {
		return alphaPc(_alphaPc + daPerc);
	}
	
	
	// UTILITY //
	
	public float x2u(float px) {
		return px / (_width==0? 100 : _width);
	}
	
	public float y2v(float px) {
		return px / (_height==0? 100 : _height);
	}
	
	public float u2x(float pc) {
		return pc * _width;
	}
	
	public float v2y(float pc) {
		return pc * _height;
	}
	
	/**
	 * Assigns an _extras bundle_ for this drawable to hold arbitrary data.
	 * 
	 * This follows the same idea as with Android's Bundles.
	 * 
	 * @chainable
	 * @see Android::Bundle
	 * @param b    The new extras bundle for this drawable.
	 * @return This drawable.
	 */
	public HDrawable extras(HBundle b) {
		_extras = b;
		return this;
	}
	
	/**
	 * Returns this drawable's _extras bundle_.
	 * 
	 * @return The extras bundle for this drawable.
	 */
	public HBundle extras() {
		return _extras;
	}
	
	/**
	 * Puts any arbitrary object into this drawable's _extras bundle_.
	 * 
	 * If the extras bundle is null, this method will create a new one.
	 * 
	 * @chainable
	 * @see HBundle.obj(String,Object)
	 * @param key    The string that will be the key for `value`.
	 * @param value  The object to be stored.
	 * @return This drawable.
	 */
	public HDrawable obj(String key, Object value) {
		if(_extras == null) _extras = new HBundle();
		_extras.obj(key,value);
		return this;
	}
	
	/**
	 * Puts any arbitrary native value into this drawable's _extras bundle_.
	 * 
	 * If the extras bundle is null, this method will create a new one.
	 * 
	 * @chainable
	 * @see HBundle.num(String,float)
	 * @param key    The string that will be the key for `value`.
	 * @param value  The native value to be stored.
	 * @return This drawable.
	 */
	public HDrawable num(String key, float value) {
		if(_extras == null) _extras = new HBundle();
		_extras.num(key,value);
		return this;
	}
	
	/**
	 * Puts any arbitrary boolean value into this drawable's _extras bundle_.
	 * 
	 * @chainable
	 * @see HBundle.bool(String,boolean)
	 * @param key    The string the will be the key for `value`.
	 * @param value  The boolean to be stored
	 * @return This drawable.
	 */
	public HDrawable bool(String key, boolean value) {
		if(_extras == null) _extras = new HBundle();
		_extras.bool(key,value);
		return this;
	}
	
	/**
	 * Returns the object from the _extras bundle_ with the corresponding key.
	 * 
	 * If the extras bundle is null, this method will return null.
	 * 
	 * @see HBundle.num(String)
	 * @param key   The key that will be used to fetch the object.
	 * @return The object with the corresponding key.
	 */
	public Object obj(String key) {
		return (_extras==null)? null : _extras.obj(key);
	}
	
	/**
	 * Returns the string from the _extras bundle_ with the corresponding key.
	 * 
	 * This is a shorthand for `(String) obj(key)`. If the extras bundle is
	 * null, this method will return null.
	 * 
	 * @see HBundle.str(String)
	 * @param key    The key that will be used to fetch the string.
	 * @return The string with the corresponding key.
	 */
	public String str(String key) {
		return (_extras==null)? null : _extras.str(key);
	}
	
	/**
	 * Returns the number from the _extras bundle_ with the corresponding key.
	 * 
	 * If the extras bundle is null, this method will return 0.
	 * 
	 * @see HBundle.num(String)
	 * @param key    The key that will be used to fetch the float value.
	 * @return The float value with the corresponding key.
	 */
	public float num(String key) {
		return (_extras==null)? 0 : _extras.num(key);
	}
	
	/**
	 * Returns the rounded number from the _extras bundle_ with the corresponding key.
	 * 
	 * If the extras bundle is null, this method will return 0.
	 * 
	 * @param key    The key that will be used to fetch the integer value.
	 * @return The integer value with the corresponding key.
	 */
	public int numI(String key) {
		return (_extras==null)? 0 : _extras.numI(key);
	}
	
	/**
	 * Returns the equivalent boolean value from the _extras bundle_ with the corresponding key.
	 * 
	 * @see HBundle.bool(String)
	 * @param key
	 * @return
	 */
	public boolean bool(String key) {
		if(_extras == null)
			return false;
		return _extras.bool(key);
	}
	
	@Override
	public boolean contains(float absX, float absY, float absZ) {
		PApplet app = H.app();
		absZ -= _z;
		return contains(
			app.screenX(absX,absY,absZ),
			app.screenY(absX,absY,absZ));
	}
	
	@Override
	public boolean contains(float absX, float absY) {
		float[] rel = HMath.relLocArr(this, absX, absY);
		rel[0] += anchorX();
		rel[1] += anchorY();
		return containsRel(rel[0], rel[1]);
	}
	
	@Override
	public boolean containsRel(float relX, float relY, float relZ) {
		PApplet app = H.app();
		relZ -= _z;
		return containsRel(
			app.screenX(relX,relY,relZ),
			app.screenY(relX,relY,relZ));
	}
	
	@Override
	public boolean containsRel(float relX, float relY) {
		return (0 <= relX) && (relX <= width()) &&
			(0 <= relY) && (relY <= height());
	}
	
	
	// DRAWING //
	
	/**
	 * Applies this drawable's styling to the given graphics context.
	 * 
	 * This method is primarily used by some subclasses' `draw()` method.
	 * 
	 * @param g    The graphics context for this drawable.
	 * @param currAlphaPc    The current alpha value in the draw cycle.
	 */
	protected void applyStyle(PGraphics g, float currAlphaPc) {
		float faPerc = currAlphaPc * (_fill >>> 24);
		g.fill(_fill | 0xFF000000, Math.round(faPerc));
		
		if(_strokeWeight > 0) {
			float saPerc = currAlphaPc * (_stroke >>> 24);
			g.stroke(_stroke | 0xFF000000, Math.round(saPerc));
			g.strokeWeight(_strokeWeight);
			g.strokeCap(_strokeCap);
			g.strokeJoin(_strokeJoin);
		} else g.noStroke();
	}
	
	/**
	 * Prepares the environment for drawing this drawable and its children.
	 * 
	 * This method is primarily called internally during the draw cycle and
	 * probably wouldn't need to be called directly.
	 * 
	 * @param g    The graphics context for this drawable.
	 * @param usesZ    Indicates if z-coordinates are used.
	 * @param currAlphaPc    The current alpha value in the draw cycle.
	 */
	public void paintAll(PGraphics g, boolean usesZ, float currAlphaPc) {
		if(_alphaPc<=0) return;
		g.pushMatrix();
			// Rotate and translate
			if(usesZ) g.translate(_x,_y,_z);
			else g.translate(_x,_y);
			g.rotate(_rotationRad);
			
			// Compute current alpha
			currAlphaPc *= _alphaPc;
			
			// Draw self
			draw(g, usesZ,-anchorX(),-anchorY(),currAlphaPc);
			
			// Draw children
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(g, usesZ, currAlphaPc);
				child = child._next;
			}
		g.popMatrix();
	}
	
	/**
	 * Draws this drawable.
	 * 
	 * This method is abstract and is meant to be implemented by the children
	 * of this class. Also, this method is primarily called internally during
	 * the draw cycle and probably wouldn't need to be called directly.
	 * 
	 * @param g     The graphics context for this drawable.
	 * @param usesZ Indicates if z-coordinates are used.
	 * @param drawX The x coordinate where this drawable would consider as 0
	 * @param drawY The y coordinate where this drawable would consider as 0
	 * @param currAlphaPc    The current alpha value in the draw cycle.
	 */
	public abstract void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float currAlphaPc);
	
	
	
	/**
	 * An HIterator used for iterating through HDrawable's children.
	 * 
	 * @author james
	 */
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
