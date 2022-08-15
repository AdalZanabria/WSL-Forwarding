```
 _ _ _ _____ __       _____                         _ _         
| | | |   __|  |     |   __|___ ___ _ _ _ ___ ___ _| |_|___ ___ 
| | | |__   |  |__   |   __| . |  _| | | | .'|  _| . | |   | . |
|_____|_____|_____|  |__|  |___|_| |_____|__,|_| |___|_|_|_|_  |
                                                           |___|
```

---
<img src="https://i.imgur.com/QYWiPRF.gif" alt="Ejemplo de WSL Forwarding"/>

### Español:

## Descripción:
_WSL Forwarding_ es un script para realizar la configuración de enrutamiento de puertos entre una instancia de WSL con una máquina virtual de Hyper-V. Esto es útil para situaciones en que se requiere acceder por medio de SSH o SFTP a una máquina virtual ejecutándose en Hyper-V desde una distribución de GNU/Linux corriendo en WSL.

## Instalación:
1. Clona o descarga este repositorio en tu equipo host Windows (No dentro de Hyper-V o WSL).
2. Ejecuta el archivo `WSL-Forwarding.ps1` desde una ventana de Powershell corriendo como administrador.
   1. Si se tiene establecido Powershell como programa por defecto para ejecutar archivos con extensión `.ps1`, solo es necesario dar doble-clic al archivo y éste pedirá permisos de administrador antes de ejecutarse.
   2. Si no se tiene establecido Powershell como programa por defecto para ejecutar archivos con extensión `.ps1`, será necesario abrir como administrador una ventana de Powershell y navegar hasta el directorio que contenga el archivo descargado y ejecutarlo con `./WSL-Forwarding.ps1`.

## Preguntas:
- ¿Porqué requiere de permisos de administrador el script?
  - El script hace uso del cmlet `Set-NetIPInterface`, el cual requiere permisos de administrador para funcionar.
- ¿No es peligroso ejecutar scripts de Powershell como administrador?
  - Si lo es, y por eso te invito a revisar el código del repositorio antes de descargarlo y ejecutarlo para que estes tranquilo de que no contiene ningún código malicioso.
- ¿Funciona para conectar WSL con otro hipervisor como VirtualBox o VMware?
  - WSL requiere del hipervisor de Microsoft Hyper-V, y generalmente no es posible usar mas de un hipervisor al mismo tiempo.

---

### English:

## Description:
_WSL Forwarding_ is a script to configure port forwarding between an instance of WSL with a Hyper-V virtual machine. This is useful in situations where you require to access a Hyper-V virtual machine via SSH or SFTP from a GNU/Linux distribution running on WSL.

## Instalation:
1. Clone or download this repository in your Windows host (Not in Hyper-V or WSL).
2. Execute the file `WSL-Forwarding.ps1` from Powershell running as administrator.
   1. If you have set Powershell as the default program to execute `.ps1` files, you only need to double-click the file and it will ask to execute as administrator.
   2. If you don't have set Powershell as the default program to execute `.ps1` files, you need open as administrator a Powershell window and navigate to the directory where you downloaded the files and run it with `./WSL-Forwarding.ps1`.

## Questions:
- Why does this script needs to run as administrator?
  - The script uses the `Set-NetIPInterface` cmlet, which requires to be run as administrator to be able to work.
- Isn't it dangerous to run Powershell scripts as administrator?
  - Yes it is, and for that I invite you to check the source code in the repository before downloading and executing it so you can be sure that it doesn't contain any malicious code.
- Does this work to connect WSL with another hypervisor such as VirtualBox or VMware?
  - WSL requires the Microsoft Hyper-V hypervisor, and generally it is not possible to run more than one hypervisor at a time.