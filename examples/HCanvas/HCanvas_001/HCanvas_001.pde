import hype.*;

HCanvas canvas;
HRect   rect;

void setup() {
    size(640,640);
    H.init(this).background(#242424);

    canvas = new HCanvas().autoClear(false).fade(5);
    H.add(canvas);

    canvas.add( rect = new HRect(50).rounding(5) ).noStroke().fill(#FF3300).rotate(45);
}

void draw() {
    rect.loc( (int)random(width), (int)random(height));
    H.drawStage();
}
