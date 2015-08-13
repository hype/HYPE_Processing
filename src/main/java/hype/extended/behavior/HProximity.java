package hype.extended.behavior;

import hype.core.drawable.HDrawable3D;
import hype.core.behavior.HBehavior;
import hype.core.drawable.HDrawable;
import hype.core.util.HConstants;
import processing.core.PApplet;
import processing.core.PVector;


public class HProximity extends HBehavior {

	private HDrawable _target, _neighbor;
	private int _property;
	private float _min, _max, _range, _radius, _rSq, _dist, _spring, _ease, _goal, _speed, _value;
	private float _origw, _origh, _origd;
	private boolean _useMouse;

	public HProximity () {
		_property = HConstants.ALPHA;
		_radius = 100;
		_rSq = _radius * _radius;
		_spring = (float) 0.9;
		_ease = (float) 0.3;
		_min = 50;
		_max = 255;
		_range = (_max - _min);
		_value = _min;
		_speed = 0;
		_goal = _max;
		_useMouse = true;
		_neighbor = null;

		register();
	}

	public HProximity (float spring, float ease, float min, float max, float radius) {
		_property = HConstants.ALPHA;
		_radius = radius;
		_rSq = _radius * _radius;
		_spring = spring;
		_ease = ease;
		_min = min;
		_max = max;
		_range = (_max - _min);
		_value = _min;
		_speed = 0;
		_goal = 0;
		_useMouse = true;
		_neighbor = null;

		register();
	}

	public HProximity target(HDrawable d) {
		_target = d;
		if(d != null) {
			_origw = d.width();
			_origh = d.height();
			_origd = 0;
		}
		return this;
	}

	public HProximity target(HDrawable3D d) {
		_target = d;
		if(d != null) {
			_origw = d.width();
			_origh = d.height();
			_origd = d.depth();
		}
		return this;
	}

	public HDrawable target() {
		return _target;
	}

	public HProximity property(int id) {
		_property = id;
		return this;
	}

	public int property() {
		return _property;
	}

	public HProximity neighbor(HDrawable d) {
		_useMouse = false;
		_neighbor = d;
		return this;
	}

	public HDrawable neighbor() {
		return _neighbor;
	}

	public HProximity min(float f) {
		_min = f;
		_value = f;
		_range = (_max - _min);
		return this;
	}
	public float min() {
		return _min;
	}

	public HProximity max(float f) {
		_max = f;
		_goal = f;
		_range = (_max - _min);
		return this;
	}
	public float max() {
		return _max;
	}

	public HProximity radius(float f) {
		_radius = f;
		_rSq = _radius * _radius;
		return this;
	}
	public float radius() {
		return _radius;
	}

	public HProximity spring(float f) {
		_spring = f;
		return this;
	}
	public float spring() {
		return _spring;
	}

	public HProximity ease(float f) {
		_ease = f;
		return this;
	}
	public float ease() {
		return _ease;
	}

	private void _run(float x, float y) {
		_dist = ((_target.x() - x) * (_target.x() - x)) + ((_target.y() - y) * (_target.y() - y));

		if (_dist < _rSq) {
			_goal = (1 - (_dist / _rSq)) * _range + _min;
		} else {
			_goal = _min;
		}

		_speed = (_speed * _spring) + ((_goal - _value) * _ease);
		_value += _speed;
	}

	@Override
	public void runBehavior(PApplet app) {
		if(_target==null) return;

		if (_useMouse == true) {
			_run(app.mouseX, app.mouseY);
		} else {
			_run(_neighbor.x(), _neighbor.y());
		}

		float v1 = _value;
		float v2 = _value;
		float v3 = _value;

		switch(_property) {
			case HConstants.WIDTH:		_target.width(_value); break;
			case HConstants.HEIGHT:		_target.height(_value); break;
			case HConstants.SCALE:
				v1 *= _origw;
				v2 *= _origh;
				v3 *= _origd;
			case HConstants.SIZE: 		_target.size(new PVector(v1, v2, v3)); break;
			case HConstants.ALPHA:		_target.alpha(Math.round(_value)); break;
			case HConstants.ROTATIONX:	_target.rotationX(_value); break;
			case HConstants.ROTATIONY:	_target.rotationY(_value); break;
			case HConstants.ROTATIONZ:	_target.rotationZ(_value); break;
			case HConstants.DROTATIONX:	_target.rotateX(_value); break;
			case HConstants.DROTATIONY:	_target.rotateY(_value); break;
			case HConstants.DROTATIONZ:	_target.rotateZ(_value); break;
			default: break;
		}
	}

	@Override
	public HProximity register() {
		return (HProximity) super.register();
	}

	@Override
	public HProximity unregister() {
		return (HProximity) super.unregister();
	}
}
