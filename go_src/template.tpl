{{define "html"}}
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>{{.page}}</title>
  </head>
  <body>
{{.body|raw}}
  </body>
</html>
{{end}}