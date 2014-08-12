HDrawablePool pool;
HColorField colorField;

int numAssets = 576;
HProximity aProx;
PVector[] gridPos;
float[] aMin;
float[] aMax;

int cellSize = 25;

void setup() {
  size(640,640);
  H.init(this).background(#202020);
  smooth();

  gridPos = new PVector[numAssets];
  aMin = new float[numAssets];
  aMax = new float[numAssets];

  colorField = new HColorField(width, height)
      .addPoint(0, height/2, #FF0066, 0.5f)
      .addPoint(width, height/2, #3300FF, 0.5f)
      .fillOnly()
    ;

  pool = new HDrawablePool(numAssets);
  pool.autoAddToStage()
    .add ( new HRect(cellSize) )
    .layout (
      new HGridLayout()
      .startX(20)
      .startY(20)
      .spacing(cellSize+1,cellSize+1)
      .cols(24)
    )
    .onCreate (
        new HCallback() {
          public void run(Object obj) {
            int i = pool.currentIndex();

            HDrawable d = (HDrawable) obj;
            d.noStroke().fill( #000000, 10 ).anchorAt(H.CENTER);

            gridPos[i] = new PVector(d.x(), d.y());

            aMin[i] = 5;
            aMax[i] = cellSize * 2;

            colorField.applyColor(d);
        }
      }
    )
    .requestAll();

  // spring, ease, min(ArrayList), max(ArrayList), radius
  aProx = new HProximity(0.99, 0.1, aMin, aMax, 100);
}

void draw() {
  int i = 0;

  for(HDrawable d : pool) {
    d.size( int(aProx.run(i)) );
    d.anchorAt(H.CENTER);
    d.fill( #000000 );
    colorField.applyColor(d);
    i++;
  }

  H.drawStage();
}

