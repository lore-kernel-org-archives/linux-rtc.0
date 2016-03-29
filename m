Return-Path: <rtc-linux+bncBAABBJWO5C3QKGQEPEM3KHY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g81si668666wmi.3.2016.03.28.23.56.38
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:38 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 2/8] rtc: m41t80: remove proc macro
Date: Tue, 29 Mar 2016 08:55:59 +0200
Message-Id: <f6e2a40d92a66812c35add5ad24e9be9c936b0cb.1459233897.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1459188215.git.mylene.josserand@free-electrons.com>
References: <cover.1459188215.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1459233897.git.mylene.josserand@free-electrons.com>
References: <cover.1459233897.git.mylene.josserand@free-electrons.com>
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

Remove the CONFIG_RTC_INTF_PROC and CONFIG_RTC_INTF_PROC_MODULE macro
which is not necessary anymore.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 2721789..cc8b93d 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -192,7 +192,6 @@ static int m41t80_set_datetime(struct i2c_client *clien=
t, struct rtc_time *tm)
 	return 0;
 }
=20
-#if defined(CONFIG_RTC_INTF_PROC) || defined(CONFIG_RTC_INTF_PROC_MODULE)
 static int m41t80_rtc_proc(struct device *dev, struct seq_file *seq)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
@@ -206,9 +205,6 @@ static int m41t80_rtc_proc(struct device *dev, struct s=
eq_file *seq)
 	}
 	return 0;
 }
-#else
-#define m41t80_rtc_proc NULL
-#endif
=20
 static int m41t80_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
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
