package hype;

import hype.extended.colorist.HColorPool;
import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PVector;

import static processing.core.PApplet.*;

//public class HLine extends HDrawable {
public class HLine extends HDrawable3D {
    private float x1 = 0, x2 = 0, y1 = 100, y2 = 100, z1 = 0, z2 = 0;
    private HColorPool colors;

    public HLine() {
    }

    public float x1() {
        return x1;
    }

    public float x2() {
        return x2;
    }

    public float y1() {
        return y1;
    }

    public float y2() {
        return y2;
    }

    public float z1() {
        return z1;
    }

    public float z2() {
        return z2;
    }

    public HLine(float startx, float starty, float endx, float endy) {
        x1 = startx;
        y1 = starty;
        x2 = endx;
        y2 = endy;
    }

    public HLine(float startx, float starty, float startz, float endx, float endy, float endz) {
        x1 = startx;
        y1 = starty;
        z1 = startz;
        x2 = endx;
        y2 = endy;
        z2 = endz;
    }

    public HLine position(float startx, float starty, float endx, float endy) {
        x1 = startx;
        y1 = starty;
        x2 = endx;
        y2 = endy;
        return this;
    }

    public HLine position(float startx, float starty, float startz, float endx, float endy, float endz) {
        x1 = startx;
        y1 = starty;
        z1 = startz;
        x2 = endx;
        y2 = endy;
        z2 = endz;
        return this;
    }

    public HLine position(HDrawable a, HDrawable b) {
        x1 = a.x();
        x2 = b.x();
        y1 = a.y();
        y2 = b.y();
        z1 = a.z();
        z2 = b.z();
        return this;
    }

    public HLine position(PVector a, PVector b) {
        x1 = a.x;
        x2 = b.x;
        y1 = a.y;
        y2 = b.y;
        z1 = a.z;
        z2 = b.z;
        return this;
    }


    public HLine x1(float f) {
        x1=f;
        return this;
    }

    public HLine x2(float f) {
        x2=f;
        return this;
    }

    public HLine y1(float f) {
        y1=f;
        return this;
    }

    public HLine y2(float f) {
        y2=f;
        return this;
    }

    public HLine z1(float f) {
        z1=f;
        return this;
    }

    public HLine z2(float f) {
        z2=f;
        return this;
    }

    public HLine gradient(HColorPool c) {
        colors = c;
        return this;
    }

    @Override
    public HLine createCopy() {
        HLine copy = new HLine();
        copy.x1 = x1;
        copy.x2 = x2;
        copy.y1 = y1;
        copy.y2 = y2;
        copy.z1 = z1;
        copy.z2 = z2;
        if (colors != null) copy.colors = colors;
        copy.copyPropertiesFrom(this);
        return copy;
    }


    @Override
    public void draw(PGraphics g, boolean usesZ,
                     float drawX, float drawY, float alphaPc
    ) {
        applyStyle(g, alphaPc);

        if (usesZ) {
            if (colors == null) {
                g.line(x1, y1, z1, x2, y2, z2);
            } else {
// gradient
                int max = colors.size();
                int clr = colors.getColorAt(0);
                g.beginShape(PConstants.LINES);
                g.stroke(clr);
                g.vertex(x1, y1, z1);
                for (int index = 1; index < max-1; index++) {
                    float pc = (float)index / (max);
                    clr = colors.getColorAt(index);
                    float x = lerp(x1, x2, pc);
                    float y = lerp(y1, y2, pc);
                    float z = lerp(z1, z2, pc);
                    g.stroke(clr);
                    g.vertex(x, y, z);
                    g.stroke(clr);
                    g.vertex(x, y, z);
                }
                clr = colors.getColorAt(max-1);
                g.stroke(clr);
                g.vertex(x2, y2, z2);
                g.endShape();
// end gradient
            }
        } else {
            if (colors == null) {
                g.line(x1, y1, x2, y2);
            } else {
                //gradient
                int max = colors.size();
                int clr = colors.getColorAt(0);
                g.beginShape(PConstants.LINES);
                g.stroke(clr);
                g.vertex(x1, y1);
                for (int index = 1; index < max-1; index++) {
                    float pc = (float)index / (max);
                    clr = colors.getColorAt(index);
                    float x = lerp(x1, x2, pc);
                    float y = lerp(y1, y2, pc);
                    g.stroke(clr);
                    g.vertex(x, y);
                    g.stroke(clr);
                    g.vertex(x, y);
                }
                clr = colors.getColorAt(max-1);
                g.stroke(clr);
                g.vertex(x2, y2);
                g.endShape();
// end gradient
            }
        }
    }
}

