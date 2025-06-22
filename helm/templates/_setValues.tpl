{{- define "environmentMerged" -}}

{{- if hasKey .Values.mcLabelsAndAnnotations "environment" -}}
{{- .Values.mcLabelsAndAnnotations.environment -}}
{{- else if (and (hasKey .Values "global") (hasKey .Values.global "mcLabelsAndAnnotations") (hasKey .Values.global.mcLabelsAndAnnotations "environment")) -}}
{{- .Values.global.mcLabelsAndAnnotations.environment -}}
{{- else -}}
{{- fail "There is no environment key in mcLabelsAndAnnotations, globally or locally" -}}
{{- end -}}
{{- end -}}
