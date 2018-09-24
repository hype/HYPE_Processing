import hype.*;
import hype.extended.colorist.*;
import hype.extended.layout.HGridLayout;

HColorPool      colors;
HDrawablePool   pool;
HFontPool       fonts;

void setup() {
  size(900, 900, P2D);
  H.init(this).background(#202020).use3D(false);
  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);
  noLoop();

  PFont font1, font2, font3, font4;
  font1 = createFont("DroidSerifRegular.ttf", 18);
  font2 = createFont("DroidSerifItalic.ttf", 48);
  font3 = createFont("DroidSerifBold.ttf", 48);
  font4 = createFont("DroidSerifBoldItalic.ttf", 48);

  fonts = new HFontPool(font1, font2, font3, font4);

  pool = new HDrawablePool(4);
  pool.autoAddToStage()
    .add(new HText("", 24, null))
    .layout(
    new HGridLayout()
    .startX(40)
    .startY(40)
    .spacing(36, 36)
    .cols(1)
    )
    .onCreate(
    new HCallback() {
    public void run(Object obj) {
      int i = pool.currentIndex();
      HText t = (HText) obj;
      t.fill( colors.getColor() );
      t.font(fonts.getFontAt(i)); 
      t.text(i+1 + ". " + fonts.currentName());
      t.anchorAt(H.LEFT);
    }
  }
  )
  .requestAll()
    ;

  H.drawStage();
}

void draw() {
}