package hype.interfaces;

public interface HRotatable {
	public float rotationRad();
	public HRotatable rotationRad(float rad); //retained for backwards compatibility
	public float rotationXRad();
	public HRotatable rotationXRad(float radx);
	public float rotationYRad();
	public HRotatable rotationYRad(float radx);
	public float rotationZRad();
	public HRotatable rotationZRad(float radz);
}
