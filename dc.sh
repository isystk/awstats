#! /bin/bash

pushd ./docker

MYSQL_CLIENT=$(dirname $0)/mysql/scripts
PATH=$PATH:$MYSQL_CLIENT

function usage {
    cat <<EOF
$(basename ${0}) is a tool for ...

Usage:
  $(basename ${0}) [command] [<options>]

Options:
  stats|st          Dockerコンテナの状態を表示します。
  start             すべてのDaemonを起動します。
  stop              すべてのDaemonを停止します。
  import            targetディレクトリ内のログファイルをAWStatsに取り込みます。
  --version, -v     バージョンを表示します。
  --help, -h        ヘルプを表示します。
EOF
}

function version {
    echo "$(basename ${0}) version 0.0.1 "
}

case ${1} in
    stats|st)
        docker container stats
    ;;

    init)
        # 停止＆削除（コンテナ・イメージ・ボリューム）
        docker-compose down --rmi all --volumes
        rm -Rf ./docker/awstats/data/*
        rm -Rf ./docker/apache/logs/*
    ;;

    start)
        docker-compose up -d
    ;;
    
    stop)
        docker-compose down
    ;;

    help|--help|-h)
        usage
    ;;

    version|--version|-v)
        version
    ;;
    
    *)
        echo "[ERROR] Invalid subcommand '${1}'"
        usage
        exit 1
    ;;
esac


