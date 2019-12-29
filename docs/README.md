# FreeSurfer勉強会

ここは、2020年1月12日に開催予定である **FreeSurfer勉強会** の受講者を対象とした情報提供サイトです。新しい情報があれば、随時このサイトへ追加していきますので、定期的にアクセスするようにして下さい。

## 新着情報

- 2019.12.29: セットアップについて追記しました。
- 2019.12.22: 勉強会用ウェブサイトを立ち上げました。

## 会場案内
- [オフィス東京](https://www.officetokyo.net/){:target="_blank"}

## チュートリアル当日のお願い
- 会場は、飲食可能です。しかし、コンピュータを使いますので、コーヒーをキーボードの上にこぼすといった悲劇が起こらないよう、ふたのついた飲み物の持ち込みにご協力ください。昼食は、会場内で召し上がっていただいてかまいません。

- 開場時間は **08:30** です。いろいろ不安な方は早めにお越しいただき、講師やチュ ーターとコミュニケーションをとっておくことをお勧めします。

- 会場に到着したら、まず受付をお願いします。


## チュートリアルのスケジュール

- 現在調整中です。

## ソフトウェアの準備

- [こちら](./setup_l4n.md){:target="_blank"} をご覧ください。

## FreeSurfer用スクリプトの準備

勉強会(およびチュートリアル)で用いるスクリプトを以下に従って準備してください。

- Lin4NeuroもしくはMacOSでターミナルを起動します。
- `cd git`をタイプします。Lin4Neuroは確実にありますが、MacOSの方でエラーになる場合は、`mkdir git`として git ディレクトリを作成し、再度 `cd git` としてください。
- 以下をタイプ(もしくはコピー＆ペースト)します。

	```
	git clone https://github.com/kytk/fs-scripts.git
	```

- これで、ホームディレクトリの下の git ディレクトリに、 fs-scripts というディレクトリが作成されます。

- 次に、このディレクトリをパスに通します。以下をタイプします。(1回だけで大丈夫です)

	```
	cd fs-scripts
	./addpath.sh
	```

そうすると次のような表示が出ます。

	```
	Which OS are you using? Select number.
	1) Linux
	2) MacOS
	3) quit
	#? 
	```

Lin4Neuroの方は 1 を、MacOSの方は 2 をタイプしてください。

そうすると、

	```
	PATH for fs-scripts was added to ~/.bashrc (Macの場合は~/.bash_profile)
	Please close the terminal, re-open and run checkpath.sh.
	```

と表示されます。

ターミナルを一度閉じてください。そして、新たにターミナルを起動します。

そこで、以下をタイプしてください。

	```
	checkpath.sh
	```

これで、

	```
	Success! fs-scripts is added to path.
	```

となれば、スクリプトのディレクトリがパスに追加されました。

## FreeSurfer用スクリプトのアップデート

案内があった場合には、以下をタイプしてください。

	```
	cd ~/git/fs-scripts
	git pull
	```


## データおよびテキスト配布

- 現在準備中です。準備ができたら案内します。

	
## 問い合わせ

準備がうまくいかない時のために、問い合わせフォームを準備しています。こちらからご質問ください。数日以内に担当者から返信させていただきます。

[問い合わせフォーム](https://docs.google.com/forms/d/e/1FAIpQLSdtCyn02LV6jI-YMr_TWyRuc84o2lirICncR0fXkcbOalesJw/viewform?usp=sf_link){:target="_blank"}


