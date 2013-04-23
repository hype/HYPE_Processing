public static class HMath implements HConstants {
	private static PApplet _app;
	private static boolean _usingTempSeed;
	private static int _resetSeedValue;
	public static void init(PApplet applet) {
		_app = applet;
	}
	public static float[] rotatePointArr(float x, float y, float rad) {
		float[] pt = new float[2];
		float c = _app.cos(rad);
		float s = _app.sin(rad);
		pt[0] = x*c - y*s;
		pt[1] = x*s + y*c;
		return pt;
	}
	public static PVector rotatePoint(float x, float y, float rad) {
		float[] f = rotatePointArr(x,y,rad);
		return new PVector(f[0], f[1]);
	}
	public static float yAxisAngle(float x1, float y1, float x2, float y2) {
		return _app.atan2(x2-x1, y2-y1);
	}
	public static float xAxisAngle(float x1, float y1, float x2, float y2) {
		return _app.atan2(y2-y1, x2-x1);
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
	public static int randomInt32() {
		float f = _app.random(1);
		f = _app.map(f, 0, 1, -2147483648, 2147483647);
		return _app.round(f);
	}
	public static void tempSeed(long seed) {
		if(!_usingTempSeed) {
			_resetSeedValue = randomInt32();
			_usingTempSeed = true;
		}
		_app.randomSeed(seed);
	}
	public static void removeTempSeed() {
		_app.randomSeed(_resetSeedValue);
	}
	public static float sineWave(float stepDegrees) {
		return H.app().sin(stepDegrees * H.D2R);
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
	public static boolean hasBits(int target, int val) {
		return ( (target & val) == val );
	}
}
