package hype;

import java.util.HashMap;

public class HBundle {
	private HashMap<String,Object> objectContents;
	private HashMap<String,Float> numberContents;
	
	public HBundle() {
		objectContents = new HashMap<String,Object>();
		numberContents = new HashMap<String,Float>();
	}
	
	public HBundle obj(String key, Object value) {
		objectContents.put(key,value);
		return this;
	}
	
	public HBundle num(String key, float value) {
		numberContents.put(key,value);
		return this;
	}
	
	public HBundle bool(String key, boolean value) {
		numberContents.put(key, (value? 1f : 0f) );
		return this;
	}
	
	public Object obj(String key) {
		return objectContents.get(key);
	}
	
	public String str(String key) {
		Object o = objectContents.get(key);
		if(o instanceof String)
			return (String) o;
		return null;
	}
	
	public float num(String key) {
		return numberContents.get(key);
	}
	
	public int numI(String key) {
		return Math.round(numberContents.get(key));
	}
	
	public boolean bool(String key) {
		return (numberContents.get(key) != 0);
	}
}
