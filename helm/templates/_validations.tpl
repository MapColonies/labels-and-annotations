{{/*
Validates commonLabelsAndAnnotations values needed for labels and annotations of all kubernetes components
*/}}
{{- define "validate" -}}
{{- $commonLabelsAndAnnotations := include "commonLabelsAndAnnotations.merged" . | fromYaml -}}

{{- if not (hasKey $commonLabelsAndAnnotations "environment") -}}
    {{- fail "There is no environment key in commonLabelsAndAnnotations" -}}
{{- end -}}
{{- if not (hasKey $commonLabelsAndAnnotations "partOf") -}}
    {{- fail "There is no partOf key in commonLabelsAndAnnotations" -}}
{{- end -}}
{{- if not (hasKey $commonLabelsAndAnnotations "owner") -}}
    {{- fail "There is no owner key in commonLabelsAndAnnotations" -}}
{{- end -}}
{{- if not (hasKey $commonLabelsAndAnnotations "component") -}}
    {{- fail "There is no component key in commonLabelsAndAnnotations" -}}
{{- end -}}

{{- $environments := splitList " " (include "environments" .) }}
{{- $gisDomains := splitList " " (include "gisDomains" .) }}
{{- $owners := splitList " " (include "owners" .) }}
{{- $components := splitList " " (include "components" .) }}

{{- if not (has $commonLabelsAndAnnotations.environment $environments) -}}
    {{- fail (printf "Invalid value for environment.\nProvided: %s \nValid values are: %s" $commonLabelsAndAnnotations.environment ($environments | join " | ")) -}}
{{- end -}}

{{- if not (has $commonLabelsAndAnnotations.owner $owners) -}}
    {{- fail (printf "Invalid value for owner.\nProvided: %s \nValid values are: %s" $commonLabelsAndAnnotations.owner ($owners | join " | ")) -}}
{{- end -}}

{{- if and (hasKey $commonLabelsAndAnnotations "gisDomain") (not (has $commonLabelsAndAnnotations.gisDomain $gisDomains)) -}}
    {{- fail (printf "Invalid value for gisDomain.\nProvided: %s \nValid values are: %s" $commonLabelsAndAnnotations.gisDomain ($gisDomains | join " | ")) -}}
{{- end -}}

{{- if not (has $commonLabelsAndAnnotations.component $components) -}}
    {{- fail (printf "Invalid value for component.\nProvided: %s \nValid values are: %s" $commonLabelsAndAnnotations.component ($components | join " | ")) -}}
{{- end -}}
{{- end -}}
