/*
 * HFontPool
 *
 * Helper class for HYPE framework - creates a pool of fonts
 *
 * HYPE_Processing
 * http://www.hypeframework.org/ & https://github.com/hype/HYPE_Processing
 *
 * Copyright (c) 2013-2017 Joshua Davis
 *
 * Distributed under the BSD License. See LICENSE.txt for details.
 *
 * All rights reserved.
 *
 */

package hype;

import java.util.ArrayList;
import processing.core.PApplet;
import processing.core.PFont;
import static processing.core.PApplet.max;
import static processing.core.PApplet.min;

public class HFontPool {
    private int currentIndex = -1;
    private String currentName = "";
    private ArrayList<PFont> fontList;
    PApplet app = H.app();

    public HFontPool() {
    }

    public HFontPool(Object... fonts) {
        PFont type;
        for (int i = 0; i < fonts.length; ++i) {
            if (fonts[i] instanceof String) {
                type = app.createFont((String) fonts[i], 24);
                add(type);
            }
            if (fonts[i] instanceof PFont) {
                add(fonts[i]);
            }
            if (fonts[i] instanceof HText) {
                HText temp = (HText) fonts[i];
                add(temp.font());
            }
        }
    }

    public HFontPool addSystemFonts() {
        String[] systemFontList;
        systemFontList = PFont.list(); //get all available system fonts
        PFont type;
        for (int i = 0; i < systemFontList.length; ++i) {
            type = app.createFont(systemFontList[i], 24);
            add(type);
        }
        return this;
    }

    public int setIndex(int i) {
        //ensure index within bounds
        if (i >= size() || i < 0) {
            currentIndex = 0;
            if (i < 0) {
                currentIndex = size() - 1;
            }
        } else {
            currentIndex = i;
        }
        return currentIndex;
    }

    public int currentIndex() {
        return currentIndex;
    }

    public String currentName() {
        PFont font;
        if (size() <= 0) {
            font = defaultFont();
        } else {
            font = fontList.get(currentIndex());
        }
        currentName = font.getName();
        return currentName;
    }

    public int size() {
        int num;
        if (fontList != null) {
            num = fontList.size();
        } else {
            num = 0;
        }
        return num;
    }

    public HFontPool add(Object font) {

        if (size() == 0) fontList = new ArrayList<PFont>();

        if (font instanceof PFont) {
            fontList.add((PFont) font);
        }
        if (font instanceof String) {
            PFont type;
            type = app.createFont((String) font, 24);
            fontList.add(type);
        }
        if (font instanceof HText) {
            HText temp = (HText) font;
            add(temp.font());
        }
        return this;
    }

    public HFontPool add(Object font, int freq) {
        if (font instanceof PFont) {
            while (freq-- > 0) add((PFont) font);
        }
        if (font instanceof String) {
            PFont type;
            while (freq-- > 0) {
                type = app.createFont((String) font, 24);
                add(type);
            }
        }
        if (font instanceof HText) {
            HText temp = (HText) font;
            while (freq-- > 0) {
                add(temp.font());
            }
        }

        return this;
    }

    public PFont getRandomFont() {
        //select a random font
        if (size() <= 0) {
            return defaultFont();
        } else {
            int rndIndex = HMath.randomInt(0, size());
            return getFontAt(rndIndex);
        }
    }

    //select subset of available fonts
    public PFont getRandomFont(int lower, int upper) {
        int lbound = max(0, lower);
        int ubound = min(upper, size());
        //select a random font
        if (size() <= 0) {
            return defaultFont();
        } else {
            int rndIndex = HMath.randomInt(lbound, ubound);
            return getFontAt(rndIndex);
        }
    }

    public PFont getNextFont() {
        // cycles forward through all available fonts
        if (size() <= 0) {
            return defaultFont();
        } else {
            currentIndex = setIndex(currentIndex + 1);
            return fontList.get(currentIndex);
        }
    }

    public PFont getPrevFont() {
        // cycles through all available fonts (in reverse order)
        if (size() <= 0) {
            return defaultFont();
        } else {
            currentIndex = setIndex(currentIndex - 1);
            return fontList.get(currentIndex);
        }
    }

    public PFont getFontAt(int index) {
        //extract a specific font by index
        if (size() <= 0) {
            return defaultFont();
        } else {
            currentIndex = setIndex(index);
            return fontList.get(currentIndex);
        }
    }

    private PFont defaultFont() {
        return app.createFont("SansSerif", 64);
    }

}
