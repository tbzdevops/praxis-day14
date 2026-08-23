#!/bin/bash
# PRAXIS Tag 16 — Container Teil 2 (Automatisierung mit GitHub Actions).
# Geprüft wird das Wurzel-Verzeichnis: die Workflows liegen in
# .github/workflows/ — genau dort, wo GitHub Actions sie ausführt.
source .github/classroom/grade.sh

solution_for_id() {
  case "$1" in
    app) echo "Lege app.py und requirements.txt im Wurzel-Verzeichnis an" ;;
    dockerfile) echo "Lege das Dockerfile im Wurzel-Verzeichnis an" ;;
    ci-workflow) echo "Lege .github/workflows/aufgabe1.yml mit Container-Build an" ;;
    ci-build) echo "Nutze docker/build-push-action oder 'docker build' im Workflow" ;;
    ecr-workflow) echo "Lege .github/workflows/aufgabe2.yml für den ECR-Push an" ;;
    aws-credentials) echo "Nutze aws-actions/configure-aws-credentials mit den AWS-Secrets" ;;
    ecr-login) echo "Ergänze aws-actions/amazon-ecr-login und den Image-Push" ;;
    ecs-workflow) echo "Lege .github/workflows/aufgabe3.yml für das ECS-Deployment an" ;;
    ecs-deploy) echo "Ergänze das ECS-Deployment (amazon-ecs-deploy-task-definition oder aws ecs update-service)" ;;
    praxis-doku) echo "Lege DOKUMENTATION.md im Wurzel-Verzeichnis an und dokumentiere die Pipeline (mind. 100 Wörter)" ;;
    *) echo "Überprüfe die Aufgabenstellung im README" ;;
  esac
}

echo "🔍 Prüfe Abnahmekriterien für Tag 16 Praxis — Container-Automatisierung mit GitHub Actions"
echo ""

WF=.github/workflows
DOKU=DOKUMENTATION.md

# classroom.yml gehoert zur Bewertung und darf kein Kriterium erfuellen.
all_wf() { ls $WF/*.yml $WF/*.yaml 2>/dev/null | grep -v '/classroom\.yml$'; }
ecr_wf() { all_wf | xargs -r grep -lEi 'ecr' 2>/dev/null; }
ecs_wf() { all_wf | xargs -r grep -lEi 'ecs' 2>/dev/null; }
ALL="$(all_wf | tr '\n' ' ')/dev/null"
ECR="$(ecr_wf | tr '\n' ' ')/dev/null"
ECS="$(ecs_wf | tr '\n' ' ')/dev/null"

echo "── Übung 1: Automatisierter Build mit GitHub Actions ──"

check "app" \
  "Übung 1: Anwendung vorhanden (app.py im Wurzel-Verzeichnis)" \
  "[ -f app.py ]"

check_file_exists "dockerfile" \
  "Übung 1: Dockerfile vorhanden (Wurzel-Verzeichnis)" \
  "Dockerfile"

check "ci-workflow" \
  "Übung 1: Workflow vorhanden (.github/workflows/)" \
  "all_wf | grep -q ."

check "ci-build" \
  "Übung 1: Container-Image wird im Workflow gebaut" \
  "grep -qiE 'docker/build-push-action|docker build|buildx' $ALL"

echo ""
echo "── Übung 2: Container Registry (Image Push zu AWS ECR) ──"

check "ecr-workflow" \
  "Übung 2: Workflow mit ECR-Bezug vorhanden" \
  "ecr_wf | grep -q ."

check "aws-credentials" \
  "Übung 2: AWS-Credentials als GitHub Secrets referenziert" \
  "grep -qE 'secrets\.AWS_|configure-aws-credentials' $ECR"

check "ecr-login" \
  "Übung 2: ECR-Login und Image-Push vorhanden" \
  "grep -qiE 'amazon-ecr-login|ecr' $ECR && grep -qiE 'push' $ECR"

echo ""
echo "── Übung 3: Continuous Deployment auf AWS ECS ──"

check "ecs-workflow" \
  "Übung 3: Workflow mit ECS-Deployment vorhanden" \
  "ecs_wf | grep -q ."

check "ecs-deploy" \
  "Übung 3: ECS-Service wird aktualisiert (Deploy-Schritt)" \
  "grep -qiE 'amazon-ecs-deploy|ecs update-service|task-definition' $ECS"

echo ""
echo "── Dokumentation ──"

check_file_exists "praxis-doku" \
  "Doku: DOKUMENTATION.md vorhanden" \
  "$DOKU"

check "praxis-doku" \
  "Doku: DOKUMENTATION.md hat ausreichend Inhalt (mind. 100 Wörter)" \
  "[ \$(wc -w < $DOKU 2>/dev/null) -ge 100 ]"

summary 16
