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
public static interface HLocatable {
	/**
	 * TODO
	 * 
	 * @return
	 */
	public float x();
	/**
	 * TODO
	 * 
	 * @chainable
	 * @param f
	 * @return
	 */
	public HLocatable x(float f);
	/**
	 * TODO
	 * 
	 * @return
	 */
	public float y();
	/**
	 * TODO
	 * 
	 * @chainable
	 * @param f
	 * @return
	 */
	public HLocatable y(float f);
	/**
	 * TODO
	 * 
	 * @return
	 */
	public float z();
	/**
	 * TODO
	 *
	 * @chainable
	 * @param f
	 * @return
	 */
	public HLocatable z(float f);
}
