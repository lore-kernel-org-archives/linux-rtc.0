Return-Path: <rtc-linux+bncBDBMPSMMRELRBAURXLBQKGQE3MUAJQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com. [2607:f8b0:400e:c05::242])
        by gmr-mx.google.com with ESMTPS id r8si18668634pfa.5.2017.01.05.08.55.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2017 08:55:24 -0800 (PST)
Received: by mail-pg0-x242.google.com with SMTP id g1so41218523pgn.0
        for <rtc-linux@googlegroups.com>; Thu, 05 Jan 2017 08:55:24 -0800 (PST)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: constify rtc_class_ops structures
Date: Thu,  5 Jan 2017 22:25:05 +0530
Message-Id: <1483635305-20423-1-git-send-email-bhumirks@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Declare rtc_class_ops structures as const as they are only passed
as an argument to the function devm_rtc_device_register. This argument
is of type const struct rtc_class_ops *, so rtc_class_ops structures
having this property can be declared const.
Done using Coccinelle:

@r1 disable optional_qualifier @
identifier i;
position p;
@@
static struct rtc_class_ops i@p = {...};

@ok1@
identifier r1.i;
position p;
@@
devm_rtc_device_register(...,&i@p,...)

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct rtc_class_ops i;

File size details:

   text	   data	    bss	    dec	    hex	filename
    559	    320	      0	    879	    36f	drivers/rtc/rtc-dm355evm.o
    671	    192	      0	    863	    35f	drivers/rtc/rtc-dm355evm.o

   4727	    320	      0	   5047	   13b7	drivers/rtc/rtc-imxdi.o
   4855	    192	      0	   5047	   13b7	drivers/rtc/rtc-imxdi.o

   1269     192       0    1461     5b5 drivers/rtc/rtc-mxc.o

File size remains unchanged for : drivers/rtc/rtc-mxc.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/rtc/rtc-dm355evm.c | 2 +-
 drivers/rtc/rtc-imxdi.c    | 2 +-
 drivers/rtc/rtc-mxc.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
index 94067f8..f225cd8 100644
--- a/drivers/rtc/rtc-dm355evm.c
+++ b/drivers/rtc/rtc-dm355evm.c
@@ -116,7 +116,7 @@ static int dm355evm_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static struct rtc_class_ops dm355evm_rtc_ops = {
+static const struct rtc_class_ops dm355evm_rtc_ops = {
 	.read_time	= dm355evm_rtc_read_time,
 	.set_time	= dm355evm_rtc_set_time,
 };
diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 67b56b8..71266ec 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -668,7 +668,7 @@ static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	return 0;
 }
 
-static struct rtc_class_ops dryice_rtc_ops = {
+static const struct rtc_class_ops dryice_rtc_ops = {
 	.read_time		= dryice_rtc_read_time,
 	.set_mmss		= dryice_rtc_set_mmss,
 	.alarm_irq_enable	= dryice_rtc_alarm_irq_enable,
diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 359876a..7731912 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -353,7 +353,7 @@ static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 }
 
 /* RTC layer */
-static struct rtc_class_ops mxc_rtc_ops = {
+static const struct rtc_class_ops mxc_rtc_ops = {
 	.release		= mxc_rtc_release,
 	.read_time		= mxc_rtc_read_time,
 	.set_mmss64		= mxc_rtc_set_mmss,
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
