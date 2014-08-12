/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
/**
 * A static class that provides some math methods.
 * 
 * These methods are primarily used internally by the HYPE classes, but these
 * can also be used externally. (e.g. `randomInt()` can be very handy in some
 * sketches.)
 * 
 * Most of these methods are here because any of the following:
 * - It's only available as a static PApplet method. (We are trying to avoid it
 *   due to Processing.jsÊnot having a static PApplet object, forcing us to call
 *   the math methods in a non-static context.)
 * - It's not available in _both_ `java.lang.Math` and the standard Javascript
 *   `Math` object.
 * - It's a modification of an existing method.
 * - It's not available at all in any of the above classes. 
 * 
 * @author james
 */
public static class HMath implements HConstants {
	private static boolean _usingTempSeed;
	private static int _resetSeedValue;
	public static float dist(float x1, float y1, float x2, float y2) {
		float w = x2 - x1;
		float h = y2 - y1;
		return (float) Math.sqrt(w*w + h*h);
	}
	public static float[] rotatePointArr(float x, float y, float rad) {
		float[] pt = new float[2];
		float c = (float) Math.cos(rad);
		float s = (float) Math.sin(rad);
		pt[0] = x*c - y*s;
		pt[1] = x*s + y*c;
		return pt;
	}
	public static PVector rotatePoint(float x, float y, float rad) {
		float[] f = rotatePointArr(x,y,rad);
		return new PVector(f[0], f[1]);
	}
	public static float yAxisAngle(float x1, float y1, float x2, float y2) {
		return (float) Math.atan2(x2-x1, y2-y1);
	}
	public static float xAxisAngle(float x1, float y1, float x2, float y2) {
		return (float) Math.atan2(y2-y1, x2-x1);
	}
	public static float[] absLocArr(HDrawable ref, float relX, float relY) {
		float[] f = {relX, relY, 0};
		while(ref != null) {
			float rot = ref.rotationRad();
			float[] g = rotatePointArr(f[0], f[1], rot);
			f[0] = g[0] + ref.x();
			f[1] = g[1] + ref.y();
			f[2] += rot;
			ref = ref.parent();
		}
		return f;
	}
	public static PVector absLoc(HDrawable ref, float relX, float relY) {
		float[] f = absLocArr(ref,relX,relY);
		return new PVector(f[0], f[1]);
	}
	public static PVector absLoc(HDrawable d) {
		return absLoc(d,0,0);
	}
	public static float[] relLocArr(HDrawable ref, float absX, float absY) {
		float[] f = absLocArr(ref,0,0);
		return rotatePointArr(absX-f[0], absY-f[1], -f[2]);
	}
	public static PVector relLoc(HDrawable ref, float absX, float absY) {
		float[] f = relLocArr(ref,absX,absY);
		return new PVector(f[0], f[1]);
	}
	public static int quadrant(float cx, float cy, float x, float y) {
		return (y>=cy)? (x>=cx? 1 : 2) : (x>=cx? 4 : 3);
	}
	public static int quadrant(float dcx, float dcy) {
		return (dcy>=0)? (dcx>=0? 1 : 2) : (dcx>=0? 4 : 3);
	}
	public static float ellipseRadius(float a, float b, float deg) {
		return ellipseRadiusRad(a,b, deg * D2R);
	}
	public static float ellipseRadiusRad(float a, float b, float rad) {
		float cosb = b * (float)Math.cos(rad);
		float sina = a * (float)Math.sin(rad);
		return a*b / (float)Math.sqrt(cosb*cosb + sina*sina);
	}
	public static PVector ellipsePoint(
			float cx, float cy, float a, float b, float deg
	) {
		return ellipsePointRad(cx, cy, a, b, deg*D2R);
	}
	public static PVector ellipsePointRad(
		float cx, float cy, float a, float b, float rad
	) {
		float[] f = ellipsePointRadArr(cx,cy, a,b, rad);
		return new PVector(f[0], f[1]);
	}
	public static float[] ellipsePointRadArr(
		float cx, float cy, float a, float b, float rad
	) {
		float[] f = new float[3];
		f[2] = ellipseRadiusRad(a, b, rad);
		f[0] = f[2] * (float)Math.cos(rad) + cx;
		f[1] = f[2] * (float)Math.sin(rad) + cy;
		return f;
	}
	public static float normalizeAngle(float deg) {
		return normalizeAngleRad(deg * D2R) * R2D;
	}
	public static float normalizeAngleRad(float rad) {
		rad %= PConstants.TWO_PI;
		if(rad < -PConstants.PI) rad += PConstants.TWO_PI;
		else if(rad > PConstants.PI) rad -= PConstants.TWO_PI;
		return rad;
	}
	public static float normalizeAngle2(float deg) {
		return normalizeAngleRad2(deg * D2R) * R2D;
	}
	public static float normalizeAngleRad2(float rad) {
		float norm = rad % PConstants.TWO_PI;
		if(norm < 0) norm += PConstants.TWO_PI;
		return norm;
	}
	public static float squishAngle(float w, float h, float deg) {
		return squishAngle(w, h, deg * D2R) * R2D;
	}
	public static float squishAngleRad(float w, float h, float rad) {
		float dx = (float)Math.cos(rad) * w/h;
		float dy = (float)Math.sin(rad);
		return (float) Math.atan2(dy,dx);
	}
	public static float lineSide(
		float x1, float y1, float x2, float y2, float ptx, float pty
	) {
		return (x2-x1)*(pty-y1) - (y2-y1)*(ptx-x1);
	}
	public static boolean collinear(
		float x1, float y1, float x2, float y2, float ptx, float pty
	) {
		return (lineSide(x1,y1, x2,y2, ptx,pty) == 0);
	}
	public static boolean leftOfLine(
		float x1, float y1, float x2, float y2, float ptx, float pty
	) {
		return (lineSide(x1,y1, x2,y2, ptx,pty) < 0);
	}
	public static boolean rightOfLine(
		float x1, float y1, float x2, float y2, float ptx, float pty
	) {
		return (lineSide(x1,y1, x2,y2, ptx,pty) > 0);
	}
	/**
	 * Solves for the real roots of a cubic equation with the given coefficients.
	 * 
	 * Said equation is in the standard polynomial form:
	 * 
	 *     ax^3 + bx^2 + cx + d = 0
	 * 
	 * where `a`, `b`, `c` & `d` are the coefficients of said equation.
	 * 
	 * Since the maximum amount of real roots that a cubic equation can have is
	 * three, the `roots` array is expected to have a size of at least 3.
	 * 
	 * If this equation happens to be a straight line lying on the x-axis, then
	 * this method will return `-1`, meaning that there are infinite number of
	 * roots for this equation.
	 * 
	 * This method may delegate itself to `solveQuadratic()` if `a` equals 0
	 * (in other words, the equation is quadratic.)
	 * 
	 * The code for this method is heavily based from paper.js (MIT License)
	 * which in turn is based from the Uintah Library (also MIT License).
	 * 
	 * @see solveQuadratic(float,float,float,float[])
	 * @param a    The coefficient for the first term (ax^3)
	 * @param b    The coefficient for the second term (bx^2)
	 * @param c    The coefficient for the third term (cx)
	 * @param d    The coefficient for the fourth term (d)
	 * @param roots    The array that will contain the roots of the equation
	 * @return The number of roots of the given equation
	 */
	public static int solveCubic(
		float a, float b, float c, float d, float[] roots
	) {
		if(Math.abs(a) < EPSILON) return solveQuadratic(b,c,d,roots);
		b /= a;
		c /= a;
		d /= a;
		float bb = b*b;
		float p = (bb - 3*c) / 9f;
		float ppp = p*p*p;
		float q = (2*bb*b - 9*b*c + 27*d) / 54;
		float D = q*q - ppp;
		b /= 3f;
		if(Math.abs(D) < EPSILON) {
			if(Math.abs(q) < EPSILON) {
				roots[0] = -b;
				return 1;
			}
			float sqrtp = (float)Math.sqrt(p);
			float signq = (q>0)? 1 : -1;
			roots[0] = -signq*2*sqrtp - b;
			roots[1] = signq*sqrtp - b;
			return 2;
		}
		if(D < 0) {
			float sqrtp = (float)Math.sqrt(p);
			float phi = (float)Math.acos(q / (sqrtp*sqrtp*sqrtp)) / 3;
			float t = -2*sqrtp;
			float o = PConstants.TWO_PI/3f;
			roots[0] = t*(float)Math.cos(phi) - b;
			roots[1] = t*(float)Math.cos(phi + o) - b;
			roots[2] = t*(float)Math.cos(phi - o) - b;
			return 3;
		}
		float A = (q>0?-1:1) *
			(float)Math.pow(Math.abs(q) + Math.sqrt(D), 1.0/3.0);
		roots[0] = A + p/A - b;
		return 1;
	}
	/**
	 * Solves for the real roots of a quadratic equation with the given
	 * coefficients.
	 * 
	 * Said equation is in the standard polynomial form:
	 * 
	 *     ax^2 + bx + c = 0
	 * 
	 * where `a`, `b` & `c` are the coefficients of said equation.
	 * 
	 * Since the maximum amount of roots that a quadratic equation can have is
	 * two, the `roots` array is expected to have a size of at least 2.
	 * 
	 * If this equation happens to be a straight line lying on the x-axis, then
	 * this method will return `-1`, meaning that there are infinite number of
	 * roots for this equation.
	 * 
	 * The code for this method is heavily based from paper.js (MIT License)
	 * which in turn is based from the Uintah Library (also MIT License).
	 * 
	 * @see solveCubic(float,float,float,float,float[])
	 * @param a    The coefficient for the first term (`ax^2`)
	 * @param b    The coefficient for the second term (`bx`)
	 * @param c    The coefficient for the third term (`c`)
	 * @param roots    The array that will contain the roots of the equation
	 * @return The number of roots of the given equation
	 */
	public static int solveQuadratic(float a, float b, float c, float[] roots) {
		if(Math.abs(a) < EPSILON) {
			if(Math.abs(b) >= EPSILON) {
				roots[0] = -c/b;
				return 1;
			}
			return (Math.abs(c)<EPSILON)? -1 : 0;
		}
		float q = b*b - 4*a*c;
		if(q < 0) return 0;
		q = (float)Math.sqrt(q);
		a *= 2;
		int numRoots = 0;
		roots[numRoots++] = (-b-q) / a;
		if(q > 0) roots[numRoots++] = (-b+q) / a;
		return numRoots;
	}
	/**
	 * Solves for the valid parameters of a given cubic bezier equation.
	 * 
	 * This method calls `solveCubic()` to solve for the said equation.
	 * 
	 * Since cubic bezier curves can have at most three parameters that could
	 * give the same value, the `params` array is expected to have a size of at
	 * least 3. Note that these parameters can be less than `0` or more than
	 * `1`, so you will need to check them before using the contents of the
	 * `params` array.
	 * 
	 * The `val` argument is the value to be tested, where:
	 * 
	 *     val = bezier(p0,p1,p2,p3,param)
	 * 
	 * If the above equation is in such a way that it could not be true, then
	 * this method will return `0` valid parameters.
	 * 
	 * @see solveCubic(float,float,float,float,float[]), bezierParam(float,float,float,float,float[])
	 * @param p0    The first anchor point
	 * @param p1    The first control point
	 * @param p2    The second control point
	 * @param p3    The second anchor point
	 * @param val   The value to be tested with the curve
	 * @param params    The array that will contain the parameters of the bezier equation
	 * @return The number of valid parameters of the given bezier equation
	 */
	public static int bezierParam(
		float p0, float p1, float p2, float p3,
		float val, float[] params
	) {
		float max = p0;
		if(max < p1) max = p1;
		if(max < p2) max = p2;
		if(max < p3) max = p3;
		float min = p0;
		if(min > p1) min = p1;
		if(min > p2) min = p2;
		if(min > p3) min = p3;
		if(val<min || val>max) return 0;
		float a = 3*(p1-p2) - p0 + p3;
		float b = 3*(p0 - 2*p1 + p2);
		float c = 3*(p1-p0);
		float d = p0 - val;
		return solveCubic(a,b,c,d,params);
	}
	public static int bezierParam(
		float p0, float p1, float p2,
		float val, float[] params
	) {
		float max = p0;
		if(max < p1) max = p1;
		if(max < p2) max = p2;
		float min = p0;
		if(min > p1) min = p1;
		if(min > p2) min = p2;
		if(val<min || val>max) return 0;
		float a = p2 - 2*p1 + p0;
		float b = 2 * (p1-p0);
		float c = p0 - val;
		return solveQuadratic(a,b,c,params);
	}
	public static float bezierPoint(
		float p0, float p1, float p2, float p3, float t
	) {
		float tt = t*t;
		float a = 3*(p1-p2) - p0 + p3;
		float b = 3*(p0 - 2*p1 + p2);
		float c = 3*(p1-p0);
		return a*tt*t + b*tt + c*t + p0;
	}
	public static float bezierPoint(float p0, float p1, float p2, float t) {
		float a = p2 - 2*p1 + p0;
		float b = 2 * (p1-p0);
		return a*t*t + b*t + p0;
	}
	public static float bezierTangent(
		float p0, float p1, float p2, float p3, float t
	) {
		float a = 3 * (3*(p1-p2) - p0 + p3);
		float b = 6 * (p0 - 2*p1 + p2);
		float c = 3 * (p1-p0);
		return a*t*t + b*t + c;
	}
	public static float bezierTangent(float p0, float p1, float p2, float t) {
		float a = 2 * (p2 - 2*p1 + p0);
		float b = 2 * (p1-p0);
		return a*t + b;
	}
	public static int randomInt(float high) {
		return (int) Math.floor( H.app().random(high) );
	}
	public static int randomInt(float low, float high) {
		return (int) Math.floor( H.app().random(low,high) );
	}
	public static int randomInt32() {
		return randomInt(-2147483648,2147483647);
	}
	public static void tempSeed(long seed) {
		if(!_usingTempSeed) {
			_resetSeedValue = randomInt32();
			_usingTempSeed = true;
		}
		H.app().randomSeed(seed);
	}
	public static void removeTempSeed() {
		H.app().randomSeed(_resetSeedValue);
	}
	public static float sineWave(float stepDegrees) {
		return (float) Math.sin(stepDegrees * H.D2R);
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
	public static boolean hasBits(byte target, byte mask) {
		return (target&mask) == mask;
	}
	public static boolean hasBits(int target, int mask) {
		return (target&mask) == mask;
	}
	public static byte setBits(byte target, byte mask, boolean val) {
		return (byte) (val? target|mask : target&(~mask));
	}
	public static int setBits(int target, int mask, boolean val) {
		return (val)? target|mask : target&(~mask);
	}
	public static boolean lessThan(float a, float b, float tolerance) {
		return a < b + tolerance;
	}
	public static boolean lessThan(float a, float b) {
		return a < b + TOLERANCE;
	}
	public static boolean greaterThan(float a, float b, float tolerance) {
		return b < a + tolerance;
	}
	public static boolean greaterThan(float a, float b) {
		return b < a + TOLERANCE;
	}
	public static boolean isEqual(float a, float b, float tolerance) {
		return Math.abs(a-b) < tolerance;
	}
	public static boolean isEqual(float a, float b) {
		return Math.abs(a-b) < TOLERANCE;
	}
	public static boolean isZero(float a, float tolerance) {
		return Math.abs(a) < tolerance;
	}
	public static boolean isZero(float a) {
		return Math.abs(a) < TOLERANCE;
	}
	public static float map(float val,
		float start1, float stop1, float start2, float stop2
	) {
		return start2 + (stop2-start2) * (val-start1)/(stop1-start1);
	}
	public static float round512(float val) {
		return Math.round(val*512)/512f;
	}
}
