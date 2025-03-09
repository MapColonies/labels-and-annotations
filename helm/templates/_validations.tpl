{{/*
Validates commonLabelsAndAnnotations values needed for general labels and annotations
*/}}
{{- define "validateGeneral" -}}
{{- $commonLabelsAndAnnotations := include "commonLabelsAndAnnotations.merged" . | fromYaml -}}

{{- if not (hasKey $commonLabelsAndAnnotations "environment") -}}
    {{- fail "There is no environment key in commonLabelsAndAnnotations" -}}
{{- end -}}
{{- if not (hasKey $commonLabelsAndAnnotations "createdBy") -}}
    {{- fail "There is no createdBy key in commonLabelsAndAnnotations" -}}
{{- end -}}
{{- if not (hasKey $commonLabelsAndAnnotations "partOf") -}}
    {{- fail "There is no partOf key in commonLabelsAndAnnotations" -}}
{{- end -}}
{{- if not (hasKey $commonLabelsAndAnnotations "owner") -}}
    {{- fail "There is no owner key in commonLabelsAndAnnotations" -}}
{{- end -}}

{{- $environments := splitList " " (include "environments" .) }}
{{- $gisDomains := splitList " " (include "gisDomains" .) }}
{{- $owners := splitList " " (include "owners" .) }}

{{- if not (has $commonLabelsAndAnnotations.environment $environments) -}}
    {{- fail (printf "Invalid value for mapcolonies.io/environment.\nProvided: %s \nValid values are: %s" $commonLabelsAndAnnotations.environment ($environments | join " | ")) -}}
{{- end -}}

{{- if not (has $commonLabelsAndAnnotations.owner $owners) -}}
    {{- fail (printf "Invalid value for mapcolonies.io/owner.\nProvided: %s \nValid values are: %s" $commonLabelsAndAnnotations.owner ($owners | join " | ")) -}}
{{- end -}}

{{- if and (hasKey $commonLabelsAndAnnotations "gisDomain") (not (has $commonLabelsAndAnnotations.gisDomain $gisDomains)) -}}
    {{- fail (printf "Invalid value for mapcolonies.io/gisDomain.\nProvided: %s \nValid values are: %s" $commonLabelsAndAnnotations.gisDomain ($gisDomains | join " | ")) -}}
{{- end -}}
{{- end -}}

{{/*
Validate commonLabelsAndAnnotations values needed for labels and annotations of all kubernetes components besides service
*/}}
{{- define "validate" -}}
{{- $commonLabelsAndAnnotations := include "commonLabelsAndAnnotations.merged" . | fromYaml -}}

{{- if not (hasKey $commonLabelsAndAnnotations "component") -}}
    {{- fail "There is no component key in commonLabelsAndAnnotations" -}}
{{- end -}}

{{- $components := splitList " " (include "components" .) }}

{{- if not (has $commonLabelsAndAnnotations.component $components) -}}
    {{- fail (printf "Invalid value for mapcolonies.io/component.\nProvided: %s \nValid values are: %s" $commonLabelsAndAnnotations.component ($components | join " | ")) -}}
{{- end -}}
{{- end -}}
