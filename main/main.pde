import processing.sound.*;


// THE TWO MAIN SCREENS
// 0: Start Page (Instructions)
// 1: Game Window and Restart


SoundFile backgroundMusic;
SoundFile catchSound;

PImage backgroundImg;
PImage fruitImg;
PImage fruit2Img;
PImage playerImg;

PFont times;

int gameScreen = 0;

Timer timer ;

Game game1;

void setup() {
  size(640, 425);

  backgroundMusic= new SoundFile(this, "theme.mp3"); //change song length
  catchSound= new SoundFile(this, "boip.mp3");

  backgroundImg = loadImage("data/wood.jpg");

  playerImg =  loadImage("data/holdingplate.png");

  PImage [] foodsimgs = { loadImage("data/pizza.png"), loadImage("data/coke.png"),
    loadImage("data/fries.png"), loadImage("data/yoghurt.png"),
    loadImage("data/salad.png") };

  timer = new Timer(35, 60) ; // make the display at location (35,60)

  frameRate(30);
  

  game1 = new Game(backgroundImg, playerImg, timer, foodsimgs, catchSound, backgroundMusic);

  backgroundMusic.play();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      game1.player.moveLeft();
    }

    if (keyCode == RIGHT) {
      game1.player.moveRight();
    }
  }
}



void draw() {
  

  if (gameScreen == 0) {
    startScreen();
  } else {
    background(game1.bgimage);
    if (!game1.timeOut) {
      game1.play();
    } else {
      game1.showGameOver();

      if (keyPressed &&(key == 'R' || key == 'r') ) {
        game1.restartGame();
      }
    }
  }
}


void startScreen() {
  background(loadImage("data/market.png"));
  
  
   times = createFont("Times New Roman",60);

  
  textFont(times);
  textAlign(CENTER);
  fill(0, 408, 612, 204);
  textSize(60);
  text("It's Saturday Night", width/2, height/2-40);
  textSize(18);
  text("Stack Up as much food as you can by moving left and right with the arrow keys.", width/2, height/2);
  text("The clock is ticking!", width/2, height/2 + 50);
  textSize(20);

  //added rectangle as a highlighter to serve as a signal to the user
  rectMode(CENTER);
  rect(width/2, height-100, height/2, 30, 10);
  fill(255);
  text("Press Enter to start !", width/2, height-95);
}

void keyReleased()
{
  if ((keyCode == ENTER))
  {
    gameScreen = 1 ;
    game1.timer.start();
  }
}
