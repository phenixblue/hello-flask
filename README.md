# hello-flask

Bits for building a Python3 based Docker Image with Flask and Gunicorn baked in

## Container Image

This only handles the latest tag for now

```bash
$ make build
$ make push
```

## Deploy to Kubernetes

### Fresh Install

```bash
$ make deploy
```

### Namespace Already exists, or initial dpeloyment already done

```bash
$ make deploy-resources
```
