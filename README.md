# mc-labels-and-annotations

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
  - name: mclabels
    version: 1.0.1
    repository: oci://acrarolibotnonprod.azurecr.io/helm/infra
```
<!-- x-release-please-end-version -->
Then run:
```bash
helm dependency update
```

## Usage

### Template Integration
Add these functions `{{ include "mclabels.labels" . }}` and `{{ include "mclabels.selectorLabels" . }}` to your labels and selectorLabels functions respectively under `_helpers.tpl` file:

```yaml
{{/*
Common labels
*/}}
{{- define "CHART-NAME.labels" -}}
...
YOUR CODE
...
{{ include "mclabels.labels" . }}
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

{{ include "mclabels.selectorLabels" . }}
{{- end }}
```

If you want to add also annotations (for example, enabling metrics annotations), use this function:
```yaml
spec:
  template:
    metadata:
      annotations:
        {{ include "mclabels.annotations" . | nindent 8 }}
```

### Configuration
Define "mclabels" in `values.yaml`. Some values can be set globally and can be overridden locally for specific cases

```yaml
global:
  mclabels:
    environment: "development"

mclabels:
  environment: "stage" # Overrides global.mclabels.environment
  criticality: "internal"
  owner: "3d"
  prometheus:
    enabled: true
    port: 8080
```

### Validation Rules

The chart validates the following metadata fields:

| Field              | Required | Valid Values                                                            | Default | Notes |
|--------------------|----------|----------------|----|----|
| environment        | No       | development, production, stage                                          | - | Can be set globally or locally |
| criticality        | Yes      | internal, customer                                                      | - | Deployment criticality classification |
| component          | Yes      | frontend, backend, database, proxy-server, cache-server, infrastructure | - | |
| partOf             | Yes      | non-empty string                                                        | - | |
| owner              | Yes      | vector, raster, 3d, app, dem, infra, common                             | - | Who is the owner of the deployment |
| gisDomain          | No       | vector, raster, 3d, dem, terrain-analysis                               | - | To what GIS domain it is related |
| prometheus.enabled | No       | boolean | false | Whether to enable metrics annotations |
| prometheus.port    | No       | port number | 8080 | The port on which the metrics are exposed |
| prometheus.path    | No       | url path | /metrics | The path on which the metrics are exposed  |
| logScraping        | No       | boolean | false | Whether to enable log scraping for this deployment |

## Maintainers

### File Structure
- `templates/_helpers.tpl`: Contains helper functions for generating labels and annotations.
- `templates/_setValues.tpl`: Contains functions for merging and setting mclabels values.

### Adding New Labels Or Annotations
1. Add the labels or annotations in `templates/_helpers.tpl`.

### Adding New Validations
1. Define valid values in `templates/_setValues.tpl`.
2. Add validation logic in `templates/_validations.tpl`.

## Migrations

### v0.x.x to v1
Rename the library name from `mc-labels-and-annotations` to `mclabels` in your `Chart.yaml` dependencies and update the references in your templates accordingly.
