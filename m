Return-Path: <rtc-linux+bncBDS7HNEFSALRB5N25WUAKGQEQGX3OCY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p4si888716wiz.0.2015.03.31.19.52.37
        for <rtc-linux@googlegroups.com>;
        Tue, 31 Mar 2015 19:52:37 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Philippe De Muyter <phdm@macqel.be>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 0/2] rtc: add Abracon ABx80x
Date: Wed,  1 Apr 2015 04:52:21 +0200
Message-Id: <1427856743-26625-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

As discussed, I reworked the abracon abx80x driver, merging Philippe's and mine.

I have added the Device Tree properties to enable the trickle charger and the
driver will detect the partnumber before doing that so that it won't try to
enable the charger when it is not available.

Andrew, when taking this series, you can drop:
rtc-add-rtc-abx805-a-driver-for-the-abracon-ab-1805-i2c-rtc.patch
rtc-add-abracon-abx80x-driver.patch
rtc-add-abracon-abx80x-driver-fix.patch

Changes in v2:
 - corrected MODULE_LICENSE
 - enforce ABX8XX_CTRL_WRITE at probe time instead of at write time
 - changed the range of supported dates to be 2000-2099
 - reworked the write function to be clearer

Alexandre Belloni (1):
  Documentation: bindings: add abracon,abx80x

Philippe De Muyter (1):
  rtc: add rtc-abx80x, a driver for the Abracon AB x80x i2c rtc

 .../devicetree/bindings/rtc/abracon,abx80x.txt     |  32 +++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-abx80x.c                           | 307 +++++++++++++++++++++
 4 files changed, 350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
 create mode 100644 drivers/rtc/rtc-abx80x.c

-- 
2.1.0

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
