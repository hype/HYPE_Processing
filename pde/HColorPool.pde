public static class HColorPool implements HColorist {
	protected ArrayList<Integer> _colorList;
	protected boolean _fillFlag, _strokeFlag;
	public HColorPool(int... colors) {
		_colorList = new ArrayList<Integer>();
		for(int i=0; i<colors.length; ++i) add(colors[i]);
		fillAndStroke();
	}
	public HColorPool createCopy() {
		HColorPool copy = new HColorPool();
		copy._fillFlag = _fillFlag;
		copy._strokeFlag = _strokeFlag;
		for(int i=0; i<_colorList.size(); ++i) {
			int clr = _colorList.get(i);
			copy._colorList.add( clr );
		}
		return copy;
	}
	public int size() { 
		return _colorList.size();
	}
	public HColorPool add(int clr) {
		_colorList.add(clr);
		return this;
	}
	public HColorPool add(int clr, int freq) {
		while(freq-- > 0) _colorList.add(clr);
		return this;
	}
	public int getColor() {
		if(_colorList.size() <= 0) return 0;
		PApplet app = H.app();
		int index = app.floor(app.random(_colorList.size()));
		return _colorList.get(index);
	}
	public int getColor(int seed) {
		HMath.tempSeed(seed);
		int clr = getColor();
		HMath.removeTempSeed();
		return clr;
	}
	public HColorPool fillOnly() {
		_fillFlag = true;
		_strokeFlag = false;
		return this;
	}
	public HColorPool strokeOnly() {
		_fillFlag = false;
		_strokeFlag = true;
		return this;
	}
	public HColorPool fillAndStroke() {
		_fillFlag = _strokeFlag = true;
		return this;
	}
	public boolean appliesFill() {
		return _fillFlag;
	}
	public boolean appliesStroke() {
		return _strokeFlag;
	}
	public HDrawable applyColor(HDrawable drawable) {
		if(_fillFlag)
			drawable.fill(getColor());
		if(_strokeFlag)
			drawable.stroke(getColor());
		return drawable;
	}
}
