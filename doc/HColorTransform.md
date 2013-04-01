HColorTransform _(class)_
=========================

### Full Name
`hype.color.HColorTransform`

### Inheritance Tree
[`java.lang.Object`][1] > `hype.color.HColorTransform`


### Interfaces
- [`hype.color.HColorist`][2]

### Summary

HColorTransform is a Colorist class that takes an existing color and transforms it according to its
own percentage and offset values. Since this class implements HColorist, it has the same methods and
functionalities common to all other Colorists.

Here is an example on HColorTransform's usage:

	HColorTransform transform = new HColorTransform()
		.perc( 0.5 ); // all color percentages to 50%
	
	myDrawable.fill(#FFFFFF)
		.stroke(#0000FF);
	
	transform.applyColor( myDrawable ); // apply the transform
	
	println(hex( transform.fill() )); // prints #808080
	println(hex( transform.stroke() )); // prints #000080


HColorTransform can also be used for things other than drawables:

	HColorTransform transform = new HColorTransform()
		.offset(255); // all offsets to +255
	
	int myColor = #C0FFEE;
	
	int newColor = transform.getColor( myColor );
	println( hex(newColor) ); // prints #FFFFFF
	
	background( newColor );

You can use both offsets and multipliers in a single color transform. Just keep in mind that the multiplier
values are applied _before_ the offsets.


- - - - - - - - - - - - - - - -

Property List
=============
- `_offsetA`	_offset for alpha_
- `_offsetR`	_offset for red_
- `_offsetG`	_offset for green_
- `_offsetB`	_offset for blue_
- `_percA`		_multiplier for alpha_
- `_percR`		_multiplier for red_
- `_percG`		_multiplier for green_
- `_percB`		_multiplier for blue_

- - - - - - - - - - - - - - - -

Method List
===========
- Constructors and Cloning Methods
	- [`HColorTransform()`	](#hcolortransform) _constructor_
	- [`createCopy()`		](#createcopy)
	- [`createNew()`		](#createnew)
- Offset Methods
	- [`offset()`	](#offset)
	- [`offsetA()`	](#offseta)
	- [`offsetR()`	](#offsetr)
	- [`offsetG()`	](#offsetg)
	- [`offsetB()`	](#offsetb)
- Percentage / Multiplier Methods
	- [`perc()`	](#perc)
	- [`percA()`](#perca)
	- [`percR()`](#percr)
	- [`percG()`](#percg)
	- [`percB()`](#percb)
- Implementations for [HColorist][2]
	- [`fillOnly()`		](HColorist.md#fillonly) _implementation_
	- [`strokeOnly()`	](HColorist.md#strokeonly) _implementation_
	- [`fillAndStroke()`](HColorist.md#fillandstroke) _implementation_
	- [`appliesFill()`	](HColorist.md#appliesfill) _implementation_
	- [`appliesStroke()`](HColorist.md#appliesstroke) _implementation_
	- [`applyColor()`	](HColorist.md#applycolor) _implementation_
- Misc.
	- [`mergeWith()`	](#mergewith)
	- [`getColor()`	](#getcolor)


- - - - - - - - - - - - - - - -

Method Summary
==============

HColorTransform()
-----------------
### Usage: `new HColorTransform()`
The default constructor for _HColorTransform_. This constructor sets the
multiplier values to 1.0, and offsets to 0.



createCopy()
------------
### Usage: `createCopy()`
Creates a copy of this transform.

**Returns:** `HColorTransform` _a copy of this transform_



createNew()
-----------
### Usage: `createNew(HColorTransform other)`
Creates a copy of this transform and calls `mergeWith(other)` on it.

**See:** [`mergeWith()`](#mergewith)

**Returns:** `HColorTransform` _a copy of this transform, merged with the other transform_



offset()
--------
### Usage: `offset(int off)`, `offset(int offR, int offG, int offB, int offA)`
Sets the offsets of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



offsetA()
---------
### Usage: `offsetA()`
Returns the alpha offset of this transform.

**Returns:** `int` _the alpha offset of this transform_

### Usage: `offsetA(int offA)`
Sets the alpha offset of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



offsetR()
---------
### Usage: `offsetR()`
Returns the red offset of this transform.

**Returns:** `int` _the red offset of this transform_

### Usage: `offsetR(int offR)`
Sets the red offset of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



offsetG()
---------
### Usage: `offsetG()`
Returns the green offset of this transform.

**Returns:** `int` _the green offset of this transform_

### Usage: `offsetG(int offG)`
Sets the green offset of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



offsetB()
---------
### Usage: `offsetB()`
Returns the blue offset of this transform.

**Returns:** `int` _the blue offset of this transform_

### Usage: `offsetB(int offB)`
Sets the blue offset of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



perc()
------
### Usage: `perc(float percentage)`, `perc(float percentageR, float percentageG, float percentageB, float percentageA)`
Sets the multipliers / percentages of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



percA()
-------
### Usage: `percA()`
Returns the alpha multiplier of this transform.

**Returns:** `float` _the alpha multiplier of this transform_

### Usage: `percA(float percentageA)`
Sets the alpha multiplier of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



percR()
-------
### Usage: `percR()`
Returns the red multiplier of this transform.

**Returns:** `float` _the red multiplier of this transform_

### Usage: `percR(float percentageR)`
Sets the red multiplier of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



percG()
-------
### Usage: `percG()`
Returns the green multiplier of this transform.

**Returns:** `float` _the green multiplier of this transform_

### Usage: `percA(float percentageG)`
Sets the green of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



percB()
-------
### Usage: `percB()`
Returns the blue multiplier of this transform.

**Returns:** `float` _the alpha multiplier of this transform_

### Usage: `percB(float percentageB)`
Sets the blue multiplier of this transform.

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



mergeWith()
-----------
### Usage: `mergeWith(HColorTransform other)`
Merges the offset and multiplier values of this transform with the other
transform. The offset values are added together, while the transform values
are multiplied together.

This is the equivalent of:

	this._percA *= other._percA;
	this._percR *= other._percR;
	this._percG *= other._percG;
	this._percB *= other._percB;
	this._offsetA += other._offsetA;
	this._offsetR += other._offsetR;
	this._offsetG += other._offsetG;
	this._offsetB += other._offsetB;

**See:** This method is chainable.

**Returns:** `HColorTransform` _this transform itself_



getColor()
----------
### Usage: `getColor(int origColor)`
Transforms _origColor_ by the values of this transform. The percentages
are applied first before the offsets. This is what this class' implementation
of _applyColor()_ uses for determining its colors.

**See:** [`applyColor()`](HColorist.md#applycolor)

**Returns:** `int` _the new, transformed color_





[1]: http://docs.oracle.com/javase/7/docs/api/java/lang/Object.html
[2]: HColorist.md
[3]: HDrawable.md
