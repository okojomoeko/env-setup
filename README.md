# env-setup

Mac と Win の開発環境を作る。

それぞれ`lima`と`WSL2`を利用する想定。

## Mac

[]ima の install 方法](https://github.com/lima-vm/lima#getting-started)に従ってbrewでinstallする

この Repository を clone してきて

`limactl start path/env-setup/mac/lima/default.yaml`で instance 起動

`lima`で instance に log in したときにうまく zsh とか`.zshrc`とかなかったら、一度 instance を再起動してから手動で適当に直す。(今後改善したい)

VS Code から入れるように`.ssh/config`に追加

```shell
touch ~/.ssh/config && limactl show-ssh -f config default >> ~/.ssh/config
```
