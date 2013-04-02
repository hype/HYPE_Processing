class HProximity {
	int i;
	float _spring, _ease, _radius, _dist, _curValue;
	float[] _min;
	float[] _max;
	float[] _goal;
	float[] _speed;
	float[] _value;
	
	HProximity (float spring, float ease, float[] min, float[] max, float radius ) {
		_spring    = spring;
		_ease      = ease;
		_min       = min;
		_max       = max;
		_radius    = radius * radius;

		_goal = new float[numAssets];
		_speed = new float[numAssets];
		_value  = new float[numAssets];

		for (int i = 0; i<numAssets; i++){
			_value[i]  = _min[i];
			_goal[i]   = _max[i];
			_speed[i]  = 0;
		}
	}

	float run(int i) {
		PVector pt = gridPos[i];


		_dist = pow(pt.x - mouseX, 2) + pow(pt.y - mouseY, 2);

		if (_dist < _radius) {
			_goal[i] = (1 - (_dist / _radius)) * (_max[i] - _min[i]) + _min[i];
		} else {
			_goal[i] = _min[i];
		}

		_speed[i] = (_speed[i] * _spring) + ((_goal[i] - _value[i]) * _ease);
	    _value[i] += _speed[i];

		return _value[i];
	}
}