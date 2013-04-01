package hype.drawable;

import processing.core.PApplet;

public class HEllipse extends HDrawable {
	public HEllipse() {
		radius(8);
	}
	
	public HEllipse(float ellipseRadius) {
		radius(ellipseRadius);
	}
	
	public HEllipse(float radiusX, float radiusY) {
		radius(radiusX,radiusY);
	}
	
	@Override
	public HEllipse createCopy() {
		HEllipse copy = new HEllipse();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	public HEllipse radius(float r) {
		size(r*2);
		return this;
	}
	
	public HEllipse radius(float radiusX, float radiusY) {
		size(radiusX*2,radiusY*2);
		return this;
	}
	
	public HEllipse radiusX(float radiusX) {
		width(radiusX * 2);
		return this;
	}
	
	public float radiusX() {
		return _width/2;
	}
	
	public HEllipse radiusY(float radiusY) {
		height(radiusY * 2);
		return this;
	}
	
	public float radiusY() {
		return _height/2;
	}
	
	public boolean isCircle() {
		return _width == _height;
	}
	
	@Override
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {
		applyStyle(app,currAlpha);
		app.ellipse(drawX+_width/2, drawY+_height/2, _width, _height);
	}
}
