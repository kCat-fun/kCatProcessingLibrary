/*--------------------------------------------------
 ボタンライブラリ
 制作者：kCat
 制作日：2023/1/20
 バージョン：ver1.5
 --------------------------------------------------*/

import java.lang.reflect.Method;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

/*----------------------------------------
 クリック時の処理：clickButtonEvent関数を実行
 clickButtonEvent(this.buttonName);
 ----------------------------------------*/

public class KBSetup {
    // mainのPApplet
    PApplet papplet;
    KBSetup(PApplet _papplet) {
        this.papplet = _papplet;
    }
}

public class KButton {
    // ボタンの設定のインスタンス生成
    Set set;
    // clickButtonEventの場所
    Object obj;
    // ボタンをクリックされたときにclickButtonEventの引数に渡される文字列
    String buttonName;
    // ボタンクリックとマウスクリックに関するフラグ
    boolean clickFlag, clickOldOnFlag, clickOnFlag;
    // 表示フラグ
    boolean visible;

    // ボタンの設定クラス
    class Set {
        // x座標, y座標, 幅, 高さ, 角丸の半径
        float x;
        float y;
        float width;
        float height;
        float radius;
        // ラベルの位置 X, Y, ラベルの文字サイズ
        float labelX;
        float labelY;
        float labelSize = 1;
        // Align horizontal:x軸, vertical:y軸
        int horizontal;
        int vertical;
        // ラベルの文字
        String textlabel = "";
        // ボタンの中の色, ボタンの外枠の色, ラベルの色
        color rectColor;
        color rectEdgeColor;
        color rectHoverColor;
        color textColor;
        PFont font;
        PImage img = null;

        // ボタンの設定のコンストラクタ
        Set() {
        }
    }

    // ボタンのコンストラクタ
    KButton(Object obj, String _buttonName, float _x, float _y, float _w, float _h, float _r) {
        kbSetup.papplet.registerMethod("draw", this);
        this.obj = obj;
        this.buttonName = _buttonName;
        // 初期値の設定
        this.set = new Set();
        // テキストの初期Alignは（CENTER, CENTER）
        this.setAlign(CENTER, CENTER);
        this.setPosition(_x, _y);
        this.setSize(_w, _h, _r);
        this.setButtonColor(200, 0);
        this.setButtonHoverColor(255);
        this.setLabelColor(0);
        this.setLabel("", 0);
        this.clickFlag = false;
        this.clickOldOnFlag = false;
        this.clickOnFlag = false;
        this.visible = true;
    }

    // ボタン表示関数
    void draw() {
        if (!visible) return;

        push();

        // ボタン自体（ラベル以外）を表示
        this.buttonShow();
        // ラベルを表示
        this.labelShow();

        // ボタンがクリックされたかを判別
        if (this.checkButtonClick()) {
            excution(this.buttonName);
        }

        pop();
    }

    // ボタン表示関数（ラベル以外）
    void buttonShow() {
        if (!checkHover())
            fill(this.set.rectColor);
        else
            fill(this.set.rectHoverColor);
        stroke(this.set.rectEdgeColor);
        rect(this.set.x, this.set.y, this.set.width, this.set.height, this.set.radius);
    }

    // ラベル表示関数
    void labelShow() {
        fill(this.set.textColor);
        textAlign(this.set.horizontal, this.set.vertical);
        textSize(this.set.labelSize);
        text(this.set.textlabel, this.set.labelX, this.set.labelY);
    }

    // マウスがボタンにホバーしてるかの判別関数
    boolean checkHover() {
        if ( (mouseX > this.set.x && mouseX < this.set.x+this.set.width) &&
            (mouseY > this.set.y && mouseY < this.set.y+this.set.height) ) {
            return true;
        }
        return false;
    }

    // ボタンがクリックされたかの判別関数
    boolean checkButtonClick() {
        boolean return_flag = false;

        if (!this.checkHover()) {
            this.clickOnFlag = false;
            this.clickOldOnFlag = false;
        } else {
            if (!this.clickFlag) {
                this.clickOnFlag = mousePressed;
            }
            if (this.clickOldOnFlag && !mousePressed) {
                return_flag = true;
            }
            this.clickOldOnFlag = this.clickOnFlag;
        }
        if (!this.clickOnFlag)
            this.clickFlag = mousePressed;

        return return_flag;
    }

    void excution(String methodName) {
        try {
            Method m = this.obj.getClass().getDeclaredMethod(methodName);
            m.invoke(this.obj);
        }
        catch (NoSuchMethodException e) {
            println("Error: No function", methodName, "()");
            // throw new RuntimeException(e);
        }
        catch(NullPointerException e) {
            println("Error: No function", methodName, "()");
            // throw new RuntimeException(e);
        }
        catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }
        catch (InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    void visible(boolean disp) {
        this.visible = disp;
    }

    KButton setPosition(float _x, float _y) {
        set.x = _x;
        set.y = _y;
        setLabelPos();
        return this;
    }

    KButton setBackgroundImage(PImage _img) {
        set.img = _img;
        return this;
    }

    KButton setSize(float _w, float _h, float _r) {
        set.width = _w;
        set.height = _h;
        set.radius = _r;
        return this;
    }

    KButton setButtonColor(color _rectColor, color _rectEdgeColor) {
        set.rectColor = _rectColor;
        set.rectEdgeColor = _rectEdgeColor;
        return this;
    }

    KButton setButtonHoverColor(color _rectHoverColor) {
        set.rectHoverColor = _rectHoverColor;
        return this;
    }

    KButton setLabel(String _text, float _labelSize) {
        set.textlabel = _text;
        setLabelSize(_labelSize);
        setLabelPos();
        return this;
    }

    KButton setLabel(String _text, float _labelSize, PFont _font) {
        set.textlabel = _text;
        setLabelSize(_labelSize);
        setLabelFont(_font);
        setLabelPos();
        return this;
    }

    KButton setLabelSize(float _labelSize) {
        set.labelSize = _labelSize;
        return this;
    }

    KButton setAlign(int _horizontal, int _vertical) {
        set.horizontal = _horizontal;
        set.vertical = _vertical;
        setLabelPos();
        return this;
    }

    KButton setLabelPos() {
        if (set.labelSize > 0) {
            switch(set.horizontal) {
            case CENTER:
                set.labelX = set.x + set.width / 2;
                break;
            case LEFT:
                set.labelX = set.x;
                break;
            case RIGHT:
                set.labelX = set.x + set.width;
                break;
            default:
                println("Warning:Invalid Align");
                throw new RuntimeException();
            }
            switch(set.vertical) {
            case CENTER:
                set.labelY = set.y + set.height / 2;
                break;
            case TOP:
                set.labelY = set.y;
                break;
            case BOTTOM:
                set.labelY = set.y + set.height;
                break;
            default:
                println("Warning:Invalid Align");
                throw new RuntimeException();
            }
        }
        return this;
    }

    KButton setLabelColor(color _textColor) {
        set.textColor = _textColor;
        return this;
    }

    KButton setLabelFont(PFont _font) {
        set.font = _font;
        return this;
    }
}
