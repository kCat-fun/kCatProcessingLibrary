ClickParticle clickParticle;

void setup() {
    clickParticle = new ClickParticle(this);
    clickParticle.setColor(color(200, 230, 255))
    .setRadius(2.0);
    size(800, 500);
}

void draw() {
    background(0);
    textAlign(LEFT, TOP);
    fill(255);
    textSize(15);
    text("isParticle: "+clickParticle.isParticle(), 5, 5);
}
