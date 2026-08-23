# Tag 16 Praxis — Container-Automatisierung mit GitHub Actions

> **Praxisauftraege.** Dieses Repository ist dein Arbeitsplatz fuer die
> Praxis-Uebungen von Tag 16. Es enthaelt bewusst nur das Geruest —
> jede Datei schreibst du selbst.

## Ausgangslage

Von der CI-Pipeline fuer Container-Builds ueber den Registry-Push bis zum
Cloud-Deployment: CI-Build (Uebung 1), Image-Push zu AWS ECR (Uebung 2) und
Continuous Deployment auf AWS ECS (Uebung 3). Die Uebungen bauen
aufeinander auf.

## Ordnerstruktur

Alle Dateien gehoeren ins **Wurzel-Verzeichnis** dieses Repos bzw. in
`.github/workflows/` — nur dort fuehrt GitHub Actions Workflows aus. Lege
keine Unterordner pro Uebung an; die automatische Pruefung sucht die
Dateien genau hier.

```
app.py                          # Uebung 1: Anwendung (z. B. Flask, Port 8080)
requirements.txt                # Uebung 1
Dockerfile                      # Uebung 1
.github/workflows/aufgabe1.yml  # Uebung 1: CI-Build
.github/workflows/aufgabe2.yml  # Uebung 2: Push zu AWS ECR
.github/workflows/aufgabe3.yml  # Uebung 3: Deploy zu AWS ECS
DOKUMENTATION.md                # deine Pipeline-Doku
```

## Aufgaben

### Uebung 1 — Automatisierter Build mit GitHub Actions (CI-Pipeline)

- Lege im Wurzel-Verzeichnis eine kleine Anwendung an: `app.py`
  (z. B. Flask, Port 8080), `requirements.txt` und ein `Dockerfile`.
- Lege `.github/workflows/aufgabe1.yml` an, das das Container-Image baut
  (`docker/setup-buildx-action` und `docker/build-push-action` oder
  `docker build`).

### Uebung 2 — Container Registry: Image-Push zu AWS ECR

- Erweitere die Pipeline zu `.github/workflows/aufgabe2.yml`.
- Authentifiziere dich mit `aws-actions/configure-aws-credentials@v4` und
  den Secrets `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`.
- Melde dich mit `aws-actions/amazon-ecr-login` an und pushe das Image in
  dein ECR-Repository.

### Uebung 3 — Continuous Deployment auf AWS ECS

- Erweitere die Pipeline zu `.github/workflows/aufgabe3.yml`.
- Aktualisiere die ECS Task Definition und den Service
  (`aws-actions/amazon-ecs-deploy-task-definition` oder
  `aws ecs update-service`).
- Benoetigte Variablen: `ECS_CLUSTER`, `ECS_SERVICE`, `ECS_TASK_DEFINITION`.
- Dokumentiere die Pipeline in `DOKUMENTATION.md`.

## Abnahmekriterien

Diese Kriterien prueft die Pipeline bei jedem Push automatisch. **Die Haken
setzt die Pipeline selbst:** ein erfuelltes Kriterium wird abgehakt, und
sobald eine Aenderung es wieder bricht, verschwindet der Haken. Du musst hier
nichts von Hand pflegen — beim naechsten Push wird die Liste ueberschrieben.

<!-- c50:progress -->
**Fortschritt: 0 / 11 Kriterien erfüllt** ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ — Stand: 2026-08-23 22:51 UTC.
<!-- /c50:progress -->

- [ ] ⬜ Übung 1: Anwendung vorhanden (app.py im Wurzel-Verzeichnis)
- [ ] ⬜ Übung 1: Dockerfile vorhanden (Wurzel-Verzeichnis)
- [ ] ⬜ Übung 1: Workflow vorhanden (.github/workflows/)
- [ ] ⬜ Übung 1: Container-Image wird im Workflow gebaut
- [ ] ⬜ Übung 2: Workflow mit ECR-Bezug vorhanden
- [ ] ⬜ Übung 2: AWS-Credentials als GitHub Secrets referenziert
- [ ] ⬜ Übung 2: ECR-Login und Image-Push vorhanden
- [ ] ⬜ Übung 3: Workflow mit ECS-Deployment vorhanden
- [ ] ⬜ Übung 3: ECS-Service wird aktualisiert (Deploy-Schritt)
- [ ] ⬜ Doku: DOKUMENTATION.md vorhanden
- [ ] ⬜ Doku: DOKUMENTATION.md hat ausreichend Inhalt (mind. 100 Wörter)

Zusaetzlich manuell abgenommen (nicht automatisch geprueft):

- ECR-Repository und ECS-Cluster im AWS-Lab angelegt
- End-to-End getestet: Push loest Build, Registry-Push und Deployment aus

## Abnahmekriterien selber pruefen

**Lokal** — jederzeit, ohne Push:

```bash
bash .github/classroom/grade.sh
```

Das Skript liest die Tagesnummer aus `.classroom50.yaml`. Du kannst sie
auch erzwingen:

```bash
CLASSROOM_DAY=16 bash .github/classroom/grade.sh
```

Die Ausgabe listet jedes Kriterium mit ✅ oder ❌ und nennt bei jedem ❌
den konkreten Loesungshinweis. Sobald ein Kriterium fehlt, endet das
Skript mit Exit-Code 1.

**In GitHub** — bei jedem Push:

Der Workflow **🎓 Classroom Autograding** laeuft automatisch und hakt die
erfuellten Kriterien oben im README ab. Ergebnis im Tab **Actions** →
letzter Run → Job *Abnahmekriterien pruefen*.

## Musterloesung

Nach dem Unterricht findest du die Musterloesung im Repository
[`tbzdevops/musterloesungen-praxisauftraege`](https://github.com/tbzdevops/musterloesungen-praxisauftraege/tree/day_16_solution)
auf dem Branch `day_16_solution`.
