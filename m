Return-Path: <rtc-linux+bncBCUZN4F4X4ARBDEL2LEAKGQEJ3KTI3Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com. [216.82.251.17])
        by gmr-mx.google.com with ESMTP id m67si94624pfm.0.2017.05.11.08.38.52
        for <rtc-linux@googlegroups.com>;
        Thu, 11 May 2017 08:38:52 -0700 (PDT)
From: Jose Diaz de Grenu de Pedro <Jose.DiazdeGrenu@digi.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>
CC: <rtc-linux@googlegroups.com>, <Jose.DiazdeGrenu@digi.com>,
	<trivial@kernel.org>
Subject: [rtc-linux] [PATCH] drivers: rtc-mxc: remove unused variable
Date: Thu, 11 May 2017 17:38:39 +0200
Message-ID: <1494517119-23622-1-git-send-email-Jose.DiazdeGrenu@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: "Diaz de Grenu, Jose" <Jose.DiazdeGrenu@digi.com>

This variable was never used. With GCC 6.2, we get the following warning:

drivers/rtc/rtc-mxc.c:44:18: warning: =E2=80=98PIE_BIT_DEF=E2=80=99 defined=
 but not used [-Wunused-const-variable=3D]
 static const u32 PIE_BIT_DEF[MAX_PIE_NUM][2] =3D {

Signed-off-by: Diaz de Grenu, Jose <Jose.DiazdeGrenu@digi.com>
---
 drivers/rtc/rtc-mxc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 77319122642a..401f46d8f21b 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -43,17 +43,6 @@
=20
 #define MAX_PIE_NUM     9
 #define MAX_PIE_FREQ    512
-static const u32 PIE_BIT_DEF[MAX_PIE_NUM][2] =3D {
-	{ 2,		RTC_2HZ_BIT },
-	{ 4,		RTC_SAM0_BIT },
-	{ 8,		RTC_SAM1_BIT },
-	{ 16,		RTC_SAM2_BIT },
-	{ 32,		RTC_SAM3_BIT },
-	{ 64,		RTC_SAM4_BIT },
-	{ 128,		RTC_SAM5_BIT },
-	{ 256,		RTC_SAM6_BIT },
-	{ MAX_PIE_FREQ,	RTC_SAM7_BIT },
-};
=20
 #define MXC_RTC_TIME	0
 #define MXC_RTC_ALARM	1

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
