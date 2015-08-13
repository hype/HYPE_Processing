package hype.core.colorist;

import hype.core.drawable.HDrawable;

public interface HColorist {
	public HColorist fillOnly();
	public HColorist strokeOnly();
	public HColorist fillAndStroke();
	public boolean appliesFill();
	public boolean appliesStroke();
	public HDrawable applyColor(HDrawable drawable);
}
