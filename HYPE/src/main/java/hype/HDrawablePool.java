package hype;

import hype.interfaces.HLayout;
import hype.interfaces.HColorist;
import hype.interfaces.HConstants;

import java.util.ArrayList;
import java.util.Iterator;

public class HDrawablePool implements Iterable<HDrawable> {
	private HLinkedHashSet<HDrawable> activeSet, inactiveSet;
	private ArrayList<HDrawable> prototypes;
	private HCallback onCreate, onRequest, onRelease;
	private HLayout layout;
	private HColorist colorist;
	private HDrawable autoParent;
	private int max;

	public HDrawablePool() {
		this(64);
	}

	public HDrawablePool(int maximumDrawables) {
		max = maximumDrawables;
		activeSet = new HLinkedHashSet<HDrawable>();
		inactiveSet = new HLinkedHashSet<HDrawable>();
		prototypes = new ArrayList<HDrawable>();
		onCreate = onRequest = onRelease = HConstants.NOP;
	}

	public int max() {
		return max;
	}

	public HDrawablePool max(int m) {
		max = m;
		return this;
	}

	public int numActive() {
		return activeSet.size();
	}

	public int numInactive() {
		return inactiveSet.size();
	}

	public int currentIndex() {
		return activeSet.size() - 1;
	}

	public HLayout layout() {
		return layout;
	}

	public HDrawablePool layout(HLayout newLayout) {
		layout = newLayout;
		return this;
	}

	public HColorist colorist() {
		return colorist;
	}

	public HDrawablePool colorist(HColorist newColorist) {
		colorist = newColorist;
		return this;
	}

	public HDrawablePool onCreate(HCallback callback) {
		onCreate = (callback==null)? HConstants.NOP : callback;
		return this;
	}

	public HCallback onCreate() {
		return onCreate;
	}

	public HDrawablePool onRequest(HCallback callback) {
		onRequest = (callback==null)? HConstants.NOP : callback;
		return this;
	}

	public HCallback onRequest() {
		return onRequest;
	}

	public HDrawablePool onRelease(HCallback callback) {
		onRelease = (callback==null)? HConstants.NOP : callback;
		return this;
	}

	public HCallback onRelease() {
		return onRelease;
	}

	public HDrawablePool autoParent(HDrawable parent) {
		autoParent = parent;
		return this;
	}

	public HDrawablePool autoAddToStage() {
		autoParent = H.stage();
		return this;
	}

	public HDrawable autoParent() {
		return autoParent;
	}

	public boolean isFull() {
		return count() >= max;
	}

	public int count() {
		return activeSet.size() + inactiveSet.size();
	}

	public HDrawablePool destroy() {
		activeSet.removeAll();
		inactiveSet.removeAll();
		prototypes.clear();

		onCreate = onRequest = onRelease = HConstants.NOP;
		layout = null;
		autoParent = null;
		max = 0;

		return this;
	}

	public HDrawablePool drain() {
		return drain(true);
	}

	public HDrawablePool drain(boolean resetLayout) {

		for (HDrawable d : activeSet) {
			if(autoParent != null) autoParent.remove(d);
			onRelease.run(d);//do we need this?
		}

		activeSet.removeAll();
		inactiveSet.removeAll();
		//Need to add this in when we've updated the HLayout interface
		// if (layout != null && resetLayout == true) {
		// 	layout.resetIndex();
		// }
		return this;
	}

	public HDrawablePool add(HDrawable prototype, int frequency) {
		if(prototype == null) {
			HWarnings.warn("Null Prototype", "HDrawablePool.add()",
					HWarnings.NULL_ARGUMENT);
		} else {
			prototypes.add(prototype);
			while(frequency-- > 0) prototypes.add(prototype);
		}
		return this;
	}

	public HDrawablePool add(HDrawable prototype) {
		return add(prototype,1);
	}

	public HDrawable request() {
		if(prototypes.size() <= 0) {
			HWarnings.warn("No Prototype", "HDrawablePool.request()",
					HWarnings.NO_PROTOTYPE);
			return null;
		}

		HDrawable drawable;
		boolean onCreateFlag = false;

		if(inactiveSet.size() > 0) {
			drawable = inactiveSet.pull();
		} else if(count() < max) {
			drawable = createRandomDrawable();
			onCreateFlag = true;
		} else return null;

		activeSet.add(drawable);

		// Apply autoParent, layout and colorist
		if(autoParent != null) autoParent.add(drawable);
		if(layout != null) layout.applyTo(drawable);
		if(colorist != null) colorist.applyColor(drawable);

		// Call onCreate (if applicable), and onRequest
		if(onCreateFlag) onCreate.run(drawable);
		onRequest.run(drawable);

		return drawable;
	}

	public HDrawablePool requestAll() {
		if(prototypes.size() <= 0) {
			HWarnings.warn("No Prototype", "HDrawablePool.requestAll()",
					HWarnings.NO_PROTOTYPE);
		} else {
			while(count() < max) request();
		}
		return this;
	}

	public HDrawablePool shuffleRequestAll() {

		HDrawable tempParent = null;
		if(autoParent != null) {
			tempParent = autoParent;
			autoParent = null;
		}

		if(prototypes.size() <= 0) {
			HWarnings.warn("No Prototype", "HDrawablePool.shuffleRequestAll()",
					HWarnings.NO_PROTOTYPE);
		} else {
			while(count() < max) request();
		}

		//shuffle active set and add to stage
		activeSet.shuffle();

		if(tempParent != null) {
			autoParent = tempParent;
			tempParent = null;

			for (HDrawable d : activeSet) {
				autoParent.add(d);
			}
		}

		return this;
	}

	public boolean release(HDrawable d) {
		if(activeSet.remove(d)) {
			inactiveSet.add(d);

			if(autoParent != null) autoParent.remove(d);
			onRelease.run(d);

			return true;
		}
		return false;
	}

	public HLinkedHashSet<HDrawable> activeSet() {
		return activeSet;
	}

	public HLinkedHashSet<HDrawable> inactiveSet() {
		return inactiveSet;
	}

	private HDrawable createRandomDrawable() {
		int index = HMath.randomInt(prototypes.size());
		return prototypes.get(index).createCopy();
	}

	@Override
	public Iterator<HDrawable> iterator() {
		return activeSet.iterator();
	}
}
