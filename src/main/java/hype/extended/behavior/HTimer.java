package hype.extended.behavior;

import hype.HTrigger;
import hype.HCallback;
import processing.core.PApplet;


public class HTimer extends HTrigger {
	private int lastInterval, interval, cycleCounter, numCycles;
	private boolean usesFrames;

	public HTimer() {
		interval = 1000;
		lastInterval = -1;
	}

	public HTimer(int timerInterval) {
		interval = timerInterval;
	}

	public HTimer(int timerInterval, int numberOfCycles) {
		interval = timerInterval;
		numCycles = numberOfCycles;
	}

	public HTimer interval(int i) {
		interval = i;
		return this;
	}

	public int interval() {
		return interval;
	}

	public HTimer cycleCounter(int cycleIndex) {
		cycleCounter = cycleIndex;
		return this;
	}

	public int cycleCounter() {
		return cycleCounter;
	}

	public HTimer numCycles(int cycles) {
		numCycles = cycles;
		return this;
	}

	public int numCycles() {
		return numCycles;
	}

	public HTimer cycleIndefinitely() {
		numCycles = 0;
		return this;
	}

	public HTimer useMillis() {
		usesFrames = false;
		return this;
	}

	public boolean usesMillis() {
		return !usesFrames;
	}

	public HTimer useFrames() {
		usesFrames = true;
		return this;
	}

	public boolean usesFrames() {
		return usesFrames;
	}

	@Override
	public void runBehavior(PApplet app) {
		int curr = (usesFrames)? app.frameCount : app.millis();
		if(lastInterval < 0) lastInterval = curr;

		if(curr- lastInterval >= interval) {
			lastInterval = curr;

			callback.run(cycleCounter);

			if(numCycles > 0 && ++cycleCounter >= numCycles) unregister();
		}
	}

	@Override
	public HTimer callback(HCallback cb) {
		return (HTimer) super.callback(cb);
	}

	@Override
	public HTimer register() {
		return (HTimer) super.register();
	}

	@Override
	public HTimer unregister() {
		numCycles = 0;
		lastInterval = -1;
		return (HTimer) super.unregister();
	}
}
