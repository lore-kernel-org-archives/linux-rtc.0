Return-Path: <rtc-linux+bncBDKLR6HU7IIBBN7P6GZAKGQEQ5MH5AA@googlegroups.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com. [195.59.15.196])
        by gmr-mx.google.com with ESMTP id d185si671926wmf.0.2015.11.30.08.22.14
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Nov 2015 08:22:15 -0800 (PST)
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-mips@linux-mips.org>
CC: Paul Burton <paul.burton@imgtec.com>, Arnd Bergmann <arnd@arndb.de>,
	Joshua Kinard <kumba@gentoo.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Jiri Slaby <jslaby@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, "Zubair
 Lutfullah Kakakhel" <Zubair.Kakakhel@imgtec.com>, Linus Walleij
	<linus.walleij@linaro.org>, Kumar Gala <galak@codeaurora.org>, Yijing Wang
	<wangyijing@huawei.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Rob
 Herring" <robh+dt@kernel.org>, John Crispin <blogic@openwrt.org>,
	"Jayachandran C" <jchandra@broadcom.com>, <linux-spi@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Ray Jui <rjui@broadcom.com>, Richard
 Cochran <richardcochran@gmail.com>, Tejun Heo <tj@kernel.org>, Michal Simek
	<michal.simek@xilinx.com>, Andrew Bresticker <abrestic@chromium.org>,
	"Russell Joyce" <russell.joyce@york.ac.uk>, Thomas Gleixner
	<tglx@linutronix.de>, "Grant Likely" <grant.likely@linaro.org>, Alexandre
 Belloni <alexandre.belloni@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>, Pawel Moll <pawel.moll@arm.com>,
	<linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, Alexandre Courbot <gnurou@gmail.com>,
	Zhou Wang <wangzhou1@hisilicon.com>, Andrew Morton
	<akpm@linux-foundation.org>, Ley Foon Tan <lftan@altera.com>,
	<devicetree@vger.kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>,
	<linux-serial@vger.kernel.org>, <rtc-linux@googlegroups.com>, Rob Herring
	<robh@kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, "Wolfram
 Sang" <wsa@the-dreams.de>, Duc Dang <dhdang@apm.com>, Frank Rowand
	<frowand.list@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Markos Chandras
	<markos.chandras@imgtec.com>, Michal Simek <monstr@monstr.eu>, Marc Zyngier
	<marc.zyngier@arm.com>, Dan Williams <dan.j.williams@intel.com>, "Miguel
 Ojeda Sandonis" <miguel.ojeda.sandonis@gmail.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, <linux-gpio@vger.kernel.org>,
	<netdev@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"Joe Perches" <joe@perches.com>, Jingoo Han <jingoohan1@gmail.com>, Hauke
 Mehrtens <hauke@hauke-m.de>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?=
	<soren.brinkmann@xilinx.com>, <dmaengine@vger.kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Minghuan Lian <Minghuan.Lian@freescale.com>,
	<linux-i2c@vger.kernel.org>
Subject: [rtc-linux] [PATCH 00/28] MIPS Boston board support
Date: Mon, 30 Nov 2015 16:21:25 +0000
Message-ID: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

This series introduces support for the Imagination Technologies MIPS
Boston development board. Boston is an FPGA-based development board
akin to the much older Malta board, built around a Xilinx FPGA running
a MIPS CPU & other logic including a PCIe root port connected to an
Intel EG20T Platform Controller Hub. This provides a base set of
peripherals including SATA, USB, SD/MMC, ethernet, I2C & GPIOs. PCIe
slots are also present for expansion.

