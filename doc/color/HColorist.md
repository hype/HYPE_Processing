HColorist _(interface)_
=======================

### Full Name
`hype.color.HColorist`

### Superinterfaces
_none_


### Summary

HColorist is the interface implemented by all colorist classes. So far, we have the following colorists:

- [HColorField][1]
- [HColorPool][2]
- [HColorTransform][3]
- [HPixelColorist][4]
 
The role of a Colorist is to generate or provide colors and apply it to a given [drawable][6].
The following is an example of _HColorPool_ in action:

	HColorPool colorPool = new HColorPool(#ABCDEF, #FEDCBA, #C0FFEE);
	
	colorPool.fillOnly();
	
	colorPool.applyColor( myDrawable ); // set myDrawable's fill

#### Chainable methods
This interface provides methods that are meant to be chainable. These methods are the following:

- `fillOnly()`
- `strokeOnly()`
- `strokeAndStroke()`

For devs, when implementing this interface, remember to actually make them chainable:

	class MyImpl implements HColorist {
		...
		
		@Override
		public MyImpl fillOnly() {
			// ... doStuff ...
			return this;
		}
		...

As seen here, _MyImpl_'s implementation of _fillOnly()_ returns itself at the end of the method
so it would be chainable. Also, changing the return type from _HColorist_ into the actual class
of the implementation makes it more convenient for Java Mode users.


- - - - - - - - - - - - - - - -


Method List
===========
- Modifiers
	- [`fillOnly()`		](#fillonly)
	- [`strokeOnly()`		](#strokeonly)
	- [`fillAndStroke()`	](#fillandstroke)
- State Methods
	- [`appliesFill()`		](#appliesfill)
	- [`appliesStroke()`	](#appliesstroke)
- Misc.
	- [`applyColor()`		](#applycolor)


- - - - - - - - - - - - - - - -

Method Summary
==============

fillOnly()
----------
### Usage: `fillOnly()`
Sets the colorist to only apply fill when [_applyColor()_][5] is called.

**Note:** This method is meant to be chainable.

**Returns:** `HColorist` _this colorist itself_



strokeOnly()
------------
### Usage: `strokeOnly()`
Sets the colorist to only apply stroke when [_applyColor()_][5] is called.

**Note:** This method is meant to be chainable.

**Returns:** `HColorist` _this colorist itself_



fillAndStroke()
------------
### Usage: `fillAndStroke()`
Sets the colorist to both fill and stroke when [_applyColor()_][5] is called.
This behavior is usually the default for classes implementing this interface.

**Note:** This method is meant to be chainable.

**Returns:** `HColorist` _this colorist itself_



appliesFill()
-------------
### Usage: `appliesFill()`
Returns whether or not this color will apply fill when [_applyColor()_][5] is called.

**Returns:** `boolean` _true, if this colorist will apply fill; otherwise false_



appliesStroke()
---------------
### Usage: `appliesStroke()`
Returns whether or not this color will apply stroke when [_applyColor()_][5] is called.

**Returns:** `boolean` _true, if this colorist will apply stroke; otherwise false_



applyColor()
------------
### Usage: `applyColor(HDrawable drawable)`
Applies this colorist's colors into _drawable_'s fill and/or stroke.

**Note:** This method is meant to return the drawable passed into it.

**Returns:** `HDrawable` _the drawable that's passed into this method_





[1]: HColorField.md
[2]: HColorPool.md
[3]: HColorTransform.md
[4]: HPixelColorist.md
[5]: #applycolor
[6]: HDrawable.md
