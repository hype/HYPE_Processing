package hype.util;

import processing.core.PConstants;

public interface HConstants {
	public static final int
		// Generic constants
		NONE = 0,
		SIN = 1,
		COS = 2,
		TAN = 3,
		
		// "where" constants (as used in locAt() & anchorAt())
		LEFT   = 1, // 0b0001
		RIGHT  = 2, // 0b0010
		TOP    = 4, // 0b0100
		BOTTOM = 8, // 0b1000
		CENTER_X = 3, // 0b0011
		CENTER_Y = 12, // 0b1100
		CENTER = 15, // 0b1111
		
		// DEFAULT COLORS
		DEFAULT_BACKGROUND_COLOR = 0xFFECF2F5,
		DEFAULT_FILL = 0x00FFFFFF,
		DEFAULT_STROKE = 0x00FFFFFF,
		
		// Oscillation types
		SAW = 0,
		SINE = 1,
		TRIANGLE = 2,
		SQUARE = 3,
		
		// HDrawable property identifiers
		WIDTH = 0,
		HEIGHT = 1,
		SIZE = 2,
		ALPHA = 3,
		X = 4,
		Y = 5,
		LOCATION = 6,
		ROTATION = 7,
		DROTATION = 8,
		DX = 9,
		DY = 10,
		DLOC = 11,
		SCALE = 12;
	
	public static final float
		// Degree-Radians conversion shortcuts
		D2R = PConstants.PI / 180f,
		R2D = 180f / PConstants.PI;
}
