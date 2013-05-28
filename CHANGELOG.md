### build_20130527.1 (May 27, 2013)
- hitbox checking for HPath's bezier curves

### build_20130527.0 (May 27, 2013)
- new static HMath methods:
	- `bezierParam()`
	- `solveCubic()`
	- `solveQuadratic()`
- added _paper.js_' license to license.txt

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
