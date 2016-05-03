Return-Path: <rtc-linux+bncBAABB6XKUG4QKGQECIAWHIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e78si107611wmc.3.2016.05.03.02.55.06
        for <rtc-linux@googlegroups.com>;
        Tue, 03 May 2016 02:55:06 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH V3 0/7] add support for Microcrystal RV-3049
Date: Tue,  3 May 2016 11:54:31 +0200
Message-Id: <cover.1462268107.git.mylene.josserand@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The current patchset adds the support of the microcrystal RV-3049 (spi).
This RTC will use the same driver than RV-3029 by updating it to use regmap=
.
It also adds the alarm IRQ functionality.

V3:
 - Create a patch to fix bit mask on bin2bcd for set_time function

V2 :
 - Add some checks removal from checkpatch
 - Fix the alarm support with a wrong use of bit mask on bin2bcd

Myl=C3=A8ne Josserand (7):
  rtc: rv3029: remove 'i2c' in functions names
  rtc: rv3029: convert to use regmap
  rtc: rv3029: Add support of RV3049
  rtc: rv3029: Remove some checks and warnings
  rtc: rv3029: fix alarm support
  rtc: rv3029: fix set_time function
  rtc: rv3029: add alarm IRQ

 drivers/rtc/Kconfig        |  37 +--
 drivers/rtc/rtc-rv3029c2.c | 582 +++++++++++++++++++++++++++++------------=
----
 2 files changed, 397 insertions(+), 222 deletions(-)

--=20
2.8.0.rc3

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
