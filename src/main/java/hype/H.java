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
	private PGraphics graphicsContext;
	private HStage stage;
	private HBehaviorRegistry behaviors;
	private HMouse mouse;
	private boolean uses3D;

	public H(PApplet applet) {
		app = applet;

		// Initialize this class' objects
		if(this.stage == null)
			this.stage = new HStage(app);
		if(this.behaviors == null)
			this.behaviors = new HBehaviorRegistry();
		if(this.mouse == null)
			this.mouse = new HMouse(app);

		//set the PGraphics renderer associated with this PApplet
		this.graphicsContext = app.g;
	}

	/**
	 * Get static instance of the PApplet
	 * @return  app
	 */
	public static PApplet app() {
		return app;
	}

	public HStage stage() {
		return stage;
	}
	
	public HBehaviorRegistry behaviors() {
		return behaviors;
	}

	public HMouse mouse() {
		return mouse;
	}
	
	public H use3D(boolean b) {
		uses3D = b;
		return this;
	}
	
	public boolean uses3D() {
		return uses3D;
	}
	
	
	// STAGE METHODS //
	public H background(int clr) {
		stage.background(clr);
		return this;
	}
	
	public H backgroundImg(Object arg) {
		stage.backgroundImg(arg);
		return this;
	}
	
	/** @deprecated */
	public H autoClear(boolean b) {
		stage.autoClear(b);
		return this;
	}
	
	public H autoClears(boolean b) {
		stage.autoClears(b);
		return this;
	}
	
	public boolean autoClears() {
		return stage.autoClears();
	}
	
	public H clearStage() {
		stage.clear();
		return this;
	}
	
	public HCanvas add(HCanvas stageChild) {
		return stage.add(stageChild);
	}
	
	public HEllipse add(HEllipse stageChild) {
		return stage.add(stageChild);
	}
	
	public HGroup add(HGroup stageChild) {
		return stage.add(stageChild);
	}
	
	public HImage add(HImage stageChild) {
		return stage.add(stageChild);
	}
	
	public HPath add(HPath stageChild) {
		return stage.add(stageChild);
	}
	
	public HRect add(HRect stageChild) {
		return stage.add(stageChild);
	}
	
	public HShape add(HShape stageChild) {
		return stage.add(stageChild);
	}
	
	public HText add(HText stageChild) {
		return stage.add(stageChild);
	}
	
	public HDrawable add(HDrawable stageChild) {
		return stage.add(stageChild);
	}
	
	public HCanvas remove(HCanvas stageChild) {
		return stage.remove(stageChild);
	}
	
	public HEllipse remove(HEllipse stageChild) {
		return stage.remove(stageChild);
	}
	
	public HGroup remove(HGroup stageChild) {
		return stage.remove(stageChild);
	}
	
	public HImage remove(HImage stageChild) {
		return stage.remove(stageChild);
	}
	
	public HPath remove(HPath stageChild) {
		return stage.remove(stageChild);
	}
	
	public HRect remove(HRect stageChild) {
		return stage.remove(stageChild);
	}
	
	public HShape remove(HShape stageChild) {
		return stage.remove(stageChild);
	}
	
	public HText remove(HText stageChild) {
		return stage.remove(stageChild);
	}
	
	public HDrawable remove(HDrawable stageChild) {
		return stage.remove(stageChild);
	}
	
	
	// MISC UTILS //
	public H drawStage() {
		behaviors.runAll(app);
		mouse.handleEvents();
		stage.paintAll(graphicsContext, uses3D, 1);
		return this;
	}
	
	public boolean mouseStarted() {
		return mouse.started();
	}
	
	public PImage getImage(Object imgArg) {
		if(imgArg instanceof PImage)
			return (PImage) imgArg;
		if(imgArg instanceof HImageHolder)
			return ((HImageHolder)imgArg).image();
		if(imgArg instanceof String)
			return app.loadImage((String) imgArg);
		return null;
	}
}
