echo "=== Startup: Largest directories ==="
du -h -d 2 /app | sort -hr | head -20

echo "=== Startup: Largest packages ==="
python -m pip list --format=freeze | while read -r pkg; do
  path=$(python -c "import importlib.util as u; print(u.find_spec('${pkg%%==*}').origin)" 2>/dev/null)
  if [[ -n "$path" ]]; then du -sh "$(dirname $path)" 2>/dev/null; fi
done | sort -hr | head -20
