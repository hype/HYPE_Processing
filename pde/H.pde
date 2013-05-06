public static class H implements HConstants {
	private static H _self;
	private static PApplet _app;
	private static PGraphics _graphicsContext;
	private static HStage _stage;
	private static HBehaviorRegistry _behaviors;
	private static HMouse _mouse;
	private static boolean _uses3D;
	public static H init(PApplet applet) {
		_app = applet;
		HMath.init(_app);
		if(_self == null) _self = new H();
		if(_stage == null) _stage = new HStage(_app);
		if(_behaviors == null) _behaviors = new HBehaviorRegistry();
		if(_mouse == null) _mouse = new HMouse(_app);
		try {
			/* HACK
			 * This arbitrary reference to a field in _app.g will throw an error
			 * in Processing.js as `g` doesn't exist in that mode.
			 */
			int dummyVar = _app.g.A;
			_graphicsContext = _app.g;
		} catch(Error e) {
			/* This roundabout assignment bypasses java's compile-time type
			 * checking. Normally, this would cause a class-cast exception in
			 * java, but js mode doesn't mind due to duck-typing.
			 */
			Object o = _app;
			_graphicsContext = (PGraphics) o;
		}
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
	public static H use3D(boolean b) {
		_uses3D = b;
		return _self;
	}
	public static boolean uses3D() {
		return _uses3D;
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
	public static boolean autoClears() {
		return _stage.autoClears();
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
		_stage.paintAll(_graphicsContext,0);
		return _self;
	}
	public static boolean mouseStarted() {
		return _mouse.started();
	}
	private H() {}
}
