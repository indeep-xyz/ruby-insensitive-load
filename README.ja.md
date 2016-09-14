InsensitiveSearch
====

大文字と小文字を無視したファイル検索をおこないます。

Installation
----

以下の行を Gemfile に追加してください:

```ruby
gem 'insensitive_search'
```

そして実行:

```bash
$ bundle
```

または以下のようにインストールしてください:

```bash
$ gem install insensitive_search
```

Usage
----

この gem ではいくつかの検索用のメソッドがあり、それらの戻り値は全て配列型です。配列には大文字小文字を無視した上でマッチしたパスが含まれています。

Linux 上で実行した場合、配列のサイズは 0 か 1 以上です。

Windows 上で実行した場合、配列のサイズは 0 か 1 です。

### `InsensitiveSearch.run(path)`

渡されたパスを検索します。ファイルのタイプは無視します。

### `InsensitiveSearch.dir(path)`

渡されたパスをもとに、ディレクトリのみを検索します。

### `InsensitiveSearch.file(path)`

渡されたパスをもとに、ファイルのみを検索します。

Sample
----

次のファイル構成で引数 `"ext/soFTwaRe/Config.conf"` を渡したときの、各メソッドの戻り値を列挙します。

実行時のディレクトリは root です。

### ファイル構成 (Linux)

~~~
root/
├── ext/
│   ├── softWARE
│   └── SOFTware/
│       ├── config.conf
│       ├── cONfig.conf
│       └── Config.CONF/
└── EXT/
    └── software/
        └── COnFIG.CONf
~~~

### InsensitiveSearch.run

~~~
[ "ext/SOFTware/config.conf",
  "ext/SOFTware/Config.CONF",
  "ext/SOFTware/cONfig.conf",
  "EXT/software/COnFIG.CONf" ]
~~~

### InsensitiveSearch.dir

~~~
[ "ext/SOFTware/Config.CONF" ]
~~~

### InsensitiveSearch.file

~~~
[ "ext/SOFTware/config.conf",
  "ext/SOFTware/cONfig.conf",
  "EXT/software/COnFIG.CONf" ]
~~~

Contributing
----

バグ報告や pull request は https://github.com/indeep-xyz/ruby-insensitive-search まで。

License
---

この gem は [MIT License](http://opensource.org/licenses/MIT) で公開されています。
