package hype.util;

import hype.behavior.HBehavior;
import hype.drawable.HDrawable;
import hype.drawable.HStage;
import processing.core.PApplet;

public class H implements HConstants {
	private static H _self;
	private static PApplet _app;
	private static HStage _stage;
	
	
	// INIT & INSTANCES //
	
	public static H init(PApplet applet) {
		_app = applet;
		HMath.init(_app);
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
	
	
	// MISC UTILS //
	
	public static boolean endsWith(String haystack, String needle) {
		return (haystack.indexOf(needle,haystack.length()-needle.length()) > 0);
	}
	
	@SuppressWarnings("static-access")
	public static void warn(String type, String loc, String msg) {
		_app.println("[Warning: "+type+" @ "+loc+"]");
		_app.println(msg);
	}
	
	private H() {}
}
