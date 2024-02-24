class Food {
  int positionX;
  int positionY;
  int diameter;

  Food(int d) {
    this.diameter = d;
  }

  void drawFood() {
    fill(0, 255, 0);
    ellipse(positionX, positionY, diameter, diameter);
  }
  
  void initial() {
    lastFoodUpdateTime = 0;
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
    } while (positionOccupied);
    
    positionX = randomX;
    positionY = randomY;
  }
}
