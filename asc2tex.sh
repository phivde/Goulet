#!/bin/sh

cat $1 | \
    sed -E \
	-e 's/^== (.*$)/\\section{\1}/' \
	-e 's/^=== (.*$)/\\subsection{\1}/' \
	-e 's/^==== (.*$)/\\subsubsection{\1}/' \
	-e 's/^\[\[_(.*)\]\]$/\\label{sec:git:\1}/' \
	-e 's/\(\(\(.*\)\)\)//g' \
	-e 's/_([^_]*)_/\\emph{\1}/g' \
	-e 's/`([^`]*)`/\\code{\1}/g' \
        -e 's/ —/ ---/g' \
        -e 's/ //g' | \
    awk 'BEGIN { FS = "[./*]" } \
         /^\..*\.$/ { \
	     caption = $2; \
	     getline; \
	     printf("\\begin{figure}[h]\n  \\centering\n  \\includegraphics{images/%s}\n  \\caption{%s}\n  \\label{fig:git:%s}\n\\end{figure}\n", $2, caption, $2) \
	 } \
	 /^image::/ { next } 
	 /^\* / && !state { state = 1; printf("\\begin{itemize}\n\\item%s\n", $2); next } \
	 /^\* / &&  state { printf("\\item%s\n", $2); next } \
	 /^$/   &&  state { state = 0; print("\\end{itemize}\n") } \
	 /^\[source/ { 
	   state = 1; 
	   print("\\begin{Schunk}\n\\begin{Verbatim}")
	   next } \
	 /^----$/ && (state == 1) { state = 2; next }
	 /^----$/ && (state == 2) { state = 0; print("\\end{Verbatim}\n\\end{Schunk}"); next }
	 1'
	 

