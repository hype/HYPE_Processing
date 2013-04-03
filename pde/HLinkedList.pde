public static class HLinkedList<T> {
	protected HLinkNode<T> firstNode, lastNode;
	protected int length;
	public int getLength() {
		return length;
	}
	public T peekFirst() {
		if(firstNode == null)
			return null;
		return firstNode.getContent();
	}
	public T peekLast() {
		if(lastNode == null)
			return null;
		return lastNode.getContent();
	}
	public T peekAt(int index) {
		HLinkNode<T> n = getNode(index);
		if(n == null)
			return null;
		return n.getContent();
	}
	protected boolean addNode(HLinkNode<T> node) {
		if(node == null) return false;
		node.popOut();
		if(length <= 0) {
			lastNode = firstNode = node;
			length = 1;
		} else {
			node.putAfter(lastNode);
			lastNode = node;
			++length;
		}
		return true;
	}
	public boolean add(T obj) {
		return addNode(new HLinkNode<T>(obj));
	}
	public T pull() {
		if(length <= 0) return null;
		HLinkNode<T> ln = lastNode;
		lastNode = ln.getPrev();
		ln.popOut();
		length--;
		if(length <= 0) lastNode = firstNode = null;
		return ln.getContent();
	}
	protected boolean pushNode(HLinkNode<T> node) {
		if(node == null) return false;
		node.popOut();
		if(length <= 0) {
			firstNode = lastNode = node;
			length = 1;
		} else {
			node.putBefore(firstNode);
			firstNode = node;
			++length;
		}
		return true;
	}
	public boolean push(T obj) {
		return pushNode(new HLinkNode<T>(obj));
	}
	public T pop() {
		if(length <= 0) return null;
		HLinkNode<T> fn = firstNode;
		firstNode = fn.getNext();
		fn.popOut();
		length--;
		if(length <= 0) lastNode = firstNode = null;
		return fn.getContent();
	}
	public void removeAll() {
		firstNode = lastNode = null;
		length = 0;
	}
	protected HLinkNode<T> getNode(int index) {
		int reverseIndex;
		if(index < 0) {
			reverseIndex = index;
			index = length + index;
		} else {
			reverseIndex = index - length;
		}
		if(index < 0 || reverseIndex > -1) return null;
		HLinkNode<T> n;
		if(index <= reverseIndex) {
			n = firstNode;
			while(0 < index--) {
				n = n.getNext();
			}
			return  n;
		} else {
			n = lastNode;
			while(-1 > reverseIndex++) {
				n = n.getPrev();
			}
			return n;
		}
	}
	public void foreach(HCallback callback) {
		HLinkNode<T> n = firstNode;
		while(n != null) {
			HLinkNode<T> nextNode = n.getNext();
			callback.run(n.getContent());
			n = nextNode;
		}
	}
	public HIterator<T> iterator() {
		return new HLinkedListIterator<T>(this);
	}
	public static class HLinkedListIterator<U> implements HIterator<U> {
		boolean started;
		HLinkedList<U> parentList;
		HLinkNode<U> currentNode;
		public HLinkedListIterator(HLinkedList<U> parent) {
			parentList = parent;
		}
		public boolean hasNext() {
			if(!started)
				return parentList.firstNode != null;
			return currentNode != null && currentNode.getNext() != null;
		}
		public U next() {
			if(!started) started = true;
			if(currentNode == null) currentNode = parentList.firstNode;
			else currentNode = currentNode.getNext();
			return currentNode.getContent();
		}
		public void remove() {
		}
	}
}
