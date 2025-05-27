# common-labels-and-annotations

This Helm chart provides MapColonies predefined labels and annotations through helper templates to streamline Kubernetes application deployments.

## Features
- Standardized Kubernetes labels and annotations
- Global and local metadata configuration
- Built-in validation for metadata values
- Helm template helpers for easy integration

## Installation

Add this chart as a dependency in your `Chart.yaml`:
<!-- x-release-please-start-version -->
```yaml
dependencies:
  - name: common-labels-and-annotations
    version: 0.3.0
    repository: oci://artifactory.io/helm/infra
```
<!-- x-release-please-end-version -->
Then run:
```bash
helm dependency update
```

## Usage

### Template Integration
Add these functions `{{ include "common-labels-and-annotations.labels" . }}` and `{{ include "common-labels-and-annotations.selectorLabels" . }}` to your labels and selectorLabels functions respectively under `_helpers.tpl` file:

```yaml
{{/*
Common labels
*/}}
{{- define "CHART-NAME.labels" -}}
...
YOUR CODE
...
{{ include "common-labels-and-annotations.labels" . }}
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

{{ include "common-labels-and-annotations.selectorLabels" . }}
{{- end }}
```

If you want to add also annotations for enabling prometheus scraping, use this function:
```yaml
metadata:
  annotations:
    {{ include "common-labels-and-annotations.metricsAnnotations" . | nindent 4 }}
```
This will add the metrics annotations to your deployment and allow prometheus to scrape it. Don't forget to change the metrics configuration in values if needed(See the metadata fields below).

### Configuration
Define "commonLabelsAndAnnotations" in `values.yaml`. Values can be set globally or overridden locally:

```yaml
global:
  commonLabelsAndAnnotations:
    environment: "development"
    component: "infrastructure"
    partOf: "monitoring"

commonLabelsAndAnnotations:
  component: "backend" # Overrides global.commonLabelsAndAnnotations.component
  owner: "3d" # Overrides global.commonLabelsAndAnnotations.owner
```

### Validation Rules

The chart validates the following metadata fields:

| Field | Required | Valid Values | Notes |
|----------------|----------|---------------------|----|
| environment | Yes | development, production, stage | |
| component | Yes | frontend, backend, database, proxy-server, cache-server, infrastructure | |
| partOf | Yes | non-empty string | |
| owner | Yes | vector, raster, 3d, app, dem, infra, common | Who is the owner of the deployment |
| gisDomain | No | vector, raster, 3d, dem, terrain-analysis | To what GIS domain it is related |
| releaseVersion | No | semantic version (e.g., v1.0.0) | The MapColonies project product version |
| metricsPort | No | port number | The port on which the metrics are exposed (8080 as default) |
| metricsPath | No | url path | The path on which the metrics are exposed (/metrics as default) |

## Maintainers

### File Structure
- `templates/_helpers.tpl`: Contains helper functions for generating labels and annotations.
- `templates/_setValues.tpl`: Contains functions for merging and setting commonLabelsAndAnnotations values.
- `templates/_validations.tpl`: Contains validation functions for commonLabelsAndAnnotations values.

### Adding New Labels Or Annotations
1. Add the labels or annotations in `templates/_helpers.tpl`.

### Adding New Validations
1. Define valid values in `templates/_setValues.tpl`.
2. Add validation logic in `templates/_validations.tpl`.
