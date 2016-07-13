 * Updated July 2016 - now can size and position the image used for HPixelColorist
 * New positioning options are .loc(x,y) or can use .offsetX(x) and .offsetY(y)
 * Size options are .autoSize() and .size(width/height) or can separately use .height() or .width()
 * If you find any issues or have any feedback, you can contact me via twitter (@Garth_D) *
 *
 */

package hype.extended.colorist;
 
 import hype.H;
 import hype.HDrawable;
 import hype.interfaces.HImageHolder;
 import hype.interfaces.HColorist;
 import hype.HImage;
 import processing.core.PImage;
 import processing.core.PVector;
 import static processing.core.PApplet.abs;
 import static processing.core.PApplet.constrain;
 
public class HPixelColorist implements HColorist, HImageHolder {
  private PImage img;
  private boolean fillFlag, strokeFlag;
  private float offsetX=0; 
  private float offsetY=0;
  private int imgHeight = 0; 
  private int imgWidth = 0; 
  private boolean autoSize;

  public HPixelColorist() {
    fillAndStroke();
  }

  public HPixelColorist loc(float x, float y) {
    offsetX(x);
    offsetY(y);
    return this;
  }

  public PVector loc() {
    return new PVector(offsetX, offsetY);
  }

  public HPixelColorist offsetX(float x) {
    float tx = x < 0 ? abs(x) : -x;
    offsetX = tx;
    return this;
  }

  public float offsetX() {
    return offsetX;
  }

  public HPixelColorist offsetY(float y) {
    float ty = y < 0 ? abs(y) : -y;
    offsetY = ty;
    return this;
  }

  public float offsetY() {
    return offsetY;
  }

  public HPixelColorist autoSize() {
    if (imgHeight==0&&imgWidth==0) {
      autoSize = true;
      image(img);
    }
    return this;
  }

  public HPixelColorist size(int w, int h) {
    width(w);
    height(h);
    image(img);
    return this;
  }

  public PVector size() {
    return new PVector(imgWidth, imgHeight);
  }

  public HPixelColorist width(int w) {
    if (autoSize == false) {
      if (w < 0) {
        w = abs(w);
      }
      imgWidth = w;
      image(img);
    }
    return this;
  }

  public int width() {
    return imgWidth;
  }

  public HPixelColorist height(int h) {
    if (autoSize == false) {
      if (h < 0) {
        h = abs(h);
      }
      imgHeight = h;
      image(img);
    }
    return this;
  }

  public int height() {
    return imgHeight;
  }

  public HPixelColorist(Object imgArg) {
    this();
    image(imgArg);
  }

  @Override
    public HPixelColorist image(Object imgArg) {
    img = H.getImage(imgArg);

    if (autoSize) {
      imgWidth = H.app().width;
      imgHeight = H.app().height;
    }

    if (imgWidth!=0 && imgHeight!=0) {
      img.resize(imgWidth, imgHeight);
    }

    return this;
  }

  @Override
    public PImage image() {
    return img;
  }

  /** @deprecated */
  public HPixelColorist setImage(Object imgArg) {
    if (imgArg instanceof PImage) {
      img = (PImage) imgArg;
    } else if (imgArg instanceof HImage) {
      img = ((HImage) imgArg).image();
    } else if (imgArg instanceof String) {
      img = H.app().loadImage((String) imgArg);
    } else if (imgArg == null) {
      img = null;
    }
    return this;
  }

  /** @deprecated */
  public PImage getImage() {
    return img;
  }

  public int getColor(float x, float y) {
    x = abs(x);
    y = abs(y);
    return (img==null)? 0 : img.get(Math.round(x+offsetX), Math.round(y+offsetY));
  }

  @Override
    public HPixelColorist fillOnly() {
    fillFlag = true;
    strokeFlag = false;
    return this;
  }

  @Override
    public HPixelColorist strokeOnly() {
    fillFlag = false;
    strokeFlag = true;
    return this;
  }

  @Override
    public HPixelColorist fillAndStroke() {
    fillFlag = strokeFlag = true;
    return this;
  }

  @Override
    public boolean appliesFill() {
    return fillFlag;
  }

  @Override
    public boolean appliesStroke() {
    return strokeFlag;
  }

  @Override
    public HDrawable applyColor(HDrawable drawable) {
    int clr = getColor(drawable.x(), drawable.y());

    if (clr==0) {
      return drawable;
    }

    if (fillFlag)
      drawable.fill(clr, drawable.alpha());
    if (strokeFlag)
      drawable.stroke(clr);
    return drawable;
  }
}
