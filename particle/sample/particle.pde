public class Particle {
    PApplet obj;
    Point[] points;
    final int POINT_NUM = 30;
    float r = 2.0;
    boolean visible = false;
    boolean drawFlag = false;
    boolean runFlag = false;
    long startTime;
    color c = color(255);
    float x;
    float y;
    
    Particle(PApplet _obj) {
        points = new Point[POINT_NUM];
        obj = _obj;
        obj.registerMethod("draw", this);
    }
    
    void setParticle(float x, float y) {
        for (int i = 0; i < POINT_NUM; i++) {
            float theta = random(2 * PI);
            points[i] = new Point(x, y, cos(theta) * random(0.5*r/2, 3*r/2), sin(theta) * random(0.5*r/2, 3*r/2), random(5*r/2, 10*r/2));
        }
        visible = true;
        startTime = millis();
    }
    
    void draw() {
        if (runFlag) {
            runFlag = false;
            if (!drawFlag) {
                setParticle(x, y);
                drawFlag = true;
                visible = true;
            }
        }
        else {
            drawFlag = false;
        }
        
        if (!visible) {
            return;
        }
        
        for (Point p : points) {
            p.draw();
            p.update();
        }
        if (millis() - startTime > r*1000) {
            visible = false;
        }
    }
    
    void drawing(float _x, float _y) {
        this.x = _x;
        this.y = _y;
        runFlag = true;
    }

    void setColor(color _c) {
        c = _c;
    }
    
    void setRadius(float _r) {
        r = _r;
    }
    
    boolean isDrawing() {
        return visible;
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
