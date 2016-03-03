Return-Path: <rtc-linux+bncBDEKVJM7XAHRBJVO4C3AKGQECUFHRMY@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.133])
        by gmr-mx.google.com with ESMTPS id w10si262846wmw.3.2016.03.03.02.51.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 02:51:18 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: k.kozlowski@samsung.com, daniel.lezcano@linaro.org, tglx@linutronix.de, dan.j.williams@intel.com, vinod.koul@intel.com, jason@lakedaemon.net, marc.zyngier@arm.com, mchehab@osg.samsung.com, lee.jones@linaro.org, peppe.cavallaro@st.com, kishon@ti.com, linus.walleij@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, andy.gross@linaro.org, david.brown@linaro.org, laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [rtc-linux] Re: [RFC 15/15] mfd: syscon: Fix build of missing ioremap
 on UM
Date: Thu, 03 Mar 2016 11:50:54 +0100
Message-ID: <1782092.xMPH0kgtGM@wuerfel>
In-Reply-To: <1456992221-26712-16-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com> <1456992221-26712-16-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thursday 03 March 2016 17:03:41 Krzysztof Kozlowski wrote:
> Since commit c89c0114955a ("mfd: syscon: Set regmap max_register in
> of_syscon_register") the syscon uses ioremap so it fails on COMPILE_TEST
> without HAS_IOMEM:
>=20
> drivers/mfd/syscon.c: In function =E2=80=98of_syscon_register=E2=80=99:
> drivers/mfd/syscon.c:67:9: error: implicit declaration of function =E2=80=
=98ioremap=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   base =3D ioremap(res.start, resource_size(&res));
>          ^
> drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer=
 without a cast [-Wint-conversion]
>   base =3D ioremap(res.start, resource_size(&res));
>        ^
> drivers/mfd/syscon.c:109:2: error: implicit declaration of function =E2=
=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   iounmap(base);
>=20
> When selecting MFD_SYSCON, depend on HAS_IOMEM to avoid unmet direct
> dependencies.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: c89c0114955a ("mfd: syscon: Set regmap max_register in of_syscon_r=
egister")
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Thanks for looking into this, the patches all look right to me, but
I fear we are forever playing catch-up here, as the number of syscon users
is only growing, and it's not obvious to the average driver developer
why they have to select this symbol.

Interestingly, when I try to build an allmodconfig kernel for UML,
it seems to reject any driver calling ioremap/iounmap but not
the wrapper functions around that (of_iomap, devm_ioremap,
devm_ioremap_resource, ...) or the actual accessors that make no
sense without ioremap (readl, writel, inb, outb, iowrite32, ...).

I've played with this a bit, and arrived at the patch below, is this
something we want as well?

	Arnd

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index aa21dc55eb15..2e5b1e525a1d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1034,6 +1034,7 @@ config MFD_SUN6I_PRCM
> =20
>  config MFD_SYSCON
>  	bool "System Controller Register R/W Based on Regmap"
> +	depends on HAS_IOMEM
>  	select REGMAP_MMIO
>  	help
>  	  Select this option to enable accessing system control registers
>=20


 arch/um/include/asm/io.h           |    1 +
 drivers/char/Kconfig               |    3 +++
 drivers/char/mem.c                 |   16 ++++++++++++++++
 drivers/clocksource/Kconfig        |    3 +++
 drivers/fmc/Kconfig                |    1 +
 drivers/fpga/Kconfig               |    1 +
 drivers/hwtracing/intel_th/Kconfig |    1 +
 drivers/mfd/Kconfig                |    1 +
 drivers/misc/altera-stapl/Kconfig  |    2 +-
 drivers/mtd/chips/Kconfig          |    4 ++++
 drivers/mtd/lpddr/Kconfig          |    1 +
 drivers/mtd/maps/Kconfig           |    3 ++-
 drivers/mtd/nand/Kconfig           |    2 +-
 drivers/mtd/spi-nor/Kconfig        |    1 +
 drivers/net/can/Kconfig            |    1 +
 drivers/net/hamradio/Kconfig       |    9 ++++++---
 drivers/nvmem/Kconfig              |    1 +
 drivers/phy/Kconfig                |    9 +++++++--
 drivers/power/reset/Kconfig        |    4 +++-
 drivers/staging/comedi/Kconfig     |    6 +++++-
 drivers/thermal/Kconfig            |   11 +++++++++--
 include/linux/irq.h                |    2 ++
 include/linux/mtd/cfi.h            |    2 ++
 include/linux/mtd/map.h            |    2 ++
 kernel/resource.c                  |    2 ++
 lib/Kconfig                        |    7 ++++++-
 mm/bootmem.c                       |    4 ++--
 27 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
new file mode 100644
index 0000000..618ff13
--- /dev/null
+++ b/arch/um/include/asm/io.h
@@ -0,0 +1 @@
+/* no IOPORT or IOMEM suport */
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a043107..f6dc17a 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -8,6 +8,7 @@ source "drivers/tty/Kconfig"
=20
 config DEVMEM
 	bool "/dev/mem virtual device support"
+	depends on HAS_IOMEM
 	default y
 	help
 	  Say Y here if you want to support the /dev/mem device.
@@ -17,6 +18,7 @@ config DEVMEM
=20
 config DEVKMEM
 	bool "/dev/kmem virtual device support"
+	depends on HAS_IOMEM
 	default y
 	help
 	  Say Y here if you want to support the /dev/kmem device. The
@@ -94,6 +96,7 @@ config BFIN_OTP_WRITE_ENABLE
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
+	depends on HAS_IOPORT
 	---help---
 	  If you intend to attach a printer to the parallel port of your Linux
 	  box (as opposed to using a serial printer; if the connector at the
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 4f6f94c..eedd129 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -91,6 +91,7 @@ void __weak unxlate_dev_mem_ptr(phys_addr_t phys, void *a=
ddr)
 }
 #endif
=20
+#ifdef CONFIG_DEVMEM
 /*
  * This funcion reads the *physical* memory. The f_pos points directly to =
the
  * memory location.
@@ -219,6 +220,7 @@ static ssize_t write_mem(struct file *file, const char =
__user *buf,
 	*ppos +=3D written;
 	return written;
 }
+#endif
=20
 int __weak phys_mem_access_prot_allowed(struct file *file,
 	unsigned long pfn, unsigned long size, pgprot_t *vma_prot)
@@ -312,6 +314,7 @@ static inline int private_mapping_ok(struct vm_area_str=
uct *vma)
 }
 #endif
=20
+#ifdef CONFIG_DEVMEM
 static const struct vm_operations_struct mmap_mem_ops =3D {
 #ifdef CONFIG_HAVE_IOREMAP_PROT
 	.access =3D generic_access_phys
@@ -351,7 +354,9 @@ static int mmap_mem(struct file *file, struct vm_area_s=
truct *vma)
 	}
 	return 0;
 }
+#endif
=20
+#ifdef CONFIG_DEVKMEM
 static int mmap_kmem(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long pfn;
@@ -552,7 +557,9 @@ static ssize_t write_kmem(struct file *file, const char=
 __user *buf,
 	*ppos =3D p;
 	return virtr + wrote ? : err;
 }
+#endif
=20
+#ifdef CONFIG_DEVPORT
 static ssize_t read_port(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -594,6 +601,7 @@ static ssize_t write_port(struct file *file, const char=
 __user *buf,
 	*ppos =3D i;
 	return tmp-buf;
 }
+#endif
=20
 static ssize_t read_null(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
@@ -710,10 +718,12 @@ static loff_t memory_lseek(struct file *file, loff_t =
offset, int orig)
 	return ret;
 }
=20
+#ifdef CONFIG_DEVPORT
 static int open_port(struct inode *inode, struct file *filp)
 {
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
+#endif
=20
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
@@ -722,6 +732,7 @@ static int open_port(struct inode *inode, struct file *=
filp)
 #define open_mem	open_port
 #define open_kmem	open_mem
=20
+#ifdef CONFIG_DEVMEM
 static const struct file_operations __maybe_unused mem_fops =3D {
 	.llseek		=3D memory_lseek,
 	.read		=3D read_mem,
@@ -733,7 +744,9 @@ static const struct file_operations __maybe_unused mem_=
fops =3D {
 	.mmap_capabilities =3D memory_mmap_capabilities,
 #endif
 };
+#endif
=20
+#ifdef CONFIG_DEVKMEM
 static const struct file_operations __maybe_unused kmem_fops =3D {
 	.llseek		=3D memory_lseek,
 	.read		=3D read_kmem,
@@ -745,6 +758,7 @@ static const struct file_operations __maybe_unused kmem=
_fops =3D {
 	.mmap_capabilities =3D memory_mmap_capabilities,
 #endif
 };
+#endif
=20
 static const struct file_operations null_fops =3D {
 	.llseek		=3D null_lseek,
@@ -755,12 +769,14 @@ static const struct file_operations null_fops =3D {
 	.splice_write	=3D splice_write_null,
 };
=20
+#ifdef CONFIG_DEVPORT
 static const struct file_operations __maybe_unused port_fops =3D {
 	.llseek		=3D memory_lseek,
 	.read		=3D read_port,
 	.write		=3D write_port,
 	.open		=3D open_port,
 };
+#endif
=20
 static const struct file_operations zero_fops =3D {
 	.llseek		=3D zero_lseek,
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 33db740..6b58974 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -38,6 +38,7 @@ config DIGICOLOR_TIMER
 config DW_APB_TIMER
 	bool "DW APB timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	help
 	  Enables the support for the dw_apb timer.
=20
@@ -64,6 +65,7 @@ config ARMADA_370_XP_TIMER
 config MESON6_TIMER
 	bool "Meson6 timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	select CLKSRC_MMIO
 	help
 	  Enables the support for the Meson6 timer driver.
@@ -114,6 +116,7 @@ config CADENCE_TTC_TIMER
 config ASM9260_TIMER
 	bool "ASM9260 timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	help
diff --git a/drivers/fmc/Kconfig b/drivers/fmc/Kconfig
index 3a75f42..adf1391 100644
--- a/drivers/fmc/Kconfig
+++ b/drivers/fmc/Kconfig
@@ -4,6 +4,7 @@
=20
 menuconfig FMC
 	tristate "FMC support"
+	depends on HAS_IOMEM
 	help
=20
 	  FMC (FPGA Mezzanine Carrier) is a mechanical and electrical
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index c9b9fdf..36c54af 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -21,6 +21,7 @@ config FPGA_MGR_SOCFPGA
=20
 config FPGA_MGR_ZYNQ_FPGA
 	tristate "Xilinx Zynq FPGA"
+	depends on HAS_IOMEM
 	help
 	  FPGA manager driver support for Xilinx Zynq FPGAs.
=20
diff --git a/drivers/hwtracing/intel_th/Kconfig b/drivers/hwtracing/intel_t=
h/Kconfig
index b7a9073..467dae9 100644
--- a/drivers/hwtracing/intel_th/Kconfig
+++ b/drivers/hwtracing/intel_th/Kconfig
@@ -1,5 +1,6 @@
 config INTEL_TH
 	tristate "Intel(R) Trace Hub controller"
+	depends on HAS_IOMEM
 	help
 	  Intel(R) Trace Hub (TH) is a set of hardware blocks (subdevices) that
 	  produce, switch and output trace data from multiple hardware and
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 9ca66de..6ff6246 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -999,6 +999,7 @@ config MFD_SUN6I_PRCM
=20
 config MFD_SYSCON
 	bool "System Controller Register R/W Based on Regmap"
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  Select this option to enable accessing system control registers
diff --git a/drivers/misc/altera-stapl/Kconfig b/drivers/misc/altera-stapl/=
Kconfig
index 7f01d8e..c7e4c77 100644
--- a/drivers/misc/altera-stapl/Kconfig
+++ b/drivers/misc/altera-stapl/Kconfig
@@ -2,7 +2,7 @@ comment "Altera FPGA firmware download module"
=20
 config ALTERA_STAPL
 	tristate "Altera FPGA firmware download module"
-	depends on I2C
+	depends on I2C && HAS_IOPORT
 	default n
 	help
 	  An Altera FPGA module. Say Y when you want to support this tool.
diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index 3b3dabc..189ddce 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -3,6 +3,7 @@ menu "RAM/ROM/Flash chip drivers"
=20
 config MTD_CFI
 	tristate "Detect flash chips by Common Flash Interface (CFI) probe"
+	depends on HAS_IOMEM
 	select MTD_GEN_PROBE
 	select MTD_CFI_UTIL
 	help
@@ -15,6 +16,7 @@ config MTD_CFI
=20
 config MTD_JEDECPROBE
 	tristate "Detect non-CFI AMD/JEDEC-compatible flash chips"
+	depends on HAS_IOMEM
 	select MTD_GEN_PROBE
 	select MTD_CFI_UTIL
 	help
@@ -207,12 +209,14 @@ config MTD_CFI_UTIL
=20
 config MTD_RAM
 	tristate "Support for RAM chips in bus mapping"
+	depends on HAS_IOMEM
 	help
 	  This option enables basic support for RAM chips accessed through
 	  a bus mapping driver.
=20
 config MTD_ROM
 	tristate "Support for ROM chips in bus mapping"
+	depends on HAS_IOMEM
 	help
 	  This option enables basic support for ROM chips accessed through
 	  a bus mapping driver.
diff --git a/drivers/mtd/lpddr/Kconfig b/drivers/mtd/lpddr/Kconfig
index 3a19cbe..07dd95a 100644
--- a/drivers/mtd/lpddr/Kconfig
+++ b/drivers/mtd/lpddr/Kconfig
@@ -4,6 +4,7 @@ menu "LPDDR & LPDDR2 PCM memory drivers"
 config MTD_LPDDR
 	tristate "Support for LPDDR flash chips"
 	select MTD_QINFO_PROBE
+	depends on HAS_IOMEM
 	help
 	  This option enables support of LPDDR (Low power double data rate)
 	  flash chips. Synonymous with Mobile-DDR. It is a new standard for
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 7c95a65..86a9604 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -3,7 +3,8 @@ menu "Mapping drivers for chip access"
 	depends on HAS_IOMEM
=20
 config MTD_COMPLEX_MAPPINGS
-	bool "Support non-linear mappings of flash chips"
+	bool "Support non-linear mappings of flash chips" if HAS_IOMEM
+	default !HAS_IOMEM
 	help
 	  This causes the chip drivers to allow for complicated
 	  paged mappings of flash chips.
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 20f01b3..6ed3de7 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -12,7 +12,7 @@ config MTD_NAND_ECC_SMC
=20
 menuconfig MTD_NAND
 	tristate "NAND Device Support"
-	depends on MTD
+	depends on MTD && HAS_IOMEM
 	select MTD_NAND_IDS
 	select MTD_NAND_ECC
 	help
diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 0dc9275..83befab 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -9,6 +9,7 @@ if MTD_SPI_NOR
=20
 config MTD_MT81xx_NOR
 	tristate "Mediatek MT81xx SPI NOR flash controller"
+	depends on HAS_IOMEM
 	help
 	  This enables access to SPI NOR flash, using MT81xx SPI NOR flash
 	  controller. This controller does not support generic SPI BUS, it only
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 6d04183..b1e268b 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -132,6 +132,7 @@ config CAN_RCAR
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
 	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
+	depends on HAS_IOMEM
 	---help---
 	  Say Y here if you want to use CAN controller found on Allwinner
 	  A10/A20 SoCs.
diff --git a/drivers/net/hamradio/Kconfig b/drivers/net/hamradio/Kconfig
index bf5e596..507f7a5 100644
--- a/drivers/net/hamradio/Kconfig
+++ b/drivers/net/hamradio/Kconfig
@@ -113,7 +113,8 @@ config SCC_TRXECHO
=20
 config BAYCOM_SER_FDX
 	tristate "BAYCOM ser12 fullduplex driver for AX.25"
-	depends on AX25 && !S390
+	depends on AX25
+	depends on HAS_IOPORT
 	select CRC_CCITT
 	---help---
 	  This is one of two drivers for Baycom style simple amateur radio
@@ -133,7 +134,8 @@ config BAYCOM_SER_FDX
=20
 config BAYCOM_SER_HDX
 	tristate "BAYCOM ser12 halfduplex driver for AX.25"
-	depends on AX25 && !S390
+	depends on AX25
+	depends on HAS_IOPORT
 	select CRC_CCITT
 	---help---
 	  This is one of two drivers for Baycom style simple amateur radio
@@ -181,7 +183,8 @@ config BAYCOM_EPP
=20
 config YAM
 	tristate "YAM driver for AX.25"
-	depends on AX25 && !S390
+	depends on AX25
+	depends on HAS_IOPORT
 	help
 	  The YAM is a modem for packet radio which connects to the serial
 	  port and includes some of the functions of a Terminal Node
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index bc4ea58..6ef3d0a 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -1,6 +1,7 @@
 menuconfig NVMEM
 	tristate "NVMEM Support"
 	select REGMAP
+	depends on HAS_IOMEM
 	help
 	  Support for NVMEM(Non Volatile Memory) devices like EEPROM, EFUSES...
=20
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index e7e117d..d2216df 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -30,9 +30,10 @@ config PHY_BERLIN_SATA
 	  Enable this to support the SATA PHY on Marvell Berlin SoCs.
=20
 config ARMADA375_USBCLUSTER_PHY
-	def_bool y
-	depends on MACH_ARMADA_375 || COMPILE_TEST
+	bool "ARMADA 375 USB cluster PHY driver" if COMPILE_TEST && !MACH_ARMADA_=
375
+	def_bool MACH_ARMADA_375
 	depends on OF
+	depends on HAS_IOMEM
 	select GENERIC_PHY
=20
 config PHY_DM816X_USB
@@ -128,6 +129,7 @@ config PHY_RCAR_GEN3_USB2
 config OMAP_CONTROL_PHY
 	tristate "OMAP CONTROL PHY Driver"
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enable this to add support for the PHY part present in the control
 	  module. This driver has API to power on the USB2 PHY and to write to
@@ -224,6 +226,8 @@ config PHY_MT65XX_USB3
=20
 config PHY_HI6220_USB
 	tristate "hi6220 USB PHY support"
+	depends on ARM64 || COMPILE_TEST
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
@@ -401,6 +405,7 @@ config PHY_CYGNUS_PCIE
 	tristate "Broadcom Cygnus PCIe PHY driver"
 	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
 	select GENERIC_PHY
+	depends on HAS_IOMEM
 	default ARCH_BCM_CYGNUS
 	help
 	  Enable this to support the Broadcom Cygnus PCIe PHY.
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 1131cf7..bb5bd1b 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -41,7 +41,7 @@ config POWER_RESET_AXXIA
 config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver"
 	depends on ARM || MIPS || COMPILE_TEST
-	depends on MFD_SYSCON
+	depends on MFD_SYSCON && HAS_IOMEM
 	default ARCH_BRCMSTB
 	help
 	  This driver provides restart support for Broadcom STB boards.
@@ -148,6 +148,7 @@ config POWER_RESET_KEYSTONE
 config POWER_RESET_SYSCON
 	bool "Generic SYSCON regmap reset driver"
 	depends on OF
+	depends on HAS_IOMEM
 	select MFD_SYSCON
 	help
 	  Reboot support for generic SYSCON mapped register reset.
@@ -155,6 +156,7 @@ config POWER_RESET_SYSCON
 config POWER_RESET_SYSCON_POWEROFF
 	bool "Generic SYSCON regmap poweroff driver"
 	depends on OF
+	depends on HAS_IOMEM
 	select MFD_SYSCON
 	help
 	  Poweroff support for generic SYSCON mapped register poweroff.
diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kconfi=
g
index e7255f8..e1ba4aa 100644
--- a/drivers/staging/comedi/Kconfig
+++ b/drivers/staging/comedi/Kconfig
@@ -67,6 +67,7 @@ config COMEDI_TEST
=20
 config COMEDI_PARPORT
 	tristate "Parallel port support"
+	depends on HAS_IOPORT
 	---help---
 	  Enable support for the standard parallel port.
 	  A cheap and easy way to get a few more digital I/O lines. Steal
@@ -87,6 +88,7 @@ config COMEDI_SERIAL2002
 config COMEDI_SSV_DNP
 	tristate "SSV Embedded Systems DIL/Net-PC support"
 	depends on X86_32 || COMPILE_TEST
+	depends on HAS_IOPORT
 	---help---
 	  Enable support for SSV Embedded Systems DIL/Net-PC
=20
@@ -97,6 +99,7 @@ endif # COMEDI_MISC_DRIVERS
=20
 menuconfig COMEDI_ISA_DRIVERS
 	bool "Comedi ISA and PC/104 drivers"
+	depends on HAS_IOPORT
 	---help---
 	  Enable comedi ISA and PC/104 drivers to be built
=20
@@ -1110,7 +1113,7 @@ endif # COMEDI_PCI_DRIVERS
=20
 menuconfig COMEDI_PCMCIA_DRIVERS
 	tristate "Comedi PCMCIA drivers"
-	depends on PCMCIA
+	depends on PCMCIA && HAS_IOPORT
 	---help---
 	  Enable support for comedi PCMCIA drivers.
=20
@@ -1262,6 +1265,7 @@ config COMEDI_8255
 config COMEDI_8255_SA
 	tristate "Standalone 8255 support"
 	select COMEDI_8255
+	depends on HAS_IOPORT
 	---help---
 	  Enable support for 8255 digital I/O as a standalone driver.
=20
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 8cc4ac6..31ae027 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -178,6 +178,7 @@ config THERMAL_EMULATION
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
@@ -198,6 +199,7 @@ config SPEAR_THERMAL
 	bool "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  Enable this to plug the SPEAr thermal sensor driver into the Linux
 	  thermal framework.
@@ -206,6 +208,7 @@ config ROCKCHIP_THERMAL
 	tristate "Rockchip thermal driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on RESET_CONTROLLER
+	depends on HAS_IOMEM
 	help
 	  Rockchip thermal driver provides support for Temperature sensor
 	  ADC (TS-ADC) found on Rockchip SoCs. It supports one critical
@@ -216,6 +219,7 @@ config RCAR_THERMAL
 	tristate "Renesas R-Car thermal driver"
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on HAS_IOMEM
 	help
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
 	  thermal framework.
@@ -223,6 +227,7 @@ config RCAR_THERMAL
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Support for the Kirkwood thermal sensor driver into the Linux thermal
@@ -231,6 +236,7 @@ config KIRKWOOD_THERMAL
 config DOVE_THERMAL
 	tristate "Temperature sensor on Marvell Dove SoCs"
 	depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Support for the Dove thermal sensor driver in the Linux thermal
@@ -249,6 +255,7 @@ config DB8500_THERMAL
 config ARMADA_THERMAL
 	tristate "Armada 370/XP thermal management"
 	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Enable this option if you want to have support for thermal management
@@ -366,12 +373,12 @@ config INTEL_PCH_THERMAL
 	  programmable trip points and other information.
=20
 menu "Texas Instruments thermal drivers"
-depends on ARCH_HAS_BANDGAP || COMPILE_TEST
+depends on ARCH_HAS_BANDGAP || (COMPILE_TEST && HAS_IOMEM)
 source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
=20
 menu "Samsung thermal drivers"
-depends on ARCH_EXYNOS || COMPILE_TEST
+depends on ARCH_EXYNOS || (COMPILE_TEST && HAS_IOMEM)
 source "drivers/thermal/samsung/Kconfig"
 endmenu
=20
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c1c967..a5d0f12 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -916,6 +916,7 @@ static inline void irq_gc_lock(struct irq_chip_generic =
*gc) { }
 static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
 #endif
=20
+#ifdef CONFIG_HAS_IOMEM
 static inline void irq_reg_writel(struct irq_chip_generic *gc,
 				  u32 val, int reg_offset)
 {
@@ -933,5 +934,6 @@ static inline u32 irq_reg_readl(struct irq_chip_generic=
 *gc,
 	else
 		return readl(gc->reg_base + reg_offset);
 }
+#endif
=20
 #endif /* _LINUX_IRQ_H */
diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index 9b57a9b..d5db153 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -310,6 +310,7 @@ uint32_t cfi_send_gen_cmd(u_char cmd, uint32_t cmd_addr=
, uint32_t base,
 				struct map_info *map, struct cfi_private *cfi,
 				int type, map_word *prev_val);
=20
+#ifdef CONFIG_HAS_IOMEM
 static inline uint8_t cfi_read_query(struct map_info *map, uint32_t addr)
 {
 	map_word val =3D map_read(map, addr);
@@ -341,6 +342,7 @@ static inline uint16_t cfi_read_query16(struct map_info=
 *map, uint32_t addr)
 		return cfi32_to_cpu(map, val.x[0]);
 	}
 }
+#endif
=20
 void cfi_udelay(int us);
=20
diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index 58f3ba7..07c0d497 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -410,6 +410,7 @@ static inline map_word map_word_ff(struct map_info *map=
)
 	return r;
 }
