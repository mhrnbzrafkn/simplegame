class Wall {
  int positionX;
  int positionY;
  int diameter;
  
  Wall(int x, int y, int d) {
    this.positionX = x;
    this.positionY = y;
    this.diameter = d;
  }
  
  void Draw() {
    fill(255);
    ellipse(positionX, positionY, diameter, diameter);
  }
}
