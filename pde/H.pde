public static class H implements HConstants {
	private static H _self;
	private static PApplet _app;
	private static HStage _stage;
	public static H init(PApplet applet) {
		_app = applet;
		HMath.init(_app);
		HBehavior.init(_app);
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
		HBehavior.runAll();
		_stage.paintAll(_app,0);
		return _self;
	}
	public static HDrawable add(HDrawable stageChild) {
		return _stage.add(stageChild);
	}
	public static HDrawable remove(HDrawable stageChild) {
		return _stage.remove(stageChild);
	}
	public static boolean mouseStarted() {
		return _stage.mouseStarted();
	}
	public static boolean endsWith(String haystack, String needle) {
		return (haystack.indexOf(needle,haystack.length()-needle.length()) > 0);
	}
	public static void setProperty(HDrawable target, int propId, float val) {
		switch(propId) {
		case H.WIDTH:		target.width(val); break;
		case H.HEIGHT:		target.height(val); break;
		case H.SIZE:		target.size(val); break;
		case H.ALPHA:		target.alpha(H.app().round(val)); break;
		case H.X:			target.x(val); break;
		case H.Y:			target.y(val); break;
		case H.LOCATION:	target.loc(val,val); break;
		case H.ROTATION:	target.rotation(val); break;
		case H.DROTATION:	target.rotate(val); break;
		case H.DX:			target.move(val,0); break;
		case H.DY:			target.move(0,val); break;
		case H.DLOC:		target.move(val,val); break;
		case H.SCALE:		target.scale(val); break;
		default: break;
		}
	}
	public static void warn(String type, String loc, String msg) {
		_app.println("[Warning: "+type+" @ "+loc+"]");
		if( msg!=null && msg.length()>0 ) _app.println(msg);
	}
	private H() {}
}
