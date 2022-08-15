# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $Command = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb RunAs -ArgumentList $Command
    Exit
  }
}

Write-Host "                                                              
 _ _ _ _____ __       _____                         _ _         
| | | |   __|  |     |   __|___ ___ _ _ _ ___ ___ _| |_|___ ___ 
| | | |__   |  |__   |   __| . |  _| | | | .'|  _| . | |   | . |
|_____|_____|_____|  |__|  |___|_| |_____|__,|_| |___|_|_|_|_  |
                                                           |___|
################################################################
################### Script by Adal Zanabria ####################
################ https://github.com/AdalZanabria ###############
################################################################
"
[int] $lang = Read-Host "Choose a language / Elige un idioma: `r`n1. English `r`n2. Español`r`n"

if ($lang -isnot [int] -Or $lang -ge 3 -Or $lang -eq 0) {
  Write-Host "ERROR: Respuesta no valida / Invalid answer."
  Write-Host "Enter 1 for English."
  Write-Host "Ingresa 2 para Español."
  return
}

switch ($lang) {
  1 {
    Write-Host "`r`nThis script will help you configure the port forwarding to connect a WSL instance with a Hyper-V virtual machine.`r`nBe sure that the network adapter of your Hyper-V virtual machine is set to 'Default Switch'."

    [int] $vm_state = Read-Host "`r`nIs your Hyper-V virtual machine already on? `r`n1. Yes, go to next step.`r`n2. No, turn on my Hyper-V virtual machine.`r`n"
    if ($vm_state -isnot [int] -Or $vm_state -ge 3 -Or $vm_state -eq 0) {
      Write-Host "ERROR: Invalid answer."
      Write-Host "Enter 1 to go to next step, or 2 to turn on yout Hyper-V virtual machine."
      return
    }

    if ($vm_state -eq 2) {
      Get-VM | Out-Default

      $vm_name = Read-Host "Enter the name of the Hyper-V virtual machine you want to turn on"
      Start-VM $vm_name
      Write-Host "Hyper-V virtual machine $vm_name turned on."
    }

    Get-NetIPInterface | Where-Object InterfaceAlias -eq "vEthernet (Default Switch)" | Select-Object ifIndex, InterfaceAlias, AddressFamily, ConnectionState, Forwarding | Sort-Object -Property IfIndex | Format-Table

    [int] $default_vEth = Read-Host "Enter the ifIndex of vEthernet (Default Switch)"
    if ($default_vEth -isnot [int] -Or $default_vEth -eq 0) {
      Write-Host "ERROR: Invalid answer, enter the numeric value in the first column (ifIndex) that corresponds to the InterfaceAlias vEthernet (Default Switch)."
      return
    }

    Get-NetIPInterface | Where-Object InterfaceAlias -eq "vEthernet (WSL)" | Select-Object ifIndex, InterfaceAlias, AddressFamily, ConnectionState, Forwarding | Sort-Object -Property IfIndex | Format-Table

    [int] $wsl_vEth = Read-Host "Enter the ifIndex of vEthernet (WSL)"
    if ($wsl_vEth -isnot [int] -Or $wsl_vEth -eq 0) {
      Write-Host "ERROR: Invalid answer, enter the numeric value in the first column (ifIndex) that corresponds to the InterfaceAlias vEthernet (WSL)."
      return
    }

    if ($default_vEth -eq $wsl_vEth) {
      Write-Host "ERROR: vEthernet (Default Switch) and vEthernet (WSL) can't have the same index."
      return
    }

    Set-NetIPInterface -ifindex $default_vEth -Forwarding Enabled
    Set-NetIPInterface -ifindex $wsl_vEth -Forwarding Enabled

    Get-NetIPInterface | Where-Object InterfaceAlias -like "vEthernet*" | Select-Object ifIndex, InterfaceAlias, AddressFamily, ConnectionState, Forwarding | Sort-Object -Property IfIndex | Format-Table

    Write-Host "If both interfaces appear Connected and Enabled, you're ready to go! `r`nIf not, check if you didn't input the wrong ifIndexes, that your Hyper-V virtual machine is turned on and that you are running this script as administrator."

    Read-Host -Prompt "Press any key to exit."

    Break
  }
  2 {
    Write-Host "Este script te ayudara a realizar la configuracion de redireccionamiento de puertos para poder conectar una instancia de WSL con una maquina virtual de Hyper-V.`r`nAsegurate de que el adaptador de red de tu maquina virtual Hyper-V sea 'Default Switch'."

    [int] $vm_state = Read-Host "`r`nLa maquina virtual Hyper-V ya se encuentra activa? `r`n1. Si, ir al siguiente paso.`r`n2. No, encender mi maquina virtual Hyper-V.`r`n"
    if ($vm_state -isnot [int] -Or $vm_state -ge 3 -Or $vm_state -eq 0) {
      Write-Host "ERROR: Respuesta invalida."
      Write-Host "Ingresa 1 para ir al siguiente paso, o 2 para encender tu maquina virtual Hyper-V."
      return
    }

    if ($vm_state -eq 2) {
      Get-VM | Out-Default

      $vm_name = Read-Host "Ingresa el nombre de la maquina virtual que quieres encender"
      Start-VM $vm_name
      Write-Host "Maquina virtual Hyper-V $vm_name encendida."
    }

    Get-NetIPInterface | Where-Object InterfaceAlias -eq "vEthernet (Default Switch)" | Select-Object ifIndex, InterfaceAlias, AddressFamily, ConnectionState, Forwarding | Sort-Object -Property IfIndex | Format-Table

    [int] $default_vEth = Read-Host "Ingresa el indice (ifIndex) de vEthernet (Default Switch)"
    if ($default_vEth -isnot [int] -Or $default_vEth -eq 0) {
      Write-Host "ERROR: Respuesta invalida, ingresa el valor numerico de la primera columna (ifIndex) que corresponde al nombre (InterfaceAlias) de vEthernet (Default Switch)."
      return
    }

    Get-NetIPInterface | Where-Object InterfaceAlias -eq "vEthernet (WSL)" | Select-Object ifIndex, InterfaceAlias, AddressFamily, ConnectionState, Forwarding | Sort-Object -Property IfIndex | Format-Table

    [int] $wsl_vEth = Read-Host "Ingresa el indice (ifIndex) de vEthernet (WSL)"
    if ($wsl_vEth -isnot [int] -Or $wsl_vEth -eq 0) {
      Write-Host "ERROR: Respuesta invalida, ingresa el valor numerico de la primera columna (ifIndex) que corresponde al nombre (InterfaceAlias) de vEthernet (WSL)."
      return
    }

    if ($default_vEth -eq $wsl_vEth) {
      Write-Host "ERROR: vEthernet (Default Switch) y vEthernet (WSL) no pueden tener el mismo indice (ifIndex)."
      return
    }

    Set-NetIPInterface -ifindex $default_vEth -Forwarding Enabled
    Set-NetIPInterface -ifindex $wsl_vEth -Forwarding Enabled

    Get-NetIPInterface | Where-Object InterfaceAlias -like "vEthernet*" | Select-Object ifIndex, InterfaceAlias, AddressFamily, ConnectionState, Forwarding | Sort-Object -Property IfIndex | Format-Table

    Write-Host "Si ambas interfaces aparecen conectadas (Connected) y habilitadas (Enabled), todo esta listo! `r`nSi no es asi, revisa que hayas ingresado los indices correctos, que la maquina virtual se encuentre encendida y hayas ejecutado este script como administrador."

    Read-Host -Prompt "Presiona cualquier tecla para salir."

    Break
  }
  default {
    Write-Host "Invalid answer / Respuesta no valida."
  }
}