#!/bin/bash

case "$1" in
i)
	brightnessctl s +10
	;;
d)
	brightnessctl s 10-
	;;
esac
