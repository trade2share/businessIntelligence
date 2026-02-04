Starten
pg_ctl -D /opt/homebrew/var/postgresql@16 start

Stoppen
pg_ctl -D /opt/homebrew/var/postgresql@16 stop

Status
pg_ctl -D /opt/homebrew/var/postgresql@16 status

Lässt mich mit dem DB Server SQL reden
psql -h localhost -p 5432 postgres