{{/* Helper to create a newValues dictionary */}}
{{- define "addons.helper" -}}
{{/* Get the values from the main chart */}}
{{- $values := .Values -}} 
{{/* Get the .Release object */}}
{{- $release := .Release -}} 
{{/* Get the .Chart object */}}
{{- $chart := .Chart -}} 
{{/* Create a new dictionary to hold all the data for each addon */}}
{{- $addonData := dict -}}
{{/* Iterate over all addons in .Values.addons */}}
{{- range $addonName, $data := $values.addons -}}
{{/* Check if the addon is enabled */}}
{{- if $data.enabled }} 
{{/* Add data for each addon to the addonData dictionary */}}
{{- $addonData = merge $addonData (dict $addonName $data) -}}
{{- end }}
{{- end }}
{{/* Pass the addonData dictionary to each addon template */}}
{{- range $addonName, $data := $addonData -}}
{{- $newValues := dict "AddonName" $addonName "Data" $data "Values" $values "Chart" $chart "Release" $release -}}
{{- include (printf "%s.helper" $addonName) $newValues -}}
{{- end }}
{{- end }}


{{/* Define the "addons.smarterdevicemanager" template */}}
{{- define "smarterdevicemanager.helper" -}}


{{- end }}

{{/* Define the "addons.zwavejs2mqtt" template */}}
{{- define "zwavejs2mqtt.helper" -}}
{{- include "zwavejs2mqtt.volumes" . -}}
{{- include "zwavejs2mqtt.replicaset" . -}}
{{- include "zwavejs2mqtt.service" . -}}
{{- include "zwavejs2mqtt.ingress" . -}}
{{- end }}

{{/* Define the "addons.zigbee2mqtt" template */}}
{{- define "zigbee2mqtt.helper" -}}
{{- include "zigbee2mqtt.volumes" . -}}
{{- include "zigbee2mqtt.replicaset" . -}}
{{- include "zigbee2mqtt.service" . -}}
{{- include "zigbee2mqtt.ingress" . -}}
{{- end }}