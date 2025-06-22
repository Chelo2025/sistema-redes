#!/bin/bash

# 🔒 Script profesional de auditoría SSH y red para servidores Linux
# Entorno probado: Debian 12 Server sin interfaz gráfica
# Requiere ejecución como root
# Autor: Marcelo Martinez – Chelo2025

fecha=$(date '+%Y-%m-%d %H:%M:%S')
echo "🛡️ Análisis de Seguridad de Sesiones SSH y Red - $fecha"
echo "========================================================="

# HOSTNAME, IP y MAC
echo -e "\n📌 HOST: $(hostname)"
echo "🕒 FECHA: $fecha"

interfaz=$(ip -o -4 route show to default | awk '{print $5}' | head -n1)
ip_local=$(ip -4 addr show "$interfaz" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
mac=$(cat /sys/class/net/"$interfaz"/address)

echo "🌐 IP: $ip_local"
echo "🔗 MAC: $mac"

# UPTIME
echo -e "\n⏳ Tiempo encendido:"
uptime -p

# SSH interactivo con terminal virtual (pts)
echo -e "\n🔐 Sesiones SSH activas (terminal interactiva - pts):"
who | grep -i 'pts/' && echo "✔️ Usuarios SSH interactivos detectados." || echo "❌ No hay usuarios SSH interactivos activos."

# Procesos SSH activos detectados por el sistema
echo -e "\n📡 Conexiones SSH activas (basadas en procesos sshd):"
ps -eo pid,ppid,user,cmd | grep '[s]shd:' | grep -v '\[priv\]' | grep -v 'sshd -D' || echo "🔎 No se detectaron otras conexiones SSH activas."

# INTENTOS FALLIDOS DE LOGIN SSH (últimos 10)
echo -e "\n❌ Intentos fallidos de acceso SSH (últimos 10 eventos):"
journalctl -u ssh --no-pager | grep -i "Failed password" | tail -n 10 || echo "✔️ Sin intentos fallidos recientes."

# PROCESOS CON CONEXIONES ACTIVAS
echo -e "\n🌐 Procesos con conexiones activas a Internet:"
ss -tunp | grep ESTAB | awk '{print $5, $6, $7}' | sort | uniq || echo "🔎 No se encontraron conexiones activas."

# PUERTOS ESCUCHANDO
echo -e "\n🔉 Puertos abiertos (LISTEN):"
ss -tulnp | grep LISTEN || echo "✔️ No hay puertos abiertos actualmente."

# CONEXIONES EXTERNAS SOSPECHOSAS
#echo -e "\n🔍 Conexiones externas sospechosas (fuera de red local):"
#ss -tunp | grep ESTAB | grep -vE '127.0.0.1|::1|192\.168|10\.|172\.1[6-9]|172\.2[0-9]|172\.3[0-1]' | awk '{print $5, $6, $7}' | sort | uniq || echo "✔️ No se detectaron conexiones externas sospechosas."

# TABLA DE RUTEO
echo -e "\n🧭 Tabla de rutas del sistema:"
ip route

# ANALISIS DE ROOTKITS
echo -e "\n🧪 Análisis de rootkits (chkrootkit):"
if [ -x /usr/sbin/chkrootkit ]; then
  /usr/sbin/chkrootkit | grep -v "not found"
else
  echo "⚠️ chkrootkit no está instalado. Instalalo con: apt install chkrootkit"
fi

echo -e "\n✅ Auditoría de seguridad finalizada.\n"

# Uso educativo y profesional. No se asume responsabilidad por el uso indebido.
# Recomendaciones: Mantener el sistema actualizado y revisar los registros regularmente.