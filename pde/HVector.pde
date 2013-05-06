public static class HVector extends PVector implements HLocatable {
	private static final long serialVersionUID = 1;
	public HVector() {
		super();
	}
	public HVector(float xCoord, float yCoord) {
		super(xCoord, yCoord);
	}
	public HVector(float xCoord, float yCoord, float zCoord) {
		super(xCoord, yCoord, zCoord);
	}
	public float x() {
		return super.x;
	}
	public HVector x(float newX) {
		super.x = newX;
		return this;
	}
	public float y() {
		return super.y;
	}
	public HVector y(float newY) {
		super.y = newY;
		return this;
	}
	public float z() {
		return super.z;
	}
	public HVector z(float newZ) {
		super.z = newZ;
		return this;
	}
}
