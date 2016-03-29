Return-Path: <rtc-linux+bncBAABBIOO5C3QKGQENCBPNOI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si711326wmd.1.2016.03.28.23.56.32
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:32 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 0/8] rtc: m41t80: update and add functionalities
Date: Tue, 29 Mar 2016 08:55:57 +0200
Message-Id: <cover.1459188215.git.mylene.josserand@free-electrons.com>
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

This patchset updates the m41t80 driver :
  - update the sysfs entries export to use DEVICE_ATTR_XX
  - remove some unnecessary macro
  - replace old i2c functions to smbus ones
  - use BIT macro
  - remove some warnings
  - replace obsolete functions

It adds also some functionalities :
  - alarm IRQ which was previously removed because it was not working
  - wakealarm to use the RTC and set an alarm to wakeup the system
  - Oscillator failure to print an error if it is set
     =20
Myl=C3=A8ne Josserand (8):
  rtc: m41t80: update sysfs entries export
  rtc: m41t80: remove proc macro
  rtc: m41t80: replace i2c functions to smbus ones
  rtc: m41t80: add the use of 'BIT' macro
  rtc: m41t80: remove warnings and replace obsolete function
  rtc: m41t80: add alarm functionality
  rtc: m41t80: add wakealarm functionality
  rtc: m41t80: handle oscillator failure bit

 drivers/rtc/rtc-m41t80.c | 443 +++++++++++++++++++++++++++++++------------=
----
 1 file changed, 289 insertions(+), 154 deletions(-)

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
