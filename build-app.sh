#!/bin/bash

echo "Generating directories.."
mkdir generated intermediates compiled builds

echo "Generating Flat files.."
aapt2 compile --dir ./app/libs/res-appcompat -o ./generated/resources-appcompat.zip
aapt2 compile --dir ./app/libs/res-cardview -o ./generated/resources-cardview.zip
aapt2 compile --dir ./app/libs/res-design -o ./generated/resources-design.zip
aapt2 compile --dir ./app/libs/res-recyclerview -o ./generated/resources-recyclerview.zip
aapt2 compile --dir ./app/src/main/res -o ./generated/resources.zip

echo "Linking source and libraries.."
aapt2 link -I ~/Android/sdk/platforms/android-34/android.jar --min-sdk-version 31 --target-sdk-version 34 --rename-manifest-package "com.marques.makedemoapp" --auto-add-overlay -R ./generated/resources-appcompat.zip -R ./generated/resources-cardview.zip -R ./generated/resources-design.zip --manifest ./app/src/main/AndroidManifest.xml --java ./generated --extra-packages android.support.v7.appcompat:android.support.v7.cardview:android.support.design -o ./compiled/resources.apk ./generated/resources.zip

echo "Clearing temporals.."
rm -f ./generated/resources-appcompat.zip ./generated/resources-cardview.zip ./generated/resources-design.zip ./generated/resources-recyclerview.zip ./generated/resources.zip

echo "Compiling Java classes.."

for i in ./app/libs/*.jar; do
  libs_colon="$libs_colon:$i"
  libs_spaced="$libs_spaced $i"
  libs_d8="$libs_d8 --classpath $i"
done
libs_colon="${libs_colon#:}"

# Java files compilation -> .class
javac -source 1.8 -target 1.8 -bootclasspath ~/Android/sdk/platforms/android-34/android.jar -cp $libs_colon -sourcepath ./app/src/main/java/com/marques/makedemoapp:./generated/ $(find ./app/src/main/java/com/marques/makedemoapp ./generated -type f -name '*.java') -d ./intermediates

echo "Dex files compilation.."

d8 --release --classpath ~/Android/sdk/platforms/android-34/android.jar $libs_d8 --output ./compiled $(find ./intermediates -type f) $libs_spaced

echo "Generating APK.."

zip -uj ./compiled/resources.apk ./compiled/classes.dex
zipalign -p -f -v 4 ./compiled/resources.apk ./builds/build-unsigned.apk

echo "Signing APK.."

if [ ! -f ./builds/release.keystore ]; then
	# File doesn't exist, create
	keytool -genkey -v -keystore ./builds/release.keystore -storepass examplepass -alias androidreleasekey -keypass examplepass -keyalg RSA -keysize 2048 -validity 10000
fi

apksigner sign --ks ./builds/release.keystore --ks-pass pass:examplepass --out ./builds/build-release.apk ./builds/build-unsigned.apk

echo "APK build completed. Check \"Build\" folder."

