Particle particle;

void setup() {
    particle = new Particle(this);
    particle.setColor(color(255, 230, 220));
    particle.setRadius(1.7);
    frameRate(60);
    size(500, 500);
}

void draw() {
    background(0);
    
    if(frameCount % 120 == 0) {
        particle.drawing(random(width), random(height));
    }
    
    fill(255);
    textAlign(LEFT, TOP);
    text("isDrawing :"+particle.isDrawing(), 10, 10);
}
