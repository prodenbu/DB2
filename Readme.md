# Dependencies
 - wget
 - Docker
 - id_ed25519.pub

Das complete.sh Skript lädt weitere Pakete herunter, baut das Image und startet die Container. Anschließend wird man
per ssh mit dem Container verbunden. Nach dem Start des Containers dauert es einige Zeit, bis alle Dienste ordnungsgemäß
laufen.

startContainer.sh stoppt die laufenden Container und startet sie neu.

stopContainer.sh stoppt die laufenden Container

createContainer.sh baut das Image
