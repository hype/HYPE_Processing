public static class HPath extends HDrawable {
	protected ArrayList<HVertex> _vertices;
	protected int _mode;
	public HPath() {
		this(PConstants.PATH);
	}
	public HPath(int pathMode) {
		_vertices = new ArrayList<HPath.HVertex>();
		_mode = pathMode;
	}
	public HPath createCopy() {
		HPath copy = new HPath();
		copy.copyPropertiesFrom(this);
		for(int i=0; i<_vertices.size(); ++i) {
			HVertex v = _vertices.get(i);
			copy.vertexPerc(v.x, v.y,
				v.hx1, v.hy1,
				v.hx2, v.hy2);
		}
		return copy;
	}
	public HPath mode(int m) {
		_mode = m;
		return this;
	}
	public int mode() {
		return _mode;
	}
	public HVertex vertex(int index) {
		return _vertices.get(index);
	}
	public HPath removeVertex(int index) {
		_vertices.remove(index);
		return this;
	}
	public int numVertices() {
		return _vertices.size();
	}
	public HPath adjustVertices() {
		int numVertices = _vertices.size();
		float minX, maxX, minY, maxY;
		minX = maxX = minY = maxY = 0;
		for(int i=0; i<numVertices; ++i) {
			HVertex v = _vertices.get(i);
			if(v.x < minX) minX = v.x;
			else if(v.x > maxX) maxX = v.x;
			if(v.y < minY) minY = v.y;
			else if(v.y > maxY) maxY = v.y;
		}
		float ratioX = maxX - minX;
		float ratioY = maxY - minY;
		scale(ratioX, ratioY);
		anchorPercX((ratioX==0)? 0 : -minX/ratioX);
		anchorPercY((ratioY==0)? 0 : -minY/ratioY);
		for(int j=0; j<numVertices; ++j) {
			HVertex w = _vertices.get(j);
			w.x -= minX;
			w.hx1 -= minX;
			w.hx2 -= minX;
			if(ratioX != 0) {
				w.x /= ratioX;
				w.hx1 /= ratioX;
				w.hx2 /= ratioX;
			}
			w.y -= minY;
			w.hy1 -= minY;
			w.hy2 -= minY;
			if(ratioY != 0) {
				w.y /= ratioY;
				w.hy1 /= ratioY;
				w.hy2 /= ratioY;
			}
		}
		return this;
	}
	public HPath vertex(float pxX, float pxY) {
		if(_height == 0 || _width == 0) {
			HWarnings.warn("Division by 0", "HPath.vertex()",
					HWarnings.VERTEXPX_ERR);
		} else {
			vertexPerc(pxX/_width, pxY/_height);
		}
		return this;
	}
	public HPath vertex(
		float handlePxX1, float handlePxY1,
		float handlePxX2, float handlePxY2,
		float pxX, float pxY
	) {
		if(_height == 0 || _width == 0) {
			HWarnings.warn("Division by 0", "HPath.vertex()",
					HWarnings.VERTEXPX_ERR);
		} else {
			vertexPerc(
				handlePxX1/_width, handlePxY1/_height,
				handlePxX2/_width, handlePxY2/_height,
				pxX/_width, pxY/_height);
		}
		return this;
	}
	public HPath vertexPerc(float percX, float percY) {
		HVertex v = new HVertex();
		v.x = v.hx1 = v.hx2 = percX;
		v.y = v.hy1 = v.hy2 = percY;
		_vertices.add(v);
		return this;
	}
	public HPath vertexPerc(
		float handlePercX1, float handlePercY1,
		float handlePercX2, float handlePercY2,
		float percX, float percY
	) {
		HVertex v = new HVertex();
		v.isBezier = true;
		v.x = percX;
		v.y = percY;
		v.hx1 = handlePercX1;
		v.hy1 = handlePercY1;
		v.hx2 = handlePercX2;
		v.hy2 = handlePercY2;
		_vertices.add(v);
		return this;
	}
	public HPath polygon(int numEdges) {
		_vertices.clear();
		PApplet app = H.app();
		float radInc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = radInc * i;
			vertexPerc(
				0.5f + 0.5f*app.cos(rad),
				0.5f + 0.5f*app.sin(rad));
		}
		_mode = PConstants.POLYGON;
		return this;
	}
	public HPath star(int numEdges, float depth) {
		_vertices.clear();
		PApplet app = H.app();
		float radInc = PConstants.TWO_PI / numEdges;
		for(int i=0; i<numEdges; ++i) {
			float rad = radInc * i;
			vertexPerc(
				0.5f + 0.5f*app.cos(rad),
				0.5f + 0.5f*app.sin(rad));
			rad = radInc * (i + 0.5f);
			vertexPerc(
				0.5f + 0.5f*app.cos(rad)*(1-depth),
				0.5f + 0.5f*app.sin(rad)*(1-depth));
		}
		_mode = PConstants.POLYGON;
		return this;
	}
	public HPath clear() {
		_vertices.clear();
		return this;
	}
	public boolean containsRel(float relX, float relY) {
		boolean isIn = false;
		float xPerc = relX / _width;
		float yPerc = relY / _height;
		for(int i=0; i<numVertices(); ++i) {
			HVertex v1 = _vertices.get(i);
			HVertex v2 = _vertices.get((i>=numVertices()-1)? 0 : i+1);
			if((v1.y<yPerc && yPerc<=v2.y) || (v2.y<yPerc && yPerc<=v1.y)) {
				float t = (yPerc-v1.y) / (v2.y - v1.y);
				float currX = v1.x + (v2.x-v1.x)*t;
				if(currX == xPerc) return true;
				if(currX < xPerc) isIn = !isIn;
			}
		}
		return isIn;
	}
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {
		int numVertices = _vertices.size();
		if(numVertices <= 0) return;
		applyStyle(app,currAlphaPerc);
		if(_mode == PConstants.POINTS) app.beginShape(PConstants.POINTS);
		else app.beginShape();
		boolean startFlag = true;
		for(int i=0; i<numVertices; ++i) {
			HVertex v = _vertices.get(i);
			float x = drawX + _width*v.x;
			float y = drawY + _height*v.y;
			if(!v.isBezier || _mode == PConstants.POINTS || startFlag) {
				app.vertex(x,y);
			} else {
				float hx1 = drawX + _width * v.hx1;
				float hy1 = drawY + _height* v.hy1;
				float hx2 = drawX + _width * v.hx2;
				float hy2 = drawY + _height* v.hy2;
				app.bezierVertex(hx1,hy1, hx2,hy2, x,y);
			}
			if(startFlag) startFlag = false;
			else if(i==0) break;
			if(_mode==PConstants.POLYGON && i>=numVertices-1) i = -1;
		}
		if(_mode == PConstants.POLYGON) app.endShape(PConstants.CLOSE);
		else app.endShape();
	}
	public static class HVertex {
		public float x, y, hx1, hy1, hx2, hy2;
		public boolean isBezier;
	}
}
