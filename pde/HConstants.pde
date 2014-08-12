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
public static interface HConstants {
	public static final int
		NONE = 0,
		LEFT = 1,		
		RIGHT = 2,		
		CENTER_X = 3,	
		TOP = 4,		
		BOTTOM = 8,		
		CENTER_Y = 12,	
		BACK = 16,		
		FRONT = 32,		
		CENTER_Z = 48,	
		CENTER = 63,	
		TOP_LEFT = 5,	
		TOP_RIGHT = 6,	
		BOTTOM_LEFT = 9,	
		BOTTOM_RIGHT = 10,	
		CENTER_LEFT = 13,	
		CENTER_RIGHT = 14,	
		CENTER_TOP = 7,		
		CENTER_BOTTOM = 11,	
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
		SAW = 0,
		SINE = 1,
		TRIANGLE = 2,
		SQUARE = 3,
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
		ISOCELES = 0,
		EQUILATERAL = 1,
		ONES = 0xFFFFFFFF,
		ZEROES = 0;
	public static final float
		D2R = PConstants.PI / 180f,
		R2D = 180f / PConstants.PI,
		SQRT2 = 1.4142135623730951f,
		PHI = 1.618033988749895f,
		PHI_1 = 0.618033988749895f,
		TOLERANCE = (float)10e-6,
		EPSILON = (float)10e-12;
	public static final HCallback
		NOP = new HCallback() {public void run(Object obj) {}};
}
