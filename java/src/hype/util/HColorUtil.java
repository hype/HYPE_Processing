package hype.util;

import processing.core.PApplet;

@SuppressWarnings("static-access")
public class HColorUtil {
	public static int[] explode(int clr) {
		int[] explodedColors = new int[4];
		for(int i=0; i<4; ++i)
			explodedColors[3-i] = (clr >>> (i*8)) & 0xFF;
		return explodedColors;
	}
	
	public static int merge(int a, int r, int g, int b) {
		PApplet app = H.app();
		a = app.constrain(a, 0, 0xFF);
		r = app.constrain(r, 0, 0xFF);
		g = app.constrain(g, 0, 0xFF);
		b = app.constrain(b, 0, 0xFF);
		return (a<<24) | (r<<16) | (g<<8) | b;
	}
	
	public static int setAlpha(int clr, int newAlpha) {
		newAlpha = H.app().constrain(newAlpha, 0, 0xFF);
		return clr & 0x00FFFFFF | (newAlpha << 24);
	}
	
	public static int setRed(int clr, int newRed) {
		newRed = H.app().constrain(newRed, 0, 0xFF);
		return clr & 0xFF00FFFF | (newRed << 16);
	}
	
	public static int setGreen(int clr, int newGreen) {
		newGreen = H.app().constrain(newGreen, 0, 0xFF);
		return clr & 0xFFFF00FF | (newGreen << 8);
	}
	
	public static int setBlue(int clr, int newBlue) {
		newBlue = H.app().constrain(newBlue, 0, 0xFF);
		return clr & 0xFFFFFF00 | newBlue;
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
	
	public static int multiply(int c1, int c2) {
		return H.app().round(c1 * c2 / 255f);
	}
	
	public static int multiplyAlpha(int clr, int a) {
		return clr & 0x00FFFFFF | ( multiply(getAlpha(clr),a) << 24 );
	}
	
	public static int multiplyRed(int clr, int r) {
		return clr & 0xFF00FFFF | ( multiply(getRed(clr),r) << 16 );
	}
	
	public static int multiplyGreen(int clr, int g) {
		return clr & 0xFFFF00FF | ( multiply(getGreen(clr),g) << 8 );
	}

	public static int multiplyBlue(int clr, int b) {
		return clr & 0xFFFFFF00 | multiply(getBlue(clr),b);
	}
}
