package hype.extended.utility;

import hype.H;

import processing.core.PVector;

public class HMovable {

	PVector location;
	PVector velocity;
	PVector acceleration;

	float maxforce;
	float maxspeed;

	PVector origin;

	float r = 2.0f;
	
	public HMovable(float x, float y, float z) {
		origin = new PVector(x, y, z);

		location = new PVector();
		location = origin.copy();

		acceleration = new PVector(0,0);
		velocity     = new PVector(0,0);

		maxspeed = 3.0f;
		maxforce = 0.1f;
	}

	public float x() {
		return location.x;
	}

	public float y() {
		return location.y;
	}

	public HMovable maxSpeed(float s) {
		maxspeed = s;
		return this;
	}
	public HMovable maxForce(float f) {
		maxforce = f;
		return this;
	}

	public HMovable follow(PVector desired) {
		desired.mult(maxspeed);

		PVector steer = PVector.sub(desired, velocity);
		steer.limit(maxforce);
		applyForce(steer);
        return this;
	}

	public HMovable applyForce(PVector force) {
		acceleration.add(force);
        return this;
	}

	public HMovable update() {
		// Update velocity
		velocity.add(acceleration);
		// Limit speed
		velocity.limit(maxspeed);
		location.add(velocity);
		// Reset accelertion to 0 each cycle
		acceleration.mult(0);

        return this;
	}

	public HMovable borders() {
		if (location.x < -r) location.x = H.app().width+r;
		if (location.y < -r) location.y = H.app().height+r;
		if (location.x > H.app().width+r) location.x = -r;
		if (location.y > H.app().height+r) location.y = -r;
        
        return this;
	}
}