=20
+#ifdef CONFIG_HAS_IOMEM
 static inline map_word inline_map_read(struct map_info *map, unsigned long=
 ofs)
 {
 	map_word r;
@@ -463,6 +464,7 @@ static inline void inline_map_copy_to(struct map_info *=
map, unsigned long to, co
 {
 	memcpy_toio(map->virt + to, from, len);
 }
+#endif
=20
 #ifdef CONFIG_MTD_COMPLEX_MAPPINGS
 #define map_read(map, ofs) (map)->read(map, ofs)
diff --git a/kernel/resource.c b/kernel/resource.c
index 09c0597..efd5c9e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -29,7 +29,9 @@
 struct resource ioport_resource =3D {
 	.name	=3D "PCI IO",
 	.start	=3D 0,
+#ifdef CONFIG_HAS_IOPORT
 	.end	=3D IO_SPACE_LIMIT,
+#endif
 	.flags	=3D IORESOURCE_IO,
 };
 EXPORT_SYMBOL(ioport_resource);
diff --git a/lib/Kconfig b/lib/Kconfig
index 133ebc0..38ff36d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -382,9 +382,14 @@ config HAS_IOMEM
 	select GENERIC_IO
 	default y
=20
+config HAS_IOPORT
+	bool
+	depends on HAS_IOMEM && !NO_IOPORT
+	default y
+
 config HAS_IOPORT_MAP
 	bool
-	depends on HAS_IOMEM && !NO_IOPORT_MAP
+	depends on HAS_IOMEM && HAS_IOPORT && !NO_IOPORT_MAP
 	default y
=20
 config HAS_DMA
diff --git a/mm/bootmem.c b/mm/bootmem.c
index 91e32bc..3471237 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -99,7 +99,7 @@ static unsigned long __init init_bootmem_core(bootmem_dat=
a_t *bdata,
 	unsigned long mapsize;
=20
 	mminit_validate_memmodel_limits(&start, &end);
-	bdata->node_bootmem_map =3D phys_to_virt(PFN_PHYS(mapstart));
+	bdata->node_bootmem_map =3D __va(PFN_PHYS(mapstart));
 	bdata->node_min_pfn =3D start;
 	bdata->node_low_pfn =3D end;
 	link_bootmem(bdata);
@@ -585,7 +585,7 @@ find_block:
 				PFN_UP(end_off), BOOTMEM_EXCLUSIVE))
 			BUG();
=20
-		region =3D phys_to_virt(PFN_PHYS(bdata->node_min_pfn) +
+		region =3D __va(PFN_PHYS(bdata->node_min_pfn) +
 				start_off);
 		memset(region, 0, size);
 		/*




--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
