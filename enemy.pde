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

  void Draw() {
    fill(255, 0, 0);
    ellipse(positionX, positionY, diameter, diameter);
  }

  void updatePosition(Player player, Wall[] walls, Enemy[] enemies) {
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
