HFollow mf;
HRect d;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();
	
	d = new HRect(100);
	d
		.rounding(40)
		.noStroke()
		.fill(#ECECEC)
		.loc(width/2,height/2)
		.anchorAt(H.CENTER)
		.rotation(45)
	;
	H.add(d);

	// Note: for HFollow we have the following constructors:
	// - new HFollow()
	// - new HFollow(float ease)
	// - new HFollow(float ease, float spring)
	// - new HFollow(float ease, float spring, HFollowable goal)

	mf = new HFollow().target(d);

	// un/register this behavior from HStage 
	// .unregister()
	// .register()
}

// There are also alternate ways of un/registering HBehaviors:

// H.addBehavior(mf);
// H.removeBehavior(mf);
// H.stage().behaviors().add(mf);
// H.stage().behaviors().remove(mf);

void draw() {
	H.drawStage();
}

