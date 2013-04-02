HDrawable _(abstract class)_
============================

### Full Name
`hype.drawable.HDrawable`

### Inheritance Tree
[`java.lang.Object`][10] > `hype.drawable.HDrawable`


### Interfaces
- [`hype.util.HFollower`][7]
- [`hype.util.HFollowable`][8]


### Summary

HDrawable is the super class of all drawables --- objects that could be
displayed on the HYPE. HDrawables can represent a variety of objects:

- Basic Shapes ([`HEllipse`][1], [`HRect`][2] & [`HPath`][3])
- Vector and Raster Images ([`HShape`][4] & [`HImage`][5])
- Text ([`HText`][6])


### Usage

*Under Construction*



- - - - - - - - - - - - - - - -


Method List
===========

- Constructors and Cloning Methods
	- [`HDrawable()`			](#hdrawable) _constructor_
	- [`copyPropertiesFrom()`	](#copypropertiesfrom)
	- [`createCopy()`			](#createcopy) _abstract_
- Child and Parent Methods
	- [`_set_parent_()`	](#_set_parent_) _reserved_
	- [`parent()`		](#parent)
	- [`children()`		](#children)
	- [`numChildren()`	](#numchildren)
	- [`hasChildren()`	](#haschildren)
	- [`add()`			](#add)
	- [`remove()`		](#remove)
	- [`iterator()`		](#iterator)
- Position Methods
	- [`loc()`			](#loc)
	- [`x()`			](#x)
	- [`y()`			](#y)
	- [`move()`			](#move)
	- [`locAt()`		](#locAt)
- Anchor Methods
	- [`anchor()`		](#anchor)
	- [`anchorX()`		](#anchorx)
	- [`anchorY()`		](#anchory)
	- [`anchorAt()`		](#anchorat)
- Size Methods
	- [`size()`			](#size)
	- [`width()`		](#width)
	- [`height()`		](#height)
	- [`scale()`		](#scale)
	- [`boundingSize()`	](#boundingsize)
- Style Methods
	- [`fill()`			](#fill)
	- [`stroke()`		](#stroke)
	- [`strokeCap()`	](#strokecap)
	- [`strokeJoin()`	](#strokejoin)
	- [`strokeWeight()`	](#strokeWeight)
- Rotation Methods
	- [`rotation()`		](#rotation)
	- [`rotationRad()`	](#rotationrad)
	- [`rotate()`		](#rotate)
	- [`rotateRad()`	](#rotaterad)
- Visibility and Appearance Methods
	- [`alpha()`		](#alpha)
	- [`visibility()`	](#visibility)
	- [`show()`			](#show)
	- [`hide()`			](#hide)
	- [`alphaShift()`	](#alphashift)
- Utility Methods
	- [`followerX()`			](followerx) _implementation_
	- [`followery()`			](#followery) _implementation_
	- [`followableX()`			](#followerx) _implementation_
	- [`followableY()`			](#followery) _implementation_
	- [`follow()`				](#follow) _implementation_
	- [`extras()`				](#extras)
	- [`generateRandomPoint()`	](#generaterandompoint)
	- [`abs2rel()`				](#abs2rel)
	- [`rel2abs()`				](#rel2abs)
	- [`set()`					](#set)
- Drawing Methods
	- [`applyStyle()`	](#applystyle)
	- [`paintAll()`		](#paintall)
	- [`draw()`			](#draw) _abstract_



- - - - - - - - - - - - - - - -

Method Summary
==============

HDrawable()
-----------
### Usage: `new HDrawable()`
The default constructor for *HDrawable*.

**Note:** Since *HDrawable* is an abstract class, you don't normally need to use
this constructor directly.



copyPropertiesFrom()
--------------------
### Usage: `copyPropertiesFrom(HDrawable other)`
Copies the following properties from *other*:

- `_x`, `_y`
- `_drawX`, `_drawY` *(used by anchorX and anchorY)*
- `_width`, `_height`
- `_rotationRad`
- `_fill`, `_stroke`, `_strokeWeight`, `_strokeCap`, `_strokeJoin`
- `_alpha`

This method is primarily used with *createCopy()*.

**See:** [`createCopy()`](#createcopy)



createCopy()
------------
### Usage: `createCopy()`
Creates a copy of this drawable.

**Note:** This is an abstract method that's supposed to be overriden by the
subclasses of this drawable.

**Returns:** `HDrawable` _a new copy of this drawable_



\_set_parent\_()
----------------
### Usage: `_set_parent_(HDrawable newParent)`
Dumbly assigns this drawable's parent to *newParent*.

**Note:** This method is reserved, to be used for internal purposes only.



parent()
--------
### Usage: `parent()`
Returns this drawable's *parent*.

**Returns:** `HDrawable` _the parent of this drawable_



children()
----------
### Usage: `children()`
Returns this drawable's children. Since *HChildList* automatically sets
the children's parents, this method could be used as an alternate way of
adding and removing children:

	HChildSet children = myDrawable.children();
	children.remove( myRect );
	children.add( myEllipse );

**Note:** HDrawable's *_children* is lazily loaded, being instantiated only
when *add()* is called. So it's possible that this method may return *null*.

**Returns:** `HChildList` _the children of this drawable_



numChildren()
-------------
### Usage: `numChildren()`
Returns the number of this drawable's children. If *_children* is null, it
will return *0*.

**Returns:** `int` _the number of this drawable's children_



hasChildren()
-------------
### Usage: `hasChildren()`
Returns true if this drawable has children. If *_children* is null, it will
return *false*;

**Returns:** `boolean` _false, if this drawable has no children; otherwise, true_



add()
-----
### Usage: `add(HDrawable child)`
Adds *child* and sets its parent to this drawable. It will always return *child*, so
it can be used like this:

	HDrawable d = myDrawable.add( new HRect() );

**Returns:** `HDrawable` _the child parameter passed to this method_



remove()
--------
### Usage: `remove(HDrawable child)`
Removes *child* from this drawable and sets its parent to null. It will always
return *child*, so it could be used like this:

	HDrawable d = myDrawable.remove( mdsChild );

**Returns:** `HDrawable` _the child paremeter passed to this method_



iterator()
----------
### Usage: `iterator()`
Returns an iterator created by *_children.iterator()* which could be used to
iterate through this drawable's children:

	HIterator<HDrawable> it = myDrawable.iterator()
	while(it.hasNext()) {
		HDrawable d = it.next();
		d.doSomething();
	}

**See:** [`HChildSet.iterator()`](HChildSet.md#iterator)

**Returns:** `HIterator` _the iterator for this drawable's children_



loc()
-----
### Usage: `loc()`
Returns this drawable's *x,y* coordinates as *PVector*.

**Returns:** `PVector` _a new PVector containing this drawable's x,y coordinates_

### Usage: `loc(float newX, float newY)`, `loc(PVector pt)`
Sets this drawable's *x,y* coordinates.

**Note:** This method is chainable

**Returns:** `HDrawable` _this drawable itself_



x()
---
### Usage: `x()`
Returns this drawable's *x* coordinate.

**Returns:** `float` _the x coordinate of this drawable_

### Usage: `x(float newX)`
Sets this drawable's *x* coordinate.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



y()
---
### Usage: `y()`
Returns this drawable's *y* coordinate.

**Returns:** `float` _the y coordinate of this drawable_

### Usage: `y(float newY)`
Sets this drawable's *y* coordinate.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



move()
------
### Usage: `move(float dx, float dy)`
Translates this drawable's *x,y* coordinates by *dx,dy*.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



locAt()
-------
### Usage: `locAt(int where)`
Sets this drawable's location to *where* in relation to its
parent. If this drawable has no parent, then it will do nothing.

The parameter *where* could be any combination of the following:

- `H.LEFT`		_(0b0001)_
- `H.RIGHT`		_(0b0010)_
- `H.CENTER_X`	_(0b0011)_
- `H.TOP`		_(0b0100)_
- `H.BOTTOM`	_(0b1000)_
- `H.CENTER_Y`	_(0b1100)_
- `H.CENTER`	_(0b1111)_

The aforementioned values can be combined via *bitwise OR*:

	myDrawable.locAt( H.BOTTOM | H.RIGHT );

**Note:** This method is chainable.

**See:** [`anchorAt()`](#anchorat)

**Returns:** `HDrawable` _this drawable itself_



anchor()
--------
A drawable's anchor coordinates dictates this drawable's rotation center. By
default the anchor is located at *0,0*, or the top-left corner of this drawable.

Resizing your drawable will adjust your anchor:

	myDrawable.size(100,100);
	
	// Anchor is at (50,50)
	myDrawable.anchorAt(H.CENTER);
	
	// Anchor is now at (125,125)
	myDrawable.size(250,250);

As a note to devs, unlike most other fields in this class, HDrawable does not store
an *_anchorX* or *_anchorY* field. Instead it stores *_drawX* and *_drawY* which are
the negatives of anchorX and anchorY. This is done for optimization purposes, as
*_drawX* and *_drawY* is used directly by *draw()*.

### Usage: `anchor()`
Returns this drawable's anchor coordinates as *PVector*.

**Returns:** `PVector` _a new PVector containing this drawable's anchor coordinates_

### Usage: `anchor(float x, float y)`, `anchor(PVector pt)`
Sets this drawable's anchor coordinates.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



anchorX()
---------
### Usage: `anchorX()`
Returns this drawable's anchor's x coordinate.

**Returns:** `float` _this drawable's anchor's x coordinate_

### Usage: `anchorX(float ancX)`
Sets this drawable's anchor's x coordinate.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



anchorY()
---------
### Usage: `anchorY()`
Returns this drawable's anchor's y coordinate.

**Returns:** `float` _this drawable's anchor's y coordinate_

### Usage: `anchorY(float ancY)`
Sets this drawable's anchor's y coordinate.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



anchorAt()
----------
### Usage: `anchorAt(int where)`
Sets this drawable's anchor location to *where* in relation to
itself.

The parameter *where* could be any combination of the following:

- `H.LEFT`		_(0b0001)_
- `H.RIGHT`		_(0b0010)_
- `H.CENTER_X`	_(0b0011)_
- `H.TOP`		_(0b0100)_
- `H.BOTTOM`	_(0b1000)_
- `H.CENTER_Y`	_(0b1100)_
- `H.CENTER`	_(0b1111)_

The aforementioned values can be combined via *bitwise OR*

	myDrawable.locAt( H.BOTTOM | H.RIGHT );

**Note:** This method is chainable.

**See:** [`locAt()`](#locat)

**Returns:** `HDrawable` _this drawable itself_



size()
------
### Usage: `size()`
Returns this drawable's width and height as a *PVector*.

**Returns:** `PVector` _a new PVector containing this drawable's width and height_

### Usage: `size(float w, float h)`, `size(PVector pt)`
Sets this drawable's width and height.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



width()
-------
### Usage: `width()`
Returns this drawable's width.

**Returns:** `float` _this drawable's width_

### Usage: `width(float w)`
Sets this drawable's width.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



height()
--------
### Usage: `height()`
Returns this drawable's height.

**Returns:** `float` _this drawable's height_

### Usage: `height(float h)`
Sets this drawable's height.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



scale()
-------
### Usage: `scale(float ratio)`
Multiplies this drawable's width and height by *ratio*.

	// width = 100, height = 200
	myDrawable.size(100,200); 
	
	// width = 150, height = 300
	myDrawable.scale(1.5);

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_

### Usage: `scale(float ratioX, float ratioY)`
Multiplies this drawable's width and height by *ratioX* and *ratioY*
respectively.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



boundingSize()
--------------
### Usage: `boundingSize()`
Returns the width and height of this drawable adjusted by its current rotation.

**Returns:** `PVector` _a new PVector with the rotated size of this drawable_



fill()
------
By default, the fill and stroke colors will be equal to fully transparent
white, or 0x00FFFFFF. So in some subclasses that represent primitive shapes,
such as *HRect*, *HEllipse* or *HPath*, not setting the fill or stroke might
make them invisible:

	HEllipse circ = new HEllipse(8);
	H.add(circ); // circ has transparent fill and stroke!

So remember to set the fill and stroke on these classes:

	HEllipse circ = new HCirc(16,32)
		fill(128,255,128)
		stroke(255,128,255);
	H.add(circ); // circ is no longer transparent!

The fill and stroke colors are independent from alpha, so your drawable can
have 255 alpha, but with transluscent fill.

Note that not all implementations will have applicable fill and stroke, such
as HImage and HStage.

Also note that while your drawable's alpha will also be applied to all its
children, fill does not.

A drawable's fill and stroke colors are stored the same way as the colors in
Processing which is 32 bit integer using an ARGB scheme. The most convenient
way to create an integer literal that represents a color is via hexadecimal
notation:

	// Java & Processing:
	int fillColor = 0xFFC0FFEE // AA,RR,GG,BB
	
	// Processing only:
	fillColor = #C0FFEE // RR,GG,BB (alpha is automatically set to 0xFF)
	
	myDrawable.fill(fillColor);

### Usage: `fill()`
Returns this drawable's fill color.

**Returns:** `int` / `color` _the fill color of this drawable_

### Usage: `fill(int clr)`, `fill(int clr, int alpha)`, `fill(int r, int g, int b)`, `fill(int r, int g, int b, int a)`
Sets this drawable's fill color.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



stroke()
--------
For general notes about fill and stroke colors, see [`fill()`](#fill)

### Usage: `stroke()`
Returns this drawable's stroke color.

**Returns:** `int` / `color` _the stroke color of this drawable_

### Usage: `stroke(int clr)`, `stroke(int clr, int alpha)`, `stroke(int r, int g, int b)`, `stroke(int r, int g, int b, int a)`
Sets this drawable's stroke color.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



strokeCap()
-----------
A drawable's stroke cap can be any of the following:

- `SQUARE`
- `PROJECT`
- `ROUND`

The stroke cap will default to *ROUND*, if *strokeCap(int)* isn't called.
See [`Processing::strokeCap()`](http://processing.org/reference/strokeCap_.html)
for more information.

### Usage: `strokeCap()`
Returns this drawable's stroke cap.

**Returns:** `int` _this drawable's stroke cap_

### Usage: `strokeCap(int capType)`
Sets the style for the stroke cap of this drawable, if applicable.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



strokeJoin()
------------
A drawable's stroke join can be any of the following:

- `MITER`
- `BEVEL`
- `ROUND`

The stroke join will default to *MITER*, if *strokeJoin(int)* isn't called.
See [`Processing::strokeJoin()`](http://processing.org/reference/strokeJoin_.html)
for more information.

### Usage: `strokeJoin()`
Returns this drawable's stroke join.

**Returns:** `int` _this drawable's stroke join_

### Usage: `strokeJoin(int strokeType)`
Sets the style for the stroke join of this drawable, if applicable.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



strokeWeight()
--------------
### Usage: `strokeWeight()`
Returns the width of this drawable's stroke in pixels.

**Returns:** `float` _this drawable's stroke weight_

### Usage: `strokeWeight(float weight)`
Sets the width of this drawable's stroke in pixels.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



rotation()
----------
Rotation dictates the angle of a drawable. The rotation is configured
clockwise, so if your drawable is rotated at 45 degrees, it gets rotated
45 degrees clockwise; if your drawable is rotated at -30 degrees, it gets
rotated 30 degrees counter-clockwise.

As a note to devs, HDrawable's rotation is stored as *_rotationRad* which
is in **radians**, not degrees. As with anchorX and anchorY, this is for
optimization purposes.

For direct handling of rotation in radians, see [`rotationRad()`](#rotationrad)
and [`rotateRad()`](#rotaterad).

### Usage: `rotation()`
Returns this drawable's rotation in degrees.

**Returns:** `float` _this drawable's rotation in degrees_

### Usage: `rotation(float degrees)`
Sets this drawable's rotation in degrees.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



rotationRad()
-------------
### Usage: `rotationRad()`
Returns this drawable's rotation in radians.

**Returns:** `float` _this drawable's rotation in radians_

### Usage: `rotationRad(float radians)`
Sets this drawable's rotation in radians.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



rotate()
--------
### Usage: `rotate(float dDegrees)`
Adds *dDegrees* to this drawable's current rotation, in degrees.

	myDrawable.rotation(45); // set rotation to 45 degrees
	myDrawable.rotate(15); // 45 + 15 = 60 degrees

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



rotateRad()
-----------
### Usage: `rotateRad(float dRadians)`
Adds *dRadians* to this drawable's current rotation, in radians.

	myDrawable.rotationRad(3.14); // set rotation to PI
	myDrawable.rotateRad(6.28); // 3.14 + 6.28 = 9.42 radians

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



alpha()
-------
Alpha dictates how transparent an HDrawable and its children would be when
it is drawn to the stage. Note that alpha is independent from *fill* and
*stroke*, so you could have maximum alpha, but transparent fill or stroke.

Alpha's range is from 0 to 255. When calling *alpha()*, you could be more
or less assured that the return value is within that range.

### Usage: `alpha()`
Returns this drawable's alpha value.

As a note to devs, *_alpha* can sometimes be stored as a negative value,
but `alpha()` will return 0.

**Returns:** `float` _this drawable's alpha value with range (0,255)_

### Usage: `alpha(int a)`
Sets this drawable's alpha.

If the parameter *a* is less than 0, this drawable's alpha value will be
assigned to 0 instead; if it is greater than 255, this drawable's alpha will
be assigned to 255.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



visibility()
------------
The visibility methods offers a quick way of showing and hiding drawables,
or for checking if said drawables are visible without needing to manually
setting or checking a specific alpha value.

### Usage: `visibility()`
Checks whether this drawable is visible or not. This method returns true if
this drawable's alpha value is greater than 0.

**Returns:** `boolean` _true if alpha > 0; otherwise, false_

### Usage: `visibility(boolean isVisible)`
Shows or hides this drawable. This method will restore transluscency, if
applicable

To devs, if *_alpha* is 0 and *isVisible* is true, then *_alpha* will be
set to 255. If *_alpha* is negative and *isVisible* is true, then *_alpha*
will be set to positive. If *_alpha* is positive and *isVisible* is false,
then *_alpha* will be set to negative.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



show()
------
### Usage: `show()`
Alias method for *visibility(true)*.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



hide()
------
### Usage: `hide()`
Alias method for *visibility(false)*.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



alphaShift()
------------
### Usage: `alphaShift(int dAlpha)`
Adds *dAlpha* to this drawable's current alpha value.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



followerX()
-----------
### Usage: `followerX()`
Returns this drawable's current follower x coordinate. By default,
follower x is the x coordinate of this drawable.

**Note:** This is primarily used internally by *HFollow*, you don't
normally need to use this method directly.

**Note:** This method is part of HDrawable's implementation for *HFollower*

**See:** [`HFollower`][7]

**Returns:** `float` _this drawable's follower y coordinate_



followerY()
-----------
### Usage: `followerY()`
Returns this drawable's current follower y coordinate. By default,
follower y is the y coordinate of this drawable.

**Note:** This is primarily used internally by *HFollow*, you don't
normally need to use this method directly.

**Note:** This method is part of HDrawable's implementation for *HFollower*

**See:** [`HFollower`][7]

**Returns:** `float` _this drawable's follower y coordinate_

followableX()
-------------
### Usage: `followableX()`
Returns this drawable's current followable x coordinate. By default,
followable x is the x coordinate of this drawable. The subclass
*HStage* is an exception to this, whose followable x value corresponds
to *mouseX*

**Note:** This is primarily used internally by *HFollow*, you don't
normally need to use this method directly.

**Note:** This method is part of HDrawable's implementation for *HFollowable*

**See:** [`HFollowable`][8]

**Returns:** `float` _this drawable's followable x value_

followableY()
-------------
### Usage: `followableY()`
Returns this drawable's current followable y coordinate. By default,
followable y is the y coordinate of this drawable. The subclass
*HStage* is the exception to this, whose followable y value corresponds
to *mouseY*

**Note:** This is primarily used internally by *HFollow*, you don't
normally need to use this method directly.

**Note:** This method is part of HDrawable's implementation for *HFollowable*

**See:** [`HFollowable`][8]

**Returns:** `float` _this drawable's followable x value_

follow()
--------
### Usage: `follow(float dfx, float dfy)`
Sets this drawable's follower x and y coordinates.  By default this
method is aliased to *move()*.

**Note:** This is primarily used internally by *HFollow*, you don't
normally need to use this method directly.

**Note:** This method is part of HDrawable's implementation for *HFollower*

**See:** [`HFollower`][7]



extras()
--------
An extras bundle can be used to store arbitrary information for individual
drawables. Note that you will have to explicitly assign a new *HBundle*
before storing and retrieving arbitrary information for your *HDrawable*:

	// Assigning a new extras bundle:
	HBundle bundle = new HBundle();
	myDrawable.extras(bundle);
	
	// Storing information in extras:
	myDrawable.extras()
		.obj("some_key", new ArrayList() );
	
	myDrawable.extras()
		.num("another_key", 1024);
	
	// Retrieving information from extras:
	ArrayList list = (ArrayList) myDrawable.extras()
		.obj("some_key");
	
	float number = myDrawable.extras()
		.num("another_key");

See [HBundle][11] for more information.

### Usage: `extras()`
Returns this drawable's extras bundle. Note that the extras bundle is null
by default, and has to be first assigned via *extras(HBundle)*.

**Returns:** `HBundle` _this drawable's extras bundle; can be null_

### Usage: `extras(HBundle bundle)`
Sets this drawable's extras bundle.

**Note:** This method is chainable.

**Returns:** `HDrawable` _this drawable itself_



generateRandomPoint()
---------------------
*NOT YET IMPLEMENTED*

abs2rel()
---------
*NOT YET IMPLEMENTED*

rel2abs()
---------
*NOT YET IMPLEMENTED*

set()
-----
### Usage: `set(int propertyId, float value)`
Sets the property indicated by parameter *propertyId* to *value*.

The parameter *propertyId* can be any of the following:

- `H.WIDTH`
- `H.HEIGHT`
- `H.SIZE`
- `H.ALPHA`
- `H.X`
- `H.Y`
- `H.LOCATION`
- `H.ROTATION`
- `H.DROTATION`
- `H.DX`
- `H.DY`
- `H.DLOC`

**Note:** This method is primarily used internally by certain *HBehavior* classes,
you normally don't need to use this method directly.



applyStyle()
------------
### Usage: `applyStyle(PApplet app, int currAlpha)`
Applies this drawable's style information to the Processing environment
indicated by *app*.

**Note:** This method is primarily used internally by *paintAll()*, you
normally don't need to use this method directly.



paintAll()
----------
### Usage: `paintAll(PApplet app, int currAlpha)`
Prepares the environment for this drawable's *draw()* method, then calls
it. This method also calls *paintAll()* for the children of this drawable,
if applicable.

**Note:** This method is primarily used internally by *HStage*, you
normally don't need to use this method directly.



draw()
------
### Usage: `draw(PApplet app, float drawX, float drawY, int currAlpha)`
Renders this drawable to the stage.

**Note:** This method is primarily used internally by *HStage*, you
normally don't need to use this method directly.

**Note:** This is an abstract method that's supposed to be overriden by the
subclasses of this drawable.





[1]: HEllipse.md
[2]: HRect.md
[3]: HPath.md
[4]: HShape.md
[5]: HImage.md
[6]: HPath.md
[7]: HFollower.md
[8]: HFollowable.md
[9]: HFollow.md
[10]: http://docs.oracle.com/javase/7/docs/api/java/lang/Object.html
[11]: HBundle.md
