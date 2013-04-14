package hype.util;

import hype.colorist.HColorist;
import hype.drawable.HDrawable;
import hype.layout.HLayout;
import hype.util.collection.HIterator;
import hype.util.collection.HLinkedHashSet;

import java.util.ArrayList;

import processing.core.PApplet;

public class HDrawablePool {
	protected HLinkedHashSet<HDrawable> _activeSet, _inactiveSet;
	protected ArrayList<HDrawable> _prototypes;
	public HCallback _onCreate, _onRequest, _onRelease;
	public HPoolListener _listener;
	protected HLayout _layout;
	protected HColorist _colorist;
	protected HDrawable _autoParent;
	protected int _max;
	
	public HDrawablePool() {
		this(64);
	}
	
	public HDrawablePool(int maximumDrawables) {
		_max = maximumDrawables;
		_activeSet = new HLinkedHashSet<HDrawable>();
		_inactiveSet = new HLinkedHashSet<HDrawable>();
		_prototypes = new ArrayList<HDrawable>();
	}
	
	public int max() {
		return _max;
	}
	
	public HDrawablePool max(int m) {
		_max = m;
		return this;
	}
	
	public int numActive() {
		return _activeSet.size();
	}
	
	public int numInactive() {
		return _inactiveSet.size();
	}
	
	public int currentIndex() {
		return _activeSet.size() - 1;
	}
	
	public HLayout layout() {
		return _layout;
	}
	
	public HDrawablePool layout(HLayout newLayout) {
		_layout = newLayout;
		return this;
	}
	
	public HColorist colorist() {
		return _colorist;
	}
	
	public HDrawablePool colorist(HColorist newColorist) {
		_colorist = newColorist;
		return this;
	}
	
	public HDrawablePool listener(HPoolListener newListener) {
		_listener = newListener;
		return this;
	}
	
	public HDrawablePool onCreate(HCallback callback) {
		_onCreate = callback;
		return this;
	}
	
	public HCallback onCreate() {
		return _onCreate;
	}
	
	public HPoolListener listener() {
		return _listener;
	}
	
	public HDrawablePool onRequest(HCallback callback) {
		_onRequest = callback;
		return this;
	}
	
	public HCallback onRequest() {
		return _onRequest;
	}
	
	public HDrawablePool onRelease(HCallback callback) {
		_onRelease = callback;
		return this;
	}
	
	public HCallback onRelease() {
		return _onRelease;
	}
	
	public HDrawablePool autoParent(HDrawable parent) {
		_autoParent = parent;
		return this;
	}
	
	public HDrawablePool autoAddToStage() {
		_autoParent = H.stage();
		return this;
	}
	
	public HDrawable autoParent() {
		return _autoParent;
	}
	
	public boolean isFull() {
		return count() >= _max;
	}
	
	public int count() {
		return _activeSet.size() + _inactiveSet.size();
	}
	
	public HDrawablePool destroy() {
		_activeSet.removeAll();
		_inactiveSet.removeAll();
		_prototypes.clear();
		
		_onCreate = _onRequest = _onRelease = null;
		_layout = null;
		_autoParent = null;
		_max = 0;
		
		return this;
	}
	
	public HDrawablePool add(HDrawable prototype, int frequency) {
		if(prototype == null) {
			H.warn("Invalid Argument", "HDrawablePool.add()",
				"The new prototype shouldn't be null.");
		} else {
			_prototypes.add(prototype);
			while(frequency-- > 0) _prototypes.add(prototype);
		}
		return this;
	}
	
	public HDrawablePool add(HDrawable prototype) {
		return add(prototype,1);
	}
	
	public HDrawable request() {
		if(_prototypes.size() <= 0) {
			H.warn("Invalid Argument", "HDrawablePool.request()",
				"Request aborted. HDrawablePool can't request a new object " +
				"without an existing prototype. Try using " +
				"HDrawablePool.add( HDrawable ) to add a new prototype");
			return null;
		}
		
		HDrawable drawable;
		boolean onCreateFlag = false;
		
		if(_inactiveSet.size() > 0) {
			drawable = _inactiveSet.pull();
		} else if(count() < _max) {
			drawable = createRandomDrawable();
			onCreateFlag = true;
		} else return null;
		
		_activeSet.add(drawable);
		
		// Apply autoParent, layout and colorist
		if(_autoParent != null) _autoParent.add(drawable);
		if(_layout != null) _layout.applyTo(drawable);
		if(_colorist != null) _colorist.applyColor(drawable);
		
		// Call onCreate (if applicable), and onRequest
		if(_listener != null) {
			int index = currentIndex();
			if(onCreateFlag) _listener.onCreate(drawable, index, this);
			_listener.onRequest(drawable, index, this);
		}
		if(onCreateFlag && _onCreate != null) _onCreate.run(drawable);
		if(_onRequest != null) _onRequest.run(drawable);
		
		return drawable;
	}
	
	public HDrawablePool requestAll() {
		while(count() < _max) request();
		return this;
	}
	
	public boolean release(HDrawable d) {
		if(_activeSet.remove(d)) {
			_inactiveSet.add(d);
			
			if(_autoParent != null) _autoParent.remove(d);
			
			if(_listener != null) _listener.onRelease(d, currentIndex(), this);
			if(_onRelease != null) _onRelease.run(d);
			
			return true;
		}
		return false;
	}
	
	public HLinkedHashSet<HDrawable> activeSet() {
		return _activeSet;
	}
	
	public HLinkedHashSet<HDrawable> inactiveSet() {
		return _inactiveSet;
	}
	
	@SuppressWarnings("static-access")
	protected HDrawable createRandomDrawable() {
		PApplet app = H.app();
		int numPrototypes = _prototypes.size();
		int index = app.round( app.random(numPrototypes-1) );
		return _prototypes.get(index).createCopy();
	}

	public HIterator<HDrawable> iterator() {
		return _activeSet.iterator();
	}
}
