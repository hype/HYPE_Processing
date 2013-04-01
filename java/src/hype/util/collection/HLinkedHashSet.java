package hype.util.collection;

import java.util.HashMap;

public class HLinkedHashSet<T> extends HLinkedList<T> {
	protected HashMap<T,HLinkNode<T>> nodeMap;
	
	public HLinkedHashSet() {
		nodeMap = new HashMap<T, HLinkNode<T>>();
	}
	
	@Override
	public boolean add(T obj) {
		if(contains(obj))
			return false;
		return addNode(register(obj));
	}
	
	// LATER peekAfter
	// LATER peekBefore
	// LATER putAfter
	// LATER putBefore
	// LATER iterator obj
	
	public boolean remove(T obj) {
		HLinkNode<T> node = nodeMap.get(obj);
		if(node == null) return false;
		
		if(node.equals(firstNode)) {
			pop();
		} else if(node.equals(lastNode)) {
			pull();
		} else {
			unregister(obj);
			node.popOut();
			length--;
		}
		return true;
	}
	
	@Override
	public T pull() {
		return unregister(super.pull());
	}
	
	@Override
	public boolean push(T obj) {
		if(contains(obj))
			return false;
		return pushNode(register(obj));
	}
	
	@Override
	public T pop() {
		return unregister(super.pop());
	}
	
	@Override
	public void removeAll() {
		nodeMap.clear();
		super.removeAll();
	}
	
	public boolean contains(T obj) {
		return nodeMap.get(obj) != null;
	}
	
	protected HLinkNode<T> register(T obj) {
		if(obj == null) return null;
		
		HLinkNode<T> node = new HLinkNode<T>(obj);
		nodeMap.put(obj,node);
		return node;
	}
	
	protected T unregister(T obj) {
		nodeMap.remove(obj);
		return obj;
	}
}
