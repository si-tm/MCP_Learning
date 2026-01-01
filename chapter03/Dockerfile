# Python 3.10以上のベースイメージを使用
FROM python:3.11-slim

# 作業ディレクトリを設定
WORKDIR /app

# uvパッケージマネージャーをインストール
RUN pip install --no-cache-dir uv

# プロジェクトファイルをコピー
COPY calculator_server.py .

# uvを使用してfastmcpをインストール
RUN uv venv && \
    . .venv/bin/activate && \
    uv pip install fastmcp

# 実行権限を付与
RUN chmod +x calculator_server.py

# MCPサーバーのポートを公開（デフォルトは標準入出力だが、ネットワーク接続用に準備）
EXPOSE 3000

# 仮想環境のPythonを使用してサーバーを起動
CMD ["uv", "run", "python", "calculator_server.py"]
