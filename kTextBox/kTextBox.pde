import java.awt.Cursor;

public class KTextBox {
    private String text;
    private PVector pos;
    private PVector size;
    private int textSize;
    private boolean active;
    private final int FLASH_SPAN = 900;
    private final int CURSOR_MARGIN = 1;
    private int cursorPoint;
    private boolean clickFlag, clickOnFlag, clickOldOnFlag;
    private boolean visible;
    private PApplet papplet;

    KTextBox(PApplet papplet, String text, float x, float y, float w, float h) {
        this.papplet = papplet;
        this.setText(text);
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
        this.cursorPoint = 0;
        this.setFont("Meiryo");
    }

    public void draw() {
        if (!visible) return;
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
            float x = pos.x + textWidth(text.substring(0, cursorPoint)) + CURSOR_MARGIN;
            line(x, pos.y + (size.y - textSize) / 2.0, x, pos.y + (size.y - textSize) / 2.0 + textSize);
        }
        switch(checkTextBoxClick()) {
        case 1:
            active = true;
            cursorPoint = text.length();
            for (int i=0; i<text.length(); i++) {
                if (textWidth(text.substring(0, i)) > mouseX-pos.x) {
                    cursorPoint = i-1;
                    break;
                }
            }
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

        if (keyCode == RIGHT) {
            cursorPoint = min(text.length(), ++cursorPoint);
        } else if (keyCode == LEFT) {
            cursorPoint = max(0, --cursorPoint);
        } else if ((('A' <= keyCode && keyCode <= 'Z') || ('0' <= keyCode && keyCode<= '9') || key == ' ') && textWidth(text + key) + CURSOR_MARGIN + 4 <= size.x) {
            text = text.substring(0, cursorPoint) + key + text.substring(cursorPoint, text.length());
            cursorPoint++;
        } else if (keyCode == BACKSPACE && text.length() > 0 && cursorPoint > 0) {
            text = text.substring(0, cursorPoint-1) + text.substring(cursorPoint, text.length());
            cursorPoint--;
        } else if (keyCode == DELETE && text.length() > 0 && cursorPoint < text.length()) {
            text = text.substring(0, cursorPoint) + text.substring(cursorPoint+1, text.length());
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
        this.cursorPoint = text.length();
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
