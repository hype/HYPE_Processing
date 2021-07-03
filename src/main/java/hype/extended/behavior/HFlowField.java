/*
 * HFlowField - A flow field based particle engine for the HYPE_Processing framework (24 April 2018)
 * With a nod to Keith Peters - https://www.bit-101.com/blog/2017/10/flow-fields-part-ii/
 * And based on Shiffman's flowfield examples at http://natureofcode.com/
 *
 * Coded and tested by GD using HYPE and processing 3.3.6
 * If you find any issues or make anything cool with this, let me know on twitter at @impossiblecode
 *
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 *
 * Copyright (c) 2013-2018 Joshua Davis
 *
 * Distributed under the BSD License. See LICENSE.txt for details.
 *
 * All rights reserved.
 *
 */

package hype.extended.behavior;

import hype.*;
import processing.core.PApplet;
import processing.core.PVector;
import hype.HBundle;

import java.util.ArrayList;

import static processing.core.PApplet.degrees;
import static processing.core.PApplet.radians;
import static processing.core.PApplet.cos;
import static processing.core.PApplet.sin;
import static processing.core.PApplet.abs;
import static processing.core.PApplet.map;
import static processing.core.PApplet.max;
import static processing.core.PApplet.constrain;
import static processing.core.PConstants.TWO_PI;

//TODO: 3D version...
//TODO: use image as input to generate flow field?

public class HFlowField extends HBehavior {
    private ArrayList<HFlowParticle> flowparticles;
    private HLinkedHashSet<HDrawable> targets;
    private int cols, rows;
    private boolean debug;
    private boolean setup = true;
    private boolean noise3D;
    private boolean rotateTarget = false;
    public int resolution = 20;
    float speedLow = 3.2F;
    float speedHigh = 4.5F;
    float forceLow = 0.2F;
    float forceHigh = 0.5F;
    float zoff = 0; // 3rd dimension of noise

    PVector[][] field;

    public HFlowField() {
        flowparticles = new ArrayList<HFlowParticle>();
        targets = new HLinkedHashSet<HDrawable>();
    }

    public HFlowField noise3D(boolean b) {
        noise3D = b;
        return this;
    }

    public boolean noise3D() {
        return noise3D;
    }

    public HFlowField debug(boolean b) {
        debug = b;
        init();
        return this;
    }

    public boolean debug() {
        return debug;
    }

    public HFlowField rotateTarget(boolean b) {
        rotateTarget = b;
        return this;
    }

    public boolean rotateTarget() {
        return rotateTarget;
    }

    public HFlowField resolution(int r) {
        resolution = abs(r);
        init();
        return this;
    }

    public int resolution() {
        return resolution;
    }

    public HFlowField speedLow(float f) {
        speedLow = abs(f);
        return this;
    }

    public float speedLow() {
        return speedLow;
    }

    public HFlowField speedHigh(float f) {
        speedHigh = abs(f);
        return this;
    }

    public float speedHigh() {
        return speedHigh;
    }

    public HFlowField forceLow(float f) {
        forceLow = abs(f);
        return this;
    }

    public float forceLow() {
        return forceLow;
    }

    public HFlowField forceHigh(float f) {
        forceHigh = abs(f);
        return this;
    }

    public float forceHigh() {
        return forceHigh;
    }

    public void reseed() {
        init();
    }

    private void cleanup() {  //remove any old flow field drawables shown in debug mode
        for (HDrawable d : H.stage()) {
            HBundle e = d.extras();
            if (e != null) {
                if (e.bool("ffdebug")) {
                    H.remove(d);
                }
            }
        }
    }

    private void showDebug(float theta, int i, int j) {
        if (debug) {
            //show drawable to display flow field
            HBundle e = new HBundle().bool("ffdebug", true);
            HDrawable r = new HRect(resolution, 1).rotationZ(degrees(theta)).anchorAt(H.CENTER).loc(i * resolution, j * resolution).noStroke().fill(H.RED).extras(e);
            H.add(r);
        }
    }

