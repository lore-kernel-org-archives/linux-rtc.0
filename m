Return-Path: <rtc-linux+bncBAABBE53365QKGQEBYJNOUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id a186si35669wma.1.2016.07.02.08.28.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jul 2016 08:28:18 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	=?UTF-8?q?Manuel=20R=C3=B6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] [PATCH v2 0/5] rtc: s35390a: allow shutdown of NAS after
 alarm triggered
Date: Sat,  2 Jul 2016 17:28:07 +0200
Message-Id: <1467473292-26371-1-git-send-email-uwe@kleine-koenig.org>
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

this is v2 of the series fixing https://bugs.debian.org/794266.

The only change compared to (implicit) v1 is that reading out a disabled
alarm is fixed. When the alarm is disabled the respective register is
shadowed with the result is that the reported alarm time is 45:85:0
because both hour and minute byte are read as 0xff and bcd2bin(0x3f) and
bcd2bin(0x7f) are 45 and 85 respectively.

The new behaviour is to only set .enabled =3D 0 and return. Not 100% sure
this is the right thing, though. The only alternative is to enable alarm
and read out a time, but that might have the side effect to trigger an
unwanted alarm, so I didn't chose this way.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (5):
  rtc: s35390a: fix reading out alarm
  rtc: s35390a: implement reset routine as suggested by the reference
  rtc: s35390a: improve irq handling
  rtc: s35390a: improve two comments in .set_alarm
  rtc: fix a typo and reduce three empty lines to one

 drivers/rtc/interface.c   |   4 +-
 drivers/rtc/rtc-s35390a.c | 157 +++++++++++++++++++++++++++++++++++-------=
----
 2 files changed, 120 insertions(+), 41 deletions(-)

--=20
2.8.1

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
