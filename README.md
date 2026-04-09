# Neuromántico

Repo Android mínimo en Kotlin + Jetpack Compose para que GitHub Actions te entregue una APK debug descargable.

## Qué hace esta base
- Abre una app real de Android
- Tiene botón de captura/análisis
- Ejecuta tu motor lógico en `core/`
- Genera `app-debug.apk` en GitHub Actions

## Estructura
- `app/src/main/java/com/neuromantico/core` → motor
- `app/src/main/java/com/neuromantico/input` → captura
- `app/src/main/java/com/neuromantico/data` → repositorio
- `app/src/main/java/com/neuromantico/model` → modelos
- `.github/workflows/build-apk.yml` → pipeline

## Cómo usarlo
1. Crear repo nuevo en GitHub.
2. Subir todo este contenido a la rama `main`.
3. Ir a **Actions**.
4. Ejecutar **Build APK** o hacer push.
5. Descargar el artifact `neuromantico-debug-apk`.

## Próximo paso lógico
Cambiar la captura demo por sensores reales y persistencia local con Room/DataStore.
