
```sh
uv run python calculator_server.py 
npx @modelcontextprotocol/inspector uv run python calculator_server.py 
```



chapter03の環境設定
- python3.10以上
- uvパッケージマネージャー
- uv add fastmcp

```sh
docker build -t mcp-chapter03 .
docker run mcp-chapter03
docker run --rm -p 6277:6277 mcp-chapter03
```

inspector
```sh
npx @modelcontextprotocol/inspector uv run python calculator_server.py
npx @modelcontextprotocol/inspector docker run mcp-chapter03 1>/dev/null
```

http://localhost:6274
