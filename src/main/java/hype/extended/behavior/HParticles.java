/*
 * HParticles - A particle engine for HYPE
 * Tested using processing 3.0.1
 * If you find any issues or make anything cool with this, let me know on twitter at @Garth_D
 * 
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013-2016 Joshua Davis
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 *
 */

package hype.extended.behavior;

import hype.H;
import hype.HBehavior;
import hype.HDrawable;
import hype.HLinkedHashSet;
import processing.core.PApplet;
import processing.core.PVector;

import java.util.ArrayList;

import static processing.core.PApplet.abs;
import static processing.core.PApplet.map;


public class HParticles extends HBehavior {
	private ArrayList<HParticle> particles;
	private HLinkedHashSet<HDrawable> targets;
	public float x, y, z, speed, decay;
	public int minimumLife, maximumLife;
	public boolean fade;

	public HParticles() {
		particles = new ArrayList<HParticle>();
		targets = new HLinkedHashSet<HDrawable>();
		x = H.app().width/2;
		y = H.app().height/2;
		z = 0;
		minimumLife = 30;
		maximumLife = 130;
		speed=1.0f;
		decay=1.0f;
		fade=true;
	}

	public HParticles location(float px, float py) {
		x = px;
		y = py;
		z = 0;
		return this;
	}

	public HParticles location(float px, float py, float pz) {
		x = px;
		y = py;
		z = pz;
		return this;
	}

	public HParticles location(PVector loc) {
		x = loc.x;
		y = loc.y;
		z = loc.z;
		return this;
	}

	public PVector location() {
		return new PVector(x, y, z);
	}

	public HParticles fade(boolean b) {
		fade = b;
		return this;
	}

	public boolean fade() {
		return fade;
	}

	public HParticles minimumLife(int i) {
		minimumLife = abs(i);
		return this;
	}

	public int minimumLife() {
		return minimumLife;
	}

	public HParticles maximumLife(int i) {
		maximumLife = abs(i);
		return this;
	}

	public int maximumLife() {
		return maximumLife;
	}

	public HParticles speed(float f) {
		speed = abs(f);
		if (speed<=0.1f) {
			speed=0.2f;
		}
		return this;
	}

	public float speed() {
		return speed;
	}

	public HParticles decay(float f) {
		decay = abs(f);
		if (decay<=0.1f) {
			decay=0.2f;
		}
		return this;
	}

	public float decay() {
		return decay;
	}

	public HParticles addParticle(HDrawable d) {

		HParticle p = new HParticle(this.x, this.y, this.z, minimumLife, maximumLife);
		particles.add(p);
		addTarget(d);
		d.loc(p.positionVec);
		return this;
	}

	private HParticles addTarget(HDrawable d) {
		if (targets.size() <= 0) register();
		targets.add(d);
		return this;
	}

	@Override
	public void runBehavior(PApplet app) {

		int i=0;
		for (HParticle p : particles) {
			p.update(x, y, z, minimumLife, maximumLife);
			HDrawable d = targets.get(i);
			if (fade) {
				d.alpha(p.alpha());
			}
			d.loc(p.position());
			++i;
		}
	}

	@Override
	public HParticles register() {
		return (HParticles) super.register();
	}

	@Override
	public HParticles unregister() {
		return (HParticles) super.unregister();
	}

	public class HParticle {
		public float px, py, pz;
		public float startLife, endLife;
		public float currentLife=endLife;
		public PVector directionVec;
		public PVector movementVec;
		public PVector applyMovementVec;
		public PVector positionVec;
		public int alpha;

		public PVector position() {
			return positionVec;
		}

		public int alpha() {
			return alpha;
		}

		public HParticle(float x, float y, float z, float startLife, float endLife) {
			px = x;
			py = y;
			pz = z;
			startLife = startLife;
			endLife = endLife;

			if (startLife>=endLife) {
				endLife = startLife+1;
			}

			currentLife = (int)H.app().random(0, endLife-1); //set random lifespan
			directionVec = new PVector(H.app().random(-1, 1), H.app().random(-1, 1), H.app().random(-1, 1)); //random dir vector
			positionVec = new PVector(px, py, pz);
			alpha = (int)map(currentLife, startLife, endLife, 0, 255);

			//ensure our starting movement is random - otherwise will 'clump'
			movementVec =  new PVector(H.app().random(-1, 1), H.app().random(-1, 1), H.app().random(-1, 1));

			int rnd = (int)H.app().random(0, 4);

			if (rnd==0) {
				applyMovementVec = PVector.mult(movementVec, H.app().random(0, speed)); //apply random starting speed
			}
			if (rnd==1) {
				applyMovementVec = PVector.mult(movementVec, H.app().random(0, speed/2)); //apply random starting speed
			}
			if (rnd==2) {
				applyMovementVec = PVector.mult(movementVec, H.app().random(0, speed/3)); //apply random starting speed
			}
			if (rnd==3) {
				applyMovementVec = PVector.mult(movementVec, H.app().random(0, speed/5)); //apply random starting speed
			}
		}

		public void update(float ux, float uy, float uz, float startLife, float endLife) {

			if (startLife>=endLife) {
				endLife = startLife+1;
			}

			if (abs(decay)<=0.1f) {
				decay=0.2f;
			}
			if (abs(speed)<=0.1f) {
				speed=0.2f;
			}

			applyMovementVec = PVector.mult(movementVec, speed); //scale by speed
			positionVec.add(applyMovementVec);
			currentLife-=decay; //decrease lifespan
			if (currentLife <= 0) {
				directionVec = new PVector(H.app().random(-1, 1), H.app().random(-1, 1), H.app().random(-1, 1));
				positionVec = new PVector(ux, uy, uz);
			currentLife = H.app().random(startLife, endLife-1); //set random lifespan
			}
			alpha = (int) map(currentLife, startLife, endLife, 0, 255);
		}
	}
}
