# MCP Inspector 実行コマンド（デバッグ版）

## Dockerイメージのビルド
```bash
cd /Users/hyakuzukamaya/Desktop/MCP_Learning/chapter03/inspector
docker build -t mcp-inspector .
```

## Dockerコンテナの実行
```bash
docker run --rm \
  -p 6274:6274 \
  -p 6277:6277 \
  mcp-inspector-local \
  --host 0.0.0.0 \
  --proxy-host 0.0.0.0
```

## Dockerコンテナの実行（ログ表示）
```bash
docker run -p 6274:6274 -p 6277:6277 mcp-inspector
```

コンテナ起動時に以下の情報が表示されます：
- Pythonのバージョン
- FastMCPのインストール確認
- 実行されるコマンド

## ブラウザでアクセス
起動ログに表示されるURLをChromeで開く：
```
http://localhost:6274
```

## デバッグ方法

### 1. コンテナ内で対話的に確認
```bash
docker run -it -p 6274:6274 -p 6277:6277 mcp-inspector /bin/bash

# コンテナ内で以下を実行
python3 --version
.venv/bin/python --version
.venv/bin/python -c "import fastmcp; print('FastMCP OK')"
.venv/bin/python calculator_server.py
```

### 2. ログをファイルに保存
```bash
docker run -p 6274:6274 -p 6277:6277 mcp-inspector 2>&1 | tee inspector.log
```

### 3. 別の実行方法を試す

#### 方法A: python3を直接使用
```bash
docker run -p 6274:6274 -p 6277:6277 mcp-inspector \
  npx @modelcontextprotocol/inspector python3 calculator_server.py
```

#### 方法B: 絶対パスで指定
```bash
docker run -p 6274:6274 -p 6277:6277 mcp-inspector \
  npx @modelcontextprotocol/inspector /usr/bin/python3 /app/calculator_server.py
```

#### 方法C: 環境変数でデバッグモード
```bash
docker run -p 6274:6274 -p 6277:6277 -e DEBUG=* mcp-inspector
```

## トラブルシューティング

### エラー: "spawn ENOENT"
Pythonの実行ファイルが見つからない場合
```bash
docker run -it mcp-inspector which python3
docker run -it mcp-inspector ls -la /app/.venv/bin/
```

### エラー: "Connection refused"
ポートが正しくマッピングされているか確認
```bash
docker ps  # PORTSカラムを確認
netstat -an | grep 6274  # Macの場合
```

### FastMCPのインポートエラー
```bash
docker run -it mcp-inspector /app/.venv/bin/pip list
```

## クリーンアップ
```bash
# 実行中のコンテナを停止
docker stop $(docker ps -q --filter ancestor=mcp-inspector)

# コンテナを削除
docker rm $(docker ps -aq --filter ancestor=mcp-inspector)

# イメージを削除して再ビルド
docker rmi mcp-inspector
```

## 正常に動作している場合の表示例
```
Starting MCP Inspector...
Python version: Python 3.x.x
FastMCP check: x.x.x
Starting inspector with command: npx @modelcontextprotocol/inspector /app/.venv/bin/python /app/calculator_server.py
⚙️ Proxy server listening on 127.0.0.1:6277
🔍 MCP Inspector is up and running at http://127.0.0.1:6274 🚀
```
