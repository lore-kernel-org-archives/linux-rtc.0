Return-Path: <rtc-linux+bncBAABBUH34XCQKGQELW7SHSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id r66si55837pfb.7.2017.03.03.06.29.35
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 06:29:35 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 00/13] rtc: Add OF device table to I2C drivers
 that are missing it
Date: Fri,  3 Mar 2017 11:29:11 -0300
Message-Id: <20170303142925.17915-1-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello,

This series add OF device ID tables to RTC I2C drivers whose devices are
either used in Device Tree source files or are listed in binding docs as
a compatible string.

That's done because the plan is to change the I2C core to report proper OF
modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
a device was registered via DT or using the legacy platform data.

So these patches will make sure that RTC I2C drivers modules will continue
to be autoloaded once the I2C core is changed to report proper OF modalias.

Best regards,
Javier


Javier Martinez Canillas (13):
  rtc: rv8803: Add OF device ID table
  rtc: rv3029: Add OF device ID table
  rtc: bq32k: Add OF device ID table
  rtc: ds1307: Add OF device ID table
  rtc: rx8010: Add OF device ID table
  rtc: ds3232: Add OF device ID table
  rtc: rtc-ds1672: Add OF device ID table
  rtc: ds1374: Set .of_match_table to OF device ID table
  rtc: isl1208: Add OF device ID table
  rtc: s35390a: Add OF device ID table
  rtc: rx8581: Add OF device ID table
  rtc: m41t80: Add OF device ID table
  rtc: rs5c372: Add OF device ID table

 drivers/rtc/rtc-bq32k.c    |  7 +++++
 drivers/rtc/rtc-ds1307.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/rtc/rtc-ds1374.c   |  1 +
 drivers/rtc/rtc-ds1672.c   |  9 +++++-
 drivers/rtc/rtc-ds3232.c   |  7 +++++
 drivers/rtc/rtc-isl1208.c  | 12 ++++++--
 drivers/rtc/rtc-m41t80.c   | 63 ++++++++++++++++++++++++++++++++++++++++--
 drivers/rtc/rtc-rs5c372.c  | 37 ++++++++++++++++++++++++-
 drivers/rtc/rtc-rv3029c2.c |  9 ++++++
 drivers/rtc/rtc-rv8803.c   | 21 +++++++++++++-
 drivers/rtc/rtc-rx8010.c   |  7 +++++
 drivers/rtc/rtc-rx8581.c   |  7 +++++
 drivers/rtc/rtc-s35390a.c  |  8 ++++++
 13 files changed, 248 insertions(+), 8 deletions(-)

-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
