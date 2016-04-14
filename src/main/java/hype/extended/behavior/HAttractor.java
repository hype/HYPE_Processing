package hype.extended.behavior;

import hype.HBehavior;
import hype.HDrawable;
import hype.HLinkedHashSet;
import processing.core.PApplet;
import processing.core.PVector;

import java.util.ArrayList;

import static processing.core.PApplet.map;

public class HAttractor extends HBehavior {
	private HLinkedHashSet<HAttracted> targets;
	private ArrayList<HAttractionForce> forces;

	private boolean attract = true;

	private float maxspeed = 5;
	private float maxforce = 0.1f;

	private boolean debug = false;

	public HAttractor() {
		targets = new HLinkedHashSet<HAttractor.HAttracted>();
		forces = new ArrayList<HAttractor.HAttractionForce>();
	}

	public HAttractor(float x, float y, float r) {
		this(x, y, 0, r);
	}

	public HAttractor(float x, float y, float z, float r) {
		targets = new HLinkedHashSet<HAttractor.HAttracted>();
		forces = new ArrayList<HAttractor.HAttractionForce>();
		addForce(x, y, z, r);
	}

	public HAttractor addForce(float x, float y, float r) {
		return addForce(x, y, 0, r);
	}

	public HAttractor addForce(float x, float y, float z, float r) {
		HAttractionForce f = new HAttractionForce(x, y, z, r);
		f.setAttaction(attract);
		forces.add(f);
		return this;		
	}

	public HAttractionForce getForce(int i) {
		return forces.get(i);
	}

	public HAttractionForce removeForce(int i) {
		return forces.remove(i);
	}

	public HAttractor attractMode() {
		attract = true;
		return this;
	}
	public HAttractor repelMode() {
		attract = false;
		return this;
	}
	public HAttractor debugMode(boolean b) {
		debug = b;
		return this;
	}

	public HAttractor addTarget(HDrawable d) {
		return addTarget(d, maxspeed, maxforce);
	}

	public HAttractor addTarget(HDrawable d, float s, float f) {
		if(targets.size() <= 0) register();
		HAttracted h = new HAttracted(d).maxSpeed(s).maxForce(f);
		targets.add(h);
		return this;
	}

	@Override
	public void runBehavior(PApplet app) {
		int forceCount = forces.size();

		// for each target
		for(HAttracted h : targets) {

			PVector totalForce = new PVector(0, 0, 0);
			boolean useTheForce = false;

			// for each force
			for(int i=0; i<forceCount; i++) {
				HAttractionForce f = forces.get(i);

				PVector force = PVector.sub(h.origin, f.loc);
				float distance = force.mag();

				if (distance <= f.radius) {
					useTheForce = true;

					if (f.attract == false) {
						force.normalize();
						force.mult(f.radius - distance);
					} else {
						force = PVector.sub(f.loc, h.origin);
					}

					totalForce.add(force);
				}
			}

			if (useTheForce == true) {
				h.setDestination(
					totalForce.x,
					totalForce.y,
					totalForce.z
				);
			} else {
				h.resetDestination();
			}

			h.update(debug);
		}
	}

	@Override
	public HAttractor register() {
		return (HAttractor) super.register();
	}

	@Override
	public HAttractor unregister() {
		return (HAttractor) super.unregister();
	}

	public static class HAttracted {
		public PVector location;
		public PVector velocity;
		public PVector acceleration;

		public float maxforce;
		public float maxspeed;

		public PVector origin;
		public PVector destination;

		public HDrawable target;

		public int originalFill;

		public HAttracted(HDrawable d) {
			origin = new PVector(d.x(), d.y(), d.z());
			destination = new PVector(d.x(), d.y(), d.z());
			location = new PVector();
			location = origin.copy();

			acceleration = new PVector(0,0);
			velocity = new PVector(0,0);

			target = d;
			originalFill = d.fill();

			maxspeed = 10;
			maxforce = 0.3f;
		}

		public HAttracted setDestination(float x, float y, float z) {
			destination.x = origin.x + x;
			destination.y = origin.y + y;
			destination.z = origin.z + z;
			return this;
		}

		public HAttracted resetDestination() {
			destination = origin.copy();
			return this;
		}

		public HAttracted maxSpeed(float s) {
			maxspeed = s;
			return this;
		}
		public HAttracted maxForce(float f) {
			maxforce = f;
			return this;
		}

		private void applyForce(PVector force) {
			acceleration.add(force);
			//acceleration.mult(0.97f);
		}

		private void arrive() {
			PVector desired = PVector.sub(destination,location);
			float d = desired.mag();
			desired.normalize();

			if (d < 50) {
				float m = map(d,0,50,0,maxspeed);
				desired.mult(m);
			} else {
				desired.mult(maxspeed);
			}
			PVector steer = PVector.sub(desired,velocity);
			steer.limit(maxforce);
			applyForce(steer);

			//proxSpeed[i] = (proxSpeed[i] * proxSpring) + ((proxGoal - proxValue[i]) * proxEase);
		}

		public HAttracted update(boolean debug) {
			PVector diff = PVector.sub(destination,location);
			float dist = diff.mag();

			// if we're not already at our destination, we update
			if (dist > 0.01f) {
				arrive();

				velocity.add(acceleration);
				velocity.limit(maxspeed);
				location.add(velocity);
				acceleration.mult(0);

				target.loc(location);

				if (debug) {
					target.fill(255, 0, 0);
				}
			} else {
				if (debug) {
					target.fill(originalFill);
				}
			}
			return this;
		}
	}

	/*
		Class to describe an attraction / repulsion force
	*/
	public static class HAttractionForce {
		public PVector loc;
		public float radius;
		public boolean attract = true;

		public HAttractionForce(float x, float y, float z, float r) {
			loc = new PVector(x, y, z);
			radius = r;
		}

		public void loc(float x, float y) {
			loc(x, y, 0);
		}

		public void loc(float x, float y, float z) {
			loc.x = x;
			loc.y = y;
			loc.z = z;
		}

		public void setAttaction(boolean b) {
			if (b == true) {
				attractMode();
			} else {
				repelMode();
			}
		}

		public void attractMode() {
			attract = true;
		}

		public void repelMode() {
			attract = false;
		}
	}
}