/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HTimer extends HTrigger {
	private int _lastInterval, _interval, _cycleCounter, _numCycles;
	private boolean _usesFrames;
	public HTimer() {
		_interval = 1000;
		_lastInterval = -1;
	}
	public HTimer(int timerInterval) {
		_interval = timerInterval;
	}
	public HTimer(int timerInterval, int numberOfCycles) {
		_interval = timerInterval;
		_numCycles = numberOfCycles;
	}
	public HTimer interval(int i) {
		_interval = i;
		return this;
	}
	public int interval() {
		return _interval;
	}
	public HTimer cycleCounter(int cycleIndex) {
		_cycleCounter = cycleIndex;
		return this;
	}
	public int cycleCounter() {
		return _cycleCounter;
	}
	public HTimer numCycles(int cycles) {
		_numCycles = cycles;
		return this;
	}
	public int numCycles() {
		return _numCycles;
	}
	public HTimer cycleIndefinitely() {
		_numCycles = 0;
		return this;
	}
	public HTimer useMillis() {
		_usesFrames = false;
		return this;
	}
	public boolean usesMillis() {
		return !_usesFrames;
	}
	public HTimer useFrames() {
		_usesFrames = true;
		return this;
	}
	public boolean usesFrames() {
		return _usesFrames;
	}
	public void runBehavior(PApplet app) {
		int curr = (_usesFrames)? app.frameCount : app.millis();
		if(_lastInterval < 0) _lastInterval = curr;
		if(curr-_lastInterval >= _interval) {
			_lastInterval = curr;
			_callback.run(_cycleCounter);
			if(_numCycles > 0 && ++_cycleCounter >= _numCycles) unregister();
		}
	}
	public HTimer callback(HCallback cb) {
		return (HTimer) super.callback(cb);
	}
	public HTimer register() {
		return (HTimer) super.register();
	}
	public HTimer unregister() {
		_numCycles = 0;
		_lastInterval = -1;
		return (HTimer) super.unregister();
	}
}
