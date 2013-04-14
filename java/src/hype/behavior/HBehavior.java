package hype.behavior;

import hype.util.collection.HNode;
import processing.core.PApplet;

public class HBehavior extends HNode<HBehavior> {
	
	public HBehavior register() {
		if(poppedOut()) {
			if(_firstBehavior != null) putBefore(_firstBehavior);
			_firstBehavior = this;
		}
		return this;
	}
	
	public HBehavior unregister() {
		if(!poppedOut()) {
			_firstBehavior = _next;
			popOut();
		}
		return this;
	}
	
	public void runBehavior(PApplet app) {}
	
	
	
	// Behavior Registry //
	
	private static HBehavior _firstBehavior;
	private static PApplet _app;
	
	public static void init(PApplet app) {
		_app = app;
	}
	
	public static void runAll() {
		HBehavior node = _firstBehavior;
		while(node != null) {
			node.runBehavior(_app);
			node = node._next;
		}
	}
}
