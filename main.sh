#!/bin/bash

dir="$(pwd)"
dir_extensiones="$dir/salida/extensiones"
mkdir -p "$dir_extensiones"

. "$dir/funciones.sh"
. "$dir/interfaz.sh"

# ARGUMENTOS
for arg in "$@"; do
	case "$arg" in
	--help | -h)
		echo "Uso: $0 [--help|-h]" # TODO Actualizar ayuda
		echo "Este script copia las extensiones de GNOME Shell del usuario actual a la carpeta de GDM y las habilita."
		salir
		;;
	--version | -v)
		salir "Versión 1.0.0"
		;;
	--about | -a)
		echo "Copiador de extensiones para GDM"
		echo "Desarrollado por Manuel Palmero"
		echo "Repositorio: https://github.com/manu-palmero/gdm-extensions-enabler"
		salir
		;;
	--sync-config | -s)
		# TODO Implementar
		;;
	--copy | -c)
		# TODO Implementar
		;;
	--*)
		salir e "Opción desconocida: $arg
		Use --help o -h para ver las opciones disponibles."
		;;
	esac
done

comprobar_root
