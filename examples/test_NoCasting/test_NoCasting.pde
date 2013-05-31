/* 
 * This testfile demonstrates the recently added
 * feature that lets you call H.add() and remove()
 * to assign variables without needing to cast them.
 *
 * Be noted that the problems presented in this test
 * file were only relevant in *Java Mode*, due to the
 * language's strict typing.
 *
 * Anyway, I've deviced a simple workaround for this.
 * 
 * 
 * 
 * TL;DR Version:
 * --------------
 * Instead of:
 *
 *     HRect r = (HRect) H.add(new HRect());
 * 
 * You can now do this:
 * 
 *     HRect r = H.add(new HRect());
 * 
 * 
 *
 * Technical:
 * ----------
 * I simply made multiple add() and remove() methods
 * for each drawable class in class H.
 * 
 * Even though I have more than one of each of the
 * aforementioned methods, this wouldn't cause an
 * issue with JS Mode. All those functions would have
 * just merged into the original H.add() and H.remove()
 * functions, which would work just fine due to its
 * weak typing.
 */

void setup() {
  size(600,600);
  H.init(this);
  
  /*
   * Before this build, whatever H.add() takes in, it
   * would return it as type HDrawable, instead of the
   * actual subclass of its argument.
   * 
   * So if you wanted to assign an HRect (or any other
   * HDrawable subclass) and add them to the stage
   * simultaneously, you need to cast it like in the
   * following: 
   */
  HRect rect = (HRect) H.add(new HRect());
  
  /* 
   * Not including (HRect) would have caused a casting
   * error in Java Mode.
   * 
   * Simultaneous removing and assigning is
   * also a similar case:
   */
  HRect rectThatHasJustBeenRemoved = (HRect) H.remove(rect);
  //HRect rectThatHasJustBeenRemoved = H.remove(rect);
  
  /*
   * Other than making you type more letters to
   * the code, it's also easy to make this
   * mistake:
   */
  //H.add( new HEllipse() ).radius(50);
  
  /*
   * ... and you're forced to put the HEllipse-specific
   * radius() method inside H.add():
   */
  H.add( new HEllipse().radius(50) );
  
  /* 
   * Otherwise, it would have caused an error, saying
   * that radius() does not exist in class HDrawable.
   */
  
  /*
   * Of course we no longer have this problem with this
   * current build.
   *
   * Here, I could call the HPath-specific
   * star() method *outside* H.add() 
   */
  HPath star = H.add( new HPath() ).star(5, H.PHI_1, -90);
  
  
  /*
   * You still need to be careful with chaining
   * methods though, especially with generic
   * HDrawable methods.
   * 
   * As a rule of thumb, if you call a chainable method
   * that can be found in HDrawable's documentation, that
   * method will return with type HDrawable.
   */
  star.loc(300,300); // loc() is a generic, non-HPath-specific
                     // method and thus will return HDrawable.
  
  
  
  /*
   * Here's the list of classes that you no longer need to
   * cast with H.add() and H.remove() as of build_21030531.0:
   * 
   * - HCanvas
   * - HEllipse
   * - HGroup
   * - HImage
   * - HPath
   * - HRect
   * - HShape
   * - HText
   *
   * If you created your own HDrawable class, then you'll still
   * need to do the old casting thing.
   */
  
  
  H.drawStage();
  noLoop();
}
