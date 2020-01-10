#!/bin/bash

if [ ! -e OAS2.zip ]; then
  echo "Download OAS2.zip. The filesize is 11GB, so please be patient."
  curl -O http://www.md.tsukuba.ac.jp/clinical-med/psy-neuroimaging/nisg-202001/OAS2.zip
fi

unzip OAS2.zip

echo "Done."

