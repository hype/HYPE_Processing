Mover mover;

void setup() {
    size(300, 300, P3D);
    smooth(4);

    H.init(this).background(#ffffff);
    HCanvas canvas = new HCanvas(P3D).autoClear(false).background(#ffffff).fade(5);

    H.add(canvas);

    mover = new Mover();
    canvas.add(mover);
}

void draw() {
	H.drawStage();
}
