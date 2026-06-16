#!/usr/bin/env bash
set -e
BASE_URL="${BASE_URL:-http://127.0.0.1:8000}"

printf "\n0) Verificar API\n"
curl -s "$BASE_URL/" | jq .

printf "\n1) Crear póliza\n"
curl -s -X POST "$BASE_URL/policies" \
  -H "Content-Type: application/json" \
  -d '{"codigo":"POL-999","cliente":"Cliente de Prueba","tipo_seguro":"Vehicular","fecha_inicio":"2026-06-01","fecha_vencimiento":"2027-06-01","valor_asegurado":15000}' | jq .

printf "\n2) Listar pólizas\n"
curl -s "$BASE_URL/policies" | jq .

printf "\n3) Consultar póliza\n"
curl -s "$BASE_URL/policies/POL-999" | jq .

printf "\n4) Actualizar póliza\n"
curl -s -X PUT "$BASE_URL/policies/POL-999" \
  -H "Content-Type: application/json" \
  -d '{"cliente":"Cliente Actualizado","tipo_seguro":"Vehicular Full","fecha_inicio":"2026-06-01","fecha_vencimiento":"2028-06-01","valor_asegurado":20000}' | jq .

printf "\n5) Eliminar póliza\n"
curl -s -X DELETE "$BASE_URL/policies/POL-999" | jq .
