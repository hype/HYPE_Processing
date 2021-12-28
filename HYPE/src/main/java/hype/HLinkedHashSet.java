package hype;

import java.util.HashMap;

public class HLinkedHashSet<T> extends HLinkedList<T> {
	private HashMap<T,HLinkedListNode<T>> nodeMap;

	public HLinkedHashSet() {
		nodeMap = new HashMap<T, HLinkedListNode<T>>();
	}

	// LATER peekAfter
	// LATER peekBefore
	// LATER putAfter
	// LATER putBefore

	public boolean remove(T content) {
		HLinkedListNode<T> node = nodeMap.get(content);
		if(node==null) return false;
		unregister(content);
		node.popOut();
		--size;
		return true;
	}

	@Override
	public boolean add(T content) {
		return contains(content)? false : super.add(content);
	}

	@Override
	public boolean push(T content) {
		return contains(content)? false : super.push(content);
	}

	@Override
	public boolean insert(T content, int index) {
		return contains(content)? false : super.insert(content, index);
	}

	@Override
	public T pull() {
		return unregister(super.pull());
	}

	@Override
	public T pop() {
		return unregister(super.pop());
	}

	@Override
	public T removeAt(int index) {
		return unregister(super.removeAt(index));
	}

	@Override
	public void removeAll() {
		while(size > 0) pop();
	}

	public boolean contains(T obj) {
		return nodeMap.get(obj) != null;
	}

	protected HLinkedListNode<T> register(T obj) {
		HLinkedListNode<T> node = new HLinkedListNode<T>(obj);
		nodeMap.put(obj,node);
		return node;
	}

	protected T unregister(T obj) {
		nodeMap.remove(obj);
		return obj;
	}
}
