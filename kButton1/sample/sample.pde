/*---------------------------------------------------------------------------
 ボタンライブラリの使い方例
 kButton.pdeを使用したいプログラムと同じフォルダに入れてお使いください。
 （階層を同じにするという意味）
 ---------------------------------------------------------------------------*/

// kbSetup という変数名でなければならない
KBSetup kbSetup;
KButton[] button = new KButton[2];
boolean[] btnFlag = {false, false};
boolean v_flag = true;

void setup() {
    size(800, 500);
    // mainのpappletを渡す
    kbSetup = new KBSetup(this);
    // 第二引数はクリック時に実行される関数名
    // ( this, ↑, x座標, y座標, 幅, 高さ, (角丸半径(0で直角)) );
    button[0] = new KButton(this, "hoge", 80, 250, 200, 100, 0);
    // (ボタンの中の色, ボタンの外枠の色)
    button[0].setButtonColor(color(255, 200, 200), color(0, 0, 255))
        // (ボタンにホバーした時の色)
        .setButtonHoverColor(color(255, 230, 230))
        // (ラベルの文字, 文字サイズ)
        // 設定しない場合は文字は表示されない
        .setLabel("test", 50)
        // (ラベルのX軸の位置, ラベルのY軸の位置)
        // 設定しない場合の初期値は(CENTER, CENTER)
        .setAlign(LEFT, TOP)
        // (ラベルの色)
        .setLabelColor(color(0, 0, 255));
    /*----------------------------------------
     その他：
     インスタンス.set.position(x座標, y座標);
     　-> ボタンの位置を変更できる
     インスタンス.set.size(幅, 高さ);
     　-> ボタンの大きさを変更できる
     ----------------------------------------*/

    button[1] = new KButton(this, "btn2", 500, 50, 100, 80, 0);
    button[1].setButtonColor(color(255, 200, 200), color(0, 0, 255))
        .setButtonHoverColor(color(255, 230, 230))
        .setLabel("Fun", 20)
        .setLabelColor(color(0, 0, 255));
}

void draw() {
    background(255);

    if (btnFlag[0]) {
        fill(0, 255, 0);
        rect(50, 50, 200, 100);
    }
    if (btnFlag[1]) {
        fill(0, 0, 255);
        rect(300, 300, 100, 100);
    }
}

/*ボタン生成時に第一引数で設定した関数名*/
void hoge() {
    btnFlag[0] = !btnFlag[0];
    println("hoge click", btnFlag[0]);
}

void btn2() {
    v_flag = !v_flag;
    button[0].visible(v_flag);
    btnFlag[1] = !btnFlag[1];
    println("btn2 click", btnFlag[1]);
}
