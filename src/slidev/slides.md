---
theme: seriph
background: /images/top-image.jpg
class: text-center
highlighter: shiki
lineNumbers: false
drawings:
  persist: false
transition: slide-left
title: パソコン1台で構築するマイクラ外部サーバー - slidev
---

# スイッチとPCでクロスプレイ！
# 家族と遊べるサーバーの作り方

### ～ パソコン1台で構築するマイクラ外部サーバー ～

---
layout: image-right
image: /images/profile.jpg
---

# 自己紹介

- 正木裕貴（まさきゆうき）
- 愛知県在住
- ネットワークエンジニア
- [@yukiii1993](https://twitter.com/yukiii1993)

---
class: bg-blue-400
---

<div class="absolute inset-0 flex items-center justify-center text-white text-5xl drop-shadow">
  <div class="flex flex-col text-center">
    <div class="pb-2">
      <div class="pb1">
        スイッチとPCでクロスプレイ！
      </div>
      <div class="pb1">
        家族と遊べるサーバーの作り方
      </div>
    </div>
    <div class="p-4 text-3xl">
      ～ パソコン1台で構築するマイクラ外部サーバー ～
    </div>
  </div>
</div>

---
class: bg-blue-400
---

<div class="absolute inset-0 flex items-center justify-center text-white text-5xl drop-shadow">
  <div class="flex flex-col text-center">
    <div class="pb-6">
      🙄
    </div>
    <div class="p-4">
      スイッチとPCって一緒に遊べるの？
    </div>
  </div>
</div>

---
class: bg-red-400
---

<div class="absolute inset-0 flex items-center justify-center text-white text-5xl drop-shadow">
  <div class="flex flex-col text-center">
    <div class="pb-6">
      🤔
    </div>
    <div class="p-4">
      条件付きでクロスプレイ可能
    </div>
  </div>
</div>

---
class: bg-green-400
---

<div class="absolute inset-0 flex items-center justify-center text-white text-5xl drop-shadow">
  <div class="flex flex-col text-center">
    <div class="pb-6">
      😊
    </div>
    <div class="p-4">
      自由に遊べる外部サーバーの作り方を紹介します
    </div>
  </div>
</div>

---

# 環境

<ul>
  <li>
    Windows10 Pro 64bit
  </li>
  <li>
    Ubuntu Server 22.04 LTS
  </li>
  <li class="text-red-400">
    dnsmasq
  </li>
  <li class="text-red-400">
    BedrockConnect 1.37
  </li>
  <li>
    Minecraft 統合版 1.20.15
  </li>
</ul>

---
layout: full
---

# 構成図

![](/figures/figure1.drawio.svg)

<style>
p {
  opacity: 1!important;
}
</style>

---
transition: slide-up
---

# 手順
1. [Windows] マイクラ外部サーバーを起動する
2. [Hyper-V] 仮想マシンを作成する
3. [Ubuntu] BedrockConnectサーバーを起動する
4. [Ubuntu] ローカルDNSサーバーを起動する
5. [Switch] スイッチのネットワーク設定を変更する
6. [Swtich] 外部サーバーに接続する

---
transition: slide-up
---

# 1. [Windows] マイクラ外部サーバーを起動する
- 公式サイトからWindows用サーバーソフトをダウンロード
  https://www.minecraft.net/ja-jp/download/server/bedrock
- ZIPファイルを解凍して実行ファイルを起動する

---
transition: slide-up
---

# 2. [Hyper-V] 仮想マシンを作成する
<ul>
  <li>
    Hyper-Vがおすすめ
  </li>
  <li>
    仮想マシンのスペックは1vCPU / 1GB程度でOK
  </li>
  <li class="text-red-400">
    仮想スイッチマネージャーで外部スイッチを作成する
  </li>
  <li>
    Ubuntu Server 22.04をインストールする
  </li>
  <li>
    IPを固定しておく
  </li>
</ul>

---
transition: slide-up
---

# 3. [Ubuntu] BedrockConnectサーバーを起動する (1/3)
- Javaをインストールする
```bash
sudo apt install -y default-jdk
```

- リポジトリからjarファイルをダウンロード
```bash
sudo mkdir /opt/bedrock-connect
cd /opt/bedrock-connect
wget https://github.com/Pugmatt/BedrockConnect/releases/download/1.37/BedrockConnect-1.0-SNAPSHOT.jar
```

- ファイアウォール許可設定を追加する
```bash
sudo ufw allow 19132
sudo ufw enable
```

---
transition: slide-up
---

# 3. [Ubuntu] BedrockConnectサーバーを起動する (2/3)

- サーバーリストを作成する
```bash
sudo nano /opt/bedrock-connect/server-list.json
```

- 書式例
```json
[
	{
		"name": "Yuki Server",
		"iconUrl": "https://example.com/icon.png",
		"address": "192.168.1.10",
		"port": 19132
	}
]
```

JSONファイルの詳しい書式はGitHubを参照

https://github.com/Pugmatt/BedrockConnect#defining-your-own-custom-servers

---
transition: slide-up
---

# 3. [Ubuntu] BedrockConnectサーバーを起動する (3/3)

- BedrockConnectサーバーを起動
```bash
java -jar BedrockConnect-1.0-SNAPSHOT.jar nodb=true custom_servers=server-list.json
```

---
transition: slide-up
---

# 4. [Ubuntu] BedrockConnectの自動起動設定 (1/2)

- SystemdのUnitファイルを作成する
```bash
sudo nano /usr/lib/systemd/system/bconnect.service
```

- 自動起動設定を記述する
```
[Unit]
Description=BedrockConnect Server
After=network.target

[Service]
ExecStart=java -jar \
/opt/bedrock-connect/BedrockConnect-1.0-SNAPSHOT.jar \
nodb=true custom_servers=/opt/bedrock-connect/server-list.json
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

---
transition: slide-up
---

# 4. [Ubuntu] BedrockConnectの自動起動設定 (2/2)

- サービスを開始する
```bash
sudo systemctl daemon-reload
sudo systemctl start bconnect.service
```

- サービスを永続化する
```bash
sudo systemctl enable bconnect.service
```

---
transition: slide-up
---

# 5. [Ubuntu] ローカルDNSサーバーを起動する (1/2)

- ファイアウォール許可設定を追加する
```bash
sudo ufw allow 53
sudo ufw reload
```

- dnsmasqをインストールする
```bash
sudo apt install -y dnsmasq
```

- コンフィグの最下行に設定を追加する
```txt {3-}
sudo nano /etc/dnsmasq.conf

domain-needed
bogus-priv
strict-order
bind-interfaces
```

---
transition: slide-up
---

# 5. [Ubuntu] ローカルDNSサーバーを起動する (2/2)

- hostsにレコードを追加する
```bash {3-}
sudo nano /etc/hosts

192.168.1.200 geo.hivebedrock.network
192.168.1.200 play.galaxite.net
192.168.1.200 mco.mineplex.com
192.168.1.200 mco.cubecraft.net
192.168.1.200 play.pixelparadise.gg
192.168.1.200 mco.lbsg.net
192.168.1.200 play.inpvp.net
```

- dnsmasqを再起動する
```bash
sudo systemctl restart dnsmasq
```

---
transition: slide-up
---

# 6. [Switch] スイッチのネットワーク設定を変更する (1/3)

<img class="h-80" src="/figures/figure2.png">

スイッチのネットワーク設定画面を開く

---
transition: slide-up
---

# 6. [Switch] スイッチのネットワーク設定を変更する (2/3)

<img class="h-80" src="/figures/figure3.png">

「設定の変更」へ進む

---
transition: slide-up
---

# 6. [Switch] スイッチのネットワーク設定を変更する (3/3)

<img class="h-80" src="/figures/figure4.png">

ローカルDNSサーバー(dnsmasqをインストールした仮想マシン)のIPアドレスを指定する

---
transition: slide-up
---

# 7. [Swtich] 外部サーバーに接続する (1/6)

<img class="h-80" src="/figures/figure6.jpg">

`Join To Open Server List`と表示されているサーバーに接続する

---
transition: slide-up
---

# 7. [Swtich] 外部サーバーに接続する (2/6)

<img class="h-80" src="/figures/figure7.jpg">

`Connect to a Server`を選択する

---
transition: slide-up
---

# 7. [Swtich] 外部サーバーに接続する (3/6)

<img class="h-60" src="/figures/figure8.jpg">

- 外部サーバーのIPアドレス
- 外部サーバーのポート番号(初期状態は19132)
- 名称(任意)

を入力し`Add to server list`を有効にする

---
transition: slide-up
---

# 7. [Swtich] 外部サーバーに接続する (4/6)

<img class="h-80" src="/figures/figure9.jpg">

`送信`を選択する

---
transition: slide-up
---

# 7. [Swtich] 外部サーバーに接続する (5/6)

<img class="h-80" src="/figures/figure10.jpg">

先ほど追加した外部サーバーを選択し接続する

---
transition: slide-up
---

# 7. [Swtich] 外部サーバーに接続する (6/6)

<img class="h-80" src="/figures/figure11.jpg">

無事接続できれば成功！
