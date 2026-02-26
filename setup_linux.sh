#!/usr/bin/env bash
set -e

if [ -f ".env" ]; then
  set -a
  source .env
  set +a
fi

if [ ! -f ".env" ]; then
  echo "No .env found."
  echo "Copy .env.example to .env and fill in FITNESS_DB_PASS (optional)."
fi

# Connection details for MySQL
HOST="${FITNESS_DB_HOST:-127.0.0.1}"
PORT="${FITNESS_DB_PORT:-3306}"
USER="${FITNESS_DB_USER:-fitness_app}"
DB="${FITNESS_DB_NAME:-exercise}"

if [[ -n "${FITNESS_DB_PASS:-}" ]]; then
  PASS_ARG="-p${FITNESS_DB_PASS}"
else
  PASS_ARG="-p"
fi

python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Check if MySQL is installed
command -v mysql >/dev/null 2>&1 || {
  echo "MySQL client not found. Install with: sudo apt install mysql-client mysql-server"
  exit 1
}

# Check if MySQL server is running
systemctl is-active --quiet mysql || {
  echo "MySQL server isn't running. Start it with: sudo systemctl start mysql"
  exit 1
}

echo "Running schema.sql (creates DB + tables)..."
mysql -h "$HOST" -P "$PORT" -u "$USER" -p < schema.sql

echo "Running seed.sql (inserts starter data)..."
mysql -h "$HOST" -P "$PORT" -u "$USER" -p "$DB" < seed.sql

echo "Starting web app..."
streamlit run web_app.py
