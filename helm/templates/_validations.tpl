{{/*
Not values.schema.json: Helm names only the bare subchart in schema errors, a template failure shows
the including chart's full path. Move back to a schema once Helm prints the full path there.
*/}}
{{- define "mclabels.validate" -}}
{{- $v := .Values.mclabels | default dict -}}
{{- $errors := list -}}

{{- range $key := list "component" "criticality" "partOf" "owner" -}}
{{- if eq (get $v $key | toString) "<nil>" "" -}}
{{- $errors = append $errors (printf "missing property '%s'" $key) -}}
{{- end -}}
{{- end -}}

{{- $enums := dict
  "environment" (list "development" "stage" "production")
  "component" (list "frontend" "backend" "database" "proxy-server" "cache-server" "infrastructure")
  "criticality" (list "internal" "customer")
  "owner" (list "vector" "raster" "3d" "app" "dem" "infra" "common" "automation")
  "gisDomain" (list "vector" "raster" "3d" "dem" "terrain-analysis")
-}}
{{- range $key, $allowed := $enums -}}
{{- $value := get $v $key -}}
{{- if and (hasKey $v $key) (not (eq ($value | toString) "<nil>" "")) (not (has $value $allowed)) -}}
{{- $errors = append $errors (printf "at '/%s': value must be one of '%s'" $key (join "', '" $allowed)) -}}
{{- end -}}
{{- end -}}

{{- if and (hasKey $v "logScraping") (not (kindIs "bool" $v.logScraping)) -}}
{{- $errors = append $errors "at '/logScraping': must be a boolean" -}}
{{- end -}}

{{- if hasKey $v "prometheus" -}}
{{- $p := $v.prometheus -}}
{{- if not (kindIs "map" $p) -}}
{{- $errors = append $errors "at '/prometheus': must be an object" -}}
{{- else -}}
{{- if not (hasKey $p "enabled") -}}
{{- $errors = append $errors "at '/prometheus': missing property 'enabled'" -}}
{{- else if not (kindIs "bool" $p.enabled) -}}
{{- $errors = append $errors "at '/prometheus/enabled': must be a boolean" -}}
{{- end -}}
{{- if hasKey $p "port" -}}
{{- if not (and (regexMatch "^[0-9]+$" ($p.port | toString)) (le 1 (int $p.port)) (le (int $p.port) 65535)) -}}
{{- $errors = append $errors "at '/prometheus/port': must be an integer between 1 and 65535" -}}
{{- end -}}
{{- end -}}
{{- if and (hasKey $p "path") (not (and (kindIs "string" $p.path) (hasPrefix "/" $p.path))) -}}
{{- $errors = append $errors "at '/prometheus/path': must be a string starting with '/'" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- if $errors -}}
{{- fail (printf "invalid mclabels values:\n- %s" (join "\n- " $errors)) -}}
{{- end -}}
{{- end -}}
