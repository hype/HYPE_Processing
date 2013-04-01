

public static class HStage extends HDrawable {
	protected PApplet _app;
	protected HLinkedHashSet<HBehavior> _behaviors;
	protected PImage _bgImg;
	protected int _bgColor;
	protected boolean _autoClearFlag, _mouseStarted;
	
	public HStage(PApplet papplet) {
		_app = papplet;
		
		_children = new HChildSet(this);
		_behaviors = new HLinkedHashSet<HBehavior>();
		
		_bgColor = H.DEFAULT_BACKGROUND_COLOR;
		_autoClearFlag = true;
	}
	
	public HLinkedHashSet<HBehavior> behaviors() {
		return _behaviors;
	}
	
	public HDrawable createCopy() {
		return null;
	}
	
	public void background(int clr) {
		_bgColor = clr;
		clear();
	}
	
	public void backgroundImg(Object arg) {
		if(arg instanceof String) {
			_bgImg = _app.loadImage((String) arg);
		} else if(arg instanceof PImage) {
			_bgImg = (PImage) arg;
		}
		clear();
	}
	
	public HStage autoClear(boolean b) {
		_autoClearFlag = b;
		return this;
	}
	
	public boolean autoClear() {
		return _autoClearFlag;
	}
	
	public HStage clear() {
		if(_bgImg == null) _app.background(_bgColor);
		else _app.background(_bgImg);
		return this;
	}
	
	public PVector size() {
		return new PVector(_app.width,_app.height);
	}
	
	public float width() {
		return _app.width;
	}
	
	public float height() {
		return _app.height;
	}
	
	public float followableX() {
		return _app.mouseX;
	}
	
	public float followableY() {
		return _app.mouseY;
	}
	
	public boolean mouseStarted() {
		return _mouseStarted;
	}
	
	public void paintAll(PApplet app, int currAlpha) {
		if(!_mouseStarted && _app.pmouseX+_app.pmouseY > 0)
			_mouseStarted = true;
		
		if(_behaviors.getLength()>0) {
			HIterator<HBehavior> bIt = _behaviors.iterator();
			while(bIt.hasNext()) bIt.next().runBehavior();
		}
		
		app.pushStyle();
			if(_autoClearFlag) clear();
			
			if(_children.getLength()>0) {
				HIterator<HDrawable> cIt = _children.iterator();
				while(cIt.hasNext()) cIt.next().paintAll(app,255);
			}
		app.popStyle();
	}
	
	public void draw(PApplet app, float drawX, float drawY, int currAlpha) {}

}
