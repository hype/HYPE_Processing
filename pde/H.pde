public static class H implements HConstants {
	private static H _self;
	private static PApplet _app;
	private static HStage _stage;
	private static HBehaviorRegistry _behaviors;
	private static HMouse _mouse;
	public static H init(PApplet applet) {
		_app = applet;
		HMath.init(_app);
		if(_self == null) _self = new H();
		if(_stage == null) _stage = new HStage(_app);
		if(_behaviors == null) _behaviors = new HBehaviorRegistry();
		if(_mouse == null) _mouse = new HMouse(_app);
		return _self;
	}
	public static HStage stage() {
		return _stage;
	}
	public static PApplet app() {
		return _app;
	}
	public static HBehaviorRegistry behaviors() {
		return _behaviors;
	}
	public static HMouse mouse() {
		return _mouse;
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
	public static HDrawable add(HDrawable stageChild) {
		return _stage.add(stageChild);
	}
	public static HDrawable remove(HDrawable stageChild) {
		return _stage.remove(stageChild);
	}
	public static H drawStage() {
		_behaviors.runAll(_app);
		_mouse.handleEvents();
		_stage.paintAll(_app.g,0);
		return _self;
	}
	public static boolean mouseStarted() {
		return _mouse.started();
	}
	private H() {}
}
