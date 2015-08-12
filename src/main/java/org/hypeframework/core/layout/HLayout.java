package org.hypeframework.core.layout;

import org.hypeframework.core.drawable.HDrawable;
import processing.core.PVector;

public interface HLayout {
	public void applyTo(HDrawable target);
	public abstract PVector getNextPoint();
}
