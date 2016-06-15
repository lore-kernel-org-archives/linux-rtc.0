Return-Path: <rtc-linux+bncBDKOBWPM5ABRBYW5QO5QKGQEXQCD57Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id 62si3601890pfx.1.2016.06.14.23.00.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 23:00:02 -0700 (PDT)
Received: by mail-pa0-x242.google.com with SMTP id hf6so794121pac.2
        for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 23:00:02 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [rtc-linux] [PATCH 00/13] DS1341 support and code cleanup
Date: Tue, 14 Jun 2016 22:59:26 -0700
Message-Id: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi everyone,

This patch set contains code to add support for DS1341 variant of the
chip, as well as code to support enabling/disabling some of its power
savings features. Lastly the set contains a number of code cleanups
intended to improve the readability of driver's code.

Any feedback is appreciated!

Thank you,
Andrey Smirnov

Andrey Smirnov (13):
  RTC: ds1307: Add DS1341 variant
  RTC: ds1307: Disable square wave and timers as default
  RTC: ds1307: Add DS1341 specific power-saving options
  RTC: ds1307: Convert ds1307_can_wakeup_device into a predicate
  RTC: ds1307: Convert want_irq into a predicate
  RTC: ds1307: Move chip configuration into a separate routine
  RTC: ds1307: Move chip sanity checking into a separate routine
  RTC: ds1307: Remove register "cache"
  RTC: ds1307: Constify struct ds1307 where possible
  RTC: ds1307: Convert goto to a loop
  RTC: ds1307: Redefine RX8025_REG_* to minimize extra code
  RTC: ds1307: Report oscillator problems more intelligently
  RTC: ds1307: Move last bits of sanity checking out of chip_configure

 .../devicetree/bindings/rtc/dallas,ds1341.txt      |  23 +
 drivers/rtc/rtc-ds1307.c                           | 742 ++++++++++++---------
 2 files changed, 457 insertions(+), 308 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1341.txt

-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
