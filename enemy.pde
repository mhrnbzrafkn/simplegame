class Enemy {
  int positionX;
  int positionY;
  int diameter;
  int screenWidth;
  int screenHeight;

  Enemy(int x, int y, int d, int screenWidth, int screenHeight) {
    this.positionX = x;
    this.positionY = y;
    this.diameter = d;
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
  }

  void drawEnemy() {
    fill(255, 0, 0);
    ellipse(positionX, positionY, diameter, diameter);
  }

  void updatePosition(Player player) {
    int dx = player.positionX - positionX;
    int dy = player.positionY - positionY;

    if (abs(dx) > abs(dy)) {
      if (dx > 0) {
        move(diameter, 0, walls, enemies); // Move right
      } else {
        move(-diameter, 0, walls, enemies); // Move left
      }
    } else {
      if (dy > 0) {
        move(0, diameter, walls, enemies); // Move down
      } else {
        move(0, -diameter, walls, enemies); // Move up
      }
    }
  }

  void move(int dx, int dy, Wall[] walls, Enemy[] enemies) {
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
      
      positionX = newX;
      positionY = newY;
  }
}

Enemy[] initial(int numEnemies, int enemyDiameter) {
  Enemy[] enemies = new Enemy[numEnemies];
  
  for (int i = 0; i < numEnemies; i++) {
    int randomX = 0;
    int randomY = 0;
    boolean positionOccupied = false;
    
    do {
      randomX = int(int(random(width / enemyDiameter) + 1) * enemyDiameter) - (int(enemyDiameter / 2));
      randomY = int(int(random(height / enemyDiameter) + 1) * enemyDiameter) - (int(enemyDiameter / 2));
      
      for (int j = 0; j < walls.length; j++) {
        if (walls[j].positionX == randomX && walls[j].positionY == randomY) {
          positionOccupied = true;
          break;
        }
      }
    } while (positionOccupied);
    
    enemies[i] = new Enemy(randomX, randomY, enemyDiameter, width, height);
  }
  
  return enemies;
}

void drawEnemies(Enemy[] enemies) {
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].drawEnemy();
  }
}

void updateEnemiesPosition() {
  if (!gameOver) {
    for (int i = 0; i < numEnemies; i++) {
      enemies[i].updatePosition(player);
      
      if (dist(enemies[i].positionX, enemies[i].positionY, player.positionX, player.positionY) < (enemies[i].diameter + player.diameter) / 2) {
        player.points -= 10;
        
        if (player.points <= 0) {
          gameOver = true;
        }
        
        break;
      }
    }
  }
}
