Starten
pg_ctl -D /opt/homebrew/var/postgresql@16 start

Stoppen
pg_ctl -D /opt/homebrew/var/postgresql@16 stop

Status
pg_ctl -D /opt/homebrew/var/postgresql@16 status

Lässt mich mit dem DB Server SQL reden
psql -h localhost -p 5432 postgres

MMD ausführen
# 1. Einmal: Paket global oder im Projekt nutzen
npx -y @mermaid-js/mermaid-cli -i DataWarehouse_ERM.mmd -o DataWarehouse_ERM.png 
