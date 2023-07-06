Particle positionParticle;

void setup() {
    positionParticle = new Particle(this);
    positionParticle.setColor(color(255, 230, 220))
    .setRadius(1.7);
    frameRate(60);
    size(800, 500);
}

void draw() {
    background(0);
    
    if(frameCount % 120 == 0) {
        positionParticle.drawing(random(width), random(height));
    }
    
    fill(255);
    textSize(15);
    textAlign(LEFT, TOP);
    text("isDrawing: "+positionParticle.isDrawing(), 5, 5);
}
