### build_20130626.0 (Jun 26, 2013)
- new fields for HConstants:
	- `ROTATIONX`
	- `ROTATIONY`
	- `ROTATIONZ`
	- `DROTATIONX`
	- `DROTATIONY`
	- `DROTATIONZ`
- HTween and HOscillator can now have 3D rotation

### build_20130624.0 (Jun 24, 2013)
- the bounds limit for picking a random position for HShapeLayout is now more accurate, when the layout's target is rotated.

### build_20130620.0 (Jun 20, 2013)
- new HStage methods:
	- `showsFPS(boolean)`
	- `showsFPS()`
- new HOscillator methods:
	- `nextRaw()` _returns and increments the raw oscillator value, depending on the current waveform (range: [-1.0, 1.0]); it also updates the "current" values_
	- `curr()`, `curr1()`, `curr2()` & `curr3()` _returns the current values_
- restructured HTween, so it stores only the scale factor rather than the size when using `HConstants.SCALE`
- new HTween methods:
	- `nextRaw()` _returns and increments the raw tween value (range: [0,1] plus spring); it also updates the "current" values_
	- `curr()`, `curr1()`, `curr2()` & `curr3()` _returns the current values_

### build_20130619.0 (Jun 19,2013)
- removed the ff. HMath methods (these are redundant to PApplet's `random()` methods):
	- `random()`
	- `random(float)`
	- `random(float,float)`
- the following methods now use PApplet's `random()` method (this means that these methods are now affected by `PApplet::seed()` and `HMath.tempSeed()`):
	- `HMath.randomInt(float)` and `HMath.randomInt(float,float)`
	- `HShapeLayout.getNextPoint()`
	- `HRandomTrigger.runBehavior()`

### build_20130617.1 (Jun 17, 2013)
- made the ff. fields private / protected:
	- `HTrigger._callback`
	- `HVector._x`
	- `HVector._y`
	- `HVector._z`
	- `HColorTransform._percA`
	- `HColorTransform._percR`
	- `HColorTransform._percG`
	- `HColorTransform._percB`
	- `HRandomTrigger._chance`
- removed unused HWarnings field `VERTEXPX_ERR`

### build_20130617.0 (Jun 17, 2013)
- new interface: `HImageHolder` _(this is a common interface for any class that can hold and return a PImage)_
	- `HImageHolder image(Object)`
	- `PImage image()`
- HImage now implements HImageHolder
- HStage now implements HImageHolder
- `HStage.background()` & `backgroundImg()` are now chainable
- marked the ff. HPixelColorist methods for deprecation:
	- `setImage(Object)`
	- `getImage()`
- HPixelColorist now implements HImageHolder with the ff. new methods as replacement of the recently deprecated methods:
	- `image(Object)`
	- `image()`

### build_20130614.4 (Jun 14, 2013)
- new HRect getter method: `rounding()`
- privatized the following HRect fields:
	- `_tl`
	- `_tr`
	- `_bl`
	- `_br`
- HColors now implements HConstants
- new HTween getter methods:
	- `start()`
	- `start1()`
	- `start2()`
	- `start3()`
	- `end1()`
	- `end2()`
	- `end3()`

### build_20130614.3 (Jun 14, 2013)
- HTween now registers itself by default
- new HCallback constant: `HConstants.NOP`
- implemented using HConstants.NOP on the ff classes:
	- `HDrawablePool`
	- `HTrigger` and its subclasses
	- `HTween`
- privatized the following HDrawablePool fields:
	- `_onCreate`
	- `_onRequest`
	- `_onRelease`
- removed the ff fields / methods from HDrawablePool:
	- `_listener`
	- `listener()`
	- `listener(HPoolListener)`
- removed unused interfaces / classes:
	- `HPoolListener`
	- `HPoolAdapter`

### build_20130614.2 (Jun 14, 2013)
- new HDrawable methods for rotating children:
	- `rotatesChildren(boolean)` & `rotatesChildren()`
- removed the casting for `HDrawable.add()` and `HDrawable.remove()`

### build_20130614.1 (Jun 14, 2013)
- renamed the following protected HDrawable fields:
	- `_anchorPercX` -> `_anchorU`
	- `_anchorPercY` -> `_anchorV`
	- `_alphaPerc` -> `_anchorPc`
- renamed the following HDrawable methods:
	- `anchorPerc(float,float)` -> `anchorUV(float,float)`
	- `anchorPerc()` -> `anchorUV()`
	- `anchorPercX(float)` -> `anchorU(float)`
	- `anchorPercX()` -> `anchorU()`
	- `anchorPercY(float)` -> `anchorV(float)`
	- `anchorPercY()` -> `anchorV()`
	- `alphaPerc(float)` -> `alphaPc(float)`
	- `alphaPerc()` -> `alphaPc()`
	- `alphaShiftPerc(float)` -> `alphaShiftPc(float)`
- marked `HStage.autoClear(boolean)` for deprecation
- new HStage method: `autoClears(boolean)` _(as replacement of autoClear(boolean).)_

### build_20130614.0 (Jun 14, 2013)
- new HDrawable methods for styling children:
	- `stylesChildren(boolean)` & `stylesChildren()`
	- `onStyleChange()` (protected)
- HGroup now styles its children by default

### build_20130613.0 (Jun 13, 2013)
- refactors on the `HPath.adjust()` method

### build_20130611.2 (Jun 11, 2013)
- new HMath comparator methods:
	- `lessThan(float,float,float)` & `lessThan(float,float,float)`
	- `greaterThan(float,float,float)` & `greaterThan(float,float,float)`
	- `isEqual(float,float,float)` & `isEqual(float,float,float)`
	- `isZero(float,float)` & `isZero(float)`
- added a pixel tolerance of 1.5 for linear hitboxes in HPath

### build_20130611.1 (Jun 11, 2013)
- hitbox detection for HPath now changes depending on mode and presence of fill color
- moved the ff constant fields from HConstants to HDrawable:
	- `DEFAULT_FILL`
	- `DEFAULT_STROKE`
	- `DEFAULT_WIDTH`
	- `DEFAULT_HEIGHT`
- renamed `HPath.startPath()` to `beginPath()` in order to be more consistent with Processing's naming standards
- HPath can now draw its bezier handles by setting `drawsHandles(true)`

### build_20130611.0 (Jun 11, 2013)
- the method `HMath.bezierParam()` (both of them) no longer removes values in the params array that are not within the range `[0,1]`
- renamed HVertexNEW to HVertex
- renamed and replaced HVertexNEW to HVertex
- new static HColors method: `isTransparent(int)`

### build_20130610.0 (Jun 10, 2013)
_note: the following changes are not yet put into the pde files due to their experimental nature_

- implemented adjustments for some edge cases in `HVertexNEW.intersectTest()`
- various debugs and refactors for `HVertexNEW` and `HPathNEW`
- new HMath methods:
	- bezierTangent(float,float,float,float,float)
	- bezierTangent(float,float,float,float)
- organized existing HMath methods (i.e. the bezier stuff are clumped together)

### build_20130605.0 (Jun 5, 2013)
- bugfix: `HPath.createCopy()` now copies its vertices properly
- some further code for HPathNEW and HVertexNEW
- marked `HOscillator.createCopy()` as deprecated

### build_20130604.1 (Jun 4, 2013)
- HGroup is now set to transform/resize its children by default; to turn this off, call `transformsChildren(false)`
- the `transformsChildren()` method for HStage is now deactivated

### build_20130604.0 (Jun 4, 2013)
- restored the `HOscillator.createCopy()` method due to backwards compatibility issues
- debug: HOscillator skips a step every 359 steps
- if HOscillator's property field is equal to `HConstants.SCALE`, it now stores the min and max values as raw scale factors, instead of width and height

### build_20130603.1 (Jun 3, 2013)
- removed the unused `HNonChild` interface in favor of `invalidChild(HDrawable)`
- new HDrawable methods:
	- `invalidChild(HDrawable)` checks if the caller will be an invalid child of the passed drawable
	- `onResize(float,float,float,float)` listener method that is called on every resize
	- `transformsChildren()` and `transformsChildren(boolean)` gets and sets the flag that determines if the drawable's children will be resized and moved along with it
- moved the code for adjusting proportional HDrawable sizes to `onResize()`
- HDrawable now stores all its boolean values (including `_proportional`) in a byte sized bitset
- new HDrawable constants (all are of type byte):
	- `BITMASK_PROPORTIONAL` is the bitmask for the "proportional" bit flag
	- `BITMASK_TRANSFORM_CHILDREN` is the bitmask for the "transforms children" bit flag
	- `BITMASK_STYLE_CHILDREN` is the bitmask for the "styles children" bit flag _(will be used for a future feature)_
	- `BITMASK_ROTATE_CHILDREN`is the bitmask for the "rotates children" bit flag _(will be used for a future feature)_

### build_20130603.0 (Jun 3, 2013)
- HOscillator now has an internal structure similar to HTween
- the property H.SCALE is now treated like H.SIZE in when `runBehavior()` is called, except that the min and max values are multiplied by the target's width and height.
- included z coordinate oscillation for HOscillator
- z coordinates can now oscillate with H.LOCATION
- removed unused constructor `new HOscillator(HDrawable)`
- removed deprecated method `HOscillator.createCopy()`
- new HOscillator methods:
	- `minimum(float,float)` & `minimum(float,float,float)`
	- `maximum(float,float)` & `maximum(float,float,float)`
	- `range(float,float,float,float)` & `range(float,float,float,float,float,float)`
	- `min1()`, `min2()` & `min3()`
	- `max1()`, `max2()` & `max3()`
	- `relativeVal1()`, `relativeVal2()`, `relativeVal3()`

### build_20130531.1 (May 31, 2013)
- java packaging changes:
	- moved HMouse from the `hype.core.event` package to `hype.core.util`
	- split the "core" classes from the extended classes (core generally contains the superclasses and other core classes, while extended generally contains the subclasses)
	- merged the classes from the `trigger` package into `behavior`.
- rename: HSwarmer -> HDirectable
- new interface: HNonChild (this will indicate if a drawable could not be added inside another drawable sometime in the future)

### build_20130531.0 (May 31, 2013)
- removed casting requirements for `H.add()` and `H.remove()` for the ff classes:
	- HCanvas
	- HEllipse
	- HGroup
	- HImage
	- HPath
	- HRect
	- HShape
	- HText

### build_20130530.0 (May 30, 2013)
- new HDrawable methods:
	- `x2u(float)` -- converts an `x` coordinate to its UV coordinate equvialent, or percentage of the drawable's width (if width is 0, then it computes with 100)
	- `y2u(float)` -- same as above, but with y and height
	- `u2x(float)` -- converts a `u` coordinate to its XY coordinate equivalent
	- `v2y(float)` -- same as above, but with y and height
	

### build_20130529.1 (May 29, 2013)
- new class: `hype.util.HVertexNEW` _(this will replace HPath.HVertex soon)_
- new method: `HMath.bezierParam(float,float,float,float,float[])` _(this is like the other bezierParam(), but for quadratic bezier curves)_
bb
### build_20130529.0 (May 29, 2013)
- bugfix: HPath overrides fill and stroke during random colors mode, even if `fillOnly()` or `strokeOnly()` are set
- bugfix: HTween doesn't reset its current value when it's finished its tweening
- the HDrawable methods `contains(float,float,float)` and `containsRel(float,float,float)` now takes for account the drawable's own z coordinates.

### build_20130528.0 (May 28, 2013)
- changes for HTween:
	- ending position should now sit exactly at the values defined by `end()`.
	- bugfix #21: processing.js incompatibility with `HTween.start()` and `end()`
	- code cleanup and refactors
- hitbox checking for 3d points
- made HShape store a static set of random colors instead of fetching it upon `draw()` when `randomColors()` is called.
- removed the ff. HShape methods:
	- `randomColors()`
	- `randomColors(HColorPool,boolean)`
- `randomColors(HColorPool)` now returns `this`

### build_20130527.0 (May 27, 2013)
- new static HMath methods:
	- `bezierParam()`
	- `solveCubic()`
	- `solveQuadratic()`
- added _paper.js_' license to license.txt
- hitbox checking for HPath's bezier curves

### build_20130522.0 (May 22, 2013)
- bugfix: HTween didn't override `unregister()` and `register()` so it would return itself as HTween, instead of HBehavior

### build_20130521.0 (May 21, 2013)
- new HBehavior method: `registered(boolean)`
- new static HMath method: `round512(float)` (sets rounds a given) float to the nearest 1/152 interval.
- changes to HConstants:
	- new constant: HConstants.Z
	- the values for property constants are have been changed to reflect the inclusion of HConstants.Z
- various HTween refinements and changes:
	- more accurate callback triggering by using `round512()`
	- methods `start()` & `end()` now take ellipsis arguments
	- removed `startPt()`, `endPt()`, `curr()` and `currPt()` and `nextVal()` methods
	- HConstants.Z is now available for HTween
	- z coordinates are now computed with HTween when using HConstants.LOC
	- HTween now passes itself to the callback, instead of the current value
- new stuff for HBundle:
	- new method: `HBundle.bool(String,boolean)`
	- new HDrawable extras shortcut: `HDrawable.bool(String,boolean)`
	- bugfix: `num(String,float)` now creates a new extras bundle when extras is null

### build_20130520.0 (May 20, 2013)
- bugfix: `HColorPool.getColor(int)` didn't properly seed their colors
- renamed `HDrawable._alpha` into `_alphaPerc`
- initial documentation contents for HDrawable
- width and/or height in `HDrawable.anchor(float,float)`, `anchorX(float)` and `anchorY(float)` are now assumed to be 100 when its width and/or height is 0 to prevent division-by-zero errors.
- new method: `HSwarm.addGoal(float,float,float)`

### build_20130517.0 (May 17, 2013)
- new file: changelog.txt
- migrate documentation from markdown to Doxygen
- set the default size of HDrawable from 64x64 to 100x100
- the values for HConstants.DEFAULT\_WIDTH & DEFAULT\_HEIGHT are now 100
- new HMouse method: `moved()`
- rename: HColorUtil -> HColors
- remove deprecated HColors methods:
	- `multiply()`
	- `multiplyAlpha()`
	- `multiplyRed()`
	- `multiplyGreen()`
	- `multiplyBlue()`
- migrate PApplet math calls to Math
- various new HMath methods:
	- `dist()`
	- `random()`
	- `map()`
- remove deprecated `HMath.init()` method
- remove unimplemented HEventTrigger
- new HDrawable methods:
	- `firstChild()`
	- `lastChild()`
- HVector is _no longer_ a subclass of PVector. Now it's just a container of x, y & z values
