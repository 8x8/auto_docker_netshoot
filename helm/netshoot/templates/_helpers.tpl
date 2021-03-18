{{/* vim: set filetype=mustache: */}}
{{/*
//
// Copyright 2019, 8x8, Inc.
//
// Licensed under the Apache License, Version 2.0 (the 'License');
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an 'AS IS' BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
*/}}

{{/*
Expand the name of the chart.
reference: https://github.com/helm/helm/tree/master/docs/examples/nginx/templates
*/}}
{{- define "netshoot.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
reference: https://github.com/helm/helm/tree/master/docs/examples/nginx/templates
*/}}
{{- define "netshoot.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "netshoot.permissions.c" -}}
"create"
{{- end -}}

{{- define "netshoot.permissions.r" -}}
"get", "list", "watch"
{{- end -}}

{{- define "netshoot.permissions.u" -}}
"update", "patch"
{{- end -}}

{{- define "netshoot.permissions.d" -}}
"delete"
{{- end -}}

{{- define "netshoot.permissions.crud" -}}
{{- template "netshoot.permissions.c" . -}}, {{- template "netshoot.permissions.r" . -}}, {{- template "netshoot.permissions.u" . -}}, {{- template "netshoot.permissions.d" . -}}
{{- end -}}

{{- define "netshoot.permissions.ru" -}}
{{- template "netshoot.permissions.r" . -}}, {{- template "netshoot.permissions.u" . -}}
{{- end -}}

