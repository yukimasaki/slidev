up:
	docker compose up -d --force-recreate
build:
	docker compose up -d --build
sh:
	docker compose exec slidev sh
dev:
	docker compose exec slidev yarn dev