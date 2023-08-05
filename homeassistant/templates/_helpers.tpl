{{/*
Expand the name of the chart.
*/}}
{{- define "homeassistant.name" -}}
{{- default .Chart.Name .Values.namePrefix | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "homeassistant.fullnamePrefix" -}}
{{- $name := default .Chart.Name .Values.namePrefix }}
{{- if not .Values.namePrefix }}
  {{- default .Release.Name "" | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" .Release.Name .Values.namePrefix | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "homeassistant.fullname" -}}
{{- if .Values.namePrefix }}
  {{- printf "%s-%s" .Release.Name .Values.namePrefix | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- default .Release.Name "" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "homeassistant.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "homeassistant.labels" -}}
helm.sh/chart: {{ include "homeassistant.chart" . }}
{{ include "homeassistant.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "homeassistant.selectorLabels" -}}
app.kubernetes.io/name: {{ include "homeassistant.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "homeassistant.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "homeassistant.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* Get the namespace from the parent chart values or use the default namespace */}}
{{- define "homeassistant.namespace" -}}
{{- if .Values.namespace -}}
{{- .Values.namespace -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end }}
