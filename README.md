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
    version: 0.1.0
    repository: oci://artifactory.io/helm/infra
```
<!-- x-release-please-end-version -->
Then run:
```bash
helm dependency update
```

## Usage

### Template Integration
Add the following to your Kubernetes manifest templates:

```yaml
metadata:
  labels:
    {{ include "common-labels-and-annotations.labels" . | nindent 4 }}
  annotations:
    {{ include "common-labels-and-annotations.annotations" . | nindent 4 }}
```

For service component, use these functions instead:
```yaml
metadata:
  labels:
    {{ include "common-labels-and-annotations.serviceLabels" . | nindent 4 }}
  annotations:
    {{ include "common-labels-and-annotations.serviceAnnotations" . | nindent 4 }}
```

### Configuration
Define "commonLabelsAndAnnotations" in `values.yaml`. Values can be set globally or overridden locally:

```yaml
global:
  commonLabelsAndAnnotations:
    environment: "development"
    createdBy: "Person"
    component: "infrastructure"
    partOf: "Monitoring"

commonLabelsAndAnnotations:
  component: "backend" # Overrides global.commonLabelsAndAnnotations.component
  owner: "3d" # Overrides global.commonLabelsAndAnnotations.owner
```

### Validation Rules

The chart validates the following metadata fields:

| Field | Required | Valid Values | Notes |
|----------------|----------|---------------------|----|
| environment | Yes | development, production,stage | |
| createdBy | Yes | non-empty string   | The person who deployed it |
| component | Yes | frontend, backend, database, proxy-server, cache-server, infrastructure | Optional when deploying service |
| partOf | Yes | non-empty string | |
| owner | Yes | vector, raster, 3d, app, dem, infra, common | Who is the owner of the deployment |
| gisDomain | No | vector, raster, 3d, dem, terrain-analysis | To what GIS domain it is related |
| releaseVersion | No | semantic version (e.g., v1.0.0) | The MapColonies project product version |

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

### Updating the Chart Version
1. Update the version in `Chart.yaml`.
2. Update the version in the `README.md` installation instructions.

### Testing Changes
1. Make changes to the templates.
2. Run `helm lint` to validate the chart.
3. Deploy the chart in a test environment to ensure it works as expected.
