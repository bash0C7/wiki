package main

import (
	"bytes"
	"fmt"
	"html/template"
	"io/ioutil"
	"net/http"

	"github.com/russross/blackfriday"
)

func handler(w http.ResponseWriter, r *http.Request) {
	page := r.FormValue("page")
	md, err := ioutil.ReadFile(page)
	if err != nil {
		panic(err)
		return
	}
	w.Header().Set("Content-Type", "text/html")
	funcMap := template.FuncMap{
		"raw": func(text string) template.HTML { return template.HTML(text) },
	}
	tpl := template.Must(template.New("").Funcs(funcMap).ParseFiles("template.tpl"))
	//tpl.Funcs(funcMap)

	body := string(blackfriday.MarkdownCommon([]byte(md)))
	buf := new(bytes.Buffer)
	tplerr := tpl.ExecuteTemplate(buf, "html", map[string]string{"title": page, "body": string(body)})
	if tplerr != nil {
		panic(tplerr)
	}

	fmt.Fprintf(w, buf.String())
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
