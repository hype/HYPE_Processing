package hype.interfaces;

public interface HHittable {
	public boolean contains(float absX, float absY, float absZ);
	public boolean contains(float absX, float absY);
	public boolean containsRel(float relX, float relY, float relZ);
	public boolean containsRel(float relX, float relY);
}
