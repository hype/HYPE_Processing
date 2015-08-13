package hype.core.layout;

import hype.core.drawable.HDrawable;
import processing.core.PVector;

public interface HLayout {
	public void applyTo(HDrawable target);
	public abstract PVector getNextPoint();
}
