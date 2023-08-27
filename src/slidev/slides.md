---
theme: seriph
background: images/top-image.jpg
class: text-center
highlighter: shiki
lineNumbers: false
drawings:
  persist: false
transition: slide-left
title: スイッチとPCで同じ外部サーバーに接続して遊ぶ方法
---

# スイッチとPCで同じ外部サーバーに接続して遊ぶ方法

パソコン1台で構築するローカルDNSサーバー

---
layout: image-right
image: images/profile.jpg
---

# 自己紹介

- 正木裕貴（まさきゆうき）
- 愛知県在住
- ネットワークエンジニア
- @yukiii1993

---
class: bg-blue-400
---

<div class="absolute inset-0 flex items-center justify-center text-white text-5xl">
  そもそもスイッチとPCって一緒に遊べないの？
</div>

---
class: bg-orange-400
---

<div class="absolute inset-0 flex items-center justify-center text-white text-5xl">
  <div class="flex flex-col text-center">
    <div class="pb-6">
      🤔
    </div>
    <div class="p-4">
      特集サーバーと呼ばれる
    </div>
    <div class="p-4">
      公式が提供するサーバーであれば
    </div>
    <div class="p-4">
      一緒にクロスプレイが可能
    </div>
  </div>
</div>

---

- 😫 見ず知らずのユーザーがたくさんいるし、特集サーバーのルールに従う必要がある

<style>
li {
  list-style-type: none;
}
</style>

---

# この話を聞くと何ができるの？

- 😊 自宅に建てた統合版外部サーバーで、スイッチ・PC間のクロスプレイができるようになる

<style>
li {
  list-style-type: none;
}
</style>

---

# 環境
- Windows10 Pro 64bit 22H2
- Ubuntu Server 22.04 LTS
- BedorockConnect 1.37
- Minecraft 1.20.15

---
transition: slide-up
---

# 手順
1. Windowsでマイクラ統合版サーバーを起動する
2. 仮想マシンを作成する
3. BedrockConnectサーバーを起動する
4. ローカルDNSサーバーを起動する
5. スイッチのネットワーク設定を変更する
6. スイッチから接続する

---
transition: slide-up
---

# 1. Windowsでマイクラ統合版サーバーを起動する
- 公式サイトからWindows用サーバーソフトをダウンロード
  https://www.minecraft.net/ja-jp/download/server/bedrock
- ZIPファイルを解凍して実行ファイルを起動する

---
transition: slide-up
---

# 2. 仮想マシンを作成する
- Hyper-Vがおすすめ
- 仮想マシンのスペックは1vCPU / 1GB程度でOK
- Uubntu Server 22.04をインストールする

---
transition: slide-up
---

# 3. BedrockConnectサーバーを起動する
- リポジトリからjarファイルをダウンロード (BedrockConnect-1.0-SNAPSHOT.jar)
```bash
wget https://github.com/Pugmatt/BedrockConnect/releases/download/1.37/BedrockConnect-1.0-SNAPSHOT.jar
```

- 仮想マシンにOpenJDKをインストール
```bash
sudo apt install -y default-jdk
```

- BedrockConnectサーバーを起動
```bash
java -jar BedrockConnect-1.0-SNAPSHOT.jar nodb=true
```

---
transition: slide-up
---
