#!/bin/bash

function salir() {
	if [ "$#" -eq 1 ]; then
		if [ "$1" == "e" ]; then
			echo "Error.
			Saliendo..." >/dev/stderr
			exit 1
		else
			echo "$1
			Saliendo..."
			exit 0
		fi
	elif [ "$#" -gt 1 ]; then
		if [ "$1" == "e" ]; then
			echo "$2
			Saliendo..." >/dev/stderr
			exit 1
		else
			echo "???"
			exit 0
		fi
	else
		echo "Saliendo..."
		exit 0
	fi
}

function comprobar_root() {
	if [ "$(id -u)" -eq 0 ]; then
		salir e "Este script no debe ejecutarse como root."
	fi
}

function obtener_usuario() {
	usuario=$(logname 2>/dev/null || echo "$SUDO_USER")
	if [ -z "$usuario" ]; then
		salir e "No se pudo determinar el usuario no root."
	fi
	echo "$usuario"
}

function superusuario() {
	if [ "$#" -eq 1 ]; then
		usuario=$(obtener_usuario)
		comando=$1
	elif [ "$#" -eq 2 ]; then
		usuario=$1
		comando=$2
	else
		salir e "Uso incorrecto de la función superusuario."
	fi
	
	echo "Verificando permisos de superusuario..."
	if sudo -v; then
		echo "Hay permisos de superusuario!"
		sudo -u "$usuario" -- "$comando"
	else
		salir e "No hay permisos de superusuario, no se puede seguir.
		Asegúrese de que el usuario $usuario tenga permisos de sudo."
	fi
}

function crear_dir() {
	dir=$1
	if [ ! -d "$dir" ]; then
		mkdir -p "$dir"
	fi
}

function obtener_home() {
	usuario=$(obtener_usuario)
	home=$(eval echo "~$usuario")
	if [ ! -d "$home" ]; then
		salir e "No se pudo determinar el directorio home del usuario $usuario."
	fi
	echo "$home"
}

function obtener_extensiones_usuario() {
	home=$(obtener_home)
	mapfile -t extensiones_usuario < <(/bin/ls "$home/.local/share/gnome-shell/extensions")
	if [ "${#extensiones_usuario[@]}" -eq 0 ]; then
		salir e "No se encontraron extensiones instaladas para el usuario $(obtener_usuario)."
	fi
	echo "${extensiones_usuario[@]}"
}

function obtener_extensiones_configuradas() {
	mapfile -t extensiones_configuradas < <(dconf dump /org/gnome/shell/extensions/ | grep -E '^\[[a-z].*\]$' | sed 's/\[//; s/\]//' | grep -v '/')
	if [ "${#extensiones_configuradas[@]}" -eq 0 ]; then
		salir e "No se encontraron extensiones configuradas en dconf."
	fi
	echo "${extensiones_configuradas[@]}"
}

function obtener_extensiones_habilitadas() {
	mapfile -t extensiones_habilitadas < <(gsettings get org.gnome.shell enabled-extensions | sed 's/,/\n/g; s/ //g; s/'\''//g; s/\[//g; s/\]//g')
	if [ "${#extensiones_habilitadas[@]}" -eq 0 ]; then
		salir e "No se encontraron extensiones habilitadas para el usuario $(obtener_usuario)."
	fi
	echo "${extensiones_habilitadas[@]}"
}

function copiar_extensiones() {
	# TODO Implementar
	true
}

function sincronizar_configuracion() {
	# TODO Terminar
	# Forma de copiar las configuraciones
	# dconf dump /org/gnome/shell/extensions/extension-ejemplo/ | sudo -u gdm dconf load /org/gnome/shell/extensions/extension-ejemplo/
	ext_conf=($obtener_extensiones_configuradas)
	ext_hab=($obtener_extensiones_habilitadas)
	ext_usr=($obtener_extensiones)
	
}