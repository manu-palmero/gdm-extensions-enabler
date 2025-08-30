#!/bin/bash


function superusuario() {
	usuario=$1
	comando=$2
	echo "Verificando permisos de superusuario..."
	if sudo -v; then
		echo "Hay permisos de superusuario!"
		sudo -u "$usuario" -- "$comando"
	else
		echo "No hay permisos de superusuario, no se puede seguir. Saliendo..." >/dev/stderr
		exit 1
	fi
}

