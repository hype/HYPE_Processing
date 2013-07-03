class Mover extends HEllipse {
	HVelocity acceleration;

	Mover() {
		this
			.loc( new PVector(width/2, height/2) )
			.stroke(0)
			.fill(175)
			.size(30)
			.anchorAt(H.CENTER)
		;

		acceleration = new HVelocity().limit(10).target(this);

		CheckEdges checkEdges = new CheckEdges();
    	checkEdges.target(this);
	}

	public Mover createCopy() {
		Mover copy = new Mover();
		copy.acceleration = acceleration;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public void draw( PGraphics g, boolean usesZ, float drawX,float drawY,float alphaPc) {
		acceleration
			.accel(PVector.random2D());
		println(acceleration.accel());
		super.draw(g, usesZ, drawX, drawY, alphaPc);
	}
}