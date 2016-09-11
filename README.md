InsensitiveSearch
====

Search paths in insensitive.

Installation
----

Add this line to your application's Gemfile:

```ruby
gem 'insensitive_search'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install insensitive_search
```

Usage
----

It has some searching methods, and all their return value is definitely an array. The array can include the paths which matched with the path argument.

Running on Linux, the size of the array is 0 or equal to or greater than 1. 

Running on Windows, the size of the array is 0 or equal to 1.

### `InsensitiveSearch.run(path)`

Search paths.

### `InsensitiveSearch.dir(path)`

Search only dirctory paths.

### `InsensitiveSearch.file(path)`

Search only file paths.

Sample
----

Running the method with the argument "ext/soFTwaRe/Config.conf" in the following file structure, the instance of Array on each methods is returned.

The working dir is at "root".

### file structure (Linux)

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

Bug reports and pull requests are welcome on GitHub at https://github.com/indeep-xyz/ruby-insensitive-search.

License
---

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
