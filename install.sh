#!/usr/bin/env bash
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "$KIT_DIR/AGENTS.md" ]; then
    echo "Error: No se encontró AGENTS.md en $KIT_DIR"
    exit 1
fi

PROJECT="${1:-}"

if [ -z "$PROJECT" ]; then
    read -rp "Carpeta destino de tu proyecto [~/Desktop/mi-proyecto-gemini]: " PROJECT
    PROJECT="${PROJECT:-$HOME/Desktop/mi-proyecto-gemini}"
fi

mkdir -p "$PROJECT"
PROJECT="$(cd "$PROJECT" && pwd)"

echo "Instalando Gemini Design Harness en: $PROJECT"

# 1. Copiar AGENTS.md
cp "$KIT_DIR/AGENTS.md" "$PROJECT/AGENTS.md"

# 2. Copiar documentación y protocolo
DOCS_DIR="$PROJECT/docs/harness"
mkdir -p "$DOCS_DIR"

FILES=(
    README.md
    HARNESS.md
    MODEL-NOTES.md
    SUBAGENTS.md
    COST.md
    SKILLS.md
    KICKOFF.md
    QUESTION-BANK.md
    CHANGELOG.md
    ROADMAP.md
)

for file in "${FILES[@]}"; do
    if [ -f "$KIT_DIR/$file" ]; then
        cp "$KIT_DIR/$file" "$DOCS_DIR/$file"
    fi
done

for dir in templates state checklists; do
    if [ -d "$KIT_DIR/$dir" ]; then
        cp -r "$KIT_DIR/$dir" "$DOCS_DIR/"
    fi
done

# 3. Copiar skills
if [ -d "$KIT_DIR/skills" ]; then
    for target in "$PROJECT/.gemini/skills" "$PROJECT/.opencode/skills"; do
        mkdir -p "$target"
        find "$KIT_DIR/skills" -mindepth 1 -maxdepth 1 -type d ! -name "_*" -exec cp -r {} "$target/" \;
    done
fi

echo "¡Instalación completada!"
echo "Abre tu editor en: $PROJECT y comienza con la Ronda 1."
