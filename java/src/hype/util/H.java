package hype.util;

import hype.behavior.HBehaviorRegistry;
import hype.drawable.HDrawable;
import hype.drawable.HStage;
import hype.event.HMouse;
import processing.core.PApplet;
import processing.core.PGraphics;

public class H implements HConstants {
	private static H _self;
	private static PApplet _app;
	private static PGraphics _graphicsContext;
	private static HStage _stage;
	private static HBehaviorRegistry _behaviors;
	private static HMouse _mouse;
	
	
	// INIT & INSTANCES //
	
	public static H init(PApplet applet) {
		_app = applet;
		
		// Initialize this class' objects
		HMath.init(_app);
		if(_self == null) _self = new H();
		if(_stage == null) _stage = new HStage(_app);
		if(_behaviors == null) _behaviors = new HBehaviorRegistry();
		if(_mouse == null) _mouse = new HMouse(_app);
		
		// HACK: We're going to abuse js mode's ducktyping in this library.
		try {
			// This random piece of code will throw an error in js mode because
			// `_app.g` doesn't exist in that mode.
			@SuppressWarnings({ "unused", "static-access" })
			int dummy = _app.g.A;
			
			_graphicsContext = _app.g;
		} catch(Error e) {
			// The roundabout assignment bypasses the java
			// compile-time type checking.
			
			Object o = _app;
			_graphicsContext = (PGraphics) o;
			
			// Normally, this would cause a class-cast exception in java, but
			// java mode will never arrive in this catch block.
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
	
	
	// STAGE METHODS //
	
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
	
	
	// MISC UTILS //
	
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
