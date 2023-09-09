# KMA/CAS Seminárka

Analýza nezaměstnanosti v USA.

Seminární práce musí obsahovat:

* Jednoduchý popis
* Indexní analýzu
* Dekompozice časové řady
* Predikce pomocí ARIMA/SARIMA modelů
* Interpretace

## Soubory

* main.Rmd - Hlavní soubor, který po spuštění vygeneruje výsledný html soubor
* custom_styles.css - Vlastní styly pro výsledný html soubor. main.Rmd bez tohoto souboru bude fungovat, ale výseldný soubor nebude vypadat tak jak autor zamýšlel.
* .env_example - Příklad souboru s klíčem. Tento soubor je nutné přejmenovat na .env a doplnit klíč.

## Zdroje

* Databáze [FRED](https://fred.stlouisfed.org/) (je nutné vygenerovat si vlastní [API klíč](https://fred.stlouisfed.org/docs/api/api_key.html))
* R knihovna [fredr](https://cran.r-project.org/web/packages/fredr/vignettes/fredr.html) (pro práci s FRED databází)

## TODO

* Zdroje
* Indexní analýza
* Osy grafů
* Porovnání mezi pohlavím, etnicita ...
* INTERPRETACE
