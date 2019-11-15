@ECHO OFF
ECHO 1. Iniciando . . .
@latex main.tex > nul
ECHO 2. Primera compilacion terminada . . .
@bibtex main > nul 
ECHO 3. BibTeX compilado correctamente . . .
@latex main.tex > nul
ECHO 4. Segunda compilacion terminada . . .
ECHO 5. Generando PDF . . .
@pdflatex main.tex > nul
ECHO 6. Proceso terminado . . .
pause