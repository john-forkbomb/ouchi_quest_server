# おうちクエスト (サーバー)

https://github.com/jphacks/KB_1904  
JPHACKS 2019で作成 (by @shikibu9419)

## Build Setup

```shell
> source aliases.sh
> build
> rails db:drop
> rails db:create
> ridgepole -c config/database.yml -E development --apply -f db/Schemafile --allow-pk-change
# or
> source setup.sh
```

## Run Server

```shell
> up
```
