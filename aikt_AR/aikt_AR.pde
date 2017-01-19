import jp.nyatla.nyar4psg.*;  // ARToolKit
import processing.video.*;    // ビデオライブラリ
import saito.objloader.*;     // objローダ

Capture     cam;   // キャプチャ
MultiMarker ar;    // ARマーカに関する処理をするオブジェクト
int         id;    // マーカに割り当てられるID番号
OBJModel    model; // 3Dモデル 

void setup() {
  size(640, 480, P3D);

  // ARをやるための準備  
  cam = new Capture(this, width, height);
  ar = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  id = ar.addARMarker("aikt.pat", 20);//大きさ注意！

  // 3Dモデルの準備
  model = new OBJModel(this, "shoes1.obj", "absolute", POLYGON);
  model.scale(10);
  model.translateToCenter();
  noStroke();

  cam.start();//本にこれ書いてなかった。
}

void draw() {
  if (cam.available() == false) return; // カメラの準備ができてないときは何もしない
  cam.read();                           // カメラ画像の読み込み
  //background(255);                        // 画面の初期化
  background(cam);  // ar背景の設定みたいなの消して背景camにしたらいい感じになった
  //ar.drawBackground(cam);               // 背景画像の描画

  ar.detect(cam);                       // マーカ認識

  //lights(); // ライティング

  if (ar.isExistMarker(id)) {
    ar.beginTransform(id);
    translate(0, 0, 0);  // 3Dオブジェクトの表示位置の調整
    //rotateX(radians(180));
    //rotateY(radians(180));
    rotateZ(radians(180));

    model.draw();         // 3Dオブジェクトの描画
    ar.endTransform();
  }
}

