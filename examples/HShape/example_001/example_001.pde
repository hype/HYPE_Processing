HShape s1,s2,s3,s4,s5,s6;

final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

void setup() {
  size(640,640);
  H.init(this).background(#202020);
  smooth();

  frameRate(6);
  
  s1 = new HShape("bot1.svg");
  H.add(s1)
    .scale(0.65f)
    .strokeWeight(3)
    .fill(#111111)
    .anchorAt(H.CENTER)
    .loc(120, height/2 - 100)
  ;
  
  s2 = new HShape("bot1.svg");
  H.add(s2)
    .scale(0.65f)
    .strokeWeight(3)
    .stroke(#000000)
    .noFill()
    .anchorAt(H.CENTER)
    .loc(width/2, height/2 - 100)
  ;
  
  s3 = new HShape("bot1.svg");
  H.add(s3)
    .scale(0.65f)
    .strokeWeight(3)
    .anchorAt(H.CENTER)
    .loc(width - 120, height/2 - 100)
  ;

  s4 = new HShape("bot1.svg");
  H.add(s4)
    .scale(0.65f)
    .strokeWeight(3)
    .fill(#111111)
    .anchorAt(H.CENTER)
    .loc(120, height/2 + 100)
  ;

  s5 = new HShape("bot1.svg");
  H.add(s5)
    .scale(0.65f)
    .strokeWeight(3)
    .stroke(#000000)
    .noFill()
    .anchorAt(H.CENTER)
    .loc(width/2, height/2 + 100)
  ;

  s6= new HShape("bot1.svg");
  H.add(s6)
    .scale(0.65f)
    .strokeWeight(3)
    .anchorAt(H.CENTER)
    .loc(width - 120, height/2 + 100)
  ;

  colors.strokeOnly();    s1.randomColors(colors);
  colors.fillOnly();      s2.randomColors(colors);
  colors.fillAndStroke(); s3.randomColors(colors);

  colors.strokeOnly();    s4.randomColors(colors);
  colors.fillOnly();      s5.randomColors(colors);
  colors.fillAndStroke(); s6.randomColors(colors);

}

void draw() {
  H.drawStage();

  colors.strokeOnly();    s4.randomColors(colors);
  colors.fillOnly();      s5.randomColors(colors);
  colors.fillAndStroke(); s6.randomColors(colors);
}
