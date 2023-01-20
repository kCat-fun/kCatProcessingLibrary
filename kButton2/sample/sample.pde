/*---------------------------------------------------------------------------
 ボタンライブラリの使い方例
 kButton.pdeを使用したいプログラムと同じフォルダに入れてお使いください。
 （階層を同じにするという意味）
 ---------------------------------------------------------------------------*/

KButton[] button = new KButton[2];
boolean[] btnFlag = {false, false};
boolean flag = true;

void setup() {
    size(500, 500);
    // 第二引数はclickButtonEventに渡される文字列
    // (関数のあるオブジェクト, ↑, x座標, y座標, 幅, 高さ, (角丸半径(0で直角)) );
    button[0] = new KButton(this, "hoge", 50, 200, 200, 100, 20);
    // (ボタンの中の色, ボタンの外枠の色)
    button[0].set.buttonColor(color(255, 200, 200), color(0, 0, 255));
    // (ボタンにホバーした時の色)
    button[0].set.buttonHoverColor(color(255, 230, 230));
    // (ラベルの文字, 文字サイズ)
    // 設定しない場合は文字は表示されない
    button[0].set.label("test", 50);
    // (ラベルのX軸の位置, ラベルのY軸の位置)
    // 設定しない場合の初期値は(CENTER, CENTER)
    button[0].set.align(LEFT, TOP);
    // (ラベルの色)
    button[0].set.labelColor(color(0, 0, 255));
    /*----------------------------------------
     その他：
     インスタンス.set.position(x座標, y座標);
     　-> ボタンの位置を変更できる
     インスタンス.set.size(幅, 高さ);
     　-> ボタンの大きさを変更できる
     ----------------------------------------*/

    button[1] = new KButton(this, "btn2", 300, 50, 100, 80, 0);
    button[1].set.buttonColor(color(255, 200, 200), color(0, 0, 255));
    button[1].set.buttonHoverColor(color(255, 230, 230));
    button[1].set.label("Fun", 20);
    button[1].set.labelColor(color(0, 0, 255));
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

/*----------------------------------------
 |関数：                                  |
 |    ボタンクリック時に呼ばれる関数      |
 |****************************************|
 |引数：                                  |
 |    引数の変数名は何でも良い            |
 |****************************************|
 |    引数にはクリックされたボタンを生成  |
 |    した際に第一引数で設定した値が入る  |
 |****************************************|
 |注意：                                  |
 |    このライブラリを使う場合は必ず      |
 |    この関数を定義してください          |
 ----------------------------------------*/
void clickButtonEvent(String e) {
    switch(e) {
    case "hoge":
        println("hoge click");
        btnFlag[0] = !btnFlag[0];
        break;
    case "btn2":
        println("btn2 click");
        btnFlag[1] = !btnFlag[1];
        flag = !flag;
        // visibleでボタンを非表示
        button[0].visible(flag);
        break;
    }
}
