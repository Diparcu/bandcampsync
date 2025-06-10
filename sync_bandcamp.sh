#!/usr/bin/env bash
# Script: sync_bandcamp.sh
# Desc: Descarga tu colección de Jean desde Bandcamp usando bandcampsync en un venv.
# Ubicación: /home/jfuser/scripts/bandcampsync
# Cookies Netscape en bandcamp_cookies.txt
# Destino: /HDD4TB3/home/jfuser/Musica/Jean

set -euo pipefail

# Variables
SCRIPT_DIR="/home/jfuser/scripts/bandcampsync"
COOKIES_FILE="$SCRIPT_DIR/bandcamp_cookies.txt"
OUTPUT_DIR="/HDD4TB3/home/jfuser/Musica/Jean"
VENV_DIR="$SCRIPT_DIR/venv"

# Verificar cookie-file
if [[ ! -f "$COOKIES_FILE" ]]; then
  echo "Error: No se encontró $COOKIES_FILE"
  exit 1
fi

# Crear venv si no existe
activate_venv() {
  # shellcheck source=/dev/null
  source "$VENV_DIR/bin/activate"
}

if [[ ! -d "$VENV_DIR" ]]; then
  echo "Creando entorno virtual en $VENV_DIR..."
  python3 -m venv "$VENV_DIR"
  activate_venv
  pip install --upgrade pip
  pip install bandcampsync
else
  activate_venv
fi

# Crear directorio de salida
mkdir -p "$OUTPUT_DIR"

# Ejecutar bandcampsync
cd "$OUTPUT_DIR"
echo "Descargando colección de Jean..."
bandcampsync \
  -c "$COOKIES_FILE" \
  -d "$OUTPUT_DIR" \

echo "Finalizado. Archivos en: $OUTPUT_DIR"
