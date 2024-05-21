# コンテナ起動時に実行するスクリプトを記述するためのファイル

#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /todo/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
# コンテナ起動時に実行するコマンドを指定するためのものです。
# これにより、Dockefile で指定した CMD ["rails", "server", "-b", "0.0.0.0"] が実行されます。
exec "$@"

# pidとは ProcessIDの略でOSが各プロセスを一意に識別するための番号。(UNIX系)
# tmp/pid/server.pidとは サーバープロセスのPIDを記録するファイル、プロセスが実行中かどうかを確認するために使われる。
# コンテナ削除時にこれを削除する理由 コンテナは一時的な環境であり、このファイルが残っていることでRailsがサーバーを起動していると誤認し起動を拒否またはエラーを出す可能性がある