IMAGE_FEATURES_remove += "splash"

IMAGE_INSTALL_append = " \
  tpm2-tools \
  libtss2 \
  libtss2-tcti-device \
  libtss2-tcti-mssim \
  tpm2-abrmd \
  tpm2-pkcs11 \
  tpm2-totp \
  tpm2-tss \
  tpm2-tss-engine \
  tpm2-tss-engine-dev \ 
"
KERNEL_DEVICETREE =+ "overlays/tpm-slb9670.dtbo"
