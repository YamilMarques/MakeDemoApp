# App build info
MIN_SDK=31
TARGET_SDK=34
MANIFEST_PACKAGE_NAME=com.marques.makedemoapp
BUILD_PATH=./builds
APK_NAME_RELEASE=build-release.apk
APK_NAME_RELEASE_UNSIGNED=build-unsigned.apk
KEYSTORE=$(BUILD_PATH)/release.keystore 



DIRS=builds compiled generated intermediates
AAPT=aapt2
AAPT_COMPILE=$(AAPT) compile --dir
AAPT_LINK=$(AAPT) link 
AAPT_LINK_FLAGS=--min-sdk-version 31 --target-sdk-version 34 --rename-manifest-package "com.marques.makedemoapp" --auto-add-overlay
KEYTOOL=keytool
APK_SIGNER=apksigner

BUILD_UNSIGNED=build-unsigned.apk

# Libs
LIBS_RES_BASE_PATH=./app/libs/res-
LIBS_RES=$(LIBS_RES_BASE_PATH)appcompat $(LIBS_RES_BASE_PATH)cardview $(LIBS_RES_BASE_PATH)design $(LIBS_RES_BASE_PATH)recyclerview
LIBS_RES_FLAT_BASE_PATH=./generated/resources-
LIBS_RES_FLAT=$(LIBS_RES_FLAT_BASE_PATH)appcompat.zip $(LIBS_RES_FLAT_BASE_PATH)cardview.zip $(LIBS_RES_FLAT_BASE_PATH)design.zip $(LIBS_RES_FLAT_BASE_PATH)recyclerview.zip


#INTERMEDIATES_FILES = $(shell find ./intermediates -type f)


#### NEW

# Build Required
JAVAC=javac
ANDROID_PLATFORM=
BUILD_VARIANT=release

# MISC 
DIR_INTERMEDIATES=intermediates
DIR_COMPILED=compiled
DIR_GENERATED=generated


