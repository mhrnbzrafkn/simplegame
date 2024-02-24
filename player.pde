class Player {
  int positionX;
  int positionY;
  int diameter;
  int screenWidth;
  int screenHeight;
  int points;
  
  Player(int d, int screenWidth, int screenHeight) {
    this.diameter = d;
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    initial();
    points = 20;
  }
  
  void increasePoints() {
    points += 10;
  }
  
  void decreasePoints() {
    points -= 10;
  }
  
  void drawPlayer() {
    fill(0, 0, 255);
    ellipse(positionX, positionY, diameter, diameter);
  }
  
  void move(int dx, int dy) {
    int newX = positionX + dx;
    int newY = positionY + dy;
    
    if (newX < 0 || newX > screenWidth || newY < 0 || newY > screenHeight) {
      return;
    }
    
    for (int i = 0; i < walls.length; i++) {
      if (dist(newX, newY, walls[i].positionX, walls[i].positionY) < (diameter + wallDiameter) / 2) {
        return;
      }
    }
      
    for (int i = 0; i < enemies.length; i++) {
      if (dist(newX, newY, enemies[i].positionX, enemies[i].positionY) < (diameter + enemies[i].diameter) / 2) {
        return;
      }
    }
    
    float distanceToFood = dist(newX, newY, food.positionX, food.positionY);
    
    if (distanceToFood < (diameter + foodDiameter) / 2) {
      increasePoints();
      food.initial();
      lastFoodUpdateTime = millis();
    } else if (millis() - lastFoodUpdateTime >= foodSpawnInterval) {
      decreasePoints();
      food.initial();
      lastFoodUpdateTime = millis();
    }
    
    positionX = newX;
    positionY = newY;
  }
  
  void initial() {
    int randomX = 0;
    int randomY = 0;
    boolean positionOccupied = false;
    
    do {
      randomX = int(int(random(width / diameter) + 1) * diameter) - (int(diameter / 2));
      randomY = int(int(random(height / diameter) + 1) * diameter) - (int(diameter / 2));
      
      for (int i = 0; i < walls.length; i++) {
        if (walls[i].positionX == randomX && walls[i].positionY == randomY) {
          positionOccupied = true;
          break;
        }
      }
      
      for (int i = 0; i < enemies.length; i++) {
        if (enemies[i].positionX == randomX && enemies[i].positionY == randomY) {
          positionOccupied = true;
          break;
        }
      }
      
      if (food.positionX == randomX && food.positionY == randomY) {
        positionOccupied = true;
        break;
      }
      
    } while (positionOccupied);
    
    positionX = randomX;
    positionY = randomY;
  }
  
  void updatePosition() {
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
    
    move(dx, dy);
  }
}
