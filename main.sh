#!/bin/bash

# ARGUMENTOS
for arg in "$@"; do
	if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
		echo "Uso: $0 [--help|-h]"
		echo "Este script copia las extensiones de GNOME Shell del usuario actual a la carpeta de GDM y las habilita."
		salir 
	elif [ "$arg" == "--version" ] || [ "$arg" == "-v" ]; then
		salir "Versión 1.0.0"
	elif [ "$arg" == "--about" ] || [ "$arg" == "-a" ]; then
		echo "Copiador de extensiones para GDM"
		echo "Desarrollado por Manuel Palmero"
		echo "Repositorio: https://github.com/manu-palmero/gdm-extensions-enabler"
		salir
	elif [[ "$arg" == --* ]]; then
		salir e "Opción desconocida: $arg
		Use --help o -h para ver las opciones disponibles."
	fi
done

dir="$(pwd)"
dir_extensiones="$dir/salida/extensiones"
mkdir -p "$dir_extensiones"
. "$dir/funciones.sh"

comprobar_root
