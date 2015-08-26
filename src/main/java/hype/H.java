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
	public PApplet app;
	private  PGraphics graphicsContext;
	private  HStage stage;
	private  HBehaviorRegistry behaviors;
	private  HMouse mouse;
	private  boolean uses3D;

	public H(PApplet applet) {
		this.app = applet;

		// Initialize this class' objects
		if(this.stage == null)
			this.stage = new HStage(this.app);
		if(this.behaviors == null)
			this.behaviors = new HBehaviorRegistry();
		if(this.mouse == null)
			this.mouse = new HMouse(this.app);

		//set the PGraphics renderer associated with this PApplet
		this.graphicsContext = this.app.g;
	}

	public HStage stage() {
		return stage;
	}
	
	public PApplet app() {
		return app;
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
		return (HCanvas) stage.add(stageChild);
	}
	
	public HEllipse add(HEllipse stageChild) {
		return (HEllipse) stage.add(stageChild);
	}
	
	public HGroup add(HGroup stageChild) {
		return (HGroup) stage.add(stageChild);
	}
	
	public HImage add(HImage stageChild) {
		return (HImage) stage.add(stageChild);
	}
	
	public HPath add(HPath stageChild) {
		return (HPath) stage.add(stageChild);
	}
	
	public HRect add(HRect stageChild) {
		return (HRect) stage.add(stageChild);
	}
	
	public HShape add(HShape stageChild) {
		return (HShape) stage.add(stageChild);
	}
	
	public HText add(HText stageChild) {
		return (HText) stage.add(stageChild);
	}
	
	public HDrawable add(HDrawable stageChild) {
		return stage.add(stageChild);
	}
	
	public HCanvas remove(HCanvas stageChild) {
		return (HCanvas) stage.remove(stageChild);
	}
	
	public HEllipse remove(HEllipse stageChild) {
		return (HEllipse) stage.remove(stageChild);
	}
	
	public HGroup remove(HGroup stageChild) {
		return (HGroup) stage.remove(stageChild);
	}
	
	public HImage remove(HImage stageChild) {
		return (HImage) stage.remove(stageChild);
	}
	
	public HPath remove(HPath stageChild) {
		return (HPath) stage.remove(stageChild);
	}
	
	public HRect remove(HRect stageChild) {
		return (HRect) stage.remove(stageChild);
	}
	
	public HShape remove(HShape stageChild) {
		return (HShape) stage.remove(stageChild);
	}
	
	public HText remove(HText stageChild) {
		return (HText) stage.remove(stageChild);
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
