# mcLabelsAndAnnotations

This Helm chart provides MapColonies predefined labels and annotations through helper templates to streamline Kubernetes application deployments.

## Features
- Standardized MapColonies labels and annotations
- Global and local metadata configuration
- Built-in schema-based validation for metadata values
- Helm template helpers for easy integration

## Installation

Add this chart as a dependency in your `Chart.yaml`:
<!-- x-release-please-start-version -->
```yaml
dependencies:
  - name: mcLabelsAndAnnotations
    version: 0.4.0
    repository: oci://artifactory.io/helm/infra
```
<!-- x-release-please-end-version -->
Then run:
```bash
helm dependency update
```

## Usage

### Template Integration
Add these functions `{{ include "mcLabelsAndAnnotations.labels" . }}` and `{{ include "mcLabelsAndAnnotations.selectorLabels" . }}` to your labels and selectorLabels functions respectively under `_helpers.tpl` file:

```yaml
{{/*
Common labels
*/}}
{{- define "CHART-NAME.labels" -}}
...
YOUR CODE
...
{{ include "mcLabelsAndAnnotations.labels" . }}
{{- end }}
```

```yaml
{{/*
Selector labels
*/}}
{{- define "CHART-NAME.selectorLabels" -}}
...
YOUR CODE
...

{{ include "mcLabelsAndAnnotations.selectorLabels" . }}
{{- end }}
```

If you want to add also annotations (for example, enabling metrics annotations), use this function:
```yaml
metadata:
  annotations:
    {{ include "mcLabelsAndAnnotations.annotations" . | nindent 4 }}
```

### Configuration
Define "mcLabelsAndAnnotations" in `values.yaml`. Some values can be set globally and can be overridden locally for specific cases

```yaml
global:
  mcLabelsAndAnnotations:
    environment: "development"

mcLabelsAndAnnotations:
  environment: "stage" # Overrides global.mcLabelsAndAnnotations.environment
  owner: "3d"
```

### Validation Rules

The chart validates the following metadata fields:

| Field | Required | Valid Values | Notes |
|----------------|----------|---------------------|----|
| environment | Yes | development, production, stage | Can be set globally |
| component | Yes | frontend, backend, database, proxy-server, cache-server, infrastructure | |
| partOf | Yes | non-empty string | |
| owner | Yes | vector, raster, 3d, app, dem, infra, common | Who is the owner of the deployment |
| gisDomain | No | vector, raster, 3d, dem, terrain-analysis | To what GIS domain it is related |
| metricsEnabled | No | boolean | true, false | Whether to enable metrics annotations (enabled as default) |
| metricsPort | No | port number | The port on which the metrics are exposed (8080 as default) |
| metricsPath | No | url path | The path on which the metrics are exposed (/metrics as default) |

## Maintainers

### File Structure
- `templates/_helpers.tpl`: Contains helper functions for generating labels and annotations.
- `templates/_setValues.tpl`: Contains functions for merging and setting mcLabelsAndAnnotations values.

### Adding New Labels Or Annotations
1. Add the labels or annotations in `templates/_helpers.tpl`.

### Adding New Validations
1. Define valid values in `templates/_setValues.tpl`.
2. Add validation logic in `templates/_validations.tpl`.
