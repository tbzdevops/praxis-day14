#!/bin/bash
# PRAXIS Tag 16 — Container Teil 2 (Automatisierung mit GitHub Actions).
# Praxis-Ordner tag16/.
source .github/classroom/grade.sh

solution_for_id() {
  case "$1" in
    app) echo "Lege tag16/uebung01-ci-build/app.py und requirements.txt an" ;;
    dockerfile) echo "Lege tag16/uebung01-ci-build/Dockerfile an" ;;
    ci-workflow) echo "Lege tag16/uebung01-ci-build/.github/workflows/aufgabe1.yml mit Container-Build an" ;;
    ci-build) echo "Nutze docker/build-push-action oder 'docker build' im Workflow" ;;
    ecr-workflow) echo "Lege einen Workflow für den ECR-Push an (aufgabe2.yml)" ;;
    aws-credentials) echo "Nutze aws-actions/configure-aws-credentials mit den AWS-Secrets" ;;
    ecr-login) echo "Ergänze aws-actions/amazon-ecr-login und den Image-Push" ;;
    ecs-workflow) echo "Lege einen Workflow für das ECS-Deployment an (aufgabe3.yml)" ;;
    ecs-deploy) echo "Ergänze das ECS-Deployment (amazon-ecs-deploy-task-definition oder aws ecs update-service)" ;;
    praxis-doku) echo "Lege tag16/README.md an und dokumentiere die Pipeline (mind. 100 Wörter)" ;;
    *) echo "Überprüfe die Aufgabenstellung im README" ;;
  esac
}

echo "🔍 Prüfe Abnahmekriterien für Tag 16 Praxis — Container-Automatisierung mit GitHub Actions"
echo ""

U1=tag16/uebung01-ci-build
WF=$U1/.github/workflows

all_wf() { ls $WF/*.yml $WF/*.yaml 2>/dev/null; }
ecr_wf() { grep -lEi 'ecr' $WF/*.yml $WF/*.yaml 2>/dev/null; }
ecs_wf() { grep -lEi 'ecs' $WF/*.yml $WF/*.yaml 2>/dev/null; }
ALL="$(all_wf | tr '\n' ' ')/dev/null"
ECR="$(ecr_wf | tr '\n' ' ')/dev/null"
ECS="$(ecs_wf | tr '\n' ' ')/dev/null"

echo "── Übung 1: Automatisierter Build mit GitHub Actions ──"

check "app" \
  "Übung 1: Anwendung vorhanden (tag16/uebung01-ci-build/app.py)" \
  "[ -f $U1/app.py ]"

check_file_exists "dockerfile" \
  "Übung 1: Dockerfile vorhanden (tag16/uebung01-ci-build/)" \
  "$U1/Dockerfile"

check "ci-workflow" \
  "Übung 1: Workflow vorhanden (tag16/uebung01-ci-build/.github/workflows/)" \
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
  "Doku: tag16/README.md vorhanden" \
  "tag16/README.md"

check "praxis-doku" \
  "Doku: tag16/README.md hat ausreichend Inhalt (mind. 100 Wörter)" \
  "[ \$(wc -w < tag16/README.md 2>/dev/null) -ge 100 ]"

summary 16
