public class Particle {
    PApplet obj;
    Point[] points;
    final int POINT_NUM = 30;
    boolean visible = false;
    boolean mouseFlag = false;
    long startTime;
    color c = color(255);
    
    Particle(PApplet _obj) {
        points = new Point[POINT_NUM];
        obj = _obj;
        obj.registerMethod("draw", this);
    }
    
    void setParticle(float x, float y) {
        for (int i = 0; i < POINT_NUM; i++) {
            float theta = random(2 * PI);
            points[i] = new Point(x, y, cos(theta) * random(0.5, 3), sin(theta) * random(0.5, 3), random(5, 10));
        }
        visible = true;
        startTime = millis();
    }
    
    void draw() {
        if (mousePressed) {
            if (!mouseFlag) {
                setParticle(mouseX, mouseY);
                mouseFlag = true;
                visible = true;
            }
        }
        else {
            mouseFlag = false;
        }
        
        if (!visible) {
            return;
        }
        
        for (Point p : points) {
            p.draw();
            p.update();
        }
        if (millis() - startTime > 2000) {
            visible = false;
        }
    }

    void setColor(color _c) {
        c = _c;
    }
    
    class Point {
        PVector pos;
        PVector vec;
        float r;
        
        Point(float x, float y, float vx, float vy, float _r) {
            pos = new PVector(x, y);
            vec = new PVector(vx, vy);
            this.r = _r;
        }
        
        void draw() {
            fill(c);
            noStroke();
            circle(pos.x, pos.y, r);
        }
        
        void update() {
            pos.add(vec);
            vec.mult(0.90);
            r *= 0.95;
        }
    }
}