package hype.extended.colorist;

import hype.H;
import hype.HDrawable;
import hype.HMath;
import hype.interfaces.HColorist;

import java.util.ArrayList;
import java.util.Collections;

public class HColorPool implements HColorist {
	private ArrayList<Integer> colorList;
	private ArrayList<Integer> colorStack;
	private boolean fillFlag, strokeFlag, repeatColors = true;

	public HColorPool(int... colors) {
		colorList = new ArrayList<Integer>();
		for(int i=0; i<colors.length; ++i) add(colors[i]);

		fillAndStroke();
	}

	public HColorPool createCopy() {
		HColorPool copy = new HColorPool();
		copy.fillFlag = fillFlag;
		copy.strokeFlag = strokeFlag;
		copy.repeatColors = repeatColors;

		for(int i=0; i< colorList.size(); ++i) {
			int clr = colorList.get(i);
			copy.colorList.add( clr );
		}
		for(int i=0; i< colorStack.size(); ++i) {
			int clr = colorStack.get(i);
			copy.colorStack.add( clr );
		}
		return copy;
	}

	public int size() {
		return colorList.size();
	}

	public HColorPool add(int clr) {
		colorList.add(clr);
		resetColorStack();
		return this;
	}

	public HColorPool add(int clr, int freq) {
		while(freq-- > 0) colorList.add(clr);
		resetColorStack();
		return this;
	}

	public int getColor() {
		if(colorList.size() <= 0) return 0;

		if (repeatColors) {
			int index = (int) Math.floor(H.app().random(colorList.size()));
			return colorList.get(index);
		} else {
			if (colorStack.size() == 0) {
				resetColorStack();
			}
			return colorStack.remove(0);
		}
	}

	public int getColor(int seed) {
		HMath.tempSeed(seed);
		int clr = getColor();
		HMath.removeTempSeed();
		return clr;
	}

	public int getColorAt(int index) {
		if (colorList.size() <= index) return 0;
		return colorList.get(index);
	}

	/**
	 * If set to false, HColorPool will cycle through colors entirely before choosing the same color.
	 *
	 * @return HColorPool
	 */
	public HColorPool repeatColors(boolean repeatColors) {
		this.repeatColors = repeatColors;
		return this;
	}

	/**
	 * Resets the color stack - used if randomColors() is called on an HShape, making sure when colorizing a
	 * shape that it starts with all available colors before removing them.
	 *
	 * @return HColorPool
	 */
	public HColorPool resetColorStack() {
		colorStack = new ArrayList<Integer>();
		colorStack.addAll(colorList);
		Collections.shuffle(colorStack);
		return this;
	}

	@Override
	public HColorPool fillOnly() {
		fillFlag = true;
		strokeFlag = false;
		return this;
	}

	@Override
	public HColorPool strokeOnly() {
		fillFlag = false;
		strokeFlag = true;
		return this;
	}

	@Override
	public HColorPool fillAndStroke() {
		fillFlag = strokeFlag = true;
		return this;
	}

	@Override
	public boolean appliesFill() {
		return fillFlag;
	}

	@Override
	public boolean appliesStroke() {
		return strokeFlag;
	}

	@Override
	public HDrawable applyColor(HDrawable drawable) {
		if(fillFlag)
			drawable.fill(getColor());
		if(strokeFlag)
			drawable.stroke(getColor());
		return drawable;
	}
}
