import java.awt.Robot;
//color pallette
color black = #000000; // log
color white = #FFFFFF; // empty
color dullBlue = #7092BE; // mossy brick
//Map
int gridSize;
PImage map;

//textures
PImage mossystone;
PImage logtop;
PImage logside;
PImage glass;
PImage diamond;

float rotx, roty;

Robot rbt;


boolean skipFrame;

boolean wkey, akey, skey, dkey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ;
float leftRightHeadAngle, upDownHeadAngle;

void setup() {
  size(displayWidth, displayHeight, P3D);

  diamond=loadImage("diamond.png");
  mossystone = loadImage("mossy.png");
  logside = loadImage("logside.png");
  logtop=loadImage("logtop.png");
  glass = loadImage("glass.png");

  textureMode(NORMAL);
  wkey=akey=skey=dkey=false;

  eyeX=width/2;
  eyeY=9*height/10;
  eyeZ=height/2;

  focusX=width/2;
  focusY=height/2;
  focusZ=height/2-100;

  upX=0;
  upY=1;
  upZ=0;

  map = loadImage("map.png");

  gridSize=100;

  leftRightHeadAngle=radians(270);
  noCursor();
  try {
    rbt=new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  skipFrame=false;
}

void draw() {
  background(0);
  
  pointLight(255,255,255,eyeX,eyeY,eyeZ);
  
  drawFloor(-2000, 2000, height, gridSize); //floor
  drawFloor(-2000, 2000, height-gridSize*3, gridSize);     //ceiling
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawFloor(int start, int end, int level, int gap) {
  stroke(255);
  strokeWeight(1);
  int x = start;
  int z = start;
  while (z<end) {
    texturedCube(x, level, z, logtop, logside, logtop, gap);
    x=x+gap;
    if (x>=end) {
      x=start;
      z=z+gap;
    }
  }
}


void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);
      if (c==dullBlue||c==black) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, mossystone, mossystone, mossystone, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, mossystone, mossystone, mossystone, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, mossystone, mossystone, mossystone, gridSize);
      }
    }
  }
}


void drawFocalPoint() {
  //focus dot
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}


void controlCamera() {
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ);

  if (wkey) {
    eyeX = eyeX + cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle)*10;
  }

  if (skey) {
    eyeX = eyeX - cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle)*10;
  }

  if (akey) {
    eyeX = eyeX - cos(leftRightHeadAngle+PI/2)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle+PI/2)*10;
  }

  if (dkey) {
    eyeX = eyeX - cos(leftRightHeadAngle-PI/2)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle-PI/2)*10;
  }

  if (skipFrame==false) {
    leftRightHeadAngle=leftRightHeadAngle+(mouseX-pmouseX)*0.01;
    upDownHeadAngle=upDownHeadAngle+(mouseY-pmouseY)*0.01;
  } 

  if (upDownHeadAngle > PI/2.5) upDownHeadAngle=PI/2.5;
  if (upDownHeadAngle > -PI/2.5) upDownHeadAngle=-PI/2.5;

  focusX = eyeX+cos(leftRightHeadAngle)*300;
  focusZ = eyeZ+sin(leftRightHeadAngle)*300;
  focusY = eyeY+tan(upDownHeadAngle)*300;

  if (mouseX<2) {
    rbt.mouseMove(width-3, mouseY);
    skipFrame=true;
  } else if (mouseX >width-2) {
    rbt.mouseMove(3, mouseY);
    skipFrame=true;
  } else {
    skipFrame=false;
  }
}


void keyPressed() {
  if (key=='W'||key=='w') wkey=true; 
  if (key=='A'||key=='a') akey=true; 
  if (key=='S'||key=='s') skey=true; 
  if (key=='D'||key=='d') dkey=true;
}

void keyReleased() {
  if (key=='W'||key=='w') wkey=false; 
  if (key=='A'||key=='a') akey=false; 
  if (key=='S'||key=='s') skey=false; 
  if (key=='D'||key=='d') dkey=false;
}
