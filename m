Return-Path: <rtc-linux+bncBDM47J4M6QEBBIUHSLCQKGQEDJHYVTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id h130si317697pfe.1.2017.02.15.08.36.49
        for <rtc-linux@googlegroups.com>;
        Wed, 15 Feb 2017 08:36:50 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [rtc-linux] [PATCH 0/5] rtc: m48t86: remove need for platform_data
Date: Wed, 15 Feb 2017 09:35:22 -0700
Message-Id: <20170215163527.5697-1-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The rtc-m48t86 driver can now manage it's own resources for the index
and data registers.

  1) Add the RTC detection logic from the ts78xx platform to the driver
     and remove it from the platform code.
  2) Update the two platforms that use this driver to remove the need
     for the platform_data.
  3) Remove the, then unused, platform_data header and it's use in the
     driver.

H Hartley Sweeten (5):
  rtc: m48t86: verify that the RTC is actually present
  ARM: Orion5x: ts78xx: remove RTC detection
  ARM: Orion5x: ts78xx: allow rtc-m48t86 to manage it's own resources
  ARM: ep93xx: ts72xx: allow rtc-m48t86 to manage it's own resources
  rtc: m48t86: remove unused platform_data

 arch/arm/mach-ep93xx/ts72xx.c            | 40 ++++-----------
 arch/arm/mach-ep93xx/ts72xx.h            | 11 ----
 arch/arm/mach-orion5x/ts78xx-setup.c     | 80 +++++++----------------------
 drivers/rtc/rtc-m48t86.c                 | 87 ++++++++++++++++++++------------
 include/linux/platform_data/rtc-m48t86.h | 16 ------
 5 files changed, 84 insertions(+), 150 deletions(-)
 delete mode 100644 include/linux/platform_data/rtc-m48t86.h

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
