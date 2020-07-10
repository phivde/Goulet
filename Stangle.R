## Copyright (C) 2020 Vincent Goulet
##
## Ce fichier fait partie du projet
## «Programmer avec R»
## https://gitlab.com/vigou3/programmer-avec-r
##
## Cette création est mise à disposition sous licence
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## https://creativecommons.org/licenses/by-sa/4.0/

## Nom du fichier source (.Rnw)
file <- getSourceName()

## Extraction du fichier de script
Stangle(file, encoding = "utf-8", annotate = FALSE, split = TRUE)

## Traitement du fichier créé par Stangle
if (file == "texte.Rnw") {
    ## cas spécial, deux fichiers de script
    postStangle(file, "script-cli", new.ext =  ".sh")
    postStangle(file, "script-r")
} else {
    postStangle(file, "script")
}

## Nettoyage
basefile <- sub(".Rnw", "", file)
pat <-paste0("^", basefile, r"(-([0-9]{3}|license.*)\.R$)")
file.remove(list.files(pattern = pat))
