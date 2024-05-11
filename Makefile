# Define variables
COMMON_DIR := ./internal
AUTHORS_DIR := ./cmd/authors-ms
TELEGRAM_DIR := ./cmd/send-telegram-message

# Define targets
.PHONY: copy_common_files start_service_authors start_service_telegram

copy_common_files:
	cp -r "$(COMMON_DIR)" "$(AUTHORS_DIR)"

	cp -r "$(COMMON_DIR)" "$(TELEGRAM_DIR)"

	@echo "Common files copied to microservices successfully."

start_service_authors:
	cd "$(AUTHORS_DIR)" && go run main.go

start_service_telegram:
	cd "$(TELEGRAM_DIR)" && go run main.go

