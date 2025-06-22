{{/*
Create common labels for all kubernetes components
*/}}
{{- define "mcLabelsAndAnnotations.selectorLabels" -}}
mapcolonies.io/environment: {{ include "environmentMerged" . }}
{{- end }}

{{/*
Create common labels for all kubernetes components
*/}}
{{- define "mcLabelsAndAnnotations.labels" -}}
mapcolonies.io/part-of: {{ .Values.mcLabelsAndAnnotations.partOf }}
mapcolonies.io/owner: {{ .Values.mcLabelsAndAnnotations.owner }}
mapcolonies.io/component: {{ .Values.mcLabelsAndAnnotations.component }}
{{- if hasKey .Values.mcLabelsAndAnnotations "gisDomain" }}
mapcolonies.io/gis-domain: {{ .Values.mcLabelsAndAnnotations.gisDomain }}
{{- end -}}
{{- end }}

{{/*
Create common annotations for all kubernetes components
*/}}
{{- define "mcLabelsAndAnnotations.annotations" -}}
prometheus.io/scrape: {{ coalesce .Values.mcLabelsAndAnnotations.metricsEnabled "true" | quote }}
prometheus.io/port: {{ coalesce .Values.mcLabelsAndAnnotations.metricsPort "8080" | quote }}
prometheus.io/path: {{ coalesce .Values.mcLabelsAndAnnotations.metricsPath "/metrics" | quote }}
{{- end }}
