Return-Path: <rtc-linux+bncBCEPJZEDQIBBBCM66C5QKGQE3422VEY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from rainbowdash.ducie.codethink.co.uk (82-70-136-246.dsl.in-addr.zen.co.uk. [82.70.136.246])
        by gmr-mx.google.com with ESMTPS id f138si243864wmf.3.2016.07.05.12.48.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jul 2016 12:48:25 -0700 (PDT)
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk,
	linux-amlogic@lists.infradead.org,
	rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	devicetree@vger.kernel.org,
	narmstrong@baylibre.com,
	frowand.list@gmail.com,
	kh@codethink.co.uk,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [rtc-linux] [PATCH v3 0/2] AMLogic Meson SoC RTC driver
Date: Tue,  5 Jul 2016 20:48:06 +0100
Message-Id: <1467748089-14718-1-git-send-email-ben.dooks@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This series adds support for the on SoC RTC driver on the
AMLogic Meson devices. The device-tree updates are not included
as they depend on the reset-controller support in -next.

The series does not have any build dependencies, but does require
the reset controller and device-tree entries for the relevant boards
and has been tested on the ODroid-C1 board.

Changes since V1:
  <1467039135-26588-1-git-send-email-ben.dooks@codethink.co.uk>

 - Fixed checkpatch and sparse errors
 - Fixed minor locking bug when writing static-control register
 - Updated the code ordering in the rtc-meson.c driver
 - Fixed alphanumeric ordering in on-cpu rtc block
 - Added Rob Hering's ack for the DT binding documentation
 - Added better description to the RTC driver header.

Ben Dooks (2):
  rtc: support for amlogic meson rtc
  meson-rtc: add device-tree binding

 .../devicetree/bindings/rtc/rtc-amlogic.txt        |  21 ++
 drivers/rtc/Kconfig                                |   9 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-meson.c                            | 349 +++++++++++++++++++++
 6 files changed, 392 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-amlogic.txt
 create mode 100644 drivers/rtc/rtc-meson.c

-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
