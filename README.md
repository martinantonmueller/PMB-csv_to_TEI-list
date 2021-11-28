# PMB-csv_to_TEI-list
XSLTS for transformations from PMB to TEI

Quite frankly: Most likely this repository is not for you. It contains several XSLT-cascades to transform
a CSV-export of PMB-data to TEI-files. But as the CSV export function of https://pmb.acdh.oeaw.ac.at/ is not
available to the general public there is not much you can do with these XSLTs, is there? On a smaller 
sidenote you might at least find rather current complete dumps of 
* listplace.xml
* listorg.xml
* listperson.xml
* listwork.xml
so that might come in handy. Enough said. I’ll continue the documentation in German as … well … as I said … I don’t know
why you would continue reading, so it’s all the same.

ANLEITUNG

Um für schnitzler-briefe (und andere Projekte) XXXXlist.xml-Dateien zu erzeugen, lade ich die kompletten 
Entitäten als CSV herunter, tab-separated. Je nachdem, um welche Enitäten es sich handelt, müssen die
CSV-Dateien noch durch zwei Transformationen:

I. XML-Dateien erzeugen

1) Ich verwende TextSoap, um die Kaufmanns-Und (»&«) umzuschreiben, und zwar: 
* REGEX: »\s(&)« wird zu »&amp;« 
* In URLs: »\S(&)« wird zu »#26«
2) In PMB werden ungenaue Daten so eingegeben: »ca. August 1977<1977-08-01>«, das heißt, ein automatisierbares ISO-Datum wird in spitzen Klammern vermerkt. Das stört die meisten automatischen Umwandlungen zu XML, weil das nicht als Element gedeutet werden kann. Mit TextSoap kann ich REGEX »\<.*?\>« mit nichts ersetzen lassen, womit die spitzen Klammern gelöscht sind
3) Dann lasse ich das CSV automatisch in ein XML umschreiben. (Ich verwende dafür xCSV).

(Alternativ habe ich ursprünglich folgenden Weg verwendet: Das CSV in eine Google Tabelle importiert (Datei -> Importieren -> Hochladen), als Excel-Sheet heruntergeladen, in Oxygen -> Datei -> Importieren -> MS Excel zu XML ausgewählt und geschaut, dass nicht automatisch umformatiert wird. Das Problem mit
der spitzen Klammer ließ sich so lösen, das &-Problem konnte mit "Suchen & Ersetzen" behoben werden.) 

Nun liegen XML-Dateien vor, wobei je nachdem, welcher Weg gewählt wird, das Top-Level Element <Items/> oder <root/> heißt. Beide Fälle sollten funktionieren, aber ehrlicherweise verwende ich nur mehr »Items>. Das selbe gilt für die Zeileneinträge, bei denen ich »<item/>« verwende, aber auch <row/> sollte klappen.

II. DIE XML-Dateien transformieren

Ich empfehle folgende Reihenfolge der Transformationen, da Personen und Institutionen auf Orte zugreift, Werke auf Personen:
1) Orte
2) Institutionen
3) Personen
4) Werke

a)
Es liegt im Repo ein Oxygen-Projekt, das die Transformationen vorbereitet hat. Ich weiß nicht, ob das funktioniert, aber vielleicht ja doch. Im einfachsten Fall öffnet man eine der eben aus dem CSV erzeugten XML-Dateien, wählt in OXYGEN die Transformation aus und die Datei XXXXlist-PMB.xml wird geschrieben. 

b)
Alternativ lässt sich die Kaskade auch manuell machen. Es müssen nur der Reihe nach die XSLT-Transformationen im entsprechenden Ordner auf die jeweilige XML-Datei angewandt werden. 

c) Um eine Reduktion auf nur die verwendeten Entitäten zu erreichen, ist im jeweiligen Ordner als letztes immer eine separate XSLT vorhanden, die das für das entsprechende Projekt macht, wobei dafür auf die Listen im Ordner /projekte-refs zugegriffen wird. Sofern bestimmte handles für bestimmte Projekte vorgesehen sind, sind diese im Ordner Handles verzeichnet.

Wer sich jetzt immer noch nicht auskennt, kann mich ja fragen, was das soll. Aber das glaube ich ja nicht, dass ich dann helfen werde können.






   
