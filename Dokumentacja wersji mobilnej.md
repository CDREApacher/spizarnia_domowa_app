# Aplikacja Spiżarnia Domowa
## Dokumentacja funkcji wersji mobilnej aplikacji na os Android

## Funkcje

### fetchAll()
Parametry:
- klient Dio
- kod grupy

Funkcja służąca do pobierania wszystkich produktów danej grupy z bazy danych

### fetch()
Parametry:
- klient Dio
- id produktu

Funkcja służaca do pobrania wszystkich informacji o konkretnym produkcie

### add()
Parametry:
- klient Dio
- obiekt typu Product zmapowany do formatu przesyłu JSON

Funkcja służąca do dodawania nowych produktów do bazy danych

### update()
Parametry:
- klient Dio
- obiekt typu Product zmapowany do formatu przesyłu JSON

Funkcja służąca do aktualizowania informacji o produkcie w bazie danych

### deleteProdukt()
Parametry:
- klient Dio
- id produktu 

Funkcja służaca do usuwania produktu o danym id z bazy danych

### fetchKategorieProdukty()
Parametry:
- klient Dio
- kod grupy

Funkcja służąca do pobierania kategorii dla produktów danej grupy z bazy danych

### fetchKategorieZakupy()
Parametry:
- klient Dio
- kod grupy

Funkcja służąca do pobierania kategorii dla zakupów danej grupy z bazy danych

### addKategorieProdukty()
Parametry:
- klient Dio
- obiekt typu kategoriaProduktu zmapowany do formatu przesyłu JSON

Funkcja służaca do dodawania kategorii produktów

### addKategorieZakupy()
Parametry:
- klient Dio
- obiekt typu kategoriaZakupu zmapowany do formatu przesyłu JSON

Funkcja służąca do dodawania kategorii zakupów

### deleteKategoriaProdukty()
Parametry:
- klient Dio
- id kategorii produktu

Funkcja służaca do usuwania kategorii produktów o danym id

### deleteKategorieZakupy()
Parametry:
- klient Dio
- id kategorii zakupów

Funkcja służąca do usuwania kategorii zakupów o danym id

### fetchZakupy()
Parametry:
- klient Dio
- kod grupy

Funkcja służąca do pobierania listy zakupów danej grupy z bazy danych

### addZakup()
Parametry:
- klient Dio
- obiekt typu Zakup zmapowany do formatu przesyłu JSON

Funkcja służąca do dodania zakupu do listy zakupów w bazie danych

### deleteZakupy()
Parametry:
- klient Dio
- id obiektu

Funkcja służąca usunięciu zakupu z listy zakupów w bazie danych

### buyProdukt()
Parametry:
- klient Dio
- id produktu
- ilość

Funkcja służąca usunięciu zakupu z listy zakupów oraz dodaniu odpowiadającej zakupowi ilości do produktu w liście produktów

### updateZakup()
Parametry:
- klient Dio
- id produktu
- ilość

Funkcja służąca do zmiany ilości zakupu na liście zakupów

### addAtrybut()
Parametry:
- klient Dio
- id produktu
- nazwa atrybutu

Funkcja służąca do dodaniu atrybutu do produktu

### deleteAtrybut()
Parametry:
- klient Dio
- id produktu
- id atrybutu

Funkcja służąca do usuwania atrybutów danego produktu

### fetchMiary()
Parametry:
- klient Dio
- kod grupy

Funkcja służąca do pobierania wszystkich miar danej grupy z bazy danych

### addMiary()
Parametry:
- klient Dio
- obiekt typu Miara zmapowany do formatu przesyłu JSON

Funkcja służąca do dodania nowej miary do bazy danych

### deleteMiary()
Parametry:
- klient Dio
- id obiektu

Funkcja służąca do usunięcia miary o danym id w bazie danych

### addGrupy()
Parametry:
- klient Dio
- nazwa grupy

Funkcja służąca stworzeniu nowej grupy w bazie danych

### joinGrupy()
Parametry:
- klient Dio
- kod grupy

Funkcja służąca dołączeniu na urządzeniu do grupy o podanym kodzie

### addBarcodes()
Parametry:
- klient Dio
- kod kreskowy w postaci numerycznej
- id produktu
- nazwa kodu

Funkcja służąca do dodaniu kodu kreskowego o podanej nazwie i wartości do produktu o podanym id

### deleteBarcodes()
Parametry:
- klient Dio
- id produktu
- id kodu kreskowego

Funkcja służąca do usunięcia z bazy danych kodu kreskowego o podanym id powiązanego z podanym produktem

### addExpDates()
Parametry:
- klient Dio
- id produktu
- data w postaci ciągu znaków
- ilość dni do przypomnienia
- nazwa

Funkcja służąca do dodania daty przydatności do spożycia o konkretnej nazwie do konkretnego produktu z ustaleniem ilości dni do przypomnienia o wygaśnięciu

### deleteExpDates()
Parametry:
- klient Dio
- id produktu
- id daty ważności

Funkcja służąca do usunięcia daty przydatności o podanym id w produkcie o podanym id