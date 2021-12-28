package hype.interfaces;

import hype.HDrawable;
import processing.core.PVector;

public interface HLayout {
	public void applyTo(HDrawable target);
	public abstract PVector getNextPoint();
}
