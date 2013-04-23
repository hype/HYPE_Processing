package hype.util;

import processing.core.PConstants;

public interface HConstants {
	public static final int
		// Generic constants
		NONE = 0,
		
		// "where" constants (as used in locAt() & anchorAt())
		LEFT = 1,		// 0b0001
		RIGHT = 2,		// 0b0010
		CENTER_X = 3,	// 0b0011
		
		TOP = 4,		// 0b0100
		BOTTOM = 8,		// 0b1000
		CENTER_Y = 12,	// 0b1100
		
		CENTER = 15, // 0b1111
		
		TOP_LEFT = 5,	// 0b0101
		TOP_RIGHT = 6,	// 0b0110
		
		BOTTOM_LEFT = 9,	// 0b1001
		BOTTOM_RIGHT = 10,	// 0b1010
		
		CENTER_LEFT = 13,	// 0b1101
		CENTER_RIGHT = 14,	// 0b1110
		
		CENTER_TOP = 7,		// 0b0111
		CENTER_BOTTOM = 11,	// 0b1011
		
		// Defaults
		DEFAULT_BACKGROUND_COLOR = 0xFFECF2F5,
		DEFAULT_FILL = 0xFFFFFFFF,
		DEFAULT_STROKE = 0xFF000000,
		DEFAULT_WIDTH = 64,
		DEFAULT_HEIGHT = 64,
		
		// COLORS
		CLEAR	= 0x00FFFFFF,
		WHITE	= 0xFFFFFFFF,
		LGREY	= 0xFFC0C0C0,
		GREY	= 0xFF808080,
		DGREY	= 0xFF404040,
		BLACK	= 0xFF000000,
		RED		= 0xFFFF0000,
		GREEN	= 0xFF00FF00,
		BLUE	= 0xFF0000FF,
		CYAN	= 0xFF00FFFF,
		MAGENTA	= 0xFFFF00FF,
		YELLOW	= 0xFFFFFF00,
		
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
		SCALE = 12,
		
		// HTriangle types
		ISOCELES = 0,
		EQUILATERAL = 1;
	
	public static final float
		// Degree-Radians conversion shortcuts
		D2R = PConstants.PI / 180f,
		R2D = 180f / PConstants.PI;
}
