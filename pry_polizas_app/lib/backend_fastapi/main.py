from __future__ import annotations

import json
import os
from datetime import date
from pathlib import Path
from typing import Dict, List

from fastapi import FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, ConfigDict, Field, field_validator, model_validator


app = FastAPI(
    title="API REST CRUD - Pólizas de Seguro",
    description="Servicio REST para registrar, consultar, actualizar y eliminar pólizas de seguro.",
    version="1.1.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class PolicyBase(BaseModel):
    cliente: str = Field(..., min_length=3, max_length=100, examples=["Juan Pérez"])
    tipo_seguro: str = Field(..., min_length=3, max_length=80, examples=["Vehicular"])
    fecha_inicio: date = Field(..., examples=["2026-06-01"])
    fecha_vencimiento: date = Field(..., examples=["2027-06-01"])
    valor_asegurado: float = Field(..., gt=0, examples=[15000.0])

    @field_validator("cliente", "tipo_seguro")
    @classmethod
    def limpiar_texto(cls, value: str) -> str:
        value = value.strip()
        if not value:
            raise ValueError("El campo no puede estar vacío")
        return value

    @model_validator(mode="after")
    def validar_fechas(self) -> "PolicyBase":
        if self.fecha_vencimiento <= self.fecha_inicio:
            raise ValueError("La fecha de vencimiento debe ser mayor a la fecha de inicio")
        return self


class PolicyCreate(PolicyBase):
    codigo: str = Field(..., min_length=3, max_length=20, examples=["POL-001"])

    @field_validator("codigo")
    @classmethod
    def limpiar_codigo(cls, value: str) -> str:
        value = value.strip().upper()
        if not value:
            raise ValueError("El código no puede estar vacío")
        return value


class PolicyUpdate(PolicyBase):
    pass


class PolicyResponse(PolicyCreate):
    model_config = ConfigDict(from_attributes=True)


class MessageResponse(BaseModel):
    message: str


class RootResponse(BaseModel):
    message: str
    status: str
    endpoints: Dict[str, str]


def get_data_file() -> Path:
    default_file = Path(__file__).parent / "database.json"
    return Path(os.getenv("POLICIES_DATA_FILE", default_file))


def read_policies() -> list[dict]:
    data_file = get_data_file()
    if not data_file.exists():
        return []

    with data_file.open("r", encoding="utf-8") as file:
        try:
            data = json.load(file)
        except json.JSONDecodeError:
            return []

    return data if isinstance(data, list) else []


def write_policies(policies: list[dict]) -> None:
    data_file = get_data_file()
    data_file.parent.mkdir(parents=True, exist_ok=True)
    with data_file.open("w", encoding="utf-8") as file:
        json.dump(policies, file, ensure_ascii=False, indent=2)


def normalize_code(codigo: str) -> str:
    return codigo.strip().upper()


def find_policy_index(policies: list[dict], codigo: str) -> int:
    normalized_code = normalize_code(codigo)
    for index, policy in enumerate(policies):
        if policy["codigo"].upper() == normalized_code:
            return index
    return -1


@app.get("/", response_model=RootResponse, tags=["Sistema"])
def root() -> RootResponse:
    return RootResponse(
        message="API funcionando correctamente",
        status="ok",
        endpoints={
            "salud": "/health",
            "documentacion": "/docs",
            "listar_polizas": "/policies",
            "listar_polizas_es": "/polizas",
        },
    )


@app.get("/health", response_model=MessageResponse, tags=["Sistema"])
def health_check() -> MessageResponse:
    return MessageResponse(message="API funcionando correctamente")


@app.get("/policies", response_model=List[PolicyResponse], tags=["Pólizas"])
@app.get("/polizas", response_model=List[PolicyResponse], tags=["Pólizas"])
def list_policies() -> list[dict]:
    return read_policies()


@app.get("/policies/{codigo}", response_model=PolicyResponse, tags=["Pólizas"])
@app.get("/polizas/{codigo}", response_model=PolicyResponse, tags=["Pólizas"])
def get_policy(codigo: str) -> dict:
    policies = read_policies()
    index = find_policy_index(policies, codigo)
    if index == -1:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Póliza no encontrada")
    return policies[index]


@app.post("/policies", response_model=PolicyResponse, status_code=status.HTTP_201_CREATED, tags=["Pólizas"])
@app.post("/polizas", response_model=PolicyResponse, status_code=status.HTTP_201_CREATED, tags=["Pólizas"])
def create_policy(policy: PolicyCreate) -> dict:
    policies = read_policies()
    if find_policy_index(policies, policy.codigo) != -1:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Ya existe una póliza con ese código")

    new_policy = policy.model_dump(mode="json")
    policies.append(new_policy)
    write_policies(policies)
    return new_policy


@app.put("/policies/{codigo}", response_model=PolicyResponse, tags=["Pólizas"])
@app.put("/polizas/{codigo}", response_model=PolicyResponse, tags=["Pólizas"])
def update_policy(codigo: str, policy: PolicyUpdate) -> dict:
    policies = read_policies()
    index = find_policy_index(policies, codigo)
    if index == -1:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Póliza no encontrada")

    updated_policy = {
        "codigo": policies[index]["codigo"],
        **policy.model_dump(mode="json"),
    }
    policies[index] = updated_policy
    write_policies(policies)
    return updated_policy


@app.delete("/policies/{codigo}", response_model=MessageResponse, tags=["Pólizas"])
@app.delete("/polizas/{codigo}", response_model=MessageResponse, tags=["Pólizas"])
def delete_policy(codigo: str) -> MessageResponse:
    policies = read_policies()
    index = find_policy_index(policies, codigo)
    if index == -1:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Póliza no encontrada")

    policies.pop(index)
    write_policies(policies)
    return MessageResponse(message="Póliza eliminada correctamente")
