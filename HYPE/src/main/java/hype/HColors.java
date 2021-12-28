package hype;

import hype.interfaces.HConstants;

public class HColors implements HConstants {
	public static int[] explode(int clr) {
		int[] explodedColors = new int[4];
		for(int i=0; i<4; ++i)
			explodedColors[3-i] = (clr >>> (i*8)) & 0xFF;
		return explodedColors;
	}

	public static int merge(int a, int r, int g, int b) {
		if(a < 0) a = 0;
		else if(a > 255) a = 255;

		if(r < 0) r = 0;
		else if(r > 255) r = 255;

		if(g < 0) g = 0;
		else if(g > 255) g = 255;

		if(b < 0) b = 0;
		else if(b > 255) b = 255;

		return (a<<24) | (r<<16) | (g<<8) | b;
	}

	public static int setAlpha(int clr, int newClr) {
		if(newClr < 0) newClr = 0;
		else if(newClr > 255) newClr = 255;
		return clr & 0x00FFFFFF | (newClr << 24);
	}

	public static int setRed(int clr, int newClr) {
		if(newClr < 0) newClr = 0;
		else if(newClr > 255) newClr = 255;
		return clr & 0xFF00FFFF | (newClr << 16);
	}

	public static int setGreen(int clr, int newClr) {
		if(newClr < 0) newClr = 0;
		else if(newClr > 255) newClr = 255;
		return clr & 0xFFFF00FF | (newClr << 8);
	}

	public static int setBlue(int clr, int newClr) {
		if(newClr < 0) newClr = 0;
		else if(newClr > 255) newClr = 255;
		return clr & 0xFFFFFF00 | newClr;
	}

	public static int getAlpha(int clr) {
		return clr >>> 24;
	}

	public static int getRed(int clr) {
		return (clr >>> 16) & 255;
	}

	public static int getGreen(int clr) {
		return (clr >>> 8) & 255;
	}

	public static int getBlue(int clr) {
		return clr & 255;
	}

	public static boolean isTransparent(int clr) {
		return (clr & 0xFF000000) == 0;
	}
}
