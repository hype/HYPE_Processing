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

package hype.extended.drawable;

import hype.core.drawable.HDrawable;
import hype.core.util.H;
import hype.core.util.HConstants;
import processing.core.PApplet;
import processing.core.PFont;
import processing.core.PGraphics;

public class HText extends HDrawable {
	private PFont _font;
	private String _text;
	private float _descent;
	
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
		_fill = HConstants.BLACK;
		_stroke = HConstants.CLEAR;
	}
	
	@Override
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
				app.loadFont(str) : app.createFont(str,64);
		} else if(arg instanceof HText) {
			_font = ((HText) arg)._font;
		} else if(arg == null) {
			_font = app.createFont("SansSerif",64);
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
	
	private void adjustMetrics() {
		PApplet app = H.app();
		app.pushStyle();
		app.textFont(_font,(_height < 0)? -_height : _height);
		
		_descent = app.textDescent();
		_width = (_text==null)? 0 :
			(_width<0)? -app.textWidth(_text) : app.textWidth(_text);
		
		app.popStyle();
	}

	@Override
	public HText width(float w) {
		if(w<0 == _width>0) _width = -_width;
		return this;
	}

	@Override
	public HText height(float h) {
		_height = h;
		adjustMetrics();
		return this;
	}
	
	@Override
	public boolean containsRel(float relX, float relY) {
		if(_text == null || _height == 0) return false;
		int numChars = _text.length();
		float ratio = 64 / _height;
		float xoff = 0;
		float yoff = (_height - _descent) * ratio;
		relX *= ratio;
		relY *= ratio;
		
		for(int i=0; i<numChars; ++i) {
			char c = _text.charAt(i);
			PFont.Glyph g = _font.getGlyph(c);
			
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
		if(_text == null) return;
		
		applyStyle(g,alphaPc);
		
		// Determine whether this text will be flipped
		int wscale = 1;
		int hscale = 1;
		float h = _height;
		if(_width < 0) {
			wscale = -1;
			drawX = -drawX;
		}
		if(_height < 0) {
			h = -_height;
			hscale = -1;
			drawY = -drawY;
		}
		
		g.pushMatrix();
			g.scale(wscale, hscale);
			g.textFont(_font,h);
			g.text(_text,drawX,drawY+h-_descent);
		g.popMatrix();
	}
}
