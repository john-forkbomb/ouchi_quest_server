# おうちクエスト (サーバー)

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

## ログイン方法

JWT認証(もどき)を使用

### register

リクエスト:
- URL: post `/api/register`
- params  
    ```
    {
        "parent": {
            "name": <親の名前>,
            "email": <メアド>
        },
        "child": {
            "name": <子の名前>,
            "sex": <性別 ("male", "female", "other"のどれか)>
        },
        "password": <入力パスワード>
    }
    ```

レスポンス(例):

```
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJwYXJlbnRfaWQiOjEsImV4cCI6MTU3MjY4OTQ3OX0.9pwWS45CFUblPgzfLYRYEOho9aiqeVRm6bFH0ulWMeE",
}
```

### login

リクエスト:
- URL: post `/api/login`
- params: `{email: <メアド>, password: <入力パスワード>}`

レスポンス(例):
```
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJwYXJlbnRfaWQiOjEsImV4cCI6MTU3MjY4OTQ3OX0.9pwWS45CFUblPgzfLYRYEOho9aiqeVRm6bFH0ulWMeE",
}
```

### それ以降

Headersに以下を追加
```
Authorization: <token (ログイン時に受け取ったもの)>
```

## push通知

### デバイスの登録

リクエスト:
- URL: post `/api/add_device`
- params: `{"token": <デバイストークン>}`

レスポンス: なし