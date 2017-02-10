Return-Path: <rtc-linux+bncBDM47J4M6QEBBFEF7DCAKGQECV3VMPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id f7si461708pfk.5.2017.02.10.10.12.35
        for <rtc-linux@googlegroups.com>;
        Fri, 10 Feb 2017 10:12:36 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [rtc-linux] [PATCH 0/3] rtc: m48t86: cleanup driver and add NVRAM support
Date: Fri, 10 Feb 2017 11:11:54 -0700
Message-Id: <20170210181157.6283-1-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This rtc driver is currently only used by the Technologic Systems TS-72xx
(arm/mach-ep93xx) and TS-78xx (arm/mach-orion5x) SBCs. These platforms use
static I/O mappings for the registers needed to access the index and data
registers of the chip.

On the TS-78xx there is one I/O mapping of SZ_1M for the entire FPGA address
space. The rtc index and data registers are located in that space along with
all the other FPGA devices.

On the TS-72xx the mapping is a bit uglier. That platform uses a CPLD to
access the rtc. The CPLD is connected to two chip select lines of the
processor and each chip select addresses 256 MiB. Address lines 25-22 and 0
are then decoded for the various devices. Since mapping the entire 256 MiB
for each address space would be _really_ ugly, a SZ_4K mapping is done for
each register that is needed.

This series does the following:
 1) Cleanup this driver to remove all the checkpatch.pl issues.
 2) Modify the probe to, optionally, ioremap the resources provided by the
    platform and handle the read/write operations internally.
 3) Add support for the NVRAM in the rtc.

With these changes the static I/O mappings for the rtc registers can be
removed from the ts-72xx platform.

Currently the ts78xx platform does some "probing" of the rtc NVRAM to see
if it is actually present before registering the rtc device. This "probing"
just checks if the NVRAM is present by reading/writing the last two bytes
of the NVRAM. I'm not sure if this is really necessary. If it can be removed
all the m48t86_ops stuff could also be removed from this driver, along with
platform_data/rtc-m48t86.h.

H Hartley Sweeten (3):
  rtc: m48t86: shorten register name defines
  rtc: m48t86: allow driver to manage it's resources
  rtc: m48t86: add NVRAM support

 drivers/rtc/rtc-m48t86.c | 247 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 169 insertions(+), 78 deletions(-)

-- 
2.10.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
