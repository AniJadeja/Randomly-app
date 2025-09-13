.PHONY: realm-build run-translator generate-arb

realm-build:
	dart run build_runner build --delete-conflicting-outputs

run-translator:
	dart run auto_translator && flutter gen-l10n

generate-arb:
	flutter gen-l10n