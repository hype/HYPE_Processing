/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.core.util;

import hype.core.behavior.HBehaviorRegistry;
import hype.core.drawable.HDrawable;
import hype.core.drawable.HStage;
import hype.core.interfaces.HImageHolder;
import hype.extended.drawable.HCanvas;
import hype.extended.drawable.HEllipse;
import hype.extended.drawable.HGroup;
import hype.extended.drawable.HImage;
import hype.extended.drawable.HPath;
import hype.extended.drawable.HRect;
import hype.extended.drawable.HShape;
import hype.extended.drawable.HText;
import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;

public class H implements HConstants {
	private static H _self;
	private static PApplet _app;
	private static PGraphics _graphicsContext;
	private static HStage _stage;
	private static HBehaviorRegistry _behaviors;
	private static HMouse _mouse;
	private static boolean _uses3D;
	
	
	// INIT & INSTANCES //
	
	public static H init(PApplet applet) {
		_app = applet;
		
		// Initialize this class' objects
		if(_self == null) _self = new H();
		if(_stage == null) _stage = new HStage(_app);
		if(_behaviors == null) _behaviors = new HBehaviorRegistry();
		if(_mouse == null) _mouse = new HMouse(_app);
		
		try {
			/* HACK
			 * This arbitrary reference to a field in _app.g will throw an error
			 * in Processing.js as `g` doesn't exist in that mode.
			 */
			@SuppressWarnings({ "unused", "static-access" })
			int dummyVar = _app.g.A;
			
			_graphicsContext = _app.g;
			
		} catch(Exception e) {
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
	
	
	// STAGE METHODS //
	
	public static H background(int clr) {
		_stage.background(clr);
		return _self;
	}
	
	public static H backgroundImg(Object arg) {
		_stage.backgroundImg(arg);
		return _self;
	}
	
	/** @deprecated */
	public static H autoClear(boolean b) {
		_stage.autoClear(b);
		return _self;
	}
	
	public static H autoClears(boolean b) {
		_stage.autoClears(b);
		return _self;
	}
	
	public static boolean autoClears() {
		return _stage.autoClears();
	}
	
	public static H clearStage() {
		_stage.clear();
		return _self;
	}
	
	public static HCanvas add(HCanvas stageChild) {
		return (HCanvas) _stage.add(stageChild);
	}
	
	public static HEllipse add(HEllipse stageChild) {
		return (HEllipse) _stage.add(stageChild);
	}
	
	public static HGroup add(HGroup stageChild) {
		return (HGroup) _stage.add(stageChild);
	}
	
	public static HImage add(HImage stageChild) {
		return (HImage) _stage.add(stageChild);
	}
	
	public static HPath add(HPath stageChild) {
		return (HPath) _stage.add(stageChild);
	}
	
	public static HRect add(HRect stageChild) {
		return (HRect) _stage.add(stageChild);
	}
	
	public static HShape add(HShape stageChild) {
		return (HShape) _stage.add(stageChild);
	}
	
	public static HText add(HText stageChild) {
		return (HText) _stage.add(stageChild);
	}
	
	public static HDrawable add(HDrawable stageChild) {
		return _stage.add(stageChild);
	}
	
	public static HCanvas remove(HCanvas stageChild) {
		return (HCanvas) _stage.remove(stageChild);
	}
	
	public static HEllipse remove(HEllipse stageChild) {
		return (HEllipse) _stage.remove(stageChild);
	}
	
	public static HGroup remove(HGroup stageChild) {
		return (HGroup) _stage.remove(stageChild);
	}
	
	public static HImage remove(HImage stageChild) {
		return (HImage) _stage.remove(stageChild);
	}
	
	public static HPath remove(HPath stageChild) {
		return (HPath) _stage.remove(stageChild);
	}
	
	public static HRect remove(HRect stageChild) {
		return (HRect) _stage.remove(stageChild);
	}
	
	public static HShape remove(HShape stageChild) {
		return (HShape) _stage.remove(stageChild);
	}
	
	public static HText remove(HText stageChild) {
		return (HText) _stage.remove(stageChild);
	}
	
	public static HDrawable remove(HDrawable stageChild) {
		return _stage.remove(stageChild);
	}
	
	
	// MISC UTILS //
	
	public static H drawStage() {
		_behaviors.runAll(_app);
		_mouse.handleEvents();
		_stage.paintAll(_graphicsContext, _uses3D, 1);
		return _self;
	}
	
	public static boolean mouseStarted() {
		return _mouse.started();
	}
	
	public static PImage getImage(Object imgArg) {
		if(imgArg instanceof PImage)
			return (PImage) imgArg;
		if(imgArg instanceof HImageHolder)
			return ((HImageHolder)imgArg).image();
		if(imgArg instanceof String)
			return _app.loadImage((String) imgArg);
		return null;
	}
	
	private H() {}
}
