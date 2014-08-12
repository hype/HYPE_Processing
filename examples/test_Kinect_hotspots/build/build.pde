import SimpleOpenNI.*;

SimpleOpenNI context;
boolean      autoCalib=true;
PVector      bodyCenter = new PVector();
PVector      bodyDir = new PVector();

ArrayList<HDrawable> leftHands;
ArrayList<HDrawable> rightHands;

HCanvas canvasHands, canvasBody, canvasHits, canvasCam;
PGraphics skel;
HImage camImg;
HRect[] hitboxes;

void setup() {
  size(1280,1024,P3D);
  H.init(this).background(#000000).autoClear(true).use3D(true);
  smooth();
  context = new SimpleOpenNI(this);
  context.setMirror(true);

  // canvasHands = new HCanvas(P3D).autoClear(false).fade(10);
  canvasHands = new HCanvas(P3D).autoClear(true);
  PGraphics g = canvasHands.graphics();
  g.beginDraw();
    g.hint(DISABLE_DEPTH_TEST);
  g.endDraw();

  canvasHits  = new HCanvas().autoClear(true);
  canvasBody = new HCanvas(P3D).autoClear(false).fade(2);
  canvasCam   = new HCanvas().autoClear(true);

  H.add(canvasCam);
  H.add(canvasHits);
  H.add(canvasHands);
  H.add(canvasBody);

  camImg = new HImage();
  canvasCam.add(camImg)
    .alpha(30)
    .anchorAt(H.CENTER)
    .loc(width/2, height/2)
  ;

  skel = canvasBody.graphics();

  HRect h1 = new HRect(120,180); h1.rounding(5).noStroke().fill(#333333, 150).anchorAt(H.CENTER_X).loc(width/2 - 260,180); canvasHits.add(h1);
  HRect h2 = new HRect(120,180); h2.rounding(5).noStroke().fill(#333333, 150).anchorAt(H.CENTER_X).loc(width/2 - 130,180); canvasHits.add(h2);
  HRect h3 = new HRect(120,180); h3.rounding(5).noStroke().fill(#333333, 150).anchorAt(H.CENTER_X).loc(width/2 - 0  ,180); canvasHits.add(h3);
  HRect h4 = new HRect(120,180); h4.rounding(5).noStroke().fill(#333333, 150).anchorAt(H.CENTER_X).loc(width/2 + 130,180); canvasHits.add(h4);
  HRect h5 = new HRect(120,180); h5.rounding(5).noStroke().fill(#333333, 150).anchorAt(H.CENTER_X).loc(width/2 + 260,180); canvasHits.add(h5);
  hitboxes = new HRect[]{h1,h2,h3,h4,h5};

  leftHands = new ArrayList<HDrawable>(15);
  for(int i=1; i<=15; ++i) {

    HDrawable dot = new HRect(20).rounding(10).noStroke().fill( #FF3300, 255 ).anchorAt(H.CENTER);

    HGroup grp = new HGroup();
    grp.add(dot);

    leftHands.add(grp);
  }

  rightHands = new ArrayList<HDrawable>(15);
  for(int i=1; i<=15; ++i) {
    HDrawable dot = new HRect(20).rounding(10).noStroke().fill( #FF3300, 255 ).anchorAt(H.CENTER);

    HGroup grp = new HGroup();
    grp.add(dot);

    rightHands.add(grp);
  }

  if(context.enableDepth() == false) {
     println("Can't open the depthMap, maybe the camera is not connected!"); 
     exit();
     return;
  }

  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  perspective(radians(45),float(width)/float(height),10,150000);

  // translate(width/2, height/2, 0);
  // rotateX(radians(180));
  // rotateY(radians(0));
  // translate(0,0,-1000);
 }

void draw() {
  context.update();
  camImg.image( context.depthImage() ).size(1280,1024);

  H.drawStage();

  skel.beginDraw();
    skel.translate(width/2, height/2, 0);
    skel.rotateX(radians(180));
    skel.rotateY(radians(0));
    skel.translate(0,0,-1000);
      
  int[] userList = context.getUsers();
  boolean[] hitList = new boolean[hitboxes.length];
  for(int i=0;i<userList.length;i++) {
    if(context.isTrackingSkeleton(userList[i])) {
      int userId = userList[i];
      drawSkeleton(userId);
      
      HDrawable lhand = leftHands.get(userId);
      HDrawable rhand = rightHands.get(userId);
      float lx=lhand.x(), ly=lhand.y(), lz=lhand.z();
      float rx=rhand.x(), ry=rhand.y(), rz=rhand.z();

      for(int j=0; j<hitboxes.length; ++j) {
        if(hitList[j]) continue;

        HDrawable hitbox = hitboxes[j];
        hitList[j] = hitbox.contains(lx,ly,lz) || hitbox.contains(rx,ry,rz);
        if(hitList[j]) hitbox.fill(H.GREEN, 150);
        else hitbox.fill(#333333, 150);
      }
    }
  }

  skel.endDraw();
}

void drawSkeleton(int userId) {
  drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  

  // draw body direction
  getBodyDirection(userId,bodyCenter,bodyDir);
  bodyDir.mult(200);
  bodyDir.add(bodyCenter);
  skel.strokeWeight(2); skel.stroke(#FFCC00, 150);
  skel.line(bodyCenter.x,bodyCenter.y,bodyCenter.z, bodyDir.x ,bodyDir.y,bodyDir.z);
}

void drawLimb(int userId,int jointType1,int jointType2) {
  PVector jointPos1 = new PVector();
  PVector jointPos2 = new PVector();
  float  confidence;
  
  confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);
  confidence = context.getJointPositionSkeleton(userId,jointType2,jointPos2);

  skel.strokeWeight(2); skel.stroke(#FF3300, 150);
  skel.line(jointPos1.x,jointPos1.y,jointPos1.z, jointPos2.x,jointPos2.y,jointPos2.z);

  ArrayList<HDrawable> handList = (jointType2 == SimpleOpenNI.SKEL_LEFT_HAND)? leftHands : (jointType2 == SimpleOpenNI.SKEL_RIGHT_HAND)? rightHands : null;

  if(handList != null) {
    HDrawable hand = handList.get(userId);

    float x = width/2 + jointPos2.x;
    float y = height/2 - jointPos2.y;
    float z = 1000 - jointPos2.z;
    hand.loc(x,y,z);
  }
}

// -----------------------------------------------------------------
// SimpleOpenNI user events

void onNewUser(int userId) {
  println("onNewUser - userId: " + userId);
  println("  start pose detection");
  
  if(autoCalib) context.requestCalibrationSkeleton(userId,true);
  else context.startPoseDetection("Psi",userId);

  HDrawable lgrp = leftHands.get(userId); canvasHands.add(lgrp);
  HDrawable rgrp = rightHands.get(userId); canvasHands.add(rgrp);
}

void onLostUser(int userId) {
  println("onLostUser - userId: " + userId);
  
  HDrawable lgrp = leftHands.get(userId); canvasHands.remove(lgrp);
  HDrawable rgrp = rightHands.get(userId); canvasHands.remove(rgrp);
}

void onExitUser(int userId) {
  println("onExitUser - userId: " + userId);

  HDrawable lgrp = leftHands.get(userId); canvasHands.remove(lgrp);
  HDrawable rgrp = rightHands.get(userId); canvasHands.remove(rgrp);
}

void onReEnterUser(int userId) {
  println("onReEnterUser - userId: " + userId);
}

void onStartCalibration(int userId) {
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull) {
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);
  if (successfull) { 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId); 
  } else { 
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
    context.startPoseDetection("Psi",userId);
  }
}

void onStartPose(String pose,int userId) {
  println("onStartdPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");
  
  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
}

void onEndPose(String pose,int userId) {
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

void getBodyDirection(int userId,PVector centerPoint,PVector dir) {
  PVector jointL = new PVector();
  PVector jointH = new PVector();
  PVector jointR = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,jointL);
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,jointH);
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,jointR);
  
  // take the neck as the center point
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,centerPoint);
    
  PVector up = new PVector();
  PVector left = new PVector();
  
  up.set(PVector.sub(jointH,centerPoint));
  left.set(PVector.sub(jointR,centerPoint));
  
  dir.set(up.cross(left));
  dir.normalize();
}

// boolean sketchFullScreen() {
//   return true;
// }

