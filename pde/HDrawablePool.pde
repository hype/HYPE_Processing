



public static class HDrawablePool {
	protected HLinkedHashSet<HDrawable> activeDrawables, inactiveDrawables;
	protected ArrayList<HDrawable> prototypes;
	public HCallback onCreateCallback, onRequestCallback, onReleaseCallback;
	public HPoolListener currentListener;
	protected HLayout currentLayout;
	protected HColorist currentColorist;
	protected HDrawable currentAutoParent;
	protected int maxDrawables;
	
	public HDrawablePool() {
		this(64);
	}
	
	public HDrawablePool(int maximumDrawables) {
		maxDrawables = maximumDrawables;
		activeDrawables = new HLinkedHashSet<HDrawable>();
		inactiveDrawables = new HLinkedHashSet<HDrawable>();
		prototypes = new ArrayList<HDrawable>();
	}
	
	public int max() {
		return maxDrawables;
	}
	
	public HDrawablePool max(int m) {
		maxDrawables = m;
		return this;
	}
	
	public int numActive() {
		return activeDrawables.getLength();
	}
	
	public int numInactive() {
		return inactiveDrawables.getLength();
	}
	
	public int currentIndex() {
		return activeDrawables.getLength() - 1;
	}
	
	public HLayout layout() {
		return currentLayout;
	}
	
	public HDrawablePool layout(HLayout newLayout) {
		currentLayout = newLayout;
		return this;
	}
	
	public HColorist colorist() {
		return currentColorist;
	}
	
	public HDrawablePool colorist(HColorist newColorist) {
		currentColorist = newColorist;
		return this;
	}
	
	public HDrawablePool setOnCreate(HCallback callback) {
		onCreateCallback = callback;
		return this;
	}
	
	public HDrawablePool listener(HPoolListener newListener) {
		currentListener = newListener;
		return this;
	}
	
	public HPoolListener listener() {
		return currentListener;
	}
	
	public HDrawablePool setOnRequest(HCallback callback) {
		onRequestCallback = callback;
		return this;
	}
	
	public HDrawablePool setOnRelease(HCallback callback) {
		onReleaseCallback = callback;
		return this;
	}
	
	public HDrawablePool autoParent(HDrawable parent) {
		currentAutoParent = parent;
		return this;
	}
	
	public HDrawablePool autoAddToStage() {
		currentAutoParent = H.stage();
		return this;
	}
	
	public HDrawable autoParent() {
		return currentAutoParent;
	}
	
	public boolean isFull() {
		return maxDrawables <= count();
	}
	
	public int count() {
		return activeDrawables.getLength() + inactiveDrawables.getLength();
	}
	
	public HDrawablePool destroy() {
		activeDrawables.removeAll();
		inactiveDrawables.removeAll();
		prototypes.clear();
		
		onCreateCallback = onRequestCallback = onReleaseCallback = null;
		currentLayout = null;
		currentAutoParent = null;
		maxDrawables = 0;
		
		return this;
	}
	
	public HDrawablePool add(HDrawable prototype, int frequency) {
		if(prototype == null) {
			H.app().println("Invalid Argument on HObjectPool.add(): " +
				"Your prototype is null!");
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
			H.app().println("HDrawablePool.request(): " +
				"can't create a new object without a prototype.");
			return null;
		}
		
		HDrawable drawable;
		boolean onCreateFlag = false;
		
		if(inactiveDrawables.getLength() > 0) {
			drawable = inactiveDrawables.pull();
		} else if(count() < maxDrawables) {
			drawable = createRandomDrawable();
			onCreateFlag = true;
		} else return null;
		
		activeDrawables.add(drawable);
		if(currentAutoParent != null)
			currentAutoParent.add(drawable);
		if(currentLayout != null)
			currentLayout.applyTo(drawable);
		if(currentColorist != null)
			currentColorist.applyColor(drawable);
		if(currentListener != null) {
			int index = currentIndex();
			if(onCreateFlag)
				currentListener.onCreate(drawable, index, this);
			currentListener.onRequest(drawable, index, this);
		}
		if(onCreateFlag && onCreateCallback != null)
			onCreateCallback.run(drawable);
		if(onRequestCallback != null)
			onRequestCallback.run(drawable);
		return drawable;
	}
	
	public HDrawablePool requestAll() {
		while(count() < maxDrawables) request();
		return this;
	}
	
	public boolean release(HDrawable d) {
		if(activeDrawables.remove(d)) {
			inactiveDrawables.add(d);
			
			if(currentAutoParent != null)
				currentAutoParent.remove(d);
			
			if(currentListener != null)
				currentListener.onRelease(d, currentIndex(), this);
			if(onReleaseCallback != null)
				onReleaseCallback.run(d);
			return true;
		}
		return false;
	}
	
	public HLinkedHashSet<HDrawable> activeSet() {
		return activeDrawables;
	}
	
	public HLinkedHashSet<HDrawable> inactiveSet() {
		return inactiveDrawables;
	}
	
	protected HDrawable createRandomDrawable() {
		PApplet app = H.app();
		int numPrototypes = prototypes.size();
		int index = app.round( app.random(numPrototypes-1) );
		return prototypes.get(index).createCopy();
	}

	public HIterator<HDrawable> iterator() {
		return activeDrawables.iterator();
	}
}
