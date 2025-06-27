#!/bin/bash

echo "🔍 Testing Service 1..."
if curl -s http://localhost:8080/service1/ping | grep -q '"status":"ok"'; then
  echo "✅ Service 1 is Healthy"
else
  echo "❌ Service 1 failed"
fi

echo "🔍 Testing Service 2..."
if curl -s http://localhost:8080/service2/ping | grep -q '"status":"ok"'; then
  echo "✅ Service 2 is Healthy"
else
  echo "❌ Service 2 failed"
fi
