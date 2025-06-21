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

{{- if not (hasKey $globalCommonLabelsAndAnnotations "environment") -}}
  {{- fail (printf "The required key 'environment' is missing in global.commonLabelsAndAnnotations") -}}
{{- end -}}

{{- $forbiddenKeys := list "partOf" "owner" "component" -}}
{{- range $key := $forbiddenKeys -}}
  {{- if hasKey $globalCommonLabelsAndAnnotations $key -}}
    {{- fail (printf "Forbidden key '%s' found in global.commonLabelsAndAnnotations. It must only be defined locally." $key) -}}
  {{- end -}}
{{- end -}}

{{- $allowedGlobal := dict -}}
{{- $_ := set $allowedGlobal "environment" (get $globalCommonLabelsAndAnnotations "environment") -}}

{{- $merged := merge $localCommonLabelsAndAnnotations $globalCommonLabelsAndAnnotations -}}
{{- $merged | toYaml -}}
{{- end -}}
