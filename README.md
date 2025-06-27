# DevOps Assignment: Nginx Reverse Proxy + Docker

This project sets up a Docker Compose-based system with:

- A **Go backend service**
- A **Python Flask backend service**
- An **Nginx reverse proxy** that routes requests to each service

Everything is containerized and wired through a single `localhost:8080` entrypoint.

---

## 📁 Project Structure

```
.
├── docker-compose.yml
├── nginx
│   ├── nginx.conf
│   └── Dockerfile
├── service_1
│   ├── Dockerfile
│   └── main.go
├── service_2
│   ├── Dockerfile
│   ├── app.py
├── test_health.sh
└── README.md
```

---

## 🛠️ Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/anuraghatole/DPDzero-DevOps-assignment.git
cd DPDzero-DevOps-assignment
```

### 2. Start the system

```bash
docker-compose up --build
```

This builds all services and launches:

- Go app at `/service1`
- Python Flask app at `/service2`
- All accessible via: `http://localhost:8080`

---

## 🌐 Routing via Nginx

Nginx runs inside its own container and proxies:

| Path        | Proxies to       | Port   |
| ----------- | ---------------- | ------ |
| `/service1` | Go app           | `8001` |
| `/service2` | Python Flask app | `8002` |

Example:

```bash
curl http://localhost:8080/service1/ping
# {"service":"1","status":"ok"}

curl http://localhost:8080/service2/ping
# {"service":"2","status":"ok"}
```

---

## 🔍 Logging

Nginx logs all incoming requests using a custom log format:

```nginx
log_format custom '[$time_local] $remote_addr requested $request';
access_log /var/log/nginx/access.log custom;
```

You’ll see logs like:

```
[27/Jun/2025:18:00:00 +0000] 172.18.0.1 requested GET /service2/ping
```

---

## ✅ Health Checks

Both services expose a `/ping` endpoint for health monitoring. Docker healthchecks are configured:

- **Service 1**: `http://localhost:8001/ping`
- **Service 2**: `http://localhost:8002/ping`

## 🧪 Bonus Test Script

Included script `test.sh` verifies both services via Nginx routing:

```bash
chmod +x test_health.sh
./test_health.sh
```

Output:

```bash
- Service 1 is Healthy
- Service 2 is Healthy
```

---

## 🧼 Clean, Modular Docker Setup

- All services are built with separate Dockerfiles.
- `uv` is used in service 2 for Python dependency resolution without runtime overhead.
- `nginx.conf` is kept modular and clean.
- `.dockerignore` files are used to reduce build context size.

---

## 📌 Notes

- All services use **bridge networking**.
- Nginx is fully containerized — no dependencies run on host.
- Healthchecks and test scripts make it easy to validate services.

---

### 🏆 Bonus Points Implemented

- Clean logs with timestamp
- Health checks for both services
- One-click up via `docker-compose up --build`
- Modular Docker setup
- Test script for route + service check

---
