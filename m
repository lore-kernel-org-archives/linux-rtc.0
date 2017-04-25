Return-Path: <rtc-linux+bncBCL5RYHM6ECRBBGC7XDQKGQEBXV54IQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com. [2a00:1450:400c:c09::229])
        by gmr-mx.google.com with ESMTPS id h203si869137wmf.1.2017.04.25.07.45.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 07:45:24 -0700 (PDT)
Received: by mail-wm0-x229.google.com with SMTP id w64so24947800wma.0
        for <rtc-linux@googlegroups.com>; Tue, 25 Apr 2017 07:45:24 -0700 (PDT)
From: Gary Bisson <gary.bisson@boundarydevices.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	Gary Bisson <gary.bisson@boundarydevices.com>
Subject: [rtc-linux] [PATCH 0/4] rtc: m41t80: improve SQW support
Date: Tue, 25 Apr 2017 16:45:13 +0200
Message-Id: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

This series aims at improving the square-wave support for some of the
devices supported by the m41t80 driver.

The first two patches are fixes that prevent the driver from overriding
the SQW configuration (divider & enable bit).

Then the last two remove the old sysfs entry and replace it with a clock
provider approach.

It has been tested on a Boundary Devices Nitrogen6_MAX which features a
MicroCrystal RV4162 RTC. The SQW (named clkout in RV4162 datasheet) can be
probed on TP70 on the platform.

Let me know if you have any question/suggestion.

Regards,
Gary

Gary Bisson (4):
  rtc: m41t80: fix SQWE override when setting an alarm
  rtc: m41t80: fix SQW dividers override when setting a date
  rtc: m41t80: remove sqw sysfs entry
  rtc: m41t80: add clock provider support

 drivers/rtc/rtc-m41t80.c | 251 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 175 insertions(+), 76 deletions(-)

-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
