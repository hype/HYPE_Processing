

public static class H implements HConstants {
	private static H _self;
	private static PApplet _app;
	private static HStage _stage;
	private static boolean _usingTempSeed;
	private static int _resetSeedValue;
	
	
	// INIT & INSTANCES //
	
	public static H init(PApplet applet) {
		_app = applet;
		if(_self == null) _self = new H();
		if(_stage == null) _stage = new HStage(_app);
		
		return _self;
	}
	
	public static HStage stage() {
		return _stage;
	}
	
	public static PApplet app() {
		return _app;
	}
	
	
	// STAGE //
	
	public static H background(int clr) {
		_stage.background(clr);
		return _self;
	}
	
	public static H backgroundImg(Object arg) {
		_stage.backgroundImg(arg);
		return _self;
	}
	
	public static H autoClear(boolean b) {
		_stage.autoClear(b);
		return _self;
	}
	
	public static boolean autoClear() {
		return _stage.autoClear();
	}
	
	public static H clearStage() {
		_stage.clear();
		return _self;
	}
	
	public static H drawStage() {
		_stage.paintAll(_app,0);
		return _self;
	}
	
	public static HDrawable add(HDrawable stageChild) {
		return _stage.add(stageChild);
	}
	
	public static HDrawable remove(HDrawable stageChild) {
		return _stage.remove(stageChild);
	}
	
	public static H addBehavior(HBehavior b) {
		_stage.behaviors().add(b);
		return _self;
	}
	
	public static H removeBehavior(HBehavior b) {
		_stage.behaviors().remove(b);
		return _self;
	}
	
	public static boolean mouseStarted() {
		return _stage.mouseStarted();
	}
	
	
	// MATH //
	
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
	
	
	// STRING //
	
	public static boolean endsWith(String haystack, String needle) {
		return (haystack.indexOf(needle,haystack.length()-needle.length()) > 0);
	}
	
	private H() {}
}
