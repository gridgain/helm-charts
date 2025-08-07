{{/*
Expand the name of the chart.
*/}}
{{- define "gridgain9.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gridgain9.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gridgain9.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gridgain9.labels" -}}
helm.sh/chart: {{ include "gridgain9.chart" . }}
{{ include "gridgain9.selectorLabels" . }}
{{- if .Values.customLabels }}
{{ include "common.tplvalues.render" (dict "value" .Values.customLabels "context" $) }}
{{- end }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gridgain9.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gridgain9.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "gridgain9.podLabels" -}}
{{ include "gridgain9.selectorLabels" . }}
{{- if .Values.podLabels }}
{{ include "common.tplvalues.render" (dict "value" .Values.podLabels "context" $) }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gridgain9.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gridgain9.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "createConfigmap" -}}
{{- if not .Values.existingConfigmap -}}
    {{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Convert memory string to bytes
*/}}
{{- define "gridgain9.memoryToBytes" -}}
{{- $memory := . -}}
{{- if hasSuffix "Gi" $memory -}}
{{- mul (atoi (trimSuffix "Gi" $memory)) 1073741824 -}}
{{- else if hasSuffix "Mi" $memory -}}
{{- mul (atoi (trimSuffix "Mi" $memory)) 1048576 -}}
{{- else if hasSuffix "Ki" $memory -}}
{{- mul (atoi (trimSuffix "Ki" $memory)) 1024 -}}
{{- else if hasSuffix "G" $memory -}}
{{- mul (atoi (trimSuffix "G" $memory)) 1000000000 -}}
{{- else if hasSuffix "M" $memory -}}
{{- mul (atoi (trimSuffix "M" $memory)) 1000000 -}}
{{- else if hasSuffix "K" $memory -}}
{{- mul (atoi (trimSuffix "K" $memory)) 1000 -}}
{{- else -}}
{{- atoi $memory -}}
{{- end -}}
{{- end -}}
