class HShapeLayout extends HAbstractLayout {
	private int x, y;
	private PShape target;
	
	// -- //
	
	public HShapeLayout(PShape target) {
		this.target = target;
	}
	
	public HShapeLayout(PShape target, int x, int y) {
		this(target);
		this.x = x;
		this.y = y;
	}
	
	// -- //
	
	public HShapeLayout setX(int x) {
		this.x = x;
		return this;
	}
	
	public int getX() {
		return x;
	}
	
	public HShapeLayout setY(int y) {
		this.y = y;
		return this;
	}
	
	public int getY() {
		return y;
	}
	
	// -- //
	
	@Override
	public PVector getNextPoint() {
		PVector pt = null;
		
		do {
			int rx = round(random(0,target.width));
			int ry = round(random(0,target.height));
			rx += x;
			ry += y;
			if(target.contains(rx,ry)) {
				pt = new PVector(rx,ry);
			}
		} while(pt == null);
		
		return pt;
	}
}