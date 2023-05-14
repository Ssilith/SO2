#!/bin/bash -eu

# Zadanie 1
# Znajdź w pliku access_log unikalnych 10 adresów IP w access_log
grep -E -o '([0-9]{1,3}.){3}[0-9]{1,3}' access_log | sort -u | head -n 10

# # Znajdź w pliku access_log zapytania, które mają frazę ""denied"" w linku
grep 'GET .denied.' access_log
grep 'POST .denied.' access_log

# Znajdź w pliku access_log zapytania wysłane z IP: 64.242.88.10
grep "^64\.242\.88\.10\s" access_log

# Znajdź w pliku access_log unikalne zapytania typu DELETE
grep "DELETE" access_log | sort -u


# Zadanie 3
# We wszystkich plikach w katalogu ‘groovies’ zamień $HEADER$ na /temat/
for FILE in groovies/*; do 
    sed -i 's|$HEADER$|/temat/|g' "$FILE"
done

# # We wszystkich plikach w katalogu ‘groovies’ usuń linijki zawierające frazę 'Help docs:'"
for FILE in groovies/*; do 
    sed -i '/Help docs:/d' "$FILE"
done


# Zadanie 4
# Uruchom skrypt fakaping.sh, standardowe wyjście przekieruj do nicości, a błedy posortuj (nie usuwaj duplikatów).
./fakaping.sh 2>/dev/null | sort

# # Uruchom skrypt fakaping.sh, wszystkie errory zawierające ""permission denied"" (bez względu na wielkośc liter) wypisz na konsolę i do pliku denied.log. Wyniki powinny być unikalne.
./fakaping.sh 2>&1 | grep -i "permission denied" | sort -u | tee denied.log

# # Uruchom skrypt fakaping.sh i wszystkie unikalne linijki zapisz do pliku all.log i na konsolę
./fakaping.sh 2>&1 | sort -u | tee all.log
