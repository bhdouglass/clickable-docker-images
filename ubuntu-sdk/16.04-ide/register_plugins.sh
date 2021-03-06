#!/bin/bash
# Purpose: Read Comma Separated CSV File
# Author: Vivek Gite under GPL v2.0+
# ------------------------------------------
INPUT=plugins.csv
QML_LIB_PATH=/usr/lib/x86_64-linux-gnu/qt5/qml
OLDIFS=$IFS
IFS=';'
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read namespace version path
do
	qmlplugindump -nonrelocatable $namespace $version $QML_LIB_PATH > $QML_LIB_PATH/$path/plugins.qmltypes
done < $INPUT
IFS=$OLDIFS
