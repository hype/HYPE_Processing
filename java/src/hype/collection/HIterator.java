package hype.collection;

public interface HIterator<U> {
	public boolean hasNext();
	public U next();
	public void remove();
}
