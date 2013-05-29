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
public static class HLinkedHashSet<T> extends HLinkedList<T> {
	private HashMap<T,HLinkedListNode<T>> nodeMap;
	public HLinkedHashSet() {
		nodeMap = new HashMap<T, HLinkedListNode<T>>();
	}
	public boolean remove(T content) {
		HLinkedListNode<T> node = nodeMap.get(content);
		if(node==null) return false;
		unregister(content);
		node.popOut();
		--_size;
		return true;
	}
	public boolean add(T content) {
		return contains(content)? false : super.add(content);
	}
	public boolean push(T content) {
		return contains(content)? false : super.push(content);
	}
	public boolean insert(T content, int index) {
		return contains(content)? false : super.insert(content, index);
	}
	public T pull() {
		return unregister(super.pull());
	}
	public T pop() {
		return unregister(super.pop());
	}
	public T removeAt(int index) {
		return unregister(super.removeAt(index));
	}
	public void removeAll() {
		while(_size > 0) pop();
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
