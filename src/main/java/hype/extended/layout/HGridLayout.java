package hype.extended.layout;

import hype.HDrawable;
import hype.interfaces.HLayout;
import processing.core.PVector;

public class HGridLayout implements HLayout {
	private int currentIndex, numCols, numRows;
	private float startX, startY, startZ, xSpace, ySpace, zSpace;

	public HGridLayout() {
		xSpace = ySpace = zSpace = numCols = 16;
		numRows = 0;
	}

	public HGridLayout(int numOfColumns) {
		this();
		numCols = numOfColumns;
	}

	public HGridLayout(int numOfColumns, int numOfRows) {
		this();
		numCols = numOfColumns;
		numRows = numOfRows;
	}

	public HGridLayout currentIndex(int i) {
		currentIndex = i;
		return this;
	}

	public int currentIndex() {
		return currentIndex;
	}

	public HGridLayout resetIndex() {
		currentIndex = 0;
		return this;
	}

	public HGridLayout cols(int numOfColumns) {
		numCols = numOfColumns;
		return this;
	}

	public int cols() {
		return numCols;
	}

	public HGridLayout rows(int numOfRows) {
		numRows = numOfRows;
		return this;
	}

	public int rows() {
		return numRows;
	}

	public PVector startLoc() {
		return new PVector(startX, startY, startZ);
	}

	public HGridLayout startLoc(float x, float y) {
		startX = x;
		startY = y;
		startZ = 0;
		return this;
	}

	public HGridLayout startLoc(float x, float y, float z) {
		startX = x;
		startY = y;
		startZ = z;
		return this;
	}

	public float startX() {
		return startX;
	}

	public HGridLayout startX(float x) {
		startX = x;
		return this;
	}

	public float startY() {
		return startY;
	}

	public HGridLayout startY(float y) {
		startY = y;
		return this;
	}

	public float startZ() {
		return startZ;
	}

	public HGridLayout startZ(float z) {
		startZ = z;
		return this;
	}

	public PVector spacing() {
		return new PVector(xSpace, ySpace, zSpace);
	}

	public HGridLayout spacing(float xSpacing, float ySpacing) {
		xSpace = xSpacing;
		ySpace = ySpacing;
		return this;
	}

	public HGridLayout spacing(float xSpacing, float ySpacing, float zSpacing) {
		xSpace = xSpacing;
		ySpace = ySpacing;
		zSpace = zSpacing;
		return this;
	}

	public float spacingX() {
		return xSpace;
	}

	public HGridLayout spacingX(float xSpacing) {
		xSpace = xSpacing;
		return this;
	}

	public float spacingY() {
		return ySpace;
	}

	public HGridLayout spacingY(float ySpacing) {
		ySpace = ySpacing;
		return this;
	}

	public float spacingZ() {
		return zSpace;
	}

	public HGridLayout spacingZ(float zSpacing) {
		zSpace = zSpacing;
		return this;
	}

	@Override
	public PVector getNextPoint() {

		int layer = 0;
		int row = 0;
		int col = currentIndex % numCols;

		if (numRows > 0) {
			layer = (int) Math.floor( currentIndex / (numCols * numRows) );
			row = (int) Math.floor(currentIndex / numCols) - (layer * numRows);
		} else {
			row = (int) Math.floor(currentIndex / numCols);
		}

		++currentIndex;

		if (numRows > 0) {
			return new PVector(col* xSpace + startX, row* ySpace + startY, layer* zSpace + startZ);
		} else {
			return new PVector(col* xSpace + startX, row* ySpace + startY);
		}
	}

	@Override
	public void applyTo(HDrawable target) {
		target.loc(getNextPoint());
	}
}
