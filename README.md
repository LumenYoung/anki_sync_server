## Anki Sync Server

The Docker image for anki offical sync server. 

## USAGE

You can run this server with `docker run`, replace the respective variable with your own:

```bash
docker run -it -e SYNC_USER1=<user_name>:<password> -v <anki_directory>:/ankidata tandizhihua/anki_sync_server:latest
```

Or you can build the image your own, cd to the root of this repo, you should have your `SYNC_USER1` environment variable defined:

```bash
docker build -t <your_tag> --build-arg <arg_1>=<value> .
```
