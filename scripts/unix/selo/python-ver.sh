#!/bin/bash
python -V &> /dev/null
if [[ $? -eq 0 ]]; then
    python -V
else
    echo "Python2 not installed."
fi

python3 -V &> /dev/null
if [[ $? -eq 0 ]]; then
    python3 -V
else
    echo "Python3 not installed."
fi