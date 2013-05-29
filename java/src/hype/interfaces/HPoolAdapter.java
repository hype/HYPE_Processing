/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.interfaces;

import hype.drawable.HDrawable;
import hype.util.HDrawablePool;

public class HPoolAdapter implements HPoolListener {
	@Override
	public void onCreate(HDrawable d, int index, HDrawablePool pool) {}

	@Override
	public void onRequest(HDrawable d, int index, HDrawablePool pool) {}

	@Override
	public void onRelease(HDrawable d, int index, HDrawablePool pool) {}
}
