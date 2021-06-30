package hype.extended.behavior;

import hype.H;
import hype.HBehavior;
import hype.HDrawable;
import hype.HLinkedHashSet;
import hype.HMath;
import processing.core.PApplet;
import processing.core.PVector;

import java.util.ArrayList;

import static processing.core.PApplet.map;

public class HPacking extends HBehavior {

	private HLinkedHashSet<HDrawable> _targets;
	private float _maxSize;
	private float _maxSizeOG;
	private float _minSize;
	private int _count;
	private boolean _firstRun;
	private long _volume;

	private int _numTrys;

	public HPacking() {
		_targets  = new HLinkedHashSet<HDrawable>();
		_maxSize  = 250.0f;
		_maxSizeOG  = 250.0f;
		_minSize  = 5.0f;
		_count    = 0;
		_firstRun = true;
		_volume   = H.app().width * H.app().height;

		_numTrys = 100;

		register();
	}

	public HPacking reset() {

		_maxSize = _maxSizeOG;
		_firstRun = true;
		_count = 0;
		_volume   = H.app().width * H.app().height;
		_targets.removeAll();

		return this;
	}

	public HPacking addTarget(HDrawable d) {

		// if (_targets.size() <= 0) {
		// 	register();
		// }
		_targets.add(d);

		d.hide();
		
		return this;
	}


	public HPacking maxSize(float f) {
		_maxSizeOG = f;
		_maxSize = f;
		return this;
	}
	public float maxSize() {
		return _maxSize;
	}


	public HPacking minSize(float f) {
		_minSize = f;
		return this;
	}
	public float minSize() {
		return _minSize;
	}


	public HPacking numTrys(int i) {
		_numTrys = i;
		return this;
	}
	public int numTrys() {
		return _numTrys;
	}


	public void runBehavior(PApplet app) {
	
		if (_firstRun) {
			
			for (HDrawable d : _targets) {
				placeCircle();
			}

			//we only want to adjust drawables once at the start
			_firstRun = false;
		}

	}//runBehavior


	private void placeCircle() {

		int start = _count;

		for (int j = 0; j <= _numTrys; j = j+1) {
		
			if(_count >= _targets.size() || _maxSize < _minSize) {
				break;
			}

			float xPos = H.app().random(0, H.app().width);
			float yPos = H.app().random(0, H.app().height);

			HDrawable target = _targets.get(_count);
			target.anchorAt(H.CENTER);
			target.loc(xPos, yPos);
			target.size(_maxSize); //scale size up and down to find best fit

			float r = target.width() / 2.0f;
			float v = (float) Math.PI*(r*r) * 0.8f;//reduce volume to 80% for denser packing

			if (!checkCollisions(_count-1, xPos, yPos, r)) {

				//circle can be shown
				target.show();

				//BF - This seems incorrect, especially if a circle is offscreen...
				_volume -= v; //subtract volume
				
				if (_volume/v < 20) {
					_maxSize = _maxSize*0.95f;
				}

				//increment how many circles we've added
				++_count;
			}
		}

		//scale down the circle
		if(start == _count) {
			_maxSize = _maxSize*0.95f;
		}
	}//end placeCircle

	private boolean checkCollisions(int index, float x, float y, float r) {

		boolean collides     = false;
		float   maxDistance  = 0;
		float   tempDistance = 0;
		
		for (int i = 0; i <= index; i = i+1) {

			HDrawable target = _targets.get(i);
			tempDistance = HMath.dist(target.x(), target.y(), x, y);
			
			if (tempDistance>maxDistance) {
				maxDistance=tempDistance;
			}
			
			if (isCollision(target.x(), target.y(), x, y, target.width()/2, r)) {
				collides = true;
				break;
			}
		}

		return collides;
	}//end checkCollisions


	private static boolean isCollision(float x1, float y1, float x2, float y2, float r1, float r2) {
		final double a = r1 + r2;
		final double dx = x1 - x2;
		final double dy = y1 - y2;
		return a * a > (dx * dx + dy * dy);
	}


	public HPacking register() {
		return (HPacking) super.register();
	}

	public HPacking unregister() {
		return (HPacking) super.unregister();
	}


}
