{{/*
Defines valid values for different fields
*/}}
{{- define "components" -}}
{{- join " " (list "frontend" "backend" "database" "proxy-server" "cache-server" "infrastructure") -}}
{{- end -}}

{{- define "gisDomains" -}}
{{- join " " (list "vector" "raster" "3d" "dem" "terrain-analysis") -}}
{{- end -}}

{{- define "environments" -}}
{{- join " " (list "development" "production" "stage") -}}
{{- end -}}

{{- define "owners" -}}
{{- join " " (list "vector" "raster" "3d" "app" "dem" "infra" "common") -}}
{{- end -}}

{{/*
Merge global and local commonLabelsAndAnnotations values
*/}}
{{- define "commonLabelsAndAnnotations.merged" -}}
{{- if not (or (and (hasKey .Values "global") (hasKey .Values.global "commonLabelsAndAnnotations")) .Values.commonLabelsAndAnnotations) -}}
    {{- fail (printf "There is no commonLabelsAndAnnotations key (locally or globally)") -}}
{{- end -}}
{{- $globalCommonLabelsAndAnnotations := default (dict) .Values.global.commonLabelsAndAnnotations -}}
{{- $localCommonLabelsAndAnnotations := default (dict) .Values.commonLabelsAndAnnotations -}}
{{- $merged := merge $localCommonLabelsAndAnnotations $globalCommonLabelsAndAnnotations -}}
{{- $merged | toYaml -}}
{{- end -}}
