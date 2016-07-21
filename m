Return-Path: <rtc-linux+bncBDSJR27JS4DBB6WNYK6AKGQEZZNIOQQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from authsmtp.register.it (authsmtp91.register.it. [195.110.122.176])
        by gmr-mx.google.com with ESMTPS id i198si139430wmd.2.2016.07.21.03.42.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jul 2016 03:42:02 -0700 (PDT)
From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	=?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: [rtc-linux] [PATCH 2/6] rtc: rv8803: Remove the check for valid time
Date: Thu, 21 Jul 2016 12:41:28 +0200
Message-Id: <1469097692-103146-2-git-send-email-benoit@wsystem.com>
In-Reply-To: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
References: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
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

The RTC core always calls rtc_valid_tm() after ->read_time() in case of
success (in __rtc_read_time()), so do not call it twice.

Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
---
 drivers/rtc/rtc-rv8803.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 05c79c3..e740c83 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -150,7 +150,7 @@ static int rv8803_get_time(struct device *dev, struct r=
tc_time *tm)
 	tm->tm_mon  =3D bcd2bin(date[RV8803_MONTH] & 0x1f) - 1;
 	tm->tm_year =3D bcd2bin(date[RV8803_YEAR]) + 100;
=20
-	return rtc_valid_tm(tm);
+	return 0;
 }
=20
 static int rv8803_set_time(struct device *dev, struct rtc_time *tm)
--=20
2.5.0

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
