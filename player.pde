class Player {
  int positionX;
  int positionY;
  int diameter;
  int screenWidth;
  int screenHeight;
  
  Player(int x, int y, int d, int screenWidth, int screenHeight) {
    this.positionX = x;
    this.positionY = y;
    this.diameter = d;
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
  }
  
  void Draw() {
    fill(0, 0, 255);
    ellipse(positionX, positionY, diameter, diameter);
  }
  
  void move(int dx, int dy, Wall[] walls) {
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
    
    positionX = newX;
    positionY = newY;
  }
}
