# API de Pólizas

## Instalar

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Ejecutar

```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

## Rutas principales

```txt
GET     /
GET     /health
GET     /policies
GET     /policies/{codigo}
POST    /policies
PUT     /policies/{codigo}
DELETE  /policies/{codigo}
```

También están disponibles las rutas `/polizas`.

## Pruebas

```bash
python -m pytest -q
```
