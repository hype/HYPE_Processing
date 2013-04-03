public static interface HIterator<U> {
	public boolean hasNext();
	public U next();
	public void remove();
}
