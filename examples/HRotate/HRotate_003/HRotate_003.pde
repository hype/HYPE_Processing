//example showing how to apply x, y and z rotations using HRotate

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HColorPool colors;
HDrawablePool pool;
HGridLayout grid;

int index=-1;
int index2=-1;
boolean applyRot;

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();

	colors = new HColorPool().add(#0095a8).add(#00616f).add(#FF3300).add(#FF6600);
	grid = new HGridLayout().startX(-125+width/2).startY(-125+height/2).startZ(0).spacing(50, 50, 50).cols(6).rows(6);

	pool = new HDrawablePool(216);
	pool.layout(grid);
	pool.autoAddToStage()
		.add(new HBox().size(20))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					index = pool.currentIndex();
					HDrawable3D d = (HDrawable3D) obj;
					d
					.strokeWeight(0)
					.noStroke()
					//.anchor(-40, -40) //you can play around with the anchor position
					;

					HRotate r1 = new HRotate();
					HRotate r2 = new HRotate();
					HRotate r3 = new HRotate();
					r1.speedX(1).speedY(0).speedZ(0); //apply to grey boxes - see below
					r2.speedX(0).speedY(1).speedZ(0); //apply to white boxes - see below
					r3.speedX(2).speedZ((int)random(-5, 5));

					colors.applyColor(d);

					if (index%6==0) {
						++index2;
					};

					if (index2%2==0) {
						if (index%2!=0) {
							d.fill(H.GREY);
							r1.target(d);
							applyRot = true;
						}
					} else {
						if (index%2==0) {
							d.fill(H.WHITE);
							r2.target(d);
							applyRot = true;
						}
					}

					if (!applyRot) {
						r3.target(d);
					}
					applyRot=false;
				}
			}
		)
		.requestAll();
}

void draw() {
	lights();
	H.drawStage();
}
