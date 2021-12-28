package hype.interfaces;

public interface HRotatable {
	float rotationRad();
	float rotationXRad();
	float rotationYRad();
	float rotationZRad();

	HRotatable rotationRad(float rad); //retained for backwards compatibility
	HRotatable rotationXRad(float radx);
	HRotatable rotationYRad(float rady);
	HRotatable rotationZRad(float radz);
}
