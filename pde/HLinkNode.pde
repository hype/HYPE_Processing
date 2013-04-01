
public static class HLinkNode<T> {
	private HLinkNode<T> prev, next;
	private T content;
	
	public HLinkNode(T o) {
		content = o;
	}
	
	public T getContent() {
		return content;
	}
	
	public HLinkNode<T> getPrev() {
		return prev;
	}
	
	public HLinkNode<T> getNext() {
		return next;
	}
	
	public void replaceWith(HLinkNode<T> otherNode) {
		popOut();
		
		if(otherNode != null) {
			HLinkNode<T> otherPrev = otherNode.prev;
			HLinkNode<T> otherNext = otherNode.next;
			stitchTogether(otherPrev,this);
			stitchTogether(this,otherNext);
		}
	}
	
	public void putBefore(HLinkNode<T> otherNode) {
		popOut();
		
		if(otherNode != null) {
			HLinkNode<T> otherPrev = otherNode.prev;
			stitchTogether(otherPrev,this);
			stitchTogether(this,otherNode);
		}
	}
	
	public void putAfter(HLinkNode<T> otherNode) {
		popOut();
		if(otherNode != null) {
			HLinkNode<T> otherNext = otherNode.next;
			stitchTogether(otherNode,this);
			stitchTogether(this,otherNext);
		}
	}
	
	public void popOut() {
		stitchTogether(prev,next);
	}
	
	
	
	public static void swap(HLinkNode node1, HLinkNode node2) {
		if(node1 == null || node2 == null) return;
		
		HLinkNode prev1 = node1.prev;
		HLinkNode next1 = node1.next;
		HLinkNode prev2 = node2.prev;
		HLinkNode next2 = node2.next;
		
		stitchTogether(prev1,node2);
		stitchTogether(node2,next1);
		
		stitchTogether(prev2,node1);
		stitchTogether(node1,next2);
	}
	
	public static void stitchTogether(HLinkNode leftNode, HLinkNode rightNode) {
		if(leftNode != null) {
			if(leftNode.next != null) leftNode.next.prev = null;
			leftNode.next = rightNode;
		}
		if(rightNode != null) {
			if(rightNode.prev != null) rightNode.prev.next = null;
			rightNode.prev = leftNode;
		}
	}
}
