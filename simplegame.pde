int diameter = 10;

int wallDiameter = diameter;
int numWalls = 100;
Wall[] walls;

int foodDiameter = diameter;
Food food;

int numEnemies = 5;
int enemyDiameter = diameter;
int enemyStep = enemyDiameter;
Enemy[] enemies;

int playerDiameter = diameter;
int playerStep = playerDiameter;
Player player;

int lastEnemyUpdateTime = 0;
int updateEnemyInterval = 10;

int lastFoodUpdateTime = 0;
int foodSpawnInterval = 10000;

int lastPlayerUpdateTime = 0;
int updatePlayerInterval = 2;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

boolean gameOver = false;

void setup() {
  size(800, 800);
  
  walls = initialWalls(numWalls, wallDiameter);
  
  enemies = initial(numEnemies, enemyDiameter);
  
  food = new Food(foodDiameter);
  
  player = new Player(playerDiameter, width, height);
  
  food.initial();
  
  player.initial();
}

void draw() { //<>//
  background(0);
  
  if (!gameOver) {
    
    drawGrid();
    drawWalls(walls);
    drawEnemies(enemies);
    food.drawFood();
    player.drawPlayer();
    
    if (frameCount - lastEnemyUpdateTime >= updateEnemyInterval) {
      updateEnemiesPosition();
      lastEnemyUpdateTime = frameCount;
    }
    
    if (frameCount - lastPlayerUpdateTime >= updatePlayerInterval) {
      player.updatePosition();
      lastPlayerUpdateTime = frameCount;
    }
    
    fill(255);
    textSize(20);
    text("Points: " + player.points, 10, 20);
    
    fill(255);
    textSize(20);
    text("5000/ " + int(millis() - lastFoodUpdateTime), 10, 40);
    
  } else {
    background(0);
    fill(255);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Game Over", width/2, height/2);
  }
}

void drawLine(int sx, int sy, int ex, int ey) {
  stroke(50);
  line(sx, sy, ex, ey);
}

void drawGrid() {
  for (int i = 0; i < width / playerDiameter; i++) {
    drawLine(int(i * playerDiameter), 0, int(i * playerDiameter), height);
  }
  
  for (int i = 0; i < height / playerDiameter; i++) {
    drawLine(0, int(i * playerDiameter), width, int(i * playerDiameter));
  }
}

void keyPressed() {
  if (keyCode == UP) {
    upPressed = true;
  }
  if (keyCode == DOWN) {
    downPressed = true;
  }
  if (keyCode == LEFT) {
    leftPressed = true;
  }
  if (keyCode == RIGHT) {
    rightPressed = true;
  }
  
  if (gameOver && key == 'r') {
    gameOver = false;
    setup();
    loop();
  }
}

void keyReleased() {
  if (keyCode == UP) {
    upPressed = false;
  }
  if (keyCode == DOWN) {
    downPressed = false;
  }
  if (keyCode == LEFT) {
    leftPressed = false;
  }
  if (keyCode == RIGHT) {
    rightPressed = false;
  }
}
