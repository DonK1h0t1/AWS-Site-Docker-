import os
import time
import platform
from datetime import datetime

APP_NAME = os.getenv("APP_NAME", "ERA Monitor")
INTERVAL = int(os.getenv("INTERVAL", "5"))


def memory():
    info = {}
    with open("/proc/meminfo") as f:
        for line in f:
            key, value = line.split(":")
            info[key] = int(value.split()[0]) // 1024
    used = info["MemTotal"] - info["MemAvailable"]
    return used, info["MemTotal"]


def uptime():
    with open("/proc/uptime") as f:
        sec = int(float(f.read().split()[0]))
    return f"{sec // 3600}ч {sec % 3600 // 60}м {sec % 60}с"


print("=" * 50)
print(f" {APP_NAME} запущен")
print(f" Хост: {platform.node()} | Python {platform.python_version()}")
print(f" Интервал проверки: {INTERVAL} сек")
print("=" * 50, flush=True)

n = 0
while True:
    n += 1
    used, total = memory()
    load1, load5, load15 = os.getloadavg()
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    status = "OK" if used / total < 0.9 else "ВНИМАНИЕ: мало памяти"
    print(f"[{now}] #{n} | RAM: {used}/{total} MB | "
          f"Load: {load1:.2f} {load5:.2f} {load15:.2f} | "
          f"Uptime: {uptime()} | {status}", flush=True)
    time.sleep(INTERVAL)
