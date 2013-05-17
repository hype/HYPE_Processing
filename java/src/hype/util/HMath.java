package hype.util;

import hype.drawable.HDrawable;
import processing.core.PConstants;
import processing.core.PVector;

public class HMath implements HConstants {
	private static boolean _usingTempSeed;
	private static int _resetSeedValue;
	
	// GEOMETRY //
	
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
		return ( (x2-x1)*(pty-y1) - (y2-y1)*(ptx-x1) );
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
	
	
	// RNG //
	
	public static float random() {
		return random(1);
	}
	
	public static float random(float high) {
		float val;
		do { // this loop is for a rare rounding bug
			val = (float)Math.random() * high;
		} while(val == high);
		return val;
	}
	
	public static float random(float low, float high) {
		if(low >= high) return low;
		return random(high-low) + low;
	}
	
	public static int randomInt(float high) {
		return (int) Math.floor( random(high) );
	}
	
	public static int randomInt(float low, float high) {
		return (int) Math.floor( random(low,high) );
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
	
	
	// WAVES //
	
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
	
	
	// MISC //
	
	public static boolean hasBits(int target, int val) {
		return ( (target & val) == val );
	}
	
	public static float map(float val,
		float start1, float stop1, float start2, float stop2
	) {
		return start2 + (stop2-start2) * (val-start1)/(stop1-start1);
	}
}
