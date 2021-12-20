float scale = 1;
int columns;
int rows;
int frameCounter;

float forceScale;
float incrementValue;
float zOffset = 0;

PVector[] vectorArray;

ArrayList<Particle> particles;
ArrayList<ColorModel> colors;

PImage faceImage;

void setup() { 

  size(1440, 1920);
  
  faceImage = loadImage("face.png");
  
  background(#27231F);

  incrementValue = 0.1;
  particles = new ArrayList<Particle>();
  colors = new ArrayList<ColorModel>();
  scale = 10;
  rows = floor(height/scale) + 1;
  columns = floor(width/scale) + 1;
  vectorArray = new PVector[columns * rows];

  UpdateFlowField();

  for (var i = 0; i < 10000; i ++) {

    var x = random(faceImage.width);
    var y = random(faceImage.height);

    particles.add(new Particle(x, y, random(2, 8)));
  }
  
  colors.add(new ColorModel(#FEDA15));
  colors.add(new ColorModel(#DE0001));
  colors.add(new ColorModel(#C8651B));

  //colors.add(new ColorModel(#D8E1E7));
 // colors.add(new ColorModel(#FF5D00));
 // colors.add(new ColorModel(#00478F));
  
}


void draw() {

  UpdateFlowField();

  for (var particle : particles) {

    Follow(particle);

    var randomindex = (int)random(colors.size());
    
    var col = colors.get(randomindex).C;

    particle.Particulate(col);
    
  }


  if (frameCounter == 1000) {

    saveFrame("output/line-######.png");
    frameCounter = 0;
  }

  frameCounter++;
}


//---------------------------------------------------------------------------------------------------------------------------------------------//


void Follow(Particle currentParticle) {

  var currentPosition = currentParticle.GetPosition();
  
  var x = floor(currentPosition.x / scale);
  var y = floor(currentPosition.y / scale);
  
  var currentIndex = x + y * columns;

  var currentForce = vectorArray[currentIndex];

  currentParticle.ApplyForce(currentForce);
}



void UpdateFlowField() {

  float xOffset = 0;

  for (var y = 0; y < rows; y++ ) {

    float yOffset = 0;

    for (var x = 0; x < columns; x++) {

      var angle = noise(xOffset, yOffset) * TWO_PI * 2;
      var vectorFromAngle = PVector.fromAngle(angle);
      var index = x + y * columns;

      vectorFromAngle.setMag(1);
      vectorArray[index] = vectorFromAngle;
      xOffset += incrementValue;
    }
    yOffset += incrementValue;
  }
  zOffset += 0.0001;
}
