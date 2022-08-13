// game itself
class Game {
  PImage bgimage;
  PImage playerimage;
  PImage [] foodimages;
  SoundFile catchSound;
  SoundFile backgroundMusic;
  Timer timer;
  int totalGameTime;
  Player player;
  Boolean timeOut;
  int score;
  ArrayList<Food> Fooditems;
  int foodspeed;
  Game(PImage _bgimage, PImage _playerimage, Timer _timer, PImage [] _foodimages, SoundFile _catchSound, SoundFile _backgroundMusic) {
    bgimage = _bgimage;
    playerimage = _playerimage;
    foodimages = _foodimages;
    timer = _timer;
    catchSound = _catchSound;
    backgroundMusic = _backgroundMusic;
    totalGameTime = 30; // 30 seconds
    timeOut = false;
    Fooditems = new ArrayList<Food>();
    score = 0;
    foodspeed = 3;
    player = new Player(playerimage, width/2, height - 80, 200, 100);
    createFood();
  }
  void play() {
    backgroundMusic.amp(0.1);
    if (!backgroundMusic.isPlaying()) {
      backgroundMusic.play();
    }
    drawGameScene();
    moveFood();
    checkIntersection();
    checkGameOver();
  }
  void createFood() {
    // food value is based on food type
    // height and width of food is 10% of original size
    // the x coordinates of each food is random
    for ( int i = 1; i < 7; i++) {
      int foodtype = int(random(5));
      Fooditems.add(new Food(foodimages[foodtype], random(30, width-100), foodspeed, foodtype, foodimages[foodtype].width*0.1, foodimages[foodtype].height*0.1));
    }
  }
  void drawGameScene() {
    timer.DisplayTime(totalGameTime);
    showScore(); // draw fruits
    for (int i =0; i < Fooditems.size(); i++) {
      Fooditems.get(i).draw();
    }
    // draw player
    player.draw();
  }
  void moveFood() {
    for (int i =0; i < Fooditems.size(); i++) {
      Fooditems.get(i).fall();
    }
  }
  // stockFood once one is removed from stack
  void stockFood() {
    int foodtype = int(random(5));
    Fooditems.add(new Food(foodimages[foodtype], random(30, width-100), foodspeed, foodtype, foodimages[foodtype].width*0.1, foodimages[foodtype].height*0.1));
  } 
  // check if player touches food
  void checkIntersection() {
    for (int i =0; i < Fooditems.size(); i++) {
      if (player.Intersect(Fooditems.get(i))) {
        score += Fooditems.get(i).value;
        Fooditems.remove(Fooditems.get(i));
        catchSound.play();
        stockFood();
      }
    }
  }
  void checkGameOver() {
    if (timer.currentTime() == totalGameTime) {
      timeOut = true;
      timer.pause();
    }
  }
  void restartGame() {
    timer.restart();
    timeOut = false;
    score = 0;
  }
  void showScore() {
    fill(60);
    text("Score: " + str(score), width - 140, 60);
  }
  void showGameOver() {
    if (!backgroundMusic.isPlaying()) {
      backgroundMusic.play();
    }
    backgroundMusic.amp(1.0);
    text("Beat that!", width/2, 80);
     //text("Beat that!", width/2, 80+);
    text("SCORE: " + str(score), width/2, height/2);
    text("Press Left ball to restart ", width/2, height/2 + 100);
  }
}
