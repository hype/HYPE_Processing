/*
 * HScreenshot - just a quick and dirty way to grab PNGs for conversion in video / animated gifts etc
 * Tested using processing 3.0.1
 * If you find any issues or make anything cool with this, let me know on twitter at @Garth_D
 * Future enhancements would be to change image format / name of output folder
 *
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013-2016 Joshua Davis
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 *
 */

package hype;

import processing.core.PApplet;

public class HScreenshot {
	private String filename;
	private int  start, end, frequency;
	private int suffix;
	private String strNumericAppend;
	private int counter;
	private boolean isRecording;
	private boolean exit;

	public HScreenshot() {
		start = end = 1;
		frequency = 1;
		exit=false;
	}

	public HScreenshot capture() {
		start = end = 1;
		return this;
	}

	public HScreenshot capture(int frameNum) {
		start = end = frameNum;
		return this;
	}

	public HScreenshot start(int frameNum) {
		start = frameNum;
		return this;
	}

	public int start() {
		return start;
	}

	public HScreenshot end(int frameNum) {
		end = frameNum;
		return this;
	}

	public int end() {
		return end;
	}

	public HScreenshot frequency(int f) {
		frequency = f;
		return this;
	}

	public int frequency() {
		return frequency;
	}

	public boolean isRecording() {
		return isRecording;
	}

	public HScreenshot exit(boolean b) {
		exit = b;
		return this;
	}

	public boolean exit() {
		return exit;
	}

	public HScreenshot filename(String s) {
		filename = s;
		return this;
	}

	public String filename() {
		return filename;
	}

	public void run() {
		++counter;

		isRecording = false;
		
		if (H.app().frameCount > end || H.app().frameCount < start) {
			//don't save anything

			if (H.app().frameCount > end && exit) {
				H.app().exit();
			};
		} else if (counter%frequency==0) {
			isRecording = true;
			++suffix;

			if (suffix<10) {
				strNumericAppend = "0000";
			}

			if (suffix>=10 && suffix<100) {
				strNumericAppend = "000";
			}

			if (suffix>=100 && suffix<1000) {
				strNumericAppend = "00";
			}

			if (suffix>=1000 && suffix<10000) {
				strNumericAppend = "0";
			}

			H.app().saveFrame("output/" + filename + strNumericAppend + suffix + ".png");
		}
	}
}
