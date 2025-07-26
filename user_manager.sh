#!/bin/bash

# Comprobamos si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor ejecuta este script como root."
  exit 1
fi

while true; do
  echo ""
  echo "===== GESTIÓN DE USUARIOS ====="
  echo "1. Crear usuario"
  echo "2. Eliminar usuario"
  echo "3. Listar usuarios"
  echo "4. Ver detalles de un usuario"
  echo "5. Salir"
  read -p "Elige una opción [1-5]: " opcion

  case $opcion in
    1)
      read -p "Nombre del nuevo usuario: " user
      read -p "Shell (por defecto /bin/bash): " shell
      shell=${shell:-/bin/bash}
      useradd -m -s "$shell" "$user" && echo "✅ Usuario '$user' creado con éxito." || echo "❌ Error al crear el usuario."
      ;;
    2)
      read -p "Nombre del usuario a eliminar: " user
      userdel -r "$user" && echo "✅ Usuario '$user' eliminado." || echo "❌ Error al eliminar el usuario."
      ;;
    3)
      echo "🧾 Lista de usuarios:"
      cut -d: -f1 /etc/passwd
      ;;
    4)
      read -p "Nombre del usuario: " user
      id "$user"
      grep "^$user:" /etc/passwd
      ;;
    5)
      echo "Saliendo del gestor de usuarios."
      break
      ;;
    *)
      echo "❌ Opción inválida. Elige entre 1 y 5."
      ;;
  esac
done
