package hype.interfaces;

public interface HLocatable {
	public float x();
	public float y();
	public HLocatable move(float dx, float dy);
}
