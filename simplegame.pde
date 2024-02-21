int numWalls = 40;
int numEnemies = 5;
int numFoods = 5;

int wallDiameter = 20;
int foodDiameter = wallDiameter;
int playerStep = wallDiameter;
int playerPoints = 100;

Wall[] walls = new Wall[numWalls];
Enemy[] enemies = new Enemy[numEnemies];
Food[] foods = new Food[numFoods];
Player player;

int lastPlayerUpdateTime = 0;
int updatePlayerInterval = 4;

int lastEnemyUpdateTime = 0;
int updateEnemyInterval = 20;

int lastFoodUpdateTime = 0;
int foodSpawnInterval = 5000;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

boolean gameOver = false;

void setup() {
  size(800, 800);
  
  initial_walls();
  initial_player();
  initial_enemies();
  initial_foods();
}

void draw() {
  background(0);
  
  if (!gameOver) {
    draw_grid();
    draw_walls();
    player.Draw();
    draw_enemies();
    draw_foods();
    check_food_collision();
    
    if (frameCount - lastPlayerUpdateTime >= updatePlayerInterval) {
      updatePlayerPosition();
      lastPlayerUpdateTime = frameCount;
    }
    
    if (frameCount - lastEnemyUpdateTime >= updateEnemyInterval) {
      update_enemies();
      lastEnemyUpdateTime = frameCount;
    }
    
    if (millis() - lastFoodUpdateTime >= foodSpawnInterval) {
      initial_foods();
      lastFoodUpdateTime = millis();
    }
    
    fill(255);
    textSize(20);
    text("Points: " + playerPoints, 10, 20);
    
  } else {
    background(0);
    fill(255);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Game Over", width/2, height/2);
  }
}

void draw_line(int sx, int sy, int ex, int ey) {
  stroke(100);
  line(sx, sy, ex, ey);
}

void draw_grid() {
  for (int i = 0; i < width / wallDiameter; i++) {
    draw_line(int(i * wallDiameter), 0, int(i * wallDiameter), height);
  }
  
  for (int i = 0; i < height / wallDiameter; i++) {
    draw_line(0, int(i * wallDiameter), width, int(i * wallDiameter));
  }
}

void initial_walls() {
  for (int i = 0; i < walls.length; i++) {
    int randomX, randomY;
    boolean positionOccupied;
    do {
      positionOccupied = false;
      randomX = int(int(random(width / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
      randomY = int(int(random(height / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
      
      for (int j = 0; j < i; j++) {
        if (walls[j].positionX == randomX && walls[j].positionY == randomY) {
          positionOccupied = true;
          break;
        }
      }
    } while (positionOccupied);
    
    walls[i] = new Wall(randomX, randomY, wallDiameter);
  }
}

void draw_walls() {
  for (int i = 0; i < walls.length; i++) {
    walls[i].Draw();
  }
}

void initial_player() {
  int randomX, randomY;
  boolean positionOccupied;
  do {
    positionOccupied = false;
    randomX = int(int(random(width / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
    randomY = int(int(random(height / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
    
    for (int i = 0; i < walls.length; i++) {
      if (walls[i].positionX == randomX && walls[i].positionY == randomY) {
        positionOccupied = true;
        break;
      }
    }
  } while (positionOccupied);
  
  player = new Player(randomX, randomY, wallDiameter, width, height);
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

void updatePlayerPosition() {
  int dx = 0;
  int dy = 0;
  
  if (upPressed) {
    dy -= playerStep;
  }
  if (downPressed) {
    dy += playerStep;
  }
  if (leftPressed) {
    dx -= playerStep;
  }
  if (rightPressed) {
    dx += playerStep;
  }
  
  player.move(dx, dy, walls);
}

void initial_enemies() {
  for (int i = 0; i < numEnemies; i++) {
    int randomX, randomY;
    boolean positionOccupied;
    do {
      positionOccupied = false;
      randomX = int(int(random(width / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
      randomY = int(int(random(height / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
      
      if ((player.positionX == randomX && player.positionY == randomY) || isWall(randomX, randomY)) {
        positionOccupied = true;
        continue;
      }
      
      for (int j = 0; j < i; j++) {
        if (enemies[j].positionX == randomX && enemies[j].positionY == randomY) {
          positionOccupied = true;
          break;
        }
      }
    } while (positionOccupied);
    
    enemies[i] = new Enemy(randomX, randomY, wallDiameter, width, height);
  }
}

boolean isWall(int x, int y) {
  for (int i = 0; i < walls.length; i++) {
    if (walls[i].positionX == x && walls[i].positionY == y) {
      return true;
    }
  }
  return false;
}

void draw_enemies() {
  for (int i = 0; i < numEnemies; i++) {
    enemies[i].Draw();
  }
}

void update_enemies() {
  if (!gameOver) {
    for (int i = 0; i < numEnemies; i++) {
      enemies[i].updatePosition(player, walls, enemies);
      
      if (dist(enemies[i].positionX, enemies[i].positionY, player.positionX, player.positionY) < (enemies[i].diameter + player.diameter) / 2) {
        playerPoints = playerPoints - 10;
        
        if (playerPoints <= 0) {
          gameOver = true;
        }
        
        break;
      }
    }
  }
}

void draw_foods() {
  for (int i = 0; i < foods.length; i++) {
    foods[i].draw();
  }
}

void initial_foods() {
  foods = new Food[numFoods];
  for (int i = 0; i < foods.length; i++) {
    int randomX, randomY;
    boolean positionOccupied;
    do {
      positionOccupied = false;
      randomX = int(int(random(width / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
      randomY = int(int(random(height / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
      
      for (int j = 0; j < i; j++) {
        if (dist(randomX, randomY, foods[j].positionX, foods[j].positionY) < (foodDiameter + wallDiameter) / 2) {
          positionOccupied = true;
          break;
        }
      }
      for (int j = 0; j < walls.length; j++) {
        if (dist(randomX, randomY, walls[j].positionX, walls[j].positionY) < (foodDiameter + wallDiameter) / 2) {
          positionOccupied = true;
          break;
        }
      }
    } while (positionOccupied);
    
    foods[i] = new Food(randomX, randomY, foodDiameter);
  }
}

void check_food_collision() {
  for (int i = 0; i < foods.length; i++) {
    if (dist(player.positionX, player.positionY, foods[i].positionX, foods[i].positionY) < (player.diameter + foods[i].diameter) / 2) {
      playerPoints += 10;
      foods = removeAtIndex(foods, i);
    }
  }
}

Food[] removeAtIndex(Food[] array, int indexToRemove) {
  if (indexToRemove < 0 || indexToRemove >= array.length) {
    println("Invalid index to remove.");
    return array;
  }

  Food[] newArray = new Food[array.length - 1];

  for (int i = 0; i < indexToRemove; i++) {
    newArray[i] = array[i];
  }

  for (int i = indexToRemove + 1; i < array.length; i++) {
    newArray[i - 1] = array[i];
  }

  return newArray;
}
