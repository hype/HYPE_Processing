package hype.behavior;

import hype.util.H;

import java.util.ArrayList;

import processing.core.PApplet;

@SuppressWarnings("static-access")
public class HMagnetField extends HBehavior {
	protected ArrayList<HMagnetPole> poles;
	protected int _rotStyle;
	
	public HMagnetField() {
		poles = new ArrayList<HMagnetField.HMagnetPole>();
	}
	
	public HMagnetField(int rotStyle) {
		this();
		_rotStyle = rotStyle;
	}
	
	public HMagnetField rotationStyle(int rotStyle) {
		_rotStyle = rotStyle;
		return this;
	}
	
	public int rotationStyle() {
		return _rotStyle;
	}
	
	public HMagnetPole pole(int index) {
		return poles.get(index);
	}
	
	public HMagnetField pole(float x, float y, boolean isSouth) {
		HMagnetPole p = new HMagnetPole();
		p.x = x;
		p.y = y;
		p.isSouth = isSouth;
		poles.add(p);
		return this;
	}
	
	public float getRotation(float targetX, float targetY, float targetRot) {
		float rotation = getRotationRad(targetX, targetY, targetRot*H.D2R);
		return rotation * H.R2D;
	}
	
	public float getRotationRad(float tx, float ty, float tr) {
		PApplet app = H.app();
		
		HMagnetPole north = pole(0);
		HMagnetPole south = pole(1);
		float t;
		if(north.x == south.x) {
			t = ty / (south.y-north.y);
		} else if(north.y == south.y) {
			t = tx / (south.x-north.x);
		} else {
			float tmpDist = app.dist(north.x,north.y, south.x,south.y);
			float xdist = south.x - north.x;
			t = (xdist*(north.x-tx) / xdist) / tmpDist;
		}
		
		float tmp = (2*(1-t)*t);
		float midx = (tx - app.sq(1-t)*north.x - t*t*south.x) / tmp;
		float midy = (ty - app.sq(1-t)*north.y - t*t*south.y) / tmp;
		
		float tanX1 = app.lerp(north.x,midx, t);
		float tanY1 = app.lerp(north.y,midy, t);
		float tanX2 = app.lerp(midx,south.x, t);
		float tanY2 = app.lerp(midy,south.y, t);
		
		return H.xAxisAngle(tanX1,tanY1, tanX2,tanY2);
		/*int numPoles = poles.size();
		float accumRots = 0;
		float[] dists = new float[numPoles];
		float maxDist = 0;
		
		for(int i=0; i<numPoles; ++i) {
			HMagnetPole p = poles.get(i);
			
			float d = app.dist(tx,ty, p.x,p.y);
			if(d > maxDist) maxDist = d;
			
			dists[i] = d;
		}
		
		for(int j=0; j<numPoles; ++j) {
			HMagnetPole p = poles.get(j);
			
			// Get the angle difference bet the pole and the current rotation
			float dRot = H.xAxisAngle(tx,ty, p.x,p.y) - tr;
			if(p.isSouth) dRot += app.PI;
			dRot %= app.TWO_PI;
			
			// Make sure that -180deg < dRot < 180deg
			if(dRot > app.PI)
				dRot = -app.TWO_PI + dRot;
			else if(dRot < -app.PI)
				dRot = app.TWO_PI + dRot;
			
			// Add weighted to the dRot via distance
			app.println(dists[j]/maxDist);//TEST
			accumRots += dRot * (dists[j]/maxDist);
		}
		
		float rotation = tr + accumRots/numPoles;
		switch(_rotStyle) {
		default: break;
		case H.SIN: rotation = app.sin(rotation); break;
		case H.COS: rotation = app.cos(rotation); break;
		case H.TAN: rotation = app.tan(rotation); break;
		}
		return rotation;*/
	}
	
//	@Override
//	public void run(HDrawable target) {
//		float r = getRotationRad(
//			target.getX(), target.getY(),
//			target.getRotationRad());
//		target.setRotationRad(r);
//	}
	
	public class HMagnetPole {
		public boolean isSouth;
		public float x, y;
	}

	@Override
	public void runBehavior() {
		// TODO Auto-generated method stub
		
	}
}
