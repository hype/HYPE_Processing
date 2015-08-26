package hype;

import hype.interfaces.HConstants;
import processing.core.PApplet;
import processing.core.PFont;
import processing.core.PGraphics;

public class HText extends HDrawable {
	private PFont font;
	private String text;
	private float descent;

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
		text = textString;

		height = size;
		font(fontArg);

		height(size);
		fill = HConstants.BLACK;
		stroke = HConstants.CLEAR;
	}

	@Override
	public HText createCopy() {
		HText copy = new HText(text, height, font);
		copy.copyPropertiesFrom(this);
		copy.adjustMetrics();
		return copy;
	}

	public HText text(String txt) {
		text = txt;
		adjustMetrics();
		return this;
	}

	public String text() {
		return text;
	}

	public HText font(Object arg) {
		PApplet app = H.app();

		if(arg instanceof PFont) {
			font = (PFont) arg;
		} else if(arg instanceof String) {
			String str = (String) arg;
			font = (str.indexOf(".vlw",str.length()-4) > 0)?
				app.loadFont(str) : app.createFont(str,64);
		} else if(arg instanceof HText) {
			font = ((HText) arg).font;
		} else if(arg == null) {
			font = app.createFont("SansSerif",64);
		}
		adjustMetrics();
		return this;
	}

	public PFont font() {
		return font;
	}

	public HText fontSize(float f) {
		return height(f);
	}

	public float fontSize() {
		return height;
	}

	private void adjustMetrics() {
		PApplet app = H.app();
		app.pushStyle();
		app.textFont(font,(height < 0)? -height : height);

		descent = app.textDescent();
		width = (text ==null)? 0 :
			(width <0)? -app.textWidth(text) : app.textWidth(text);

		app.popStyle();
	}

	@Override
	public HText width(float w) {
		if(w<0 == width >0) width = -width;
		return this;
	}

	@Override
	public HText height(float h) {
		height = h;
		adjustMetrics();
		return this;
	}

	@Override
	public boolean containsRel(float relX, float relY) {
		if(text == null || height == 0) return false;
		int numChars = text.length();
		float ratio = 64 / height;
		float xoff = 0;
		float yoff = (height - descent) * ratio;
		relX *= ratio;
		relY *= ratio;

		for(int i=0; i<numChars; ++i) {
			char c = text.charAt(i);
			PFont.Glyph g = font.getGlyph(c);

			int pxx = Math.round(relX - xoff);
			int pxy = Math.round(relY - yoff) + g.topExtent;

			if(g.image.get(pxx, pxy)>>>24 > 0) return true;

			xoff += g.setWidth;
		}
		return false;
	}

	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float alphaPc
	) {
		if(text == null) return;

		applyStyle(g,alphaPc);

		// Determine whether this text will be flipped
		int wscale = 1;
		int hscale = 1;
		float h = height;
		if(width < 0) {
			wscale = -1;
			drawX = -drawX;
		}
		if(height < 0) {
			h = -height;
			hscale = -1;
			drawY = -drawY;
		}

		g.pushMatrix();
			g.scale(wscale, hscale);
			g.textFont(font,h);
			g.text(text,drawX,drawY+h- descent);
		g.popMatrix();
	}
}
