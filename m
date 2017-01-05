Return-Path: <rtc-linux+bncBDBMPSMMRELRBAURXLBQKGQE3MUAJQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id z62si18730168pfz.1.2017.01.05.09.19.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2017 09:19:19 -0800 (PST)
Received: by mail-pf0-x244.google.com with SMTP id b22so2357537pfd.3
        for <rtc-linux@googlegroups.com>; Thu, 05 Jan 2017 09:19:19 -0800 (PST)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	adi-buildroot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: add const to rtc_class_ops structures
Date: Thu,  5 Jan 2017 22:48:37 +0530
Message-Id: <1483636717-30429-1-git-send-email-bhumirks@gmail.com>
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

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Compilation was terminated while compiling the .o files for all the 
changed .c files. Therefore file size details of the .o files 
could not be obtained.

 drivers/rtc/rtc-au1xxx.c | 2 +-
 drivers/rtc/rtc-bfin.c   | 2 +-
 drivers/rtc/rtc-ls1x.c   | 2 +-
 drivers/rtc/rtc-sh.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
index 84d6e02..2ba44cc 100644
--- a/drivers/rtc/rtc-au1xxx.c
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -56,7 +56,7 @@ static int au1xtoy_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static struct rtc_class_ops au1xtoy_rtc_ops = {
+static const struct rtc_class_ops au1xtoy_rtc_ops = {
 	.read_time	= au1xtoy_rtc_read_time,
 	.set_time	= au1xtoy_rtc_set_time,
 };
diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
index 535a5f9..15344b7 100644
--- a/drivers/rtc/rtc-bfin.c
+++ b/drivers/rtc/rtc-bfin.c
@@ -333,7 +333,7 @@ static int bfin_rtc_proc(struct device *dev, struct seq_file *seq)
 #undef yesno
 }
 
-static struct rtc_class_ops bfin_rtc_ops = {
+static const struct rtc_class_ops bfin_rtc_ops = {
 	.read_time     = bfin_rtc_read_time,
 	.set_time      = bfin_rtc_set_time,
 	.read_alarm    = bfin_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index 22a9ec4..e04ca54 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -138,7 +138,7 @@ static int ls1x_rtc_set_time(struct device *dev, struct  rtc_time *rtm)
 	return ret;
 }
 
-static struct rtc_class_ops  ls1x_rtc_ops = {
+static const struct rtc_class_ops  ls1x_rtc_ops = {
 	.read_time	= ls1x_rtc_read_time,
 	.set_time	= ls1x_rtc_set_time,
 };
diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 17b6235..c626e43 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -535,7 +535,7 @@ static int sh_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	return 0;
 }
 
-static struct rtc_class_ops sh_rtc_ops = {
+static const struct rtc_class_ops sh_rtc_ops = {
 	.read_time	= sh_rtc_read_time,
 	.set_time	= sh_rtc_set_time,
 	.read_alarm	= sh_rtc_read_alarm,
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
