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
public static class HWarnings {
	public static final String
		NULL_TARGET =
		"A target should be assigned before using this method.",
		NO_PROTOTYPE =
		"This pool needs at least one prototype before requesting.",
		NULL_ARGUMENT =
		"This method does not take null arguments.",
		INVALID_DEST =
		"The destination doesn't not belong to any parent.",
		DESTCEPTION =
		"The destination cannot be itself",
		CHILDCEPTION =
		"Can't add this parent as its own child.",
		INVALID_CHILD =
		"The child you're trying to add is cannot be added to this drawable."
		;
	public static void warn(String type, String loc, String msg) {
		PApplet app = H.app();
		app.println("[Warning: "+type+" @ "+loc+"]");
		if( msg!=null && msg.length()>0 ) app.println("\t"+msg);
	}
	private HWarnings() {}
}
