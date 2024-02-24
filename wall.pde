class Wall {
  int positionX;
  int positionY;
  int diameter;
  
  Wall(int x, int y, int d) {
    this.positionX = x;
    this.positionY = y;
    this.diameter = d;
  }
  
  void drawWall() {
    fill(255);
    ellipse(positionX, positionY, diameter, diameter);
  }
}

Wall[] initialWalls(int numWalls, int wallDiameter) {
  Wall[] walls = new Wall[numWalls];
  
  for (int i = 0; i < numWalls; i++) {
    int randomX, randomY;
    
    randomX = int(int(random(width / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
    randomY = int(int(random(height / wallDiameter) + 1) * wallDiameter) - (int(wallDiameter / 2));
    
    walls[i] = new Wall(randomX, randomY, wallDiameter);
  }
  
  return walls;
}

void drawWalls(Wall[] walls) {
  for (int i = 0; i < walls.length; i++) {
    walls[i].drawWall();
  }
}
