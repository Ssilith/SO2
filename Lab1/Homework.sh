#!/bin/bash

SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-remove}
TARGET_DIR=${3:-bakap}

if [[ -d ${TARGET_DIR} ]]; then
  echo "${TARGET_DIR} istnieje"
else
  mkdir ${TARGET_DIR}
fi

ITEMS=$(cat ${RM_LIST})
for ITEM in ${ITEMS}; do
  if [[ -e ${SOURCE_DIR/${ITEM}} ]]; then
    echo "Removing ${ITEM}"
    rm -rf -r ${SOURCE_DIR}/${ITEM}
  fi
done

for FILE in ${SOURCE_DIR}/*; do
  if [[ -f ${FILE} ]]; then
    mv ${FILE} ${TARGET_DIR}
  elif [[ -d ${FILE} ]]; then
    cp -r ${FILE} ${TARGET_DIR}
  fi
done

COUNTER=$(ls ${SOURCE_DIR} | wc -l)
if [[ ${COUNTER} -gt 0 ]]; then
  echo "Jeszcze coś zostało"
  if [[ ${COUNTER} -ge 2 ]]; then
    echo "Zostały co najmniej 2 pliki"
    if [[ ${COUNTER}  -gt 4 ]]; then
        echo "Zostało więcej niż 4 pliki"
    else
        echo "Zostało między 2 a 4 pliki"
    fi
  else
    echo "Pozostał tylko 1 plik"
  fi
else
  echo "Tu był Kononowicz"
fi

zip -r "bakap_$(date +%Y-%m-%d).zip" ${TARGET_DIR}