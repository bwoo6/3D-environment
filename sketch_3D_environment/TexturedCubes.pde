void texturedCube(float x, float y, float z, PImage top, PImage side, PImage bottom, float size) {
  pushMatrix();
  textureMode(NORMAL);
  translate(x, y, z);
  scale(size);
  rotateX(rotx);
  rotateY(roty);

  noStroke();

  beginShape(QUADS);
  texture(top);
  //top
  //     x, y, z, tx, ty

  vertex(0, 0, 0, 0, 0);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 0, 1, 1, 1);
  vertex(0, 0, 1, 0, 1);


  endShape();

  beginShape(QUADS);
  texture(bottom);
  //bottom
  vertex(0, 1, 0, 0, 0);
  vertex(1, 1, 0, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(0, 1, 1, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(side);
  //front
  vertex(0, 0, 1, 0, 0);
  vertex(1, 0, 1, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(0, 1, 1, 0, 1);

  //back
  vertex(0, 0, 0, 0, 0);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 1, 0, 1, 1);
  vertex(0, 1, 0, 0, 1);

  //left
  vertex(0, 0, 0, 0, 0);
  vertex(0, 0, 1, 1, 0);
  vertex(0, 1, 1, 1, 1);
  vertex(0, 1, 0, 0, 1);

  //right
  vertex(1, 0, 0, 0, 0);
  vertex(1, 0, 1, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(1, 1, 0, 0, 1);

  endShape();
  popMatrix();
}
