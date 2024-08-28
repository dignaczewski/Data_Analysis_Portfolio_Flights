Opis

W tym warsztacie wcielimy się w rolę konsultanta pracującego dla jednego z przewoźników lotniczych, którego zadaniem jest optymalizacja procesu dostarczania oraz analizowania danych.

Dane którymi będziemy się posługiwać pochodzą ze znanej nam już platformy Kaggle. W opisie zbioru znajdziemy dość szczegółowy opis, dlaczego dane powstały oraz co było inspiracją do ich wygenerowania - zalecamy do zapoznania się z dostępnym tam opisem, choć nie jest to konieczne.

Ze względu na swój wolumen (ponad 9 milionów wierszy), zbiór danych został odpowiednio zmniejszony, aby ułatwić prace.


Kontekst biznesowy

Ostatnio przewoźnik otrzymał dostęp do danych wcześniej dostępnych jedynie z poziomu zewnętrznej aplikacji – został udostępniony dedykowany serwis API do pobierania danych. Z poprzedniej aplikacji można było pobierać dane wyłącznie ręcznie. Co więcej, aplikacja posiadała dodatkowe ograniczenie w postaci liczby wyeksportowanych wierszy. Ze względu na nałożone w aplikacji limity przetwarzanie danych oraz analiza były skrajnie nieefektywne – wymagające zaangażowania wielu pracowników, co wiązało się dodatkowo z opóźnieniem w dostarczaniu danych skutkując opóźnieniem w podejmowaniu istotnych decyzji. W ostatnim czasie jednak doszło do zmiany i ostatnio został udostępniony dedykowany serwis API do pobierania danych.

Klient nie posiada własnej komórki odpowiedzialnej za analizę danych. Z tego powodu wynajął naszego pracodawcę do stworzenia systemu raportująco-analitycznego, który przyśpieszy czas otrzymywania danych oraz wyeliminuje ręczny nakład wymagany do przetworzenia danych. W efekcie klient oczekuje, że będzie w stanie szybciej otrzymywać raport dot. opóźnień samolotów, a dodatkowo pozna ich przyczyny, dzięki czemu będzie możliwe określenie działań zapobiegawczych.

W związku z tym nasza firma została poproszona o:

stworzenie mechanizmu pobierającego dane z udostępnionego API,
stworzenie bazy danych używanej do celów analityczno-raportowych,
zasilenie pobranymi danymi bazy,
dokonanie analizy eksploracyjnej zbioru danych,
stworzenie raportu operacyjnego.

Jako pracownik naszej firmy, masz za zadanie wykonać wszystkie powyższe punkty oraz dostarczyć wszystkie niezbędne dane, które wymaga od naszej firmy klient.