package hype.extended.colorist;

import hype.H;
import hype.HDrawable;
import hype.HMath;
import hype.interfaces.HColorist;

import java.util.ArrayList;

public class HColorPool implements HColorist {
	private ArrayList<Integer> colorList;
	private boolean fillFlag, strokeFlag;

	public HColorPool(int... colors) {
		colorList = new ArrayList<Integer>();
		for(int i=0; i<colors.length; ++i) add(colors[i]);

		fillAndStroke();
	}

	public HColorPool createCopy() {
		HColorPool copy = new HColorPool();
		copy.fillFlag = fillFlag;
		copy.strokeFlag = strokeFlag;

		for(int i=0; i< colorList.size(); ++i) {
			int clr = colorList.get(i);
			copy.colorList.add( clr );
		}
		return copy;
	}

	public int size() {
		return colorList.size();
	}

	public HColorPool add(int clr) {
		colorList.add(clr);
		return this;
	}

	public HColorPool add(int clr, int freq) {
		while(freq-- > 0) colorList.add(clr);
		return this;
	}

	public int getColor() {
		if(colorList.size() <= 0) return 0;

		int index = (int) Math.floor(H.app().random(colorList.size()));
		return colorList.get(index);
	}

	public int getColor(int seed) {
		HMath.tempSeed(seed);
		int clr = getColor();
		HMath.removeTempSeed();
		return clr;
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
