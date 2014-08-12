/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.extended.util;

import hype.core.collection.HLinkedHashSet;
import hype.core.colorist.HColorist;
import hype.core.drawable.HDrawable;
import hype.core.interfaces.HCallback;
import hype.core.layout.HLayout;
import hype.core.util.H;
import hype.core.util.HConstants;
import hype.core.util.HMath;
import hype.core.util.HWarnings;

import java.util.ArrayList;
import java.util.Iterator;

public class HDrawablePool implements Iterable<HDrawable> {
	private HLinkedHashSet<HDrawable> _activeSet, _inactiveSet;
	private ArrayList<HDrawable> _prototypes;
	private HCallback _onCreate, _onRequest, _onRelease;
	private HLayout _layout;
	private HColorist _colorist;
	private HDrawable _autoParent;
	private int _max;
	
	public HDrawablePool() {
		this(64);
	}
	
	public HDrawablePool(int maximumDrawables) {
		_max = maximumDrawables;
		_activeSet = new HLinkedHashSet<HDrawable>();
		_inactiveSet = new HLinkedHashSet<HDrawable>();
		_prototypes = new ArrayList<HDrawable>();
		_onCreate = _onRequest = _onRelease = HConstants.NOP;
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
	
	public HDrawablePool onCreate(HCallback callback) {
		_onCreate = (callback==null)? HConstants.NOP : callback;
		return this;
	}
	
	public HCallback onCreate() {
		return _onCreate;
	}
	
	public HDrawablePool onRequest(HCallback callback) {
		_onRequest = (callback==null)? HConstants.NOP : callback;
		return this;
	}
	
	public HCallback onRequest() {
		return _onRequest;
	}
	
	public HDrawablePool onRelease(HCallback callback) {
		_onRelease = (callback==null)? HConstants.NOP : callback;
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
		
		_onCreate = _onRequest = _onRelease = HConstants.NOP;
		_layout = null;
		_autoParent = null;
		_max = 0;
		
		return this;
	}
	
	public HDrawablePool add(HDrawable prototype, int frequency) {
		if(prototype == null) {
			HWarnings.warn("Null Prototype", "HDrawablePool.add()",
					HWarnings.NULL_ARGUMENT);
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
			HWarnings.warn("No Prototype", "HDrawablePool.request()",
					HWarnings.NO_PROTOTYPE);
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
		if(onCreateFlag) _onCreate.run(drawable);
		_onRequest.run(drawable);
		
		return drawable;
	}
	
	public HDrawablePool requestAll() {
		if(_prototypes.size() <= 0) {
			HWarnings.warn("No Prototype", "HDrawablePool.requestAll()",
					HWarnings.NO_PROTOTYPE);
		} else {
			while(count() < _max) request();
		}
		return this;
	}
	
	public boolean release(HDrawable d) {
		if(_activeSet.remove(d)) {
			_inactiveSet.add(d);
			
			if(_autoParent != null) _autoParent.remove(d);
			_onRelease.run(d);
			
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
	
	private HDrawable createRandomDrawable() {
		int index = HMath.randomInt(_prototypes.size());
		return _prototypes.get(index).createCopy();
	}

	@Override
	public Iterator<HDrawable> iterator() {
		return _activeSet.iterator();
	}
}
