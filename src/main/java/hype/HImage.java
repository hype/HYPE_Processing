package hype;

import hype.interfaces.HImageHolder;
import processing.core.PGraphics;
import processing.core.PImage;

public class HImage extends HDrawable implements HImageHolder {
	private PImage image;

	public HImage() {
		this(null);
	}

	public HImage(Object imgArg) {
		image(imgArg);
	}

	@Override
	public HImage createCopy() {
		HImage copy = new HImage(image);
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public HImage resetSize() {
		if(image == null) size(0f,0f);
		else size(image.width, image.height);
		return this;
	}

	public HImage image(Object imgArg) {
		image = H.getImage(imgArg);
		return resetSize();
	}

	public PImage image() {
		return image;
	}

	public HImage tint(int clr) {
		fill(clr);
		return this;
	}

	public HImage tint(int clr, int alpha) {
		fill(clr, alpha);
		return this;
	}

	public HImage tint(int r, int g, int b) {
		fill(r,g,b);
		return this;
	}

	public HImage tint(int r, int g, int b, int a) {
		fill(r,g,b,a);
		return this;

	}

	public int tint() {
		return fill();
	}

	@Override
	public boolean containsRel(float relX, float relY) {
		if(image == null ||
				image.width <= 0 || image.height <= 0 ||
				width <= 0 || height <= 0)
			return false;
		int ix = Math.round(relX * image.width/ width);
		int iy = Math.round(relY * image.height/ height);
		return (0 < image.get(ix,iy)>>>24);
	}

	@Override
	public void draw( PGraphics g, boolean usesZ,
		float drawX, float drawY, float alphaPc
	) {
		if(image ==null) return;

		// This awkward alpha separation is due to pjs compatibility issues
		alphaPc *= (fill >>>24);
		g.tint( fill | 0xFF000000, Math.round(alphaPc) );

		// Determine if the image will be flipped
		int wscale = 1;
		int hscale = 1;
		float w = width;
		float h = height;
		if(width < 0) {
			w = -width;
			wscale = -1;
			drawX = -drawX;
		}
		if(height < 0) {
			h = -height;
			hscale = -1;
			drawY = -drawY;
		}

		// Flip and draw the image
		g.pushMatrix();
			g.scale(wscale, hscale);
			g.image(image, drawX,drawY, w,h);
		g.popMatrix();
	}
}
