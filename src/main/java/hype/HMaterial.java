package hype;

import processing.core.PGraphics;
import processing.opengl.PShader;

public class HMaterial {
	PShader shader;
	boolean active = false;
	
	public HMaterial(){
		shader = null;
	}
	
	public HMaterial(HMaterial copy){
		shader = copy.shader;
	}
	
	public void bind(PGraphics pg){
		if(!active)
			return;
		if(shader != null)
		{
			pg.shader(shader);
		}
	}
	
	public boolean getActive() {
		return active;
	}

	public HMaterial setActive(boolean _active) {
		this.active = _active;
		return this;
	}
	public PShader getShader() {
		return shader;
	}

	public HMaterial setShader(PShader shader) {
		this.shader = shader;
		return this;
	}
	
	
}
