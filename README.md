# Amakan Importer

## Setup
Install chrome canary.

```
$ alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
```

## Usage

### 1. Start chrome headless
```
$ chrome-canary --headless --disable-gpu --remote-debugging-port=9222 https://amazon.co.jp/
```

### 2. Open http://localhost:9292/ on your browser and login to amazon.co.jp and amakan.net

### 3. Run fetch_kindle_list.rb
```
$ ruby fetch_kindle_list.rb init
```
