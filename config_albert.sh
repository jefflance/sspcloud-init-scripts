#!/bin/sh
# Pose un agent Continue sans toucher au config.yaml généré par l'extension.
# ALBERT_API_KEY : variable d'env Onyxia (idéalement adossée à Vault).
set -e

mkdir -p "$HOME/.continue/agents"

# La clé est lue depuis le Vault
cat > "$HOME/.continue/agents/albert.yaml" <<'EOF'
%YAML 1.1
---
name: Albert
version: 1.0.0
schema: v1
model_defaults: &model_defaults
  provider: openai
  apiKey: ${{ ALBERT_API_KEY }}
  apiBase: https://albert.api.etalab.gouv.fr/v1
models:
  - name: openweight-large
    <<: *model_defaults
    model: openweight-large
    roles:
      - chat
      - edit
      - apply
      - autocomplete
  - name: openweight-code
    <<: *model_defaults
    model: openweight-code
    roles:
      - chat
      - edit
      - apply
      - autocomplete
  - name: openweight-small
    <<: *model_defaults
    model: openweight-small
    roles:
      - chat
      - edit
      - apply
      - autocomplete
EOF

echo "Agent Continue posé (clé dans ~/.continue/.env)."
