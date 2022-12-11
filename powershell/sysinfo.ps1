#System Hardware Description 

function OSDescription { 

"Computer System Information:"

Get-wmiobject win32_computersystem | format-list Description 

} 

OSDescription  

 

#Operating System name and version number 

function OSInfo { 

"Operating System Information:" 

Get-wmiobject win32_operatingsystem | format-list Caption, Version
 } 

OSInfo 

 

#Cpu Information Cache information is broken, commented out

function CPUInfo { 

"Processor Information:" 

#$L1cache = (gwmi win32_processor).L1CacheSize  

#$L2cache = (gwmi win32_processor).L2CacheSize 

#$L3cache = (gwmi win32_processor).L3CacheSize 

Get-wmiobject win32_processor | format-list CurrentClockSpeed, NumberOfCores #, $L1cache, $L2cache, $L3cache 

} 

CPUInfo 

 

#RamInfo 

function RAMInfo { 

"Ram Information:" 

$totalcapacity = 0  

get-wmiobject -class win32_physicalmemory |  

foreach {  

new-object -TypeName psobject -Property @{  

Manufacturer = $_.manufacturer  

"Speed(MHz)" = $_.speed  

"Size(MB)" = $_.capacity/1mb  

Bank = $_.banklabel  

Slot = $_.devicelocator  

}  

$totalcapacity += $_.capacity/1mb  

} | 

ft -auto Manufacturer, "Size(MB)", "Speed(MHz)", Bank, Slot  

"Total RAM: ${totalcapacity}MB " 

} 

RAMInfo 

 

#Get Disk summary  

Function DiskInfo { 

"Disk Information:" 

$diskdrives = Get-CIMInstance CIM_diskdrive 

  

foreach ($disk in $diskdrives) { 

      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition 

      foreach ($partition in $partitions) { 

            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk 

            foreach ($logicaldisk in $logicaldisks) { 

                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer 

                                                               Location=$partition.deviceid 

                                                               Drive=$logicaldisk.deviceid 

                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int] 

                                                               } 

           } 

      } 

  } 

} 

DiskInfo 

 

#Ip configuration report 

Function IPReport { 

"IP Configuration:" 

get-ciminstance win32_networkadapterconfiguration | where-object ipenabled | format-table Description, Index, Ipaddress, Ipsubnet, Dnsdomain, Dnsserver 

} 

IPReport 

 

#Video card information 

Function GPUInfo { 

"Video Card Information:"

Get-wmiobject win32_videocontroller | format-list Name, Description 

} 

GPUInfo 