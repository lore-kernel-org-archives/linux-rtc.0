Return-Path: <rtc-linux+bncBAABBAXLUG4QKGQED2VSOOA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a65si1433313wma.0.2016.05.03.02.55.13
        for <rtc-linux@googlegroups.com>;
        Tue, 03 May 2016 02:55:13 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH V3 6/7] rtc: rv3029: fix set_time function
Date: Tue,  3 May 2016 11:54:37 +0200
Message-Id: <2824c888ece3f99950adb38bfe18e7305bc5c410.1462268107.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1462268107.git.mylene.josserand@free-electrons.com>
References: <cover.1462268107.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1462268107.git.mylene.josserand@free-electrons.com>
References: <cover.1462268107.git.mylene.josserand@free-electrons.com>
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

The bin2bcd function in set_time is uncorrect on weekdays as the
bit mask should be done at the end of arithmetic operations.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-rv3029c2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 88a0c18..916bbc2 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -502,7 +502,7 @@ static int rv3029_set_time(struct device *dev, struct r=
tc_time *tm)
 	regs[RV3029_W_HOURS - RV3029_W_SEC] =3D bin2bcd(tm->tm_hour);
 	regs[RV3029_W_DATE - RV3029_W_SEC] =3D bin2bcd(tm->tm_mday);
 	regs[RV3029_W_MONTHS - RV3029_W_SEC] =3D bin2bcd(tm->tm_mon + 1);
-	regs[RV3029_W_DAYS - RV3029_W_SEC] =3D bin2bcd((tm->tm_wday & 7) + 1);
+	regs[RV3029_W_DAYS - RV3029_W_SEC] =3D bin2bcd(tm->tm_wday + 1) & 0x7;
 	regs[RV3029_W_YEARS - RV3029_W_SEC] =3D bin2bcd(tm->tm_year - 100);
=20
 	ret =3D rv3029_write_regs(dev, RV3029_W_SEC, regs,
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
