/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013-2015 Joshua Davis, James Cruz, Benjamin Fox, Christopher Tino
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype;

import hype.interfaces.HImageHolder;
import hype.interfaces.HConstants;
import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;

/**
 * Main Hype Class
 * @version     2.0.0
 * @since       2013
 */
public class H implements HConstants {
	public final static String VERSION = "##library.prettyVersion##";
	private static PApplet app;
	private static H hype = null;
	private static HStage stage = null;
	private static HBehaviorRegistry behaviors = null;
	private static HMouse mouse = null;
	private static PGraphics graphicsContext;
	private static boolean uses3D;

	private H() {
		//singleton pattern, prevents instantiation
	}

	public static H init(PApplet applet) {
		app = applet;

		// Create singleton
		if (hype == null)
			hype = new H();

		// Initialize this class' objects
		if(stage == null)
			stage = new HStage(app);
		if(behaviors == null)
			behaviors = new HBehaviorRegistry();
		if(mouse == null)
			mouse = new HMouse(app);

		//set the PGraphics renderer associated with this PApplet
		graphicsContext = app.g;

		return hype;
	}

	/**
	 * Get static instance of the PApplet
	 * @return  app
	 */
	public static PApplet app() {
		return app;
	}

	public static HStage stage() {
		return stage;
	}
	
	public static HBehaviorRegistry behaviors() {
		return behaviors;
	}

	public static HMouse mouse() {
		return mouse;
	}
	
	public static H use3D(boolean b) {
		uses3D = b;
		return hype;
	}
	
	public static boolean uses3D() {
		return uses3D;
	}
	
	
	// STAGE METHODS //
	public static H background(int clr) {
		stage.background(clr);
		return hype;
	}
	
	public static H backgroundImg(Object arg) {
		stage.backgroundImg(arg);
		return hype;
	}
	
	/** @deprecated */
	public static H autoClear(boolean b) {
		stage.autoClear(b);
		return hype;
	}
	
	public static H autoClears(boolean b) {
		stage.autoClears(b);
		return hype;
	}
	
	public static boolean autoClears() {
		return stage.autoClears();
	}
	
	public static H clearStage() {
		stage.clear();
		return hype;
	}
	
	public static HCanvas add(HCanvas stageChild) {
		return stage.add(stageChild);
	}
	
	public static HEllipse add(HEllipse stageChild) {
		return stage.add(stageChild);
	}
	
	public static HGroup add(HGroup stageChild) {
		return stage.add(stageChild);
	}
	
	public static HImage add(HImage stageChild) {
		return stage.add(stageChild);
	}
	
	public static HPath add(HPath stageChild) {
		return stage.add(stageChild);
	}
	
	public static HRect add(HRect stageChild) {
		return stage.add(stageChild);
	}
	
	public static HShape add(HShape stageChild) {
		return stage.add(stageChild);
	}
	
	public static HText add(HText stageChild) {
		return stage.add(stageChild);
	}
	
	public static HDrawable add(HDrawable stageChild) {
		return stage.add(stageChild);
	}
	
	public static HCanvas remove(HCanvas stageChild) {
		return stage.remove(stageChild);
	}
	
	public static HEllipse remove(HEllipse stageChild) {
		return stage.remove(stageChild);
	}
	
	public static HGroup remove(HGroup stageChild) {
		return stage.remove(stageChild);
	}
	
	public static HImage remove(HImage stageChild) {
		return stage.remove(stageChild);
	}
	
	public static HPath remove(HPath stageChild) {
		return stage.remove(stageChild);
	}
	
	public static HRect remove(HRect stageChild) {
		return stage.remove(stageChild);
	}
	
	public static HShape remove(HShape stageChild) {
		return stage.remove(stageChild);
	}
	
	public static HText remove(HText stageChild) {
		return stage.remove(stageChild);
	}
	
	public static HDrawable remove(HDrawable stageChild) {
		return stage.remove(stageChild);
	}
	
	
	// MISC UTILS //
	public static H drawStage() {
		behaviors.runAll(app);
		mouse.handleEvents();
		stage.paintAll(graphicsContext, uses3D, 1);
		return hype;
	}
	
	public static boolean mouseStarted() {
		return mouse.started();
	}

	/**
	 * Cast an image to PImage
	 * @param   imgArg    Type: PImage, HImageHolder, String
	 * @return  PImage
	 */
	public static PImage getImage(Object imgArg) {
		if(imgArg instanceof PImage)
			return (PImage) imgArg;
		if(imgArg instanceof HImageHolder)
			return ((HImageHolder)imgArg).image();
		if(imgArg instanceof String)
			return app.loadImage((String) imgArg);
		return null;
	}
}
