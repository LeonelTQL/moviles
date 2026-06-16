import sys
from pathlib import Path

from fastapi.testclient import TestClient

sys.path.append(str(Path(__file__).resolve().parents[1]))
from main import app


def test_root_y_health_responden_correctamente():
    client = TestClient(app)

    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["status"] == "ok"
    assert response.json()["endpoints"]["listar_polizas"] == "/policies"

    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["message"] == "API funcionando correctamente"


def test_crud_completo_de_polizas(tmp_path, monkeypatch):
    monkeypatch.setenv("POLICIES_DATA_FILE", str(tmp_path / "policies_test.json"))
    client = TestClient(app)

    nueva_poliza = {
        "codigo": "POL-100",
        "cliente": "Ana Torres",
        "tipo_seguro": "Vida",
        "fecha_inicio": "2026-01-01",
        "fecha_vencimiento": "2027-01-01",
        "valor_asegurado": 25000.0,
    }

    response = client.post("/policies", json=nueva_poliza)
    assert response.status_code == 201
    assert response.json()["codigo"] == "POL-100"

    response = client.get("/policies")
    assert response.status_code == 200
    assert len(response.json()) == 1

    response = client.get("/polizas")
    assert response.status_code == 200
    assert len(response.json()) == 1

    response = client.get("/policies/POL-100")
    assert response.status_code == 200
    assert response.json()["cliente"] == "Ana Torres"

    datos_actualizados = {
        "cliente": "Ana Torres Actualizada",
        "tipo_seguro": "Vida Premium",
        "fecha_inicio": "2026-01-01",
        "fecha_vencimiento": "2028-01-01",
        "valor_asegurado": 30000.0,
    }
    response = client.put("/policies/POL-100", json=datos_actualizados)
    assert response.status_code == 200
    assert response.json()["cliente"] == "Ana Torres Actualizada"
    assert response.json()["valor_asegurado"] == 30000.0

    response = client.delete("/policies/POL-100")
    assert response.status_code == 200
    assert response.json()["message"] == "Póliza eliminada correctamente"

    response = client.get("/policies/POL-100")
    assert response.status_code == 404


def test_no_permite_codigo_duplicado(tmp_path, monkeypatch):
    monkeypatch.setenv("POLICIES_DATA_FILE", str(tmp_path / "policies_test.json"))
    client = TestClient(app)

    poliza = {
        "codigo": "POL-200",
        "cliente": "Luis Mora",
        "tipo_seguro": "Hogar",
        "fecha_inicio": "2026-02-01",
        "fecha_vencimiento": "2027-02-01",
        "valor_asegurado": 12000.0,
    }

    assert client.post("/policies", json=poliza).status_code == 201
    response = client.post("/policies", json=poliza)
    assert response.status_code == 409
