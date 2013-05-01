public static class HVector extends PVector implements HGoal {
	private static final long serialVersionUID = 1;
	public HVector() {
		super();
	}
	public HVector(float xCoord, float yCoord) {
		super(xCoord, yCoord);
	}
	public float x() {
		return x;
	}
	public float y() {
		return y;
	}
	public HVector move(float dx, float dy) {
		x += dx;
		y += dy;
		return this;
	}
	public float followableX() {
		return x;
	}
	public float followableY() {
		return y;
	}
}
