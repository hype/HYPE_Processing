

public static interface HLayout {
	public void applyTo(HDrawable target);
	public abstract PVector getNextPoint();
}
