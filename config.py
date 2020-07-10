from os import environ as env
import multiprocessing

APP_PORT = int(env.get("APP_PORT", 8080))
APP_DEBUG = int(env.get("APP_DEBUG", 1))

# Gunicorn config
bind = ":" + str(APP_PORT)
workers = multiprocessing.cpu_count() * 2 + 1
threads = 2 * multiprocessing.cpu_count()
