Return-Path: <rtc-linux+bncBAABBS5GRW6AKGQEJJZTHUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id b77si342367wmb.1.2016.07.11.01.05.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2016 01:05:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ben Hutchings <benh@debian.org>,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 0/2] rtc: fix regressions of d68778b80dd7
Date: Mon, 11 Jul 2016 10:05:26 +0200
Message-Id: <1468224328-7391-1-git-send-email-uwe@kleine-koenig.org>
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

while applying d68778b80dd7 ("rtc: initialize output parameter for read
alarm to "uninitialized"") to the Debian kernel Ben Hutchings wondered
if there are drivers that rely on .tm_sec being initialized to 0.

I checked this now an found a few that do.

The hym8563 already used -1 explicitly, it is fixed in a separate patch.

Uwe Kleine-K=C3=B6nig (2):
  rtc: explicitly set tm_sec =3D 0 for drivers with minute accurancy
  rtc: hym8563: in .read_alarm set .tm_sec to 0 to signal minute
    accuracy

 drivers/rtc/rtc-da9052.c  | 1 +
 drivers/rtc/rtc-da9055.c  | 1 +
 drivers/rtc/rtc-davinci.c | 2 ++
 drivers/rtc/rtc-hym8563.c | 2 +-
 drivers/rtc/rtc-pcf8563.c | 1 +
 drivers/rtc/rtc-rc5t583.c | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)

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
