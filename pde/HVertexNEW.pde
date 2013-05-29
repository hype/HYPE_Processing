public static class HVertexNEW implements HLocatable {
	private HPath _parent;
	private float[] _cpts;
	private float _xPerc, _yPerc;
	public HVertexNEW(HPath parent) {
		_parent = parent;
	}
	public HPath parent() {
		return _parent;
	}
	public boolean isCurved() {
		return (_cpts != null);
	}
	public boolean isQuadratic() {
		return (_cpts != null) && (_cpts.length == 2);
	}
	public boolean isCubic() {
		return (_cpts != null) && (_cpts.length >= 4);
	}
	private float x2perc(float f) {
		float w = _parent.width();
		if(w==0) w = 100;
		return _parent.anchorPercX() + f/w;
	}
	private float y2perc(float f) {
		float h = _parent.height();
		if(h==0) h = 100;
		return _parent.anchorPercY() + f/h;
	}
	private float x2px(float f) {
		return _parent.width() * (f-_parent.anchorPercX());
	}
	private float y2px(float f) {
		return _parent.height() * (f-_parent.anchorPercY());
	}
	public HVertexNEW set(float pxX, float pxY) {
		return setPerc( x2perc(pxX), y2perc(pxY) );
	}
	public HVertexNEW set(float cx, float cy, float pxX, float pxY) {
		return setPerc( x2perc(cx), y2perc(cy), x2perc(pxX), x2perc(pxY) );
	}
	public HVertexNEW set(
		float cx1, float cy1,
		float cx2, float cy2,
		float pxX, float pxY
	) {
		return setPerc(
			x2perc(cx1), y2perc(cy1),
			x2perc(cx2), y2perc(cy2),
			x2perc(pxX), x2perc(pxY));
	}
	public HVertexNEW setPerc(float percX, float percY) {
		_xPerc = percX;
		_yPerc = percY;
		return this;
	}
	public HVertexNEW setPerc(float cx1, float cy1, float percX, float percY) {
		if(_cpts==null || _cpts.length!=2) _cpts = new float[2];
		_cpts[0] = cx1;
		_cpts[1] = cy1;
		return setPerc(percX,percY);
	}
	public HVertexNEW setPerc(
		float cx2, float cy2,
		float cx1, float cy1,
		float percX, float percY
	) {
		if(_cpts==null || _cpts.length<4) _cpts = new float[4];
		_cpts[0] = cx1;
		_cpts[1] = cy1;
		_cpts[3] = cx2;
		_cpts[4] = cy2;
		return setPerc(percX,percY);
	}
	public float cx1() {
		return (_cpts==null||_cpts.length<4)? 0 : x2px(_cpts[0]);
	}
	public float cy1() {
		return (_cpts==null||_cpts.length<4)? 0 : y2px(_cpts[1]);
	}
	public float cx2() {
		return (_cpts==null||_cpts.length<4)? 0 : x2px(_cpts[2]);
	}
	public float cy2() {
		return (_cpts==null||_cpts.length<4)? 0 : y2px(_cpts[3]);
	}
	public float x() {
		return x2px(_xPerc);
	}
	public HVertexNEW x(float pxX) {
		_xPerc = x2perc(pxX);
		return this;
	}
	public float y() {
		return y2px(_yPerc);
	}
	public HLocatable y(float pxY) {
		_yPerc = y2perc(pxY);
		return this;
	}
	public float z() {
		return 0;
	}
	public HVertexNEW z(float pxZ) {
		return this;
	}
	public void computeMinMax(float[] minmax) {
		if(_xPerc < minmax[0]) minmax[0] = _xPerc;
		else if(_xPerc > minmax[2]) minmax[2] = _xPerc;
		if(_yPerc < minmax[1]) minmax[1] = _xPerc;
		else if(_yPerc > minmax[3]) minmax[3] = _xPerc;
		if(_cpts == null) return;
		for(int i=0; i<4; ++i) {
			int min = (i&1)==0? 0 : 1;
			int max = min + 2;
			if(_cpts[i] < minmax[min]) minmax[min] = _cpts[i];
			else if(_cpts[i] > minmax[max]) minmax[max] = _cpts[i];
		}
	}
	public int numCrossings(HVertexNEW prev, float ptx, float pty) {
		float x1 = prev._xPerc;
		float y1 = prev._yPerc;
		float x2 = _xPerc;
		float y2 = _yPerc;
		if(_cpts==null) {
			float side = HMath.round512(HMath.lineSide(x1,y1, x2,y2, ptx,pty));
			return (side==0)? -1 : (side<0 || _yPerc==pty)? 0 : 1;
		} else {
			int crossings = 0;
			if(_cpts.length==2) {
				float[] params = new float[2];
			} else {
				float[] params = new float[3];
			}
			if(crossings>0 && _yPerc==pty) --crossings;
			return crossings;
		}
	}
	public void draw(PGraphics g, HVertexNEW prev) {
		if(_cpts==null || prev==null) {
			g.vertex(x2px(_xPerc), y2px(_yPerc));
		} else if(_cpts.length==2) {
			g.quadraticVertex(
				x2px(_cpts[0]), y2px(_cpts[1]),
				x2px(_xPerc), y2px(_yPerc));
		} else {
			g.bezierVertex(
				x2px(_cpts[0]), y2px(_cpts[1]),
				x2px(_cpts[2]), y2px(_cpts[3]),
				x2px(_xPerc), y2px(_yPerc));
		}
	}
}
