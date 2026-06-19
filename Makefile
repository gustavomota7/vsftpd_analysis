.PHONY: up down victim alice attacker clean

up:
	docker compose up --build -d

down:
	docker compose down

victim:
	docker exec -it victim /bin/bash

attacker:
	docker exec -u bob -it attacker /bin/bash

clean:
	docker compose down --rmi all -v