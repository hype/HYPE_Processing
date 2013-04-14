package hype.drawable;

import processing.core.PApplet;

public class HGroup extends HDrawable {
	
	@Override
	public HGroup createCopy() {
		HGroup copy = new HGroup();
		copy.copyPropertiesFrom(this);
		return copy;
	}
	
	@Override
	public void paintAll(PApplet app, float currAlphaPerc) {
		if(_alpha<=0 || _width<=0 || _height<=0) return;
		
		// Perform a trimmed down version of super.paintAll()Ê
		app.pushMatrix();
			app.translate(_x,_y);
			app.rotate(_rotationRad);
			
			currAlphaPerc *= _alpha;
			
			HDrawable child = _firstChild;
			while(child != null) {
				child.paintAll(app,currAlphaPerc);
				child = child.next();
			}
		app.popMatrix();
	}
	
	@Override
	public void draw(PApplet app,float drawX,float drawY,float currAlphaPerc) {}
}
