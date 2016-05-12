//example showing how to rotate a group of objects in 3D

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HColorPool colors, colors2;
HDrawablePool pool, pool2;
HGroup grp, grp2;
HGridLayout grid, grid2;
HRotate r, r2; 

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();

	colors = new HColorPool().add(#0095a8).add(#00616f).add(#FF3300).add(#FF6600);
	colors2 = new HColorPool().add(#FFFFFF).add(#ECECEC).add(#CCCCCC).add(#333333);

	grid = new HGridLayout().startX(-125).startY(-125).startZ(-125).spacing(50, 50, 50).cols(6).rows(6);
	grid2 = new HGridLayout().startX(-175).startY(-175).startZ(-175).spacing(70, 70, 70).cols(6).rows(6);

	grp = new HGroup();
	grp.loc(width/2, height/2, 0);
	H.add(grp);

	grp2 = new HGroup();
	grp2.loc(width/2, height/2, 0);
	H.add(grp2);

	pool = new HDrawablePool(216);
	pool.layout(grid);
	pool.autoAddToStage()
		.add(new HBox().size(12))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.strokeWeight(0)
						.noStroke()
						.rotateY(13)
						.rotateZ(30);
					colors.applyColor(d);
					r = new HRotate().speedY(2.3).target(d);
					grp.add(d);
				}
			}
		)
		.requestAll();

	pool2 = new HDrawablePool(216);
	pool2.layout(grid2);
	pool2.autoAddToStage()
		.add(new HBox().size(12))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.alpha(0);
					colors2.applyColor(d);
					grp2.add(d);
					r2 = new HRotate().speedX(3).target(d);
					d.extras( new HBundle().num("sd", 2*(int)random(1, 4)) ); //sets variable for sphere detail
				}
			}
		)
		.requestAll();
}


void draw() {

	lights();

	grp.rotateX(0.1);
	grp.rotateY(-1);
	grp.rotateZ(0);

	grp2.rotateX(-1.2);
	grp2.rotateY(0);
	grp2.rotateZ(0.1);

	H.drawStage();

	translate(width/2, height/2, 0);

	rotateX(radians(grp2.rotationX()));  
	rotateY(radians(grp2.rotationY()));
	rotateZ(radians(grp2.rotationZ()));

	for (HDrawable d : pool2) {
		pushMatrix();
		strokeWeight(2);
		stroke(d.fill(), 255);
		noFill();
		translate(d.x(), d.y(), d.z());
		rotateX(d.rotationXRad());
		rotateY(d.rotationYRad());
		rotateZ(d.rotationZRad());
		sphere(d.size().x);
		int sd = (int)d.extras().num("sd");
		sphereDetail(sd);
		popMatrix();
	}
	
}
