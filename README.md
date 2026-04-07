# Jottacloud Backup (Docker / Unraid)

## Overview / Purpose

This container runs the Jottacloud CLI (`jotta-cli`) to continuously back up files to your Jottacloud account.

* Uses `jottad` daemon for automatic, event-based syncing
* All data under `/backup` is uploaded
* Logs are exposed via Docker logs

---

## Install

### Option 1 – Unraid (GUI)

1. Go to **Docker → Add Container**
2. Set:

   * **Name:** `JottacloudBackup`
   * **Repository:** `jotta-backup`
3. Add paths:

   * `/root/.jottad` → `/mnt/user/appdata/jotta-backup`
   * `/backup` → your data folder(s)

Click **Apply**

---

### Option 2 – Docker CLI

```bash id="cli1"
docker build -t jotta-backup .

docker run -d \
  --name=JottacloudBackup \
  -v /mnt/user/appdata/jotta-backup:/root/.jottad \
  -v /mnt/user/jotta-backup:/backup \
  jotta-backup
```

---


## Login

Run once after container start:

```bash
docker exec -it <container_name> jotta-cli login
```
or run it in the Unraid docker console from the context menu

Use a personal login token from:
https://www.jottacloud.com/web/secure

---

## Add folders

All content under `/backup` is synced.

### Option 1 – Docker mounts

Add new paths in the GUI mapped into `/backup`, then restart the container.

Example:

```
/mnt/user/photos → /backup/photos
```

---

### Option 2 

Use a single root folder:

```
/mnt/user/jotta-backup → /backup
```

Then add symlinks:

```bash
ln -s /mnt/user/photos /mnt/user/jotta-backup/photos
ln -s /mnt/user/docs /mnt/user/jotta-backup/docs
```

New folders are picked up automatically.
