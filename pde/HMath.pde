public static class HMath {
	private static PApplet _app;
	private static boolean _usingTempSeed;
	private static int _resetSeedValue;
	public static void init(PApplet applet) {
		_app = applet;
	}
	public static float[] rotatePoint(float x, float y, float rad) {
		float[] pt = new float[2];
		float c = _app.cos(rad);
		float s = _app.sin(rad);
		pt[0] = x*c + y*s;
		pt[1] = x*s + y*c;
		return pt;
	}
	public static float yAxisAngle(float x1, float y1, float x2, float y2) {
		return _app.atan2(x2-x1, y2-y1);
	}
	public static float xAxisAngle(float x1, float y1, float x2, float y2) {
		return _app.atan2(y2-y1, x2-x1);
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
	public static boolean containsBits(int target, int val) {
		return ( (target & val) == val );
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
}
