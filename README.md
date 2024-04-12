# Custom firmware for RTL8371B based network switches
This is an effort to write custom firmware for RTL8371B.  

# Supported devices
```
Manufacturer: Vimin
Name: 6-Port 2.5G Ethernet Switch with 2x 10G SFP
Model: VM-S250402
```

# Building
### Requirements
- mips64-linux-gnu-toolchain

Fedora: ``dnf install binutils-mips64-linux-gnu gcc-mips64-linux-gnu``

### Build steps
```
make all
```

# Flashing
If you don't know how to flash the firmware, then you should not use it in it's current state.  
This section will be written as soon as basic functionality is implemented.