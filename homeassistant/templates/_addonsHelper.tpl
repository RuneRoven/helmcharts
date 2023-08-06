{{/* Helper to create a newValues dictionary */}}
{{- define "addons.helper" -}}
{{/* Get the values from the main chart */}}
{{- $values := .Values -}} 
{{/* Get the .Release object */}}
{{- $release := .Release -}} 
{{/* Get the .Chart object */}}
{{- $chart := .Chart -}} 
{{/* Iterate over all addons in .Values.addons */}}
{{- range $addonName, $data := $values.addons -}}
{{/* Check if the addon is enabled */}}
{{- if $data.enabled }} 
{{/* New values with both main chart and the addon */}}
{{- $newValues := dict "AddonName" $addonName "Data" $data "Values" $values "Chart" $chart "Release" $release -}} 
{{/* Use the addon name in the include statement */}}
{{- include (printf "%s.helper" $addonName) $newValues -}} 
{{- end }}
{{- end }}
{{- end }}
{{/* end of addons.helper template */}}


{{/* end of addons.helper template */}}
{{/* Define the "addons.smarterdevicemanager" template */}}
{{- define "smarterdevicemanager.helper" -}}
{{- include "smarterdevicemanager.configmap" . -}}
{{- include "smarterdevicemanager.daemonset" . -}}
{{- include "smarterdevicemanager.persistentvolumes" . -}}
{{- end }}

{{/* Define the "addons.zwavejs2mqtt" template */}}
{{- define "zwavejs2mqtt.helper" -}}
{{- include "zwavejs2mqtt.replicaset" . -}}
{{- include "zwavejs2mqtt.service" . -}}
{{- include "zwavejs2mqtt.ingress" . -}}
{{- end }}

{{/* Define the "addons.zigbee2mqtt" template */}}
{{- define "zigbee2mqtt.helper" -}}
{{- include "zigbee2mqtt.replicaset" . -}}
{{- include "zigbee2mqtt.service" . -}}
{{- include "zigbee2mqtt.ingress" . -}}
{{- end }}
