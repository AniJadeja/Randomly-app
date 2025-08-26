#!/bin/bash

# Automates Flutter Android release build with keystore generation & placement.
# Generates AAB and split APKs directly in timestamped release folder.

# --- Step 0: Request Super User Permissions ---
echo "Checking for 'jq' and requesting super user permissions if necessary..."
sudo -v || { echo "Super user permissions are required."; exit 1; }

# --- Step 1: Define Paths and Variables ---
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="release/$TIMESTAMP"
KEYSTORE_DIR="keystore"
CONFIG_FILE="keystore_config.json"
KEYSTORE_FILE="$KEYSTORE_DIR/randomly-release-key.jks"
ANDROID_KEYSTORE_DIR="android/app/keystore"
ANDROID_KEYSTORE_FILE="$ANDROID_KEYSTORE_DIR/randomly-release-key.jks"

# --- Step 2: Check for jq and Install if Needed ---
if ! command -v jq &> /dev/null; then
  echo "'jq' is not installed. Installing..."
  sudo apt-get update && sudo apt-get install jq -y || { echo "Install jq manually."; exit 1; }
fi

# --- Step 3: Generate Keystore if Missing ---
if [ ! -f "$KEYSTORE_FILE" ]; then
  echo "Keystore file not found. Generating..."
  mkdir -p "$KEYSTORE_DIR"
  [ ! -f "$CONFIG_FILE" ] && {
    echo "Missing $CONFIG_FILE. Create with storePassword, keyPassword, keyAlias."; exit 1;
  }
  STORE_PASSWORD=$(jq -r '.storePassword' "$CONFIG_FILE")
  KEY_PASSWORD=$(jq -r '.keyPassword' "$CONFIG_FILE")
  KEY_ALIAS=$(jq -r '.keyAlias' "$CONFIG_FILE")

  keytool -genkey -v \
    -keystore "$KEYSTORE_FILE" \
    -storetype JKS \
    -keyalg RSA \
    -keysize 2048 \
    -validity 10000 \
    -alias "$KEY_ALIAS" \
    -storepass "$STORE_PASSWORD" \
    -keypass "$KEY_PASSWORD" || { echo "Keystore generation failed."; exit 1; }
fi

# --- Step 4: Copy Keystore to Android Directory ---
mkdir -p "$ANDROID_KEYSTORE_DIR"
cp "$KEYSTORE_FILE" "$ANDROID_KEYSTORE_FILE"
echo "Keystore ready at $ANDROID_KEYSTORE_FILE."

# --- Step 5: Create key.properties ---
KEY_PROPERTIES_FILE="android/key.properties"
{
  echo "storePassword=$(jq -r '.storePassword' "$CONFIG_FILE")"
  echo "keyPassword=$(jq -r '.keyPassword' "$CONFIG_FILE")"
  echo "keyAlias=$(jq -r '.keyAlias' "$CONFIG_FILE")"
  echo "storeFile=$(pwd)/$ANDROID_KEYSTORE_FILE"
} > "$KEY_PROPERTIES_FILE"
echo "key.properties created."

# --- Step 6: Clean Flutter Project ---
flutter clean || { echo "Flutter clean failed."; exit 1; }

# --- Step 7: Create Release Folder ---
mkdir -p "$OUTPUT_DIR"

# --- Step 8: Build AAB and Split APKs ---
echo "Building appbundle..."
flutter build appbundle --release || { echo "App bundle build failed."; exit 1; }

echo "Building APKs (split per ABI)..."
flutter build apk --release --split-per-abi || { echo "Split APK build failed."; exit 1; }

# --- Step 9: Copy Artifacts to Release Folder ---
# Copy AAB
cp build/app/outputs/bundle/release/app-release.aab "$OUTPUT_DIR/app-release.aab" || { echo "Copy AAB failed."; exit 1; }

# Copy APKs
for APK in build/app/outputs/apk/release/*/*.apk; do
  cp "$APK" "$OUTPUT_DIR/"
done

echo "Build complete!"
echo "All AABs and APKs are in: $OUTPUT_DIR"
