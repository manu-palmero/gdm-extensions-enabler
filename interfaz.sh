#!/bin/bash

# TODO Todo este código está generado por IA, falta revisarlo y modificarlo

function mostrar_menu_principal() {
    while true; do
        opcion=$(whiptail --title "GDM Extensions Manager" --menu "Seleccione una opción:" 15 60 4 \
            "1" "Copiar extensiones" \
            "2" "Sincronizar configuración" \
            "3" "Información" \
            "4" "Salir" 3>&1 1>&2 2>&3)

        case "$opcion" in
            "1")
                copiar_extensiones_menu
                ;;
            "2")
                sincronizar_configuracion_menu
                ;;
            "3")
                mostrar_informacion
                ;;
            "4")
                salir
                ;;
            *)
                salir
                ;;
        esac
    done
}

function copiar_extensiones_menu() {
    while true; do
        opcion=$(whiptail --title "Copiar extensiones" --menu "Seleccione una opción:" 15 60 4 \
            "1" "Copiar todas las extensiones" \
            "2" "Seleccionar extensiones específicas" \
            "3" "Volver al menú principal" 3>&1 1>&2 2>&3)

        case "$opcion" in
            "1")
                copiar_extensiones
                ;;
            "2")
                seleccionar_extensiones
                ;;
            "3")
                break
                ;;
            *)
                break
                ;;
        esac
    done
}

function sincronizar_configuracion_menu() {
    while true; do
        opcion=$(whiptail --title "Sincronizar configuración" --menu "Seleccione una opción:" 15 60 4 \
            "1" "Sincronizar todas las configuraciones" \
            "2" "Seleccionar configuraciones específicas" \
            "3" "Volver al menú principal" 3>&1 1>&2 2>&3)

        case "$opcion" in
            "1")
                sincronizar_configuracion
                ;;
            "2")
                seleccionar_configuraciones
                ;;
            "3")
                break
                ;;
            *)
                break
                ;;
        esac
    done
}

function seleccionar_extensiones() {
    extensiones=$(obtener_extensiones_usuario)
    seleccion=$(whiptail --title "Seleccionar extensiones" --checklist \
        "Seleccione las extensiones a copiar:" 20 78 10 \
        $(for ext in $extensiones; do echo "$ext" "OFF"; done) 3>&1 1>&2 2>&3)

    if [ -n "$seleccion" ]; then
        echo "Copiando extensiones seleccionadas..."
        # Implementar lógica para copiar solo las seleccionadas
    fi
}

function seleccionar_configuraciones() {
    configuraciones=$(obtener_extensiones_configuradas)
    seleccion=$(whiptail --title "Seleccionar configuraciones" --checklist \
        "Seleccione las configuraciones a sincronizar:" 20 78 10 \
        $(for conf in $configuraciones; do echo "$conf" "OFF"; done) 3>&1 1>&2 2>&3)

    if [ -n "$seleccion" ]; then
        echo "Sincronizando configuraciones seleccionadas..."
        # Implementar lógica para sincronizar solo las seleccionadas
    fi
}

function mostrar_informacion() {
    whiptail --title "Información" --msgbox "Copiador de extensiones para GDM\nDesarrollado por Manuel Palmero\nRepositorio: https://github.com/manu-palmero/gdm-extensions-enabler" 10 60
}

# Mostrar el menú principal al inicio
mostrar_menu_principal