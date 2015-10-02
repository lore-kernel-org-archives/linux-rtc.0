Return-Path: <rtc-linux+bncBAABBM4XXGYAKGQEN7NB3FI@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id ha7si53910wib.0.2015.10.02.02.17.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 02 Oct 2015 02:17:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v1 0/4] rtc: pcf2127: a fix, a cleanup and two
 questionable features
Date: Fri,  2 Oct 2015 11:17:18 +0200
Message-Id: <1443777442-15920-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello,

the fix and the cleanup should be fine. Patches 3 and 4 are probably
wrong (but still state of the art for other in-tree drivers) because
sysfs_create_file is called too late. See
http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
for some details.

I failed to find how to do it correctly though:
 - the attributes are device specific, so device_driver::groups is wrong
 - for using the i2c's device group it's too late in .probe
 - the rtc's device is only malloc'd in rtc_device_register and when
   this returns it's already too late again.
 - these are neither class nor bus attributes, so these are ruled out, too.

Uwe Kleine-K=C3=B6nig (4):
  rtc: pcf2127: fix reading uninitialized value on RTC_READ_VL ioctl
  rtc: pcf2127: remove useless driver version
  rtc: pcf2127: implement reading battery status bits
  rtc: pcf2127: implement access to nvram

 drivers/rtc/rtc-pcf2127.c | 285 ++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 261 insertions(+), 24 deletions(-)

--=20
2.6.0

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
