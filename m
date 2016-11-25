Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBB2ET4DAQKGQENNQDTUI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id l130si1088220wmf.2.2016.11.25.01.52.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2016 01:52:40 -0800 (PST)
From: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 0/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
Date: Fri, 25 Nov 2016 11:52:16 +0200
Message-Id: <1480067538-64415-1-git-send-email-vesa.jaaskelainen@vaisala.com>
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

Texas Instrument's TPS65910 has support for compensating RTC crystal
inaccuracies. When enabled every hour RTC counter value will be compensated
with two's complement value.

Vesa J=C3=A4=C3=A4skel=C3=A4inen (2):
  drivers: rtc: rtc-tps65910: Add RTC calibration support
  drivers: rtc: rtc-tps65910: use 'unsigned int' instead of 'unsigned'
    in arguments

 .../ABI/testing/sysfs-bus-i2c-devices-tps65910-rtc |   9 ++
 MAINTAINERS                                        |   1 +
 drivers/rtc/rtc-tps65910.c                         | 123 +++++++++++++++++=
+++-
 include/linux/mfd/tps65910.h                       |   1 +
 4 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-tps6591=
0-rtc

--=20
2.1.4

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
