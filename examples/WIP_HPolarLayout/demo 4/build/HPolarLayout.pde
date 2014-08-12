/*
 * HPolarLayout
 * 
 * old AS3 layout by Michael Svendsen / twitter.com/michaelSvendsen
 * HYPE processing port and WIP examples by Joshua Davis
 * 
 * still a WIP/DEMO until we can fold into main code structure
 * 
 */

class HPolarLayout {
	int _index = 0;
	int _offsetX, _offsetY;
	float _length, _angleStep, _scaleMultiplier;
	Boolean _scaleByDistance;
	
	HPolarLayout (float length, float angleStep, int offsetX, int offsetY, Boolean scaleByDistance, float scaleMultiplier) {
		_length = length;
		_angleStep = angleStep;
		_offsetX = offsetX;
		_offsetY = offsetY;
		_scaleByDistance = scaleByDistance;
		_scaleMultiplier = scaleMultiplier;
	}

	public void applyLayout(HDrawable target) {
		PVector pt = new PVector();
		pt = getNextPoint();
		target.loc(pt);
		
		if(_scaleByDistance) scaleByDist(target);
	}

	public PVector getNextPoint() {
		PVector pt = new PVector();
		pt = _getPosition();
		pt.x += _offsetX;
		pt.y += _offsetY;
		++_index;

		return pt;
	}

	private PVector _getPosition() {
		PVector pt = new PVector();

		// Convert a polar coordinate (r,theta) to cartesian // James... maybe add to H.MATH ?

		float r     = _index * _length;
		float theta = _index * _angleStep;

		float x = r * cos(theta);
		float y = r * sin(theta);

		pt.x = x;
		pt.y = y;

		return pt;
	}

	private void scaleByDist(HDrawable target) {
		float d = dist( _offsetX, _offsetY, target.x(), target.y() );

		target.scale(d * _scaleMultiplier);
	}
	
}