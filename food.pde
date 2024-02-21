class Food {
  int positionX;
  int positionY;
  int diameter;

  Food(int x, int y, int d) {
    this.positionX = x;
    this.positionY = y;
    this.diameter = d;
  }

  void draw() {
    fill(0, 255, 0);
    ellipse(positionX, positionY, diameter, diameter);
  }
}
