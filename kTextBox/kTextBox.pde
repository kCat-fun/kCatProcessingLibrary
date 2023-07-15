import java.awt.Cursor;

public class KTextBox {
    private String text;
    private PVector pos;
    private PVector size;
    private int textSize;
    private boolean active;
    private final int FLASH_SPAN = 900;
    private final int TYPE_SPAN = 100;
    private boolean clickFlag, clickOnFlag, clickOldOnFlag;
    private boolean visible;
    private PApplet papplet;
    
    KTextBox(PApplet papplet, String text, float x, float y, float w, float h) {
        this.papplet = papplet;
        this.text = text;
        this.init(x, y, w, h);
    }
    
    KTextBox(PApplet papplet, float x, float y, float w, float h) {
        this.papplet = papplet;
        this.text = "";
        this.init(x, y, w, h);
        
    }
    
    private void init(float x, float y, float w, float h) {
        this.papplet.registerMethod("draw", this);
        this.visible = true; 
        this.pos = new PVector(x, y);
        this.size = new PVector(w, h);
        this.active = false;
        this.textSize = floor(h * 0.8);
        this.clickFlag = false;
        this.clickOnFlag = false;
        this.clickOldOnFlag = false;
    }
    
    public void draw() {
        if(!visible) return;
        push();
        fill(255);
        strokeWeight(1);
        stroke(0);
        rect(pos.x, pos.y, size.x, size.y);
        textAlign(LEFT, CENTER);
        textSize(textSize);
        fill(0);
        text(text, pos.x, pos.y + size.y / 2.0 - 5);
        if (active && (millis() % FLASH_SPAN * 2 < FLASH_SPAN || keyPressed)) {
            float x = pos.x + textWidth(text) + 5;
            line(x, pos.y + (size.y - textSize) / 2.0, x, pos.y + (size.y - textSize) / 2.0 + textSize);
        }
        switch(checkTextBoxClick()) {
        case 1:
            active = true;
            break;
        case -1:
            active = false;
            break;
        }
        getSurface().setCursor(checkHover() ? Cursor.TEXT_CURSOR : Cursor.DEFAULT_CURSOR);
        
        pop();
    }
    
    public void keyType() {
        if (!active) return;
        
        if (('A' <= keyCode && keyCode <= 'Z') || ('0' <= keyCode && keyCode<= '9') || key == ' ') {
            text = textWidth(text + key) + 5 > size.x ? text : text + key;
        } else if (keyCode == BACKSPACE && text.length() > 0) {
            text = text.substring(0, text.length() - 1);
        }
    }

    public KTextBox setVisible(boolean visible) {
        this.visible = visible;
        return this;
    }
    
    public KTextBox setPos(float x, float y) {
        this.pos = new PVector(x, y);
        return this;
    }
    
    public KTextBox setSize(float w, float h) {
        this.size = new PVector(w, h);
        return this;
    }
    
    public KTextBox setTextSize(int textSize) {
        this.textSize = textSize;
        return this;
    }
    
    public KTextBox setFont(String font) {
        textFont(createFont(font, textSize));
        return this;
    }
    
    public KTextBox setText(String text) {
        this.text = text;
        return this;
    }
    
    public String getText() {
        return text;
    }
    
    // マウスがテキストボックスにホバーしてるかの判別関数
    private boolean checkHover() {
        if ((mouseX > pos.x && mouseX < pos.x + size.x) && 
           (mouseY > pos.y && mouseY < pos.y + size.y)) {
            return true;
        }
        return false;
    }
    
    // テキストボックスがクリックされたかの判別関数
    private int checkTextBoxClick() {
        boolean returnFlag = false;
        
        if (!clickFlag) {
            clickOnFlag = mousePressed;
        }
        if (clickOldOnFlag && !mousePressed) {
            returnFlag = true;
        }
        clickOldOnFlag = clickOnFlag;
        
        if (!clickOnFlag)
            clickFlag = mousePressed;

        if (returnFlag)
            return checkHover() ? 1 : - 1;  
        
        return 0;
    }
}
