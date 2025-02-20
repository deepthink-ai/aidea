
ipa:
	flutter build ipa --no-tree-shake-icons --release 

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

build-all: build-android ipa build-macos
	rm -fr build/release 
	mkdir -p build/release
	mv build/app/outputs/flutter-apk/app-release.apk build/release/deepthink-android.apk
	mv build/ios/ipa/askaide.ipa build/release/deepthink-ios.ipa
	mv build/macos/Build/Products/Release/DeepThink.app build/release/deepthink-macos.app
	cd build/release
	zip -r deepthink-macos.zip deepthink-macos.app
	rm -fr deepthink-macos.app
	cd ../..
	mv build/release ~/Downloads/DeepThink-Release

.PHONY: run build-android build-macos ipa build-web-samehost build-web deploy-web build-dmg build-all
