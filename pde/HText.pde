public static class HText extends HDrawable {
	protected PFont _font;
	protected String _text;
	protected float _descent;
	public HText() {
		this(null,16);
	}
	public HText(String textString) {
		this(textString,16,null);
	}
	public HText(String textString, float size) {
		this(textString,size,null);
	}
	public HText(String textString, float size, Object fontArg) {
		_text = textString;
		_height = size;
		font(fontArg);
		height(size);
	}
	public HText createCopy() {
		HText copy = new HText(_text,_height,_font);
		copy.copyPropertiesFrom(this);
		copy.adjustMetrics();
		return copy;
	}
	public HText text(String txt) {
		_text = txt;
		adjustMetrics();
		return this;
	}
	public String text() {
		return _text;
	}
	public HText font(Object arg) {
		PApplet app = H.app();
		if(arg instanceof PFont) {
			_font = (PFont) arg;
		} else if(arg instanceof String) {
			String str = (String) arg;
			_font = (str.indexOf(".vlw",str.length()-4) > 0)?
				app.loadFont(str) : app.createFont(str,_height);
		} else if(arg instanceof HText) {
			_font = ((HText) arg)._font;
		} else if(arg == null) {
			_font = app.createFont("SansSerif",_height);
		}
		adjustMetrics();
		return this;
	}
	public PFont font() {
		return _font;
	}
	public HText fontSize(float f) {
		return height(f);
	}
	public float fontSize() {
		return _height;
	}
	protected void adjustMetrics() {
		PApplet app = H.app();
		app.pushStyle();
		app.textFont(_font,_height);
		_descent = app.textDescent();
		super.width( (_text==null)? 0 : app.textWidth(_text) );
		app.popStyle();
	}
	public HText width(float w) {
		return this;
	}
	public HText height(float h) {
		super.height(h);
		adjustMetrics();
		return this;
	}
	public HText size(float w, float h) {
		return height(h);
	}
	public HText size(float s) {
		return height(s);
	}
	public HText scale(float s) {
		super.scale(s);
		adjustMetrics();
		return this;
	}
	public HText scale(float sw, float sh) {
		return scale(sh);
	}
	public boolean containsRel(float relX, float relY) {
		if(_text == null || _height == 0) return false;
		PApplet app = H.app();
		int numChars = _text.length();
		float ratio = _font.getSize() / _height;
		float xoff = 0;
		float yoff = (_height - _descent) * ratio;
		relX *= ratio;
		relY *= ratio;
		for(int i=0; i<numChars; ++i) {
			char c = _text.charAt(i);
			PFont.Glyph g = _font.getGlyph(c);
			int pxx = app.round(relX - xoff);
			int pxy = app.round(relY - yoff) + g.topExtent;
			if(g.image.get(pxx, pxy)>>>24 > 0) return true;
			xoff += g.setWidth;
		}
		return false;
	} 
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {
		if(_text == null) return;
		applyStyle(app,currAlphaPerc);
		app.textFont(_font,_height);
		app.text(_text,drawX,drawY+_height-_descent);
	}
}
