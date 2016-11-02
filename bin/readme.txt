- Copiare tutti i file all'interno della cartella bin in home (esempio /home/<usename>/bin o ~/bin)
- chmod +x ~/bin/*
- unico requisito: avere i repository all'interno della cartella actorbase in home (es: ~/actorbase/Actorbase-Documents ecc ecc)

* Agiscono tutti a livello di progetto (tutti i file vengono esaminati)

- build genera tutti i pdf eliminando i file inutili
- verify controlla gli errori nei .tex
- gulpease calcola l'indice di leggibilità dei documenti
- findgloss cerca le parole da glossario nei .tex