    private void init() {

        H.app().noiseSeed((int) HMath.randomInt(0, 10000));

        cols = 1 + (H.app().width / resolution);
        rows = 1 + (H.app().height / resolution);
        field = new PVector[cols][rows];

        cleanup(); //remove flow field drawables

        //setup flow field direction vectors
        float xoff = 0;
        for (int i = 0; i < cols; i++) {
            float yoff = 0;
            for (int j = 0; j < rows; j++) {
                float theta = map(H.app().noise(xoff, yoff), 0, 1, 0, TWO_PI);
                field[i][j] = new PVector(cos(theta), sin(theta));
                showDebug(field[i][j].heading(), i, j); //show flow field drawables
                yoff += 0.1;
            }
            xoff += 0.1;
        }
        //end setup flow field vectors
    }

    public void update() { //animate flow field using 3d noise..

        if (!noise3D) return;

        cleanup(); //remove flow field drawables

        float xoff = 0;
        for (int i = 0; i < cols; i++) {
            float yoff = 0;
            for (int j = 0; j < rows; j++) {
                float theta = map(H.app().noise(xoff, yoff, zoff), 0, 1, 0, TWO_PI);
                // Make a vector from an angle
                field[i][j] = PVector.fromAngle(theta);
                showDebug(theta, i, j);
                yoff += 0.1;
            }
            xoff += 0.1;
        }
        // Animate by changing 3rd dimension of noise every frame
        zoff += 0.01;
    }

    private PVector lookup(PVector lookup) {
        int column = (int) constrain(lookup.x / resolution, 0, cols - 1);
        int row = (int) constrain(lookup.y / resolution, 0, rows - 1);
        return field[column][row].copy();
    }

    public HFlowField addParticle(HDrawable d) {
        HFlowParticle p = new HFlowParticle(d.loc(), H.app().random(speedLow, speedHigh), H.app().random(forceLow, forceHigh), this);
        flowparticles.add(p);
        addTarget(d);
        d.loc(p.loc());
        return this;
    }

    private HFlowField addTarget(HDrawable d) {
        if (targets.size() <= 0) register();
        targets.add(d);
        return this;
    }

    @Override
    public void runBehavior(PApplet app) {
        if (setup) {
            init();
            setup = false;
        }

        update(); //apply 3d noise

        int i = 0;
        for (HFlowParticle p : flowparticles) {
            p.update();

            HDrawable d = targets.get(i);
            d.x(p.loc().x);
            d.y(p.loc().y);

            float radius = max(d.width(),d.height());
            p.r = radius;

            if (rotateTarget) { //so dizzy my head is spinning...
                if (d.width() > d.height()) {
                    d.rotationZRad(p.rotation());
                } else {
                    d.rotationZRad(p.rotation() + radians(90));
                }
            }
            ++i;
        }
    }

    @Override
    public HFlowField register() {
        return (HFlowField) super.register();
    }

    @Override
    public HFlowField unregister() {
        return (HFlowField) super.unregister();
    }

    private static class HFlowParticle {

        PVector position;
        PVector velocity;
        PVector acceleration;
        float r;
        float maxforce;    // Maximum steering force
        float maxspeed;    // Maximum speed
        float theta;
        HFlowField field;

        public PVector loc() {
            return position;
        }

        public float rotation() {
            return theta;
        }

        public HFlowParticle(PVector loc, float ms, float mf, HFlowField ff) {
            position = loc;
            r = 10.0F;
            maxspeed = ms;
            maxforce = mf;
            acceleration = new PVector(0, 0);
            velocity = new PVector(0, 0);
            field = ff;
        }

        void update() {
            follow(field);
        }

        void follow(HFlowField flow) {
            PVector desired = flow.lookup(position);
            desired.mult(maxspeed);
            PVector steer = PVector.sub(desired, velocity);
            steer.limit(maxforce);  // Limit to maximum steering force
            applyForce(steer);
            updateForces();

            theta = velocity.heading(); //set rotation

            //wrap to screen
            if (position.x < -r) position.x = H.app().width + r;
            if (position.y < -r) position.y = H.app().height + r;
            if (position.x > H.app().width + r) position.x = -r;
            if (position.y > H.app().height + r) position.y = -r;
        }

        void applyForce(PVector force) {
            acceleration.add(force);
        }

        void updateForces() {
            velocity.add(acceleration);
            velocity.limit(maxspeed);
            position.add(velocity);
            acceleration.mult(0);
        }

    }
}