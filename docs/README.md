# FreeSurfer勉強会

ここは、2020年1月12日に開催予定である **FreeSurfer勉強会** の受講者を対象とした情報提供サイトです。新しい情報があれば、随時このサイトへ追加していきますので、定期的にアクセスするようにして下さい。

## 新着情報

- 2020.01.08: テキストが見れないなどする場合、以下を試してください。`git lfs install` は一度だけ実行すればOKです。

    - Lin4Neuro

        ```
        cd /media/sf_share/nisg-202001
        git lfs install
        git lfs pull
        ``` 

    - macOS
    
        ```
        cd ~/git/nisg-202001
        git lfs install
        git lfs pull
        ```


- 2020.01.08: **お願い**: テキストをすべてアップロードしました。以下でアップデートをお願いします。

    - Lin4Neuro

        ```
        cd /media/sf_share/nisg-202001
        git pull
        git lfs pull
        ``` 

    - macOS
    
        ```
        cd ~/git/nisg-202001
        git pull
        git lfs pull
        ```
        
- 2020.01.07: **お願い**: 縦断データを入手するためのスクリプトを準備しました。下に示す「縦断データのダウンロード」に従って、データの入手をお願いします。ダウンロードするファイルサイズが10GBありますので、時間がかかります。

- 2020.01.07: テキストを第2部(1)までアップロードしました。以下でアップデートをお願いします。

- 2020.01.07: **お願い**: fs-scriptsをアップデートしました。以下でアップデートしてください。

        ```
        cd ~/git/fs-scripts
        git pull
        ```
    
- 2020.01.05: プロキシの設定について追記しました。

- 2020.01.04: テキストについて追記しました。

- 2020.01.01: Git LFSについて追記しました。

- 2019.12.29: セットアップについて追記しました。

- 2019.12.22: 勉強会用ウェブサイトを立ち上げました。

## 会場案内
- [オフィス東京](https://www.officetokyo.net/){:target="_blank"}

## チュートリアル当日のお願い
- 会場は、飲食可能です。しかし、コンピュータを使いますので、コーヒーをキーボードの上にこぼすといった悲劇が起こらないよう、ふたのついた飲み物の持ち込みにご協力ください。昼食は、会場内で召し上がっていただいてかまいません。

- 開場時間は **08:30** です。いろいろ不安な方は早めにお越しいただき、講師やチュ ーターとコミュニケーションをとっておくことをお勧めします。

- 会場に到着したら、まず受付をお願いします。


## チュートリアルのスケジュール

- 09:00 - 09:50 recon-all -autorecon1
- 10:00 - 11:20 recon-all -autorecon2
- 11:30 - 12:30 recon-all -autorecon3
- 12:30 - 13:20 昼休み
- 13:20 - 14:20 recon-allの実際 / freeview
- 14:30 - 15:20 ROI解析
- 15:30 - 16:40 縦断解析
- 16:40 - 17:00 質疑応答

## FreeSurferを含めたソフトウェアの準備

- [こちら](./setup_l4n.md){:target="_blank"} をご覧いただき、準備してください。

## プロキシサーバーを使っている方の設定（必要な人のみ）

- 受講者の方々の中に、自分の使っているネットワークがプロキシサーバーの下にあるという方は、ターミナルから以下のコマンドをタイプしてください。

	```
	git config --global http.proxy http://プロキシ名:ポート番号
	git config --global https.proxy http://プロキシ名:ポート番号
	```

- この設定を解除するときは、以下のコマンドをタイプします。

	```
	git config --global --unset http.proxy
	git config --global --unset https.proxy
	```


## Git LFSの準備

- 今回、ファイルの配布のために、Git LFSというサービスを使います。このために、以下の作業を必ず行ってください。

### Lin4Neuro

- ターミナルを起動します。

- 以下をタイプしてください。

	```
	sudo apt install git-lfs
	```

- パスワードは lin4neuro です。


### macOS

- brewがインストールされていることが必要です。

- ターミナルを起動します。

- 以下をタイプしてください。

	```
	brew install git-lfs
	```


## FreeSurfer用スクリプトの準備

勉強会(およびチュートリアル)で用いるスクリプトを以下に従って準備してください。

- Lin4NeuroもしくはmacOSでターミナルを起動します。
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

- そうすると次のような表示が出ます。

	```
	Which OS are you using? Select number.
	1) Linux
	2) MacOS
	3) quit
	```

- Lin4Neuroの方は 1 を、macOSの方は 2 をタイプしてください。そうすると、以下が表示されます。

	```
	PATH for fs-scripts was added to ~/.bashrc (Macの場合は~/.bash_profile)
	Please close the terminal, re-open and run checkpath.sh.
	```

- ターミナルを一度閉じてください。そして、新たにターミナルを起動し、以下をタイプしてください。

	```
	checkpath.sh
	```

- これで、以下が表示されれば無事にパスに追加されました。

	```
	Success! fs-scripts is added to path.
	```


### FreeSurfer用スクリプトのアップデート

- 案内があった場合には、以下をタイプしてください。

	```
	cd ~/git/fs-scripts
	git pull
	```

## データおよびテキストの入手

- ターミナルを起動します。

- 勉強会のデータをダウンロードしていい場所に移動します。
	- Lin4Neuroの方は、/media/sf_shareがおすすめです。
	- macOSの方はどこでも大丈夫ですが、~/git がおすすめです。

	```
	#Lin4Neuro
	cd /media/sf_share
	
	#macOS
	cd ~/git
	```

- この上で、以下をタイプします。

	```
	git clone https://github.com/kytk/nisg-202001.git
	cd nisg-202001
	git lfs install
	git lfs pull
	```

- git clone だけだと、大容量ファイルはcloneされません。

- git lfs pull で、はじめて大容量ファイルがダウンロードされます。

## 縦断データのダウンロード

- ターミナルを起動し、勉強会のディレクトリに移動します。
    - Lin4Neuro
        ```
        cd /media/sf_share/nisg-202001
        ```

    - macOS
        ```
        cd ~/git/nisg-202001
        ```

- 内容を最新にします。
    ```
    git pull
    git lfs pull
    ```

- さらに下の subjects ディレクトリに移動します。
    ```
    cd subjects
    ```

- ここにある getdata.sh を実行します。ファイルの前に、./ をつけることを忘れないでください。
    ```
    ./getdata.sh
    ```

- こうすると、OAS2.zip というファイルがダウンロードされ、その後自動で展開されます。


## チートシート

- [recon-all -autorecon1](./ex1.md){:target="_blank"}
- [recon-all -autorecon2](./ex2.md){:target="_blank"}
- [recon-all -autorecon3](./ex3.md){:target="_blank"}
- [recon-allの実際 / freeview](./ex4.md){:target="_blank"}
- [ROI解析](./ex5.md){:target="_blank"}
- [縦断解析](./ex6.md){:target="_blank"}


## 問い合わせ

準備がうまくいかない時のために、問い合わせフォームを準備しています。こちらからご質問ください。数日以内に担当者から返信させていただきます。

[問い合わせフォーム](https://docs.google.com/forms/d/e/1FAIpQLSdtCyn02LV6jI-YMr_TWyRuc84o2lirICncR0fXkcbOalesJw/viewform?usp=sf_link){:target="_blank"}


