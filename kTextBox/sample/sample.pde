KTextBox textBox;

void setup() {
    size(800, 500);
    frameRate(60);
    textBox = new KTextBox(this, 250, 250, 300, 50);
    textBox.setFont("Courier New");
}

void draw() {
    background(100);
    fill(255);
    textAlign(CENTER, CENTER);
    text(textBox.getText(), width/2, 150);
}

void keyPressed() {
    textBox.keyType();
    if(keyCode == ENTER) {
         textBox.setText("");   
    }
}
