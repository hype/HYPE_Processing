package hype.interfaces;

import hype.HCallback;
import processing.core.PConstants;

public interface HConstants {
	public static final int
		// Generic constants
		NONE = 0,

		// Where constants
		LEFT = 1,		// 0b0001
		RIGHT = 2,		// 0b0010
		CENTER_X = 3,	// 0b0011

		TOP = 4,		// 0b0100
		BOTTOM = 8,		// 0b1000
		CENTER_Y = 12,	// 0b1100

		BACK = 16,		// 0001 0000
		FRONT = 32,		// 0010 0000
		CENTER_Z = 48,	// 0011 0000

		CENTER = 63,	// 0011 1111

		TOP_LEFT = 5,	// 0b0101
		TOP_RIGHT = 6,	// 0b0110

		BOTTOM_LEFT = 9,	// 0b1001
		BOTTOM_RIGHT = 10,	// 0b1010

		CENTER_LEFT = 13,	// 0b1101
		CENTER_RIGHT = 14,	// 0b1110

		CENTER_TOP = 7,		// 0b0111
		CENTER_BOTTOM = 11,	// 0b1011

		// Colors
		DEFAULT_BACKGROUND_COLOR = 0xFFECF2F5,
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
		Z = 6,
		LOCATION = 7,
		ROTATION = 8,
		DROTATION = 9,
		DX = 10,
		DY = 11,
		DZ = 12,
		DLOC = 13,
		SCALE = 14,
		ROTATIONX = 15,
		ROTATIONY = 16,
		ROTATIONZ = 8,
		DROTATIONX = 17,
		DROTATIONY = 18,
		DROTATIONZ = 9,

		// HTriangle types
		ISOCELES = 0,
		EQUILATERAL = 1,
		// RIGHT = 2,

		// Bitmasks
		ONES = 0xFFFFFFFF,
		ZEROES = 0;

	public static final float
		// Degree-Radians conversion shortcuts
		D2R = PConstants.PI / 180f,
		R2D = 180f / PConstants.PI,

		// Misc Math constants
		SQRT2 = 1.4142135623730951f,
		PHI = 1.618033988749895f,
		PHI_1 = 0.618033988749895f,
		TOLERANCE = (float)10e-6,
		EPSILON = (float)10e-12;

	public static final HCallback
		NOP = new HCallback() {public void run(Object obj) {}};
}
