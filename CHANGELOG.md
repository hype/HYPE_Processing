### build_??? (???, 2013)
- included z coordinate oscillation for HOscillator
- removed unused constructor `new HOscillator(HDrawable)`
- removed deprecated method `HOscillator.createCopy()`
- new HOscillator methods:
	- `minimum(float,float)` & `minimum(float,float,float)`
	- `maximum(float,float)` & `maximum(float,float,float)`
	- `range(float,float,float,float)` & `range(float,float,float,float,float,float)`
	- `min1()`, `min2()` & `min3()`
	- `max1()`, `max2()` & `max3()`
- BLAHRG

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
