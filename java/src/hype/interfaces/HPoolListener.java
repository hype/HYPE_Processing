package hype.interfaces;

import hype.drawable.HDrawable;
import hype.util.HDrawablePool;

public interface HPoolListener {
	public void onCreate(HDrawable d, int index, HDrawablePool pool);
	public void onRequest(HDrawable d, int index, HDrawablePool pool);
	public void onRelease(HDrawable d, int index, HDrawablePool pool);
}
