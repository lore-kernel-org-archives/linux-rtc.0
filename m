Return-Path: <rtc-linux+bncBC6YH6VTZQDRBCFIU3BAKGQEUQMJFDQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id l206si1367643wmf.2.2016.12.08.09.10.31
        for <rtc-linux@googlegroups.com>;
        Thu, 08 Dec 2016 09:10:31 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 0/3] rtc: armada38x: Few improvement and cleanup
Date: Thu,  8 Dec 2016 18:10:07 +0100
Message-Id: <20161208171010.29446-1-gregory.clement@free-electrons.com>
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

this series brings some improvement and cleanup for the armada 38x
RTC.

The errata for this RTC gave us more information on how to work around
it. The first patch implement it.

The second patch convert the driver to the time64_t usage.

And the last patch make the driver really usable on 64 bits
architecture.

These last two patches are a preliminary step allowing using this
driver on the Armada 7K/8K which are 64 bits ARM SoCs which use the
same RTC IP.

Thanks,

Gregory

Gregory CLEMENT (2):
  rtc: armada38x: Convert to time64_t
  rtc: armada38x: Prepare for being use on 64 bits

Shaker Daibes (1):
  rtc: armada38x: improve RTC errata implementation

 drivers/rtc/rtc-armada38x.c | 145 ++++++++++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 45 deletions(-)

-- 
2.10.2

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
