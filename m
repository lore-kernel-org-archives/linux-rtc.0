Return-Path: <rtc-linux+bncBCX3TTWUQMPRBXWMU24QKGQE2CAS3IA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id a65si257285wma.0.2016.05.04.00.35.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 May 2016 00:35:58 -0700 (PDT)
Date: Wed, 4 May 2016 09:35:55 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, 794266@bugs.debian.org
Subject: [rtc-linux] rtc-s35390a: the big mess or inconsistencies during startup
Message-ID: <20160504073555.GA29930@pengutronix.de>
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

Hello,

there was a bug reported against the Debian kernel that seems related to
the rtc-s35390a driver/chip. See https://bugs.debian.org/794266.

I looked a bit into the driver now, and there are several problems. As I
don't have access to such a chip I just want to tell what I found and
how I think it should be tackled.

 - The rtc-s35390a chip's alarm uses only minute, hour and dow.
   The .read_alarm callback (s35390a_read_alarm()) returns -EINVAL if
   the alarm is not enabled. I think it should just set alm->enabled =3D 0
   in this case. Further it only sets alm->time.tm_wday,
   alm->time.tm_hour and alm->time.tm_min which isn't handled in a sane
   way by __rtc_read_alarm. Maybe rtc_read_alarm_internal should better
   initialize all fields of alarm->time to -1 instead of 0?

 - During startup we saw:

 	[    2.257418] rtc rtc0: invalid alarm value: 1900-1-29 1193031:57:16

   I don't see how this big hour value can be found, looking at the
   driver it sets alm->time.tm_hour at most to

   	bcd2bin(reg & 0x3f) + 12

   where reg is a char. Then in __rtc_read_alarm we get into the missing
   =3D day case (because it doesn't handle an initialized wday).
   So it must be rtc_time64_to_tm that returns that big hour, probably
   because rtc_tm_to_time64(&alarm->time) is < 0 which rtc_time64_to_tm
   cannot handle?

So the action items are:

  - let rtc_read_alarm_internal initialize alarm->time to 9*{-1} (or fix
    s35390a_read_alarm to set the uninitialized values to -1).
  - let s35390a_read_alarm set alm->pending and alm->enabled.
  - teach __rtc_read_alarm to handle mday =3D -1 but wday >=3D 0.
  - tell hw-engineers not to use read-to-clear events (use a big clue
    stick).
  - debug rtc_tm_to_time64 + rtc_time64_to_tm for dates < 1970
    (or clamp t_alm in __rtc_read_alarm to >=3D 0?)

Any volunteers?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

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
