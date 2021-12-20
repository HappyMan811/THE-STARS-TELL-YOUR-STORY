class Particle{
  
  float currentSpeed;
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector previousPosition;
  
  
  //------------------------------------------------------------------------------------//
  
  float GetSpeed(){
    return currentSpeed;
  }  
  
  PVector GetPosition(){
    return position;
  }
  
  PVector GetAcceleration(){
    return acceleration;
  }
  
  PVector GetVelocity(){
    return velocity;
  }
  
  
  //------------------------------------------------------------------------------------//
  
  
  Particle(float x, float y, float z, float speed) {
    
    position = new PVector(x,y,z);    
    currentSpeed = speed;    
    Initialize();
    
  }  
  
  Particle(float x, float y, float speed) {
    
    position = new PVector(x,y);
    currentSpeed = speed;    
    Initialize();
    
  }
  
  
  //------------------------------------------------------------------------------------//
  
   void Initialize(){
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    previousPosition = position.copy();
  }
  
  
  void ApplyForce(PVector force){    
    acceleration.add(force);      
  }
  
  
   void updatePreviousPos() {
    this.previousPosition.x = position.x;
    this.previousPosition.y = position.y;
  }
  
  
  void Particulate(color col){
    
    position.add(velocity);
    velocity.limit(currentSpeed);
    velocity.add(acceleration);
    acceleration.mult(0);
    
    if(position.x > faceImage.width){
      position.x = 0;
      updatePreviousPos();
    }
    
    if(position.x < 0){
      position.x = faceImage.width;
      updatePreviousPos();
    }
    
    if(position.y > faceImage.height){
      position.y  = 0;
      updatePreviousPos();
    }
    
    if(position.y < 0){
      position.y = faceImage.height;
      updatePreviousPos();
    }    
      
      
      var index = int(position.x) + int(position.y) * faceImage.width;
      
      if(index < faceImage.pixels.length){
        
        var pixelColor = faceImage.pixels[index];      
        var currentR = pixelColor >> 16 & 0xFF;
        
        if(currentR != 255){
        
          stroke(col,5);
          strokeWeight(0.5);
          line(position.x, position.y, previousPosition.x, previousPosition.y);        
        }        
      }
      
      updatePreviousPos();
    
  }
  
  
}
