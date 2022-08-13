
//game objects
class Item {
  PImage image;
  float xlocation;
  float ylocation;
  float _width;
  float _height;

  Item( PImage _image, float _xlocation, float _ylocation, float new_width, float new_height) {
    image = _image;
    xlocation = _xlocation;
    ylocation = _ylocation;
    _width = new_width;
    _height =new_height;
  }

  // draw item on screen
  void draw() {
    image(image, xlocation, ylocation, _width, _height);
  }

  //check intersection
  Boolean Intersect(Item newItem) {
    float itemwidth = newItem._width;
    float itemheight = newItem._height;
    float  itemxloc = newItem.xlocation;
    float itemyloc = newItem.ylocation;

    if (itemxloc < xlocation + _width &&
      itemxloc + itemwidth > xlocation &&
      itemyloc < ylocation + _height &&
      itemheight + itemyloc - 50
      > ylocation) {
      return true;
    }


    return false;
  }
}

class Player extends Item {
  
  Player( PImage _image, float xloc, float yloc, float w, float h) {
    super(_image,xloc, yloc, w , h);
  }
  
  void moveLeft(){
    if (xlocation - 10 > 0 ){
       xlocation -= 10;
    }
    
  }
  
  void moveRight(){
     if (xlocation+_width+10 < width ){
       xlocation += 10;
    }
  }

}


class Food extends Item {
  
  float speed;
  float originalspeed;
  int value;
  
  Food( PImage _image, float xloc, float _speed , int _value, float w, float h) {
    super(_image,xloc, random(-300, -100), w, h);
      speed = _speed;
      originalspeed = _speed;
      value = _value; // food value
  }
  
  
  
  //fall
  void fall(){
    ylocation = ylocation + speed;
    
    // add some velocity
    
    speed += 0.05;
    
    // reset to 
    if ( ylocation > height){
       ylocation = random(-300, -100);
       speed = originalspeed;
    }
  }
 

}
