# 🛡️ red_chkrootkit.sh - Auditoría de Sesiones SSH y Seguridad de Red en Linux

Un script profesional desarrollado en Bash para entornos Linux, orientado a tareas de **ciberseguridad defensiva**, **monitoreo de servidores SSH** y **auditoría de red**.

Diseñado para ser ejecutado en **servidores Debian 12 sin entorno gráfico**, brinda una visión detallada del estado actual del sistema en cuanto a sesiones activas, intentos fallidos y conexiones de red.

---

## 🔍 Funcionalidades

🔐 Identifica usuarios conectados por SSH en terminales "pts"

📡 Muestra todos los procesos activos relacionados con "sshd"

❌ Registra los últimos intentos fallidos de autenticación SSH

🌐 Lista los procesos con conexiones activas a Internet

🔉 Muestra los puertos abiertos en estado LISTEN

🧭 Presenta la tabla de rutas del sistema

🧪 Ejecuta un escaneo local de rootkits mediante "chkrootkit" (Realiza un escaneo rápido de binarios y procesos del sistema para detectar rastros de rootkits conocidos.)

## 💻 Requisitos

Distribución Debian 12 (u otra basada en Debian)

Acceso como **usuario root**

Servicios: "openssh-server", "systemd-journald", "chkrootkit"

Con usuario root ejecutar "apt install chkrootkit" este comando permite instalar el paquete chkrootkit y todo lo necesario para detectar rootkits en el sistema.

## 🛠️ Instalación y uso (seguimos como usuario root)

### 1. Actualizar paquetes e instalar Git 
apt update && apt install git -y

### 2. Clonar el repositorio e ingresar a ese directorio

git clone https://github.com/Chelo2025/sistema-redes

cd sistema-redes

### 3. Asignar permisos de ejecución y ejecutar script

chmod +x red_chkrootkit.sh
./red_chkrootkit.sh

## 📋 Salida esperada del script

Información del hostname, IP y MAC.

Tiempo de actividad del sistema.

Sesiones SSH activas detectadas por terminal o por procesos.

Intentos fallidos de autenticación SSH (últimos 10 eventos)

Conexiones establecidas y puertos en escucha.

Análisis de posibles rootkits (chkrootkit)


## 👨‍💻 Autor

### Marcelo Martinez - Chelo2025

🎓 Estudiante de Licenciatura en Tecnología Digital

🛡️ Técnico Superior en Redes Informáticas

🎓 Estudiante en Diplomado en Administración de Redes Linux, Ciberseguridad y Hacking Ético

🔗 GitHub: https://github.com/Chelo2025