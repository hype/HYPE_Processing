/* @pjs preload="theAmericas.png"; */

HColorPool colors;
HShapeLayout hsl;
HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#CCE70B, #80C41C, #40A629, #237D26, #FF3300, #FF6600);

	HImage hitObj = new HImage("theAmericas.png");
	H.add(hitObj);

	hsl = new HShapeLayout().target(hitObj);

	HRandomTrigger blipTrigger = new HRandomTrigger( 1f/40 );

	blipTrigger.callback(
		new HCallback(){
			public void run(Object obj) {

				int ranScale = 5+((int)random(5)*3);

				final HDrawable blip1 = H.add( new HEllipse((ranScale * 1.5) + ((int)random(5)*5) ) )
					.noStroke()
					.fill( colors.getColor(), 126 )
					.anchorAt(H.CENTER)
				;

				final HDrawable blip2 = blip1.add( new HRect(ranScale).rounding(5) )
					.noStroke()
					.fill( colors.getColor(), 200 )
					.anchorAt(H.CENTER)
					.rotation(45)
				;

				String ranSVG = new String("");
				int num = (int)random(3);
				if      (num==0) ranSVG = "arc1.svg";
				else if (num==1) ranSVG = "arc2.svg";
				else if (num==2) ranSVG = "arc3.svg";

				final HDrawable blip3 = blip1.add(new HShape(ranSVG) )
					.scale(0.5+((int)random(3)*0.25))
				;

				int ranRotation = (int)random(-6,6);
				if (ranRotation==0) ranRotation = 1;
				new HRotate(blip3, ranRotation );

				hsl.applyTo(blip1);

				final HTween tween1 = new HTween()
					.target(blip1).property(H.SCALE)
					.start(0).end(1).ease(.03).spring(.8f)
				;

				final HTween tween2 = new HTween()
					.target(blip2).property(H.SCALE)
					.start(0).end(1).ease(.035).spring(.9f)
				;

				final HTween tween3 = new HTween()
					.target(blip3).property(H.SCALE)
					.start(0).end(1).ease(.1).spring(.5f)
				;

				blip1.scale(0); blip2.scale(0); blip3.scale(0);

				final HTimer timer = new HTimer()
					.interval(9000)
					.unregister();

				final HCallback onAppear = new HCallback(){public void run(Object obj) {
					timer.register();
				}};

				final HCallback onDisappear = new HCallback(){public void run(Object obj) {
					H.remove(blip1);
				}};

				final HCallback onPause = new HCallback(){public void run(Object obj) {
					timer.unregister();
					tween1.start(1).end(0).ease(.03).spring(.5f).register().callback(onDisappear);
					tween2.start(1).end(0).ease(.035).spring(.55f).register();
					tween3.start(1).end(0).ease(.1).spring(.5f).register();
				}};

				tween1.callback(onAppear);
				timer.callback(onPause);
			}
		}
	);
}

void draw(){
	H.drawStage();
}

