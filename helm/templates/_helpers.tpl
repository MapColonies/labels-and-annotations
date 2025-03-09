{{/*
Create common labels for all kubernetes components
*/}}
{{- define "generalLabels" -}}
{{- include "validateGeneral" . }}
{{- include "selectorLabels" . }}
{{ $commonLabelsAndAnnotations := fromYaml (include "commonLabelsAndAnnotations.merged" .) -}}
app.kubernetes.io/part-of: {{ $commonLabelsAndAnnotations.partOf }}
mapcolonies.io/owner: {{ $commonLabelsAndAnnotations.owner }}
app.kubernetes.io/created-by: {{ $commonLabelsAndAnnotations.createdBy }}
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
{{- define "generalAnnotations" -}}
{{- end }}

{{/*
Create common labels for all kubernetes components
*/}}
{{- define "selectorLabels" -}}
{{- $commonLabelsAndAnnotations := fromYaml (include "commonLabelsAndAnnotations.merged" .) -}}
mapcolonies.io/environment: {{ $commonLabelsAndAnnotations.environment }}
{{- end }}

{{/*
Create common labels for all kubernetes components besides service.
It includes also the common labels from "generalLabels" function
*/}}
{{- define "common-labels-and-annotations.labels" -}}
{{- include "validate" . }}
{{- $commonLabelsAndAnnotations := fromYaml (include "commonLabelsAndAnnotations.merged" .) -}}
{{- include "generalLabels" . }}
app.kubernetes.io/component: {{ $commonLabelsAndAnnotations.component }}
{{- end }}

{{/*
Create common annotations for all kubernetes components besides service.
It includes also the common annotations from "generalAnnotations" function
*/}}
{{- define "common-labels-and-annotations.annotations" -}}
{{- include "generalAnnotations" . }}
{{- end }}

{{/*
Create common labels for kubernetes service component.
It includes also the common labels from "generalLabels" function
*/}}
{{- define "common-labels-and-annotations.serviceLabels" -}}
{{- include "generalLabels" . }}
{{- end }}

{{/*
Create common annotations for kubernetes service component.
It includes also the common annotations from "generalAnnotations" function
*/}}
{{- define "common-labels-and-annotations.serviceAnnotations" -}}
{{- include "generalAnnotations" . }}
{{- end }}