LIBS_DIR := app/libs
JARS := $(wildcard $(LIBS_DIR)/*.jar)
libs_colon :=
libs_spaced :=
libs_dex :=
libs_colon := $(foreach jar,$(JARS), $(libs_colon):$(jar)) # Loop through all jars and build the variables
libs_spaced := $(foreach jar, $(JARS), $(libs_spaced) $(jar))
libs_dex := $(foreach jar, $(JARS), $(libs_dex) --classpath $(jar))
space := $(subst ,, ) 
libs_colon := $(subst $(space),, $(libs_colon)) # Remove spaces
libs_colon := $(patsubst :%,%, $(libs_colon)) # Remove leading colon

# Android and Java 
JAVA_VERSION=1.8
JAVAC_TARGET=-source $(JAVA_VERSION) -target $(JAVA_VERSION)
JAVA_SOURCEPATHS=./app/src/main/java/com/marques/makedemoapp:./generated/
DEX_COMPILER=d8
JAVA_FILES_LIST=$(shell find ./app/src/main/java/com/marques/makedemoapp ./generated -type f -name '*.java')
COMPILED_CLASSES=$(shell find $(DIR_INTERMEDIATES) -type f -exec echo "'{}'" \;)

APP_RES=app/src/main/res
APP_RES_FLAT=$(DIR_GENERATED)/resources.zip
APK_RES_BUILT=resources.apk 

APP_LIBS_RES=$(LIBS_DIR)/res-%
APP_LIBS_RES_ZIP=$(DIR_GENERATED)/resources-%.zip


# Class files - APP
APP_CLASS_FILES_BASE_PATH=$(DIR_INTERMEDIATES)/com/marques/makedemoapp
APP_CLASS_FILES=$(APP_CLASS_FILES_BASE_PATH)/MainActivity.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$bool.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$drawable.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$layout.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$styleable.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$anim.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$color.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$id.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$mipmap.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$style.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$attr.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$dimen.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$integer.class \
								$(APP_CLASS_FILES_BASE_PATH)/R$$string.class \
								$(APP_CLASS_FILES_BASE_PATH)/R.class

# Class files - Android Support Libraries
ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH=$(DIR_INTERMEDIATES)/android/support/design
ANDROID_SUPPORT_DESIGN_CLASS_FILES=$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$bool.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$drawable.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$layout.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$styleable.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$anim.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$color.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$id.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$mipmap.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$style.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$attr.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$dimen.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$integer.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R$$string.class \
								$(ANDROID_SUPPORT_DESIGN_CLASS_FILES_BASE_PATH)/R.class

ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH=$(DIR_INTERMEDIATES)/android/support/v7/appcompat
ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES=$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$bool.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$drawable.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$layout.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$styleable.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$anim.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$color.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$id.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$mipmap.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$style.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$attr.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$dimen.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$integer.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R$$string.class \
								$(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES_BASE_PATH)/R.class

ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH=$(DIR_INTERMEDIATES)/android/support/v7/cardview
ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES=$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$bool.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$drawable.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$layout.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$styleable.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$anim.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$color.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$id.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$mipmap.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$style.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$attr.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$dimen.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$integer.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R$$string.class \
								$(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES_BASE_PATH)/R.class
# Required classes files to build - Add here future needs
CLASS_FILES_REQUIRED=$(APP_CLASS_FILES) \
										 $(ANDROID_SUPPORT_DESIGN_CLASS_FILES) \
										 $(ANDROID_SUPPORT_V7_APPCOMPAT_CLASS_FILES) \
										 $(ANDROID_SUPPORT_V7_CARDVIEW_CLASS_FILES)

# Add more dex files here if multidex is required
DEX_CLASSES=$(DIR_COMPILED)/classes.dex


#--------------------------------------------------------------------------------------------------------------------

all: $(DIRS) $(KEYSTORE) $(BUILD_PATH)/$(APK_NAME_RELEASE)
.PHONY: all

$(DIRS):
	mkdir $(DIRS)

$(KEYSTORE):
	$(KEYTOOL) -genkey -v -keystore $(KEYSTORE) -storepass examplepass -alias androidreleasekey -keypass examplepass -keyalg RSA -keysize 2048 -validity 10000

$(BUILD_PATH)/$(APK_NAME_RELEASE): $(BUILD_PATH)/$(APK_NAME_RELEASE_UNSIGNED) #Sign APK
	$(APK_SIGNER) sign --ks ./builds/release.keystore --ks-pass pass:examplepass --out ./builds/build-release.apk ./builds/build-unsigned.apk 

$(BUILD_PATH)/$(APK_NAME_RELEASE_UNSIGNED): $(APK_RES_BUILT) $(DEX_CLASSES) #Zip file - unsigned creation
	zip -uj ./compiled/resources.apk ./compiled/classes.dex
	zipalign -p -f -v 4 ./compiled/resources.apk ./builds/build-unsigned.apk

$(APK_RES_BUILT): $(LIBS_RES_FLAT) $(APP_RES_FLAT) #Needs zip
	$(AAPT) link -I $(ANDROID_PLATFORM) \
		--min-sdk-version 31 --target-sdk-version 34 \
		--rename-manifest-package "com.marques.makedemoapp" --auto-add-overlay \
		-R ./generated/resources-appcompat.zip \
		-R ./generated/resources-cardview.zip \
		-R ./generated/resources-design.zip \
		--manifest ./app/src/main/AndroidManifest.xml \
		--java ./generated \
		--extra-packages android.support.v7.appcompat:android.support.v7.cardview:android.support.design \
		-o ./compiled/resources.apk \
		./generated/resources.zip

$(APP_LIBS_RES_ZIP): $(APP_LIBS_RES) 
	$(AAPT_COMPILE) $^ -o $@

$(APP_RES_FLAT): $(APP_RES) 
	$(AAPT_COMPILE) $^ -o $@

$(DEX_CLASSES): $(CLASS_FILES_REQUIRED)
	$(DEX_COMPILER) --$(BUILD_VARIANT) --classpath $(ANDROID_PLATFORM) $(libs_dex) --output ./compiled $(COMPILED_CLASSES) $(libs_spaced)

$(CLASS_FILES_REQUIRED):
	$(JAVAC) $(JAVAC_TARGET) -bootclasspath $(ANDROID_PLATFORM) -cp $(libs_colon) -sourcepath $(JAVA_SOURCEPATHS) $(JAVA_FILES_LIST) -d $(DIR_INTERMEDIATES) 

clean:
	rm -rf $(DIRS)
