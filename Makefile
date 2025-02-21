
ipa:
	flutter build ipa --no-tree-shake-icons --release 

run:
	flutter run --release 

build-all: build-android ipa build-dmg
	rm -fr build/release 
	mkdir -p build/release
	mv build/app/outputs/flutter-apk/app-release.apk build/release/aidea-android.apk
	mv build/ios/ipa/askaide.ipa build/release/aidea-ios.ipa
	mv build/macos/Build/Products/Package/AIdea-Installer.dmg build/release/aidea-macos.dmg
	open build/release

build-android:
	flutter build apk --release --no-tree-shake-icons

build-and-sync-android: build-android 
	mv build/app/outputs/flutter-apk/app-release.apk /Users/mylxsw/ResilioSync/ResilioSync/临时文件/aidea-release.apk

build-macos:
	flutter build macos --no-tree-shake-icons --release
	codesign -f -s "Developer ID Application: YIYAO  GUAN (N95437SZ2A)" build/macos/Build/Products/Release/AIdea.app

build-appimage:
	flutter build linux --no-tree-shake-icons --release 
	mkdir -p aidea_app.AppDir
	cp -r build/linux/x64/release/bundle/* aidea_app.AppDir
	cp assets/app.png aidea_app.AppDir/
	cp AppRun aidea_app.AppDir/
	cp askaide.desktop aidea_app.AppDir/
	appimagetool aidea_app.AppDir/

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


.PHONY: run build-android build-macos ipa build-web-samehost build-web deploy-web build-dmg build-all build-and-sync-android
