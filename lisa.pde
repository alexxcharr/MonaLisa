PGraphics pg;
float posX;
float posY;
PImage lisa;
PImage[] segments = new PImage[16];
float a = 0.0;
float s = 0.0;

void setup() {
  size(720, 1080);
  lisa = loadImage("monalisa.jpg");
  lisa.resize(720, 0);  
  pg = createGraphics(720, 1080); //where I redraw the img
  imageMode(CENTER);
  frameRate(30);
}

void draw() {
  background(0);
  pg.beginDraw();
  pg.background(0);
  pg.fill(255);
  pg.noStroke();
  float pgres = 450; //pg resolution
  float pgstep = width/pgres; //cuts img depending on resolution

  for (float x = 0; x < lisa.width; x += pgstep) {
    for (float y = 0; y < lisa.height; y +=pgstep) {
      int pixelX = int(x + posX); // picking pixel x axis
      int pixelY = int(y + posY);  // picking pixel y axis

      color pixel = lisa.get(pixelX, pixelY);  //reads color of pixel
      float bri = brightness(pixel);  //calculates brightness of pixel

      float size = map(bri, 0, 255, 2, 0); //map brightness so that the size of rectangle depents on it
      pg.pushMatrix();
      pg.translate(x, y); //transaleting on x and y to draw there the rectangle
      pg. rect(0, 0, size, size);
      pg.popMatrix();
    }
  }
  pg.endDraw();
  translate(width/2, height/2);
  int w = width/16; 
  int c = 0;
  int x0 = 0;
  int x1 = w;
  a = a + 0.01;
  s = sin(a)*2;
  for (int x = 0; x < width; x = x + w) { // loopong thought x axis with step of width/16
   segments[c] = pg.get(x0, 0, x1, height); //cuting img in 16 columns and storing the pieces
   scale(s, -s);  //scaling every piece based on sine movement
   image(segments[c], x, 0); //showing img
   x0 = x0 + w; //updateting x0 location
   x1 = x1 +w; //updateting x1 location
   c++; //updateting counter
  }
  //saveFrame("out3/lisa_####.png");

}
