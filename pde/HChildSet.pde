

public static class HChildSet extends HLinkedHashSet<HDrawable> {
	private HDrawable _parent;
	
	public HChildSet(HDrawable parent) {
		_parent = parent;
	}
	
	protected HLinkNode<HDrawable> register(HDrawable d) {
		HDrawable dparent = d.parent();
		if(dparent != null)
			dparent.remove(d);
		d._set_parent_(_parent);
		return super.register(d);
	}
	
	protected HDrawable unregister(HDrawable d) {
		if(contains(d))
			d._set_parent_(null);
		return super.unregister(d);
	}
}
