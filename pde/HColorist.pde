/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static interface HColorist {
	public HColorist fillOnly();
	public HColorist strokeOnly();
	public HColorist fillAndStroke();
	public boolean appliesFill();
	public boolean appliesStroke();
	public HDrawable applyColor(HDrawable drawable);
}
