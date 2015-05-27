#!/bin/bash
link=$(ls wiki | shuf -n 1)

echo "<li><a href=/wiki/$link>$link</a></li>"