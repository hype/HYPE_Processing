/*
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */

package hype.core.collection;

import hype.core.util.HWarnings;

import java.util.Iterator;

public class HLinkedList<T> implements Iterable<T> {
	protected HLinkedListNode<T> _firstSentinel, _lastSentinel;
	protected int _size;
	
	public HLinkedList() {
		_firstSentinel = new HLinkedListNode<T>(null);
		_lastSentinel = new HLinkedListNode<T>(null);
		_lastSentinel.putAfter(_firstSentinel);
	}
	
	// Peek //
	
	public T first() {
		return _firstSentinel._next._content;
	}
	
	public T last() {
		return _lastSentinel._prev._content;
	}
	
	public T get(int index) {
		HLinkedListNode<T> n = nodeAt(index);
		return (n==null)? null : n._content;
	}
	
	
	// Insert //
	
	public boolean push(T content) {
		if(content==null) return false;
		register(content).putAfter(_firstSentinel);
		++_size;
		return true;
	}
	
	public boolean add(T content) {
		if(content==null) return false;
		register(content).putBefore(_lastSentinel);
		++_size;
		return true;
	}
	
	public boolean insert(T content, int index) {
		if(content==null) return false;
		HLinkedListNode<T> n = (index==_size)? _lastSentinel : nodeAt(index);
		if(n==null) return false;
		
		register(content).putBefore(n);
		++_size;
		return true;
	}
	
	
	// Remove //
	
	public T pop() {
		HLinkedListNode<T> firstNode = _firstSentinel._next;
		if(firstNode._content != null) {
			firstNode.popOut();
			--_size;
		}
		return firstNode._content;
	}
	
	public T pull() {
		HLinkedListNode<T> lastNode = _lastSentinel._prev;
		if(lastNode._content != null) {
			lastNode.popOut();
			--_size;
		}
		return lastNode._content;
	}
	
	public T removeAt(int index) {
		HLinkedListNode<T> n = nodeAt(index);
		if(n==null) return null;
		n.popOut();
		--_size;
		return n._content;
	}
	
	public void removeAll() {
		_lastSentinel.putAfter(_firstSentinel);
		_size = 0;
	}
	
	// Misc //
	
	public int size() {
		return _size;
	}
	
	public boolean inRange(int index) {
		return (0 <= index) && (index < _size);
	}
	
	@Override
	public HLinkedListIterator<T> iterator() {
		return new HLinkedListIterator<T>(this);
	}
	
	protected HLinkedListNode<T> nodeAt(int i) {
		int ri; // reverse index
		if(i<0) {
			ri = -i;
			i += _size;
		} else {
			ri = _size-i;
		}
		
		if(!inRange(i)) {
			HWarnings.warn("Out of Range: "+i, "HLinkedList.nodeAt()", null);
			return null;
		}
		
		HLinkedListNode<T> node;
		if(ri < i) { // iterate backwards
			node = _lastSentinel._prev;
			while(--ri > 0) node = node._prev;
		} else { // iterate forwards
			node = _firstSentinel._next;
			while(i-- > 0) node = node._next;
		}
		return node;
	}
	
	protected HLinkedListNode<T> register(T obj) {
		return new HLinkedListNode<T>(obj);
	}
	
	
	
	public static class HLinkedListNode<U> extends HNode<HLinkedListNode<U>> {
		private U _content;
		
		public HLinkedListNode(U nodeContent) {
			_content = nodeContent;
		}
		
		public U content() {
			return _content;
		}
	}
	
	public static class HLinkedListIterator<U> implements Iterator<U> {
		private HLinkedList<U> list;
		private HLinkedListNode<U> n1, n2;
		
		public HLinkedListIterator(HLinkedList<U> parent) {
			list = parent;
			n1 = list._firstSentinel._next;
			if(n1 != null) n2 = n1._next;
		}

		@Override
		public boolean hasNext() {
			return (n1._content != null);
		}

		@Override
		public U next() {
			U content = n1._content;
			n1 = n2;
			if(n2 != null) n2 = n2._next; 
			return content;
		}

		@Override
		public void remove() {
			if(n1._content != null) {
				n1.popOut();
				--list._size;
			}
		}
	}
}
