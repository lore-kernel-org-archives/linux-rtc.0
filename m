Return-Path: <rtc-linux+bncBCNNJWF7RUMRBH6M5CYQKGQEYX3HM2I@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com. [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id el2si190828pbb.0.2015.11.04.07.37.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:03 -0800 (PST)
Received: by mail-pa0-x22d.google.com with SMTP id z6so57706706pas.2
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:03 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 0/9] rtc-2123: access the clock offset feature
Date: Wed,  4 Nov 2015 07:36:31 -0800
Message-Id: <cover.1446587705.git.stillcompiling@gmail.com>
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

Greetings,
This series was prompted by a need to adjust the clock rate of the rtc
The existing code performs a soft reset during probe, which wipes out
several registers including the offset register, which performs adjustments
to the clock rate.

The first several patches are cleanup, with patch 5 and 6 avoiding the reset,
and patch 9 adding a nice sysfs interface to the clock offset.

I know that this is not the only rtc to provide a programmable clock offset
I wonder if this interface would make a good addition to the rtc api?

The rtc chips I have seen list their clock adjustments in parts per million.
I went with parts per billion, since the ppm listed was listed with a
fractional component.

Joshua Clayton (9):
  rtc-pcf2123: Document all registers and useful bits
  rtc-pcf2123: clean up reads from the chip
  rtc-pcf2123: clean up writes to the rtc chip
  rtc-pcf2123: replace magic numbers with defines
  rtc-pcf2123: put the chip reset into a function
  rtc-pcf2123: avoid resetting the clock if possible
  rtc-pcf2123: allow sysfs to accept hexidecimal
  rtc-pcf2123: use sysfs groups
  rtc-pcf2123: adjust the clock rate via sysfs

 drivers/rtc/rtc-pcf2123.c | 391 ++++++++++++++++++++++++++++++----------------
 1 file changed, 257 insertions(+), 134 deletions(-)

-- 
2.5.0

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
