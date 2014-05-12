#!/bin/bash

SCRIPT_FILENAME="${BASH_SOURCE[0]}"
SCRIPT_BASE_DIR=$( cd "$( dirname $SCRIPT_FILENAME )" && pwd )
SECURITY_ZIP_FILE="$SCRIPT_BASE_DIR/Security.zip"

TMP_SECURITY_DIR="${TMPDIR}Security"

# Handle re-encryption automatically
Seal() {

    # Internal exit
    if [[ $? == 2 ]]; then 
        echo "Failed due to the above errors!"
        exit 1; 
    fi

    # Early manual exit
    if [[ "$(ls -A "$TMP_SECURITY_DIR")" == "" ]]; then exit 1; fi

    echo "Resealing $SECURITY_ZIP_FILE..."
    pushd "$TMP_SECURITY_DIR"
    zip -P "$PASSWORD" --filesync "$SECURITY_ZIP_FILE" *
    if [[ $? != 0 ]]; then popd && exit 2; fi
    popd
    
    echo "Removing temporary files..."
    rm -r "$TMP_SECURITY_DIR"
    echo "Done!"
    echo ""
}
trap Seal EXIT

# Decrypt
read -s -p "Password:" PASSWORD
mkdir -p "$( dirname $TMP_SECURITY_DIR )"
unzip -P "$PASSWORD" "$SECURITY_ZIP_FILE" -d "$TMP_SECURITY_DIR"
if [[ $? != 0 ]] ; then exit 2; fi


echo "##############################################################"
echo "Press any key to open the extracted folder"
echo "Will reseal automatically to ${SECURITY_ZIP_FILE} when you're done"
echo "##############################################################"
echo ""

# Open the tmp folder
read -n 1 key
open "${TMP_SECURITY_DIR}"
if [[ $? != 0 ]] ; then exit 2; fi

# And hang
read -n 1 -p "Press any key when you're ready to reseal ${TMP_SECURITY_DIR} to ${SECURITY_ZIP_FILE}" key