Paul Burton (28):
  serial: earlycon: allow MEM32 I/O for DT earlycon
  dt-bindings: ascii-lcd: Document a binding for simple ASCII LCDs
  auxdisplay: driver for simple memory mapped ASCII LCD displays
  MIPS: PCI: compatibility with ARM-like PCI host drivers
  PCI: xilinx: keep references to both IRQ domains
  PCI: xilinx: unify INTx & MSI interrupt FIFO decode
  PCI: xilinx: always clear interrupt decode register
  PCI: xilinx: fix INTX irq dispatch
  PCI: xilinx: allow build on MIPS platforms
  misc: pch_phub: allow build on MIPS platforms
  dmaengine: pch_dma: allow build on MIPS platforms
  gpio: pch: allow build on MIPS platforms
  gpio: pch: allow use from device tree
  i2c: eg20t: allow build on MIPS platforms
  i2c: eg20t: set i2c_adapter->dev.of_node
  rtc: m41t80: add devicetree probe support
  spi: topcliff-pch: allow build for MIPS platforms
  ptp: pch: allow build on MIPS platforms
  net: pch_gbe: allow build on MIPS platforms
  net: pch_gbe: clear interrupt FIFO during probe
  net: pch_gbe: mark Minnow PHY reset GPIO active low
  net: pch_gbe: pull PHY GPIO handling out of Minnow code
  net: pch_gbe: always reset PHY along with MAC
  net: pch_gbe: add device tree support
  net: pch_gbe: allow longer for resets
  MIPS: support for generating FIT (.itb) images
  dt-bindings: mips: img,boston: Document img,boston binding
  MIPS: Boston board support

 Documentation/devicetree/bindings/ascii-lcd.txt    |  10 +
 .../devicetree/bindings/mips/img/boston.txt        |  15 ++
 MAINTAINERS                                        |  14 ++
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  45 ++++
 arch/mips/Makefile                                 |   6 +-
 arch/mips/boot/Makefile                            |  61 ++++++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/img/Makefile                    |   7 +
 arch/mips/boot/dts/img/boston.dts                  | 201 ++++++++++++++++++
 arch/mips/boot/skeleton.its                        |  24 +++
 arch/mips/boston/Makefile                          |  12 ++
 arch/mips/boston/Platform                          |   8 +
 arch/mips/boston/init.c                            |  75 +++++++
 arch/mips/boston/int.c                             |  33 +++
 arch/mips/boston/time.c                            |  89 ++++++++
 arch/mips/boston/vmlinux.its                       |  23 ++
 arch/mips/configs/boston_defconfig                 | 170 +++++++++++++++
 .../asm/mach-boston/cpu-feature-overrides.h        |  26 +++
 arch/mips/include/asm/mach-boston/irq.h            |  18 ++
 arch/mips/include/asm/mach-boston/spaces.h         |  20 ++
 arch/mips/include/asm/pci.h                        |  67 +++++-
 arch/mips/lib/iomap-pci.c                          |   2 +-
 arch/mips/pci/Makefile                             |   6 +
 arch/mips/pci/pci-generic.c                        | 138 ++++++++++++
 arch/mips/pci/pci-legacy.c                         | 232 +++++++++++++++++++++
 arch/mips/pci/pci.c                                | 226 +-------------------
 drivers/auxdisplay/Kconfig                         |   7 +
 drivers/auxdisplay/Makefile                        |   1 +
 drivers/auxdisplay/ascii-lcd.c                     | 230 ++++++++++++++++++++
 drivers/dma/Kconfig                                |   2 +-
 drivers/gpio/Kconfig                               |   2 +-
 drivers/gpio/gpio-pch.c                            |   1 +
 drivers/i2c/busses/Kconfig                         |   2 +-
 drivers/i2c/busses/i2c-eg20t.c                     |   1 +
 drivers/misc/Kconfig                               |   2 +-
 drivers/net/ethernet/oki-semi/pch_gbe/Kconfig      |   2 +-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h    |   4 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |  74 +++++--
 drivers/of/fdt.c                                   |   2 +-
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pcie-xilinx.c                     | 123 +++++------
 drivers/ptp/Kconfig                                |   2 +-
 drivers/rtc/rtc-m41t80.c                           |  26 +++
 drivers/spi/Kconfig                                |   2 +-
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/earlycon.c                      |  15 +-
 include/linux/serial_core.h                        |   2 +-
 48 files changed, 1720 insertions(+), 313 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ascii-lcd.txt
 create mode 100644 Documentation/devicetree/bindings/mips/img/boston.txt
 create mode 100644 arch/mips/boot/dts/img/Makefile
 create mode 100644 arch/mips/boot/dts/img/boston.dts
 create mode 100644 arch/mips/boot/skeleton.its
 create mode 100644 arch/mips/boston/Makefile
 create mode 100644 arch/mips/boston/Platform
 create mode 100644 arch/mips/boston/init.c
 create mode 100644 arch/mips/boston/int.c
 create mode 100644 arch/mips/boston/time.c
 create mode 100644 arch/mips/boston/vmlinux.its
 create mode 100644 arch/mips/configs/boston_defconfig
 create mode 100644 arch/mips/include/asm/mach-boston/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-boston/irq.h
 create mode 100644 arch/mips/include/asm/mach-boston/spaces.h
 create mode 100644 arch/mips/pci/pci-generic.c
 create mode 100644 arch/mips/pci/pci-legacy.c
 create mode 100644 drivers/auxdisplay/ascii-lcd.c

-- 
2.6.2

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
