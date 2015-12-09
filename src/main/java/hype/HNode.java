package hype;

public abstract class HNode<T extends HNode<T>> {
	protected T prev, next;

	public T prev() {
		return prev;
	}

	public T next() {
		return next;
	}

	public boolean poppedOut() {
		return (prev ==null) && (next ==null);
	}

	public void popOut() {
		// Stitch `prev` and `next` together
		if(prev !=null) prev.next = next;
		if(next !=null) next.prev = prev;

		// Remove this node from the node chain
		prev = next = null;
	}

	@SuppressWarnings("unchecked")
	public void putBefore(T dest) {
		if(dest==null || dest.equals(this)) return;
		if(!poppedOut()) popOut();

		T p = dest.prev;

		// Stitch together `p` and this node
		if(p!=null) p.next = (T) this;
		prev = p;

		// Stitch together this node and `dest`
		next = dest;
		dest.prev = (T) this;
	}

	@SuppressWarnings("unchecked")
	public void putAfter(T dest) {
		if(dest==null || dest.equals(this)) return;
		if(!poppedOut()) popOut();

		T n = dest.next();

		// Stitch together `dest` and `target`
		dest.next = (T) this;
		prev = dest;

		// Stitch together `insert` and `n`
		next = n;
		if(n!=null) n.prev = (T) this;
	}

	public void replaceNode(T dest) {
		if(dest==null || dest.equals(this)) return;
		if(!poppedOut()) popOut();

		T p = dest.prev;
		T n = dest.next;

		// Remove `target` from the chain and put this node into it
		dest.prev = dest.next = null;
		prev = p;
		next = n;
	}

	@SuppressWarnings("unchecked")
	public void swapLeft() {
		if(prev ==null) return;

		T pairPrev = prev.prev;
		T pairNext = next;

		// Swap `target` and `left`
		next = prev;
		prev.prev = (T) this;

		// Put this node and `prev` back into the chain
		prev.next = pairNext;
		if(pairNext != null) pairNext.prev = prev;

		prev = pairPrev;
		if(pairPrev != null) pairPrev.next = (T) this;
	}

	@SuppressWarnings("unchecked")
	public void swapRight() {
		if(next ==null) return;

		T pairPrev = prev;
		T pairNext = next.next;

		// Swap `right` and this node
		next.next = (T) this;
		prev = next;

		// Put `next` and this node back into the chain
		next.prev = pairPrev;
		if(pairPrev != null) pairPrev.next = next;

		next = pairNext;
		if(pairNext != null) pairNext.prev = (T) this;
	}
}
