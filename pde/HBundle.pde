public static class HBundle {
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
		return H.app().round(numberContents.get(key));
	}
	public boolean bool(String key) {
		return (numberContents.get(key) != 0);
	}
}
