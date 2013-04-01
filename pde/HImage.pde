

public static class HImage extends HDrawable {
	protected PImage _image;

	public HImage() {}
	
	public HImage(Object imgArg) {
		image(imgArg);
	}
	
	public HImage createCopy() {
		HImage copy = new HImage(_image);
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	public HImage resetSize() {
		if(_image == null) {
			size(0f,0f);
		} else {
			size(_image.width, _image.height);
		}
		return this;
	}
	
	public HImage image(Object imgArg) {
		if(imgArg instanceof PImage) {
			_image = (PImage) imgArg;
		} else if(imgArg instanceof String) {
			_image = H.app().loadImage((String) imgArg);
		} else if(imgArg instanceof HImage) {
			_image = ((HImage) imgArg)._image;
		} else if(imgArg == null) {
			_image = null;
		}
		return resetSize();
	}
	
	public PImage image() {
		return _image;
	}
	
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {
		if(_image==null) return;
		app.tint(currAlpha);
		app.image(_image,drawX,drawY);
	}
}
