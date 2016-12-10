Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBB4HRWHBAKGQE5JLCNQQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id d199si2178268wmd.1.2016.12.10.13.51.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Dec 2016 13:51:44 -0800 (PST)
From: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v2 0/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
Date: Sat, 10 Dec 2016 23:50:42 +0200
Message-Id: <1481406644-1614-1-git-send-email-vesa.jaaskelainen@vaisala.com>
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

 drivers/rtc/rtc-tps65910.c   | 135 +++++++++++++++++++++++++++++++++++++++=
+++-
 include/linux/mfd/tps65910.h |   1 +
 2 files changed, 135 insertions(+), 1 deletion(-)

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
