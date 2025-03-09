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
{{- $global := default (dict) .Values.global -}}
{{- if not (or $global.commonLabelsAndAnnotations .Values.commonLabelsAndAnnotations) -}}
    {{- fail (printf "There is no commonLabelsAndAnnotations key (locally or globally)") -}}
{{- end -}}
{{- $globalCommonLabelsAndAnnotations := default (dict) $global.commonLabelsAndAnnotations -}}
{{- $localCommonLabelsAndAnnotations := default (dict) .Values.commonLabelsAndAnnotations -}}
{{- $merged := merge $localCommonLabelsAndAnnotations $globalCommonLabelsAndAnnotations -}}
{{- $merged | toYaml -}}
{{- end -}}
