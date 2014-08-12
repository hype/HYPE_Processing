/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static abstract class HNode<T extends HNode<T>> {
	protected T _prev, _next;
	public T prev() {
		return _prev;
	}
	public T next() {
		return _next;
	}
	public boolean poppedOut() {
		return (_prev==null) && (_next==null);
	}
	public void popOut() {
		if(_prev!=null) _prev._next = _next;
		if(_next!=null) _next._prev = _prev;
		_prev = _next = null;
	}
	public void putBefore(T dest) {
		if(dest==null || dest.equals(this)) return;
		if(!poppedOut()) popOut();
		T p = dest._prev;
		if(p!=null) p._next = (T) this;
		_prev = p;
		_next = dest;
		dest._prev = (T) this;
	}
	public void putAfter(T dest) {
		if(dest==null || dest.equals(this)) return;
		if(!poppedOut()) popOut();
		T n = dest.next();
		dest._next = (T) this;
		_prev = dest;
		_next = n;
		if(n!=null) n._prev = (T) this;
	}
	public void replaceNode(T dest) {
		if(dest==null || dest.equals(this)) return;
		if(!poppedOut()) popOut();
		T p = dest._prev;
		T n = dest._next;
		dest._prev = dest._next = null;
		_prev = p;
		_next = n;
	}
	public void swapLeft() {
		if(_prev==null) return;
		T pairPrev = _prev._prev;
		T pairNext = _next;
		_next = _prev;
		_prev._prev = (T) this;
		_prev._next = pairNext;
		if(pairNext != null) pairNext._prev = _prev;
		_prev = pairPrev;
		if(pairPrev != null) pairPrev._next = (T) this;
	}
	public void swapRight() {
		if(_next==null) return;
		T pairPrev = _prev;
		T pairNext = _next._next;
		_next._next = (T) this;
		_prev = _next;
		_next._prev = pairPrev;
		if(pairPrev != null) pairPrev._next = _next;
		_next = pairNext;
		if(pairNext != null) pairNext._prev = (T) this;
	}
}
