Return-Path: <rtc-linux+bncBAABB4PLT65QKGQEOPOYPQQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [2a01:4f8:d12:1f44::2])
        by gmr-mx.google.com with ESMTPS id f70si432022wmf.0.2016.06.20.06.56.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2016 06:56:00 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	=?UTF-8?q?Manuel=20R=C3=B6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] [PATCH 0/5] rtc: s35390a: allow shutdown on NAS after
 alarm triggered
Date: Mon, 20 Jun 2016 15:55:48 +0200
Message-Id: <1466430953-18659-1-git-send-email-uwe@kleine-koenig.org>
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

this series addresses the issued reported at https://bugs.debian.org/794266=
.

The problem at hand is that some qnap NAS devices can wake up on rtc
alarm and the s35390a driver didn't handle the particularities of the
rtc: When an irq is pending the irq line is pulled low and the INT2 bit
in a status register is set. Unfortunately this INT2 is cleared when the
status register is read, but the irq line isn't deasserted at the same
time. (No cookie for the hardware engineer!)

So the driver (which doesn't pay attention at the first read of the
status register) cannot notice that the irq is pending and so doesn't
disable it which makes the NAS wake up instantly after shutdown.

Among other fixes this series makes the driver aware on the first read
of the status register to check for the INT2 flag and handle
accordingly. Note that this means that if the RTC is already in the
state that the irq is active but the status register was already read,
this is still not noticed (because that's impossible AFAIK). But it
should make it harder to enter this state.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (5):
  rtc: s35390a: fix reading out alarm
  rtc: s35390a: implement reset routine as suggested by the reference
  rtc: s35390a: improve irq handling
  rtc: s35390a: improve two comments in .set_alarm
  rtc: fix a typo and reduce three empty lines to one

 drivers/rtc/interface.c   |   4 +-
 drivers/rtc/rtc-s35390a.c | 149 ++++++++++++++++++++++++++++++++++--------=
----
 2 files changed, 112 insertions(+), 41 deletions(-)

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
