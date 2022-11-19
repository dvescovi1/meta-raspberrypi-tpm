# raspberry pi with TPM2 from Infineon (SLx 9670) 

### Hardware Prerequisites 

Use the following Raspbeyy PI 4 rev. B with 4/8GB RAM

https://www.raspberrypi.org/products/raspberry-pi-4-model-b/

Please install the following board from Infineon on Raspberry

https://www.infineon.com/dgdl/Infineon-OPTIGA_SLx_9670_TPM_2.0_Pi_4-ApplicationNotes-v07_19-EN.pdf?fileId=5546d4626c1f3dc3016c3d19f43972eb

### Prerequisities for Ubuntu 20.04 LTS 

```
sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm
```

### Get Poky (from Yocto Project)

```
git clone git://git.yoctoproject.org/poky
cd poky
git checkout tags/yocto-3.1.3 -b my-yocto-3.1.3
(Verify with «git branch»)
```

### Get Meta Raspberry

```
git clone git://git.yoctoproject.org/meta-raspberrypi
cd meta-raspberrypi
git switch dunfell
(Verify with «git branch»)
cd ..
```

### Get Meta Openembedded

```
git clone git://git.openembedded.org/meta-openembedded
cd meta-openembedded
git switch dunfell
(Verify with «git branch»)
cd ..
```

### Get Meta Security

```
git clone git://git.yoctoproject.org/meta-security
cd meta-security
git switch dunfell
(Verify with «git branch»)
cd ..
```

### Get this...

```
git clone https://github.com/dvescovi1/meta-raspberrypi-tpm.git
```

### Init environment 

```

### Bitbake

```
bitbake core-image-base
```


## How to test TPM

### HW Check from shell

```
dmesg | grep -i tpm
ls /dev/tpm0

```

### TPM tools (tpm2-tools)

Try the following commands:

```
tpm2_getrandom 8 | xxd -p
tpm2_getrandom 16 | xxd -p
tpm2_getrandom 32 | xxd -p
```

### Generate Key (tpm2-tss)

```
tpm2tss-genkey -a rsa private.tss
cat private.tss
```

result:

```
-----BEGIN TSS2 PRIVATE KEY-----
MIICDwYGZ4EFCgEDoAMBAQECAQAEggEYARYAAQALAAYEcgAAABAAEAgAAAEAAQEA
...
5Xh9wLLdEzh0NoxGACGuGGiSAB/g2qHAdXQ9vofhMfYxoxFL7du9xBR7VwknuJIz
bnfJ
-----END TSS2 PRIVATE KEY-----
```

### TSS Engine (tpm2-tss-engine)

Engine informations can be retrieved using

```
openssl engine -t -c tpm2tss
```

A set of 10 or 16 random bytes can be retrieved using

```
openssl rand -engine tpm2tss -hex 10
openssl rand -engine tpm2tss -hex 16
```

#### RSA 2048

```
tpm2tss-genkey -a rsa -s 2048 mykey
openssl rsa -engine tpm2tss -inform engine -in mykey -pubout -outform pem -out mykey.pub
```

#### EDCSA

```
tpm2tss-genkey -a ecdsa mykey
openssl ec -engine tpm2tss -inform engine -in mykey -pubout -outform pem -out mykey.pub
```

#### Self Signed

```
tpm2tss-genkey -a rsa rsa.tss
openssl req -new -x509 -engine tpm2tss -key rsa.tss -keyform engine -out rsa.crt
```








