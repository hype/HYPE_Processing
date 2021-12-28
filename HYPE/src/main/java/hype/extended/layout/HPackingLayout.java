package hype.extended.layout;

import hype.interfaces.HLayout;

import hype.H;
import hype.HDrawable;
import hype.HMath;

import processing.core.PVector;

import java.util.ArrayList;
 
import static processing.core.PApplet.cos;
import static processing.core.PApplet.sin;
import static processing.core.PApplet.radians;
import static processing.core.PApplet.abs;
import static processing.core.PApplet.map;
 
public class HPackingLayout implements HLayout {

	private int currentIndex;
	private ArrayList<PVector> pos;

	private boolean _firstRun;

	private int     numItems;

	private float   _maxSizeInit;
	private float   _maxSize;
	private float   _minSize;

	private int     _count;
	private int     _volume;
	private int     _numTrys;



	public HPackingLayout() {
		currentIndex = 0;
		pos = new ArrayList<PVector>();

		_firstRun      = true;

		numItems       = 100;

		_maxSizeInit   = 450.0f;
		_maxSize       = 450.0f;
		_minSize       = 3.0f;

		_count         = 0;
		_numTrys       = 200;

		_volume = H.app().width * H.app().height;
	}


	public HPackingLayout numTrys(int i) {
		_numTrys = i;
		return this;
	}
	public int numTrys() {
		return _numTrys;
	}


	public HPackingLayout numItems(int i) {
		numItems = i;
		return this;
	}
	public int numItems() {
		return numItems;
	}


	public HPackingLayout maxSize(float f) {
		_maxSizeInit = f;
		_maxSize = f;
		return this;
	}
	public float maxSize() {
		return _maxSizeInit;
	}
	public float curMaxSize() {
		return _maxSize;
	}

	public HPackingLayout minSize(float f) {
		_minSize = f;
		return this;
	}
	public float minSize() {
		return _minSize;
	}









 
	public HPackingLayout currentIndex(int i) {
		currentIndex = i;
		return this;
	}

	public int currentIndex() {
		return currentIndex;
	}

	public HPackingLayout resetIndex() {
		currentIndex = 0;
		return this;
	}


	public void reset() {
		resetIndex();

		for (int i = pos.size() - 1; i >= 0; i--) {
			pos.remove(i);
		}

		_count   = 0;
		_maxSize = _maxSizeInit;
		_volume = H.app().width * H.app().height;

		for (int i = 0; i < numItems; ++i) {
			runPacking();
		}
		_firstRun = false;
	}

	private void generatePoints() {
		for (int i = 0; i < numItems; ++i) {
			runPacking();
		}
		_firstRun = false;
	}

	private void runPacking() {
		int start = _count;

		for (int i = 0; i < _numTrys; ++i) {

			if(_count >= numItems || _maxSize < _minSize) {
				break;
			}

			float xPos = H.app().random(0, H.app().width);
			float yPos = H.app().random(0, H.app().height);

			float r = _maxSize / 2.0f;
			float v = (float) Math.PI*(r*r) * 0.8f;

			if (!checkCollisions(_count-1, xPos, yPos, r)) {

				PVector pt = new PVector();
				pt.x = xPos;
				pt.y = yPos;
				pt.z = _maxSize;

				pos.add(pt);

				_volume -= v;
				if (_volume/v < 20) {
					_maxSize = _maxSize*0.95f;
				}
				++_count;
			}
		}
		if(start == _count)  _maxSize = _maxSize*0.95f;
	}


	// ********************************************************************************************************************

	boolean checkCollisions(int index, float x, float y, float r) {
		boolean collides     = false;
		float   maxDistance  = 0;
		float   tempDistance = 0;

		for (PVector p : pos ) {
			tempDistance = HMath.dist(p.x, p.y, x, y);
			if (tempDistance>maxDistance) {
				maxDistance=tempDistance;
			}
			if (isCollision(p.x, p.y, x, y, p.z/2, r)) {
				collides = true;
				break;
			}
		}
		return collides;
	}

	// ********************************************************************************************************************

	boolean isCollision(float x1, float y1, float x2, float y2, float r1, float r2) {
		float a = r1 + r2;
		float dx = x1 - x2;
		float dy = y1 - y2;
		return a * a > (dx * dx + dy * dy);
	}

	// ********************************************************************************************************************
 
	@Override
	public PVector getNextPoint() {

		if (_firstRun == true) {
			generatePoints();
		}

		float x = 0.0f;
		float y = 0.0f;
		float z = 0.0f;

		if (currentIndex < pos.size()) {
			PVector p = pos.get(currentIndex);
			x = p.x;
			y = p.y;
			z = p.z;
		}
 
		++currentIndex;
		return new PVector(x, y, z);
	}
 
	@Override
	public void applyTo(HDrawable target) {
		PVector p = getNextPoint();

		if (p.z == 0.0f) {
			target.hide();
		} else {
			target.anchorAt(H.CENTER);
			target.loc(p.x, p.y);
			target.size(p.z);
		}
		
	}

}
