KTextBox textBox;
String text;

void setup() {
    size(800, 500);
    frameRate(60);
    textBox = new KTextBox(this, 250, 250, 300, 50);
    textBox.setFont("Courier New");
    text = "";
}

void draw() {
    background(100);
    fill(255);
    textAlign(CENTER, CENTER);
    text(text, width/2, 150);
}

void keyPressed() {
    textBox.keyType();
    if (keyCode == ENTER) {
        text = textBox.getText();
        textBox.setText("");
    }
}
