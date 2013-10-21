/*
 * HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 *
 * HMagneticField
 * by Benjamin Fox / twitter.com/tracerstar
 * https://github.com/tracerstar
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HMagneticField extends HBehavior {
	private ArrayList<HPole> _poles;
	private HLinkedHashSet<HDrawable> _targets;
	public HMagneticField() {
		_poles = new ArrayList<HMagneticField.HPole>();
		_targets = new HLinkedHashSet<HDrawable>();
	}
	public HMagneticField addMagnet(float nx, float ny, float sx, float sy) {
		addPole(nx, ny, 1);
		addPole(sx, sy, -1);
		return this;
	}
	public HMagneticField addPole(float x, float y, float polarity) {
		HPole p = new HPole(x, y, polarity);
		_poles.add(p);
		return this;	
	}
	public HPole pole(int index) {
		return _poles.get(index);
	}
	public HMagneticField removePole(int index) {
		_poles.remove(index);
		return this;
	}
	public HMagneticField addTarget(HDrawable d) {
		if(_targets.size() <= 0) register();
		_targets.add(d);
		return this;
	}
	public HMagneticField removeTarget(HDrawable d) {
		_targets.remove(d);
		if(_targets.size() <= 0) unregister();
		return this;
	}
	public float getRotation(float x, float y) {
		int poleCount = _poles.size();
		PVector v1 = new PVector(0, 0);
		PVector v2 = new PVector(x, y); 
		PVector distance = new PVector(0, 0);
		PVector force = new PVector(0, 0);
		float d = 0;
		for(int i=0; i<poleCount; i++) {
			HPole p = _poles.get(i);
			v1.x = p._x;
			v1.y = p._y;
			if (p._polarity < 0) {
				distance = PVector.sub(v1, v2);
			} else {
				distance = PVector.sub(v2, v1);	
			}
			d = distance.mag() / 5;
			distance.normalize();
			distance.mult(abs(p._polarity));
			distance.div(d);
			force.add(distance);
		}
    	return atan2(force.y, force.x);
	}
	public void runBehavior(PApplet app) {
		for(HDrawable d : _targets) d.rotationRad( getRotation(d.x(), d.y()) );
	}
	public HMagneticField register() {
		return (HMagneticField) super.register();
	}
	public HMagneticField unregister() {
		return (HMagneticField) super.unregister();
	}
	public static class HPole {
		public float _x, _y, _polarity;
		public HPole(float x, float y, float polarity) {
			_x = x;
			_y = y;
			_polarity = polarity;
		}
	}
}
