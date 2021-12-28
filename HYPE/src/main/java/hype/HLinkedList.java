package hype;

import java.util.Iterator;
import java.util.Random;

public class HLinkedList<T> implements Iterable<T> {
	protected HLinkedListNode<T> firstSentinel, lastSentinel;
	protected int size;

	public HLinkedList() {
		firstSentinel = new HLinkedListNode<T>(null);
		lastSentinel = new HLinkedListNode<T>(null);
		lastSentinel.putAfter(firstSentinel);
	}

	// Peek //

	public T first() {
		return firstSentinel.next.content;
	}

	public T last() {
		return lastSentinel.prev.content;
	}

	public T get(int index) {
		HLinkedListNode<T> n = nodeAt(index);
		return (n==null)? null : n.content;
	}


	// Insert //

	public boolean push(T content) {
		if(content==null) return false;
		register(content).putAfter(firstSentinel);
		++size;
		return true;
	}

	public boolean add(T content) {
		if(content==null) return false;
		register(content).putBefore(lastSentinel);
		++size;
		return true;
	}

	public boolean insert(T content, int index) {
		if(content==null) return false;
		HLinkedListNode<T> n = (index== size)? lastSentinel : nodeAt(index);
		if(n==null) return false;

		register(content).putBefore(n);
		++size;
		return true;
	}


	// Remove //

	public T pop() {
		HLinkedListNode<T> firstNode = firstSentinel.next;
		if(firstNode.content != null) {
			firstNode.popOut();
			--size;
		}
		return firstNode.content;
	}

	public T pull() {
		HLinkedListNode<T> lastNode = lastSentinel.prev;
		if(lastNode.content != null) {
			lastNode.popOut();
			--size;
		}
		return lastNode.content;
	}

	public T removeAt(int index) {
		HLinkedListNode<T> n = nodeAt(index);
		if(n==null) return null;
		n.popOut();
		--size;
		return n.content;
	}

	public void removeAll() {
		lastSentinel.putAfter(firstSentinel);
		size = 0;
	}

	/*
		Shuffle list items
		approximate replication of Java's shuffle method
	*/
	public void shuffle() {

		Random rnd = new Random();

		for (int i= size; i>1; i--) {

			HLinkedListNode<T> i_node = nodeAt(i-1);
			HLinkedListNode<T> rnd_node = nodeAt(rnd.nextInt(i));

			//move node at i-1 to after the random node
			i_node.putAfter(rnd_node);

			//move the random node to the position of node at i-1
			i_node = nodeAt(i-1);
			rnd_node.putAfter(i_node);
		}
	}

	// Misc //

	public int size() {
		return size;
	}

	public boolean inRange(int index) {
		return (0 <= index) && (index < size);
	}

	@Override
	public HLinkedListIterator<T> iterator() {
		return new HLinkedListIterator<T>(this);
	}

	protected HLinkedListNode<T> nodeAt(int i) {
		int ri; // reverse index
		if(i<0) {
			ri = -i;
			i += size;
		} else {
			ri = size -i;
		}

		if(!inRange(i)) {
			HWarnings.warn("Out of Range: "+i, "HLinkedList.nodeAt()", null);
			return null;
		}

		HLinkedListNode<T> node;
		if(ri < i) { // iterate backwards
			node = lastSentinel.prev;
			while(--ri > 0) node = node.prev;
		} else { // iterate forwards
			node = firstSentinel.next;
			while(i-- > 0) node = node.next;
		}
		return node;
	}

	protected HLinkedListNode<T> register(T obj) {
		return new HLinkedListNode<T>(obj);
	}



	public static class HLinkedListNode<U> extends HNode<HLinkedListNode<U>> {
		private U content;

		public HLinkedListNode(U nodeContent) {
			content = nodeContent;
		}

		public U content() {
			return content;
		}
	}

	public static class HLinkedListIterator<U> implements Iterator<U> {
		private HLinkedList<U> list;
		private HLinkedListNode<U> n1, n2;

		public HLinkedListIterator(HLinkedList<U> parent) {
			list = parent;
			n1 = list.firstSentinel.next;
			if(n1 != null) n2 = n1.next;
		}

		@Override
		public boolean hasNext() {
			return (n1.content != null);
		}

		@Override
		public U next() {
			U content = n1.content;
			n1 = n2;
			if(n2 != null) n2 = n2.next;
			return content;
		}

		@Override
		public void remove() {
			if(n1.content != null) {
				n1.popOut();
				--list.size;
			}
		}
	}
}
