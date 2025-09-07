{{/*
Create common labels for all kubernetes components
*/}}
{{- define "mcLabelsAndAnnotations.selectorLabels" -}}
{{- end }}

{{/*
Create common labels for all kubernetes components
*/}}
{{- define "mcLabelsAndAnnotations.labels" -}}
mapcolonies.io/environment: {{ include "environmentMerged" . }}
mapcolonies.io/part-of: {{ .Values.mcLabelsAndAnnotations.partOf }}
mapcolonies.io/owner: {{ .Values.mcLabelsAndAnnotations.owner }}
mapcolonies.io/component: {{ .Values.mcLabelsAndAnnotations.component }}
mapcolonies.io/alloy-api-logs: {{ coalesce .Values.mcLabelsAndAnnotations.logScraping "false" | quote }}
{{- if hasKey .Values.mcLabelsAndAnnotations "gisDomain" }}
mapcolonies.io/gis-domain: {{ .Values.mcLabelsAndAnnotations.gisDomain }}
{{- end -}}
{{- end }}

{{/*
Create common annotations for all kubernetes components
*/}}
{{- define "mcLabelsAndAnnotations.annotations" -}}
{{- if and (hasKey .Values.mcLabelsAndAnnotations "prometheus") .Values.mcLabelsAndAnnotations.prometheus.enabled }}
prometheus.io/scrape: "true"
prometheus.io/port: {{ coalesce .Values.mcLabelsAndAnnotations.prometheus.port "8080" | quote }}
prometheus.io/path: {{ coalesce .Values.mcLabelsAndAnnotations.prometheus.path "/metrics" | quote }}
{{- end }}
{{- end }}
