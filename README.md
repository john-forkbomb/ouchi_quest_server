# by :(){:|:&};:

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
