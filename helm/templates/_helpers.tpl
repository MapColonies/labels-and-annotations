{{/*
Create common labels for all kubernetes components
*/}}
{{- define "common-labels-and-annotations.selectorLabels" -}}
{{- $commonLabelsAndAnnotations := fromYaml (include "commonLabelsAndAnnotations.merged" .) -}}
mapcolonies.io/environment: {{ $commonLabelsAndAnnotations.environment }}
{{- end }}

{{/*
Create common labels for all kubernetes components
*/}}
{{- define "common-labels-and-annotations.labels" -}}
{{- include "validate" . }}
{{- $commonLabelsAndAnnotations := fromYaml (include "commonLabelsAndAnnotations.merged" .) -}}
app.kubernetes.io/part-of: {{ $commonLabelsAndAnnotations.partOf }}
mapcolonies.io/owner: {{ $commonLabelsAndAnnotations.owner }}
app.kubernetes.io/component: {{ $commonLabelsAndAnnotations.component }}
{{- if hasKey $commonLabelsAndAnnotations "releaseVersion" }}
mapcolonies.io/release-version: {{ $commonLabelsAndAnnotations.releaseVersion }}
{{- end -}}
{{ if hasKey $commonLabelsAndAnnotations "gisDomain" }}
mapcolonies.io/gis-domain: {{ $commonLabelsAndAnnotations.gisDomain }}
{{- end -}}
{{- end }}

{{/*
Create common annotations for all kubernetes components
*/}}
{{- define "common-labels-and-annotations.annotations" -}}
{{- end }}

{{/*
Create prometheus annotations for enabling metrics
*/}}
{{- define "common-labels-and-annotations.metricsAnnotations" -}}
{{- $commonLabelsAndAnnotations := fromYaml (include "commonLabelsAndAnnotations.merged" .) -}}
prometheus.io/scrape: "true"
prometheus.io/port: {{ coalesce $commonLabelsAndAnnotations.metricsPort "8080" | quote }}
prometheus.io/path: {{ coalesce $commonLabelsAndAnnotations.metricsPath "/metrics" | quote }}
{{- end }}
