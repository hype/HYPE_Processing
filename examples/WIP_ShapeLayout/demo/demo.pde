/*

please note : only works in P2D

*/

HDrawablePool pool;

PShape myCanvas;
PVector[] vertsArray;
ArrayList<PVector> placementPoints = new ArrayList<PVector>();

final int count = 1000;

final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

void setup() {
	size(640,640,P2D);
	H.init(this).background(#202020);
	smooth();
	
	myCanvas = loadShape("MyShape.svg");
	shape(myCanvas);
	vertsArray = getVertices( myCanvas );

	//generate new points until size of placementPoints is == count
	while( placementPoints.size() < count ){

		//better to make random points within  myCanvas.x, myCanvas.width  and  myCanvas.y, myCanvas.height
		PVector randomPoint = new PVector( random(0,width), random(0,height) );

	   	if( pixelInPoly(vertsArray, randomPoint) ){
	   		placementPoints.add(randomPoint);
	   	}
	}

 	pool = new HDrawablePool(count);
 	pool.autoAddToStage()
		.add( new HRect().rounding(4).rotation(45) )
	    .setOnCreate (
		    new HCallback() {
		    	public void run(Object obj) {
		    		HDrawable d = (HDrawable) obj;
					d
						.fill(#181818)
						.stroke( colors.getColor() )
						.strokeWeight(2)
						.size( random(20, 40) )
						.anchorAt(H.CENTER)
					;
				}
			}
		)
		.requestAll();
}

void draw(){

	HIterator<HDrawable> it = pool.iterator();

	int index = 0;
	while( it.hasNext() ) {    
    	HDrawable d = it.next();
    	PVector p = placementPoints.get(index);
    	d.loc( p.x, p.y );

		index++;
  	}

	H.drawStage();
}

//detect if pos is within boundaries defined by list of verts

boolean pixelInPoly(PVector[] verts, PVector pos) {
	int i, j;
	boolean c=false;
	int sides = verts.length;
	for (i=0,j=sides-1;i<sides;j=i++) {
		if (( ((verts[i].y <= pos.y) && (pos.y < verts[j].y)) || ((verts[j].y <= pos.y) && (pos.y < verts[i].y))) &&
			(pos.x < (verts[j].x - verts[i].x) * (pos.y - verts[i].y) / (verts[j].y - verts[i].y) + verts[i].x)) {
			c = !c;
		}
	}
	return c;
}

//get list of vertices that define shape of given PShape
//Sometimes svgs are separated into different shapes, as in the case with "MyShape.svg", so we iterate through them as children and add their verticies to our list
PVector[] getVertices(PShape canvas){

	ArrayList<PVector> _vertsList = new ArrayList<PVector>();
	ArrayList<PShape> _children = new ArrayList<PShape>();
	PVector[] _vertsArray;

	int vertexCount = 0;
	int noOfChildren = 0;

	while(true) {
		try {
			_children.add( canvas.getChild(noOfChildren) );
			int currentCount =  canvas.getChild(noOfChildren).getVertexCount();	
			vertexCount += currentCount;

			for( int i = 0; i < currentCount; i++ ) {
				_vertsList.add( canvas.getChild(noOfChildren).getVertex(i) );
			}

			noOfChildren++;

		} 
		catch (Exception e) {
			break;
		}
	}

	_vertsArray = new PVector[ vertexCount ];

	for( int i = 0; i < vertexCount; i++ ) {
		_vertsArray[i] = PVector.add(_vertsList.get(i), new PVector() );
	}

	return _vertsArray;
}