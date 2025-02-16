
ipa:
	flutter build ipa --no-tree-shake-icons --release 
	open build/ios/ipa

run:
	flutter run --release 

build-all: build-android ipa

build-android:
	flutter build apk --release --no-tree-shake-icons

build-macos:
	flutter build macos --no-tree-shake-icons --release

build-web:
	flutter build web --web-renderer canvaskit --release
	cd scripts && go run main.go ../build/web/main.dart.js && cd ..


.PHONY: run build-android build-macos ipa build-web-samehost build-web deploy-web build-dmg
