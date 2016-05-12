/*
 * HGroupColorPool - class for HYPE by GD / @Garth_D
 * Tested using processing 3.0.1
 * If you find any issues or make anything cool with this, let me know on twitter at @Garth_D
 * 
 * Helper class for HYPE framework - creates a pool of HColorPools 
 * (Yes...pools within pools...I know. It's all a bit self referential)
 *
 * What's the point of this? Well, this is basically to help you explore different color schemes in HYPE
 * it'll let you easily swap out and apply different HColorPools to a single HYPE sketch 
 * without having to restart and change your code each time
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

package hype.extended.colorist;
import hype.H;
import java.util.ArrayList;

public class HGroupColorPool {
	private int currentIndex=-1;
	private ArrayList<HColorPool> colorGroupList;
	public HGroupColorPool(HColorPool... colors) {
		colorGroupList = new ArrayList<HColorPool>();
		for (int i=0; i<colors.length; ++i) 
			add(colors[i]);
	}

	private int setIndex(int i) {
		//ensure index within bounds
		if (i >= size() || i<0) {
			currentIndex = 0;  
			if (i<0) {
				currentIndex = size()-1;
			}
		} else {
			currentIndex = i;
		}
		return currentIndex;
	}

	public int currentIndex() {
		return currentIndex;
	}

	public int size() { 
		return colorGroupList.size();
	}

	public HGroupColorPool add(HColorPool clrPool) {
		colorGroupList.add(clrPool);
		return this;
	}

	public HColorPool getRandomColorPool() {
		//select a color pool at random
		if (size() <= 0) {
			return new HColorPool().add(0);
		} else {
			int rndIndex = (int) Math.floor(H.app().random(size()));
			currentIndex = setIndex(rndIndex);
			return colorGroupList.get(rndIndex);
		}
	}

	public HColorPool getNextColorPool() {
		//cycles through all available color pools
		if (size() <= 0) {
			return new HColorPool().add(0);
		} else {
			currentIndex = setIndex(currentIndex+1);
			return colorGroupList.get(currentIndex);
		}
	}

	public HColorPool getPrevColorPool() {
		//cycles through all available color pools
		if (size() <= 0) {
			return new HColorPool().add(0);
		} else {
			currentIndex = setIndex(currentIndex+1);
			return colorGroupList.get(currentIndex);
		}
	}

	public HColorPool getColorPool(int index) {
		//extract a specific color pool
		currentIndex = setIndex(index);
		return colorGroupList.get(currentIndex);
	}
}
