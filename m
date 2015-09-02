Return-Path: <rtc-linux+bncBCF4LM7M7AFBBG7OTKXQKGQESENPCMQ@googlegroups.com>
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com. [2a00:1450:400c:c05::22a])
        by gmr-mx.google.com with ESMTPS id et8si96637wib.2.2015.09.02.01.45.15
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2015 01:45:15 -0700 (PDT)
Received: by mail-wi0-x22a.google.com with SMTP id mc4so57788930wic.0
        for <rtc-linux@googlegroups.com>; Wed, 02 Sep 2015 01:45:15 -0700 (PDT)
From: Mike Rapoport <mike.rapoport@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Mike Rapoport <mike.rapoport@gmail.com>
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-ds1374.c: fix compilation warning
Date: Wed,  2 Sep 2015 11:45:10 +0300
Message-Id: <1441183510-5160-1-git-send-email-mike.rapoport@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

When CONFIG_RTC_DRV_DS1374_WDT is enabled, the compiler warns about unused
variable:

  CC      drivers/rtc/rtc-ds1374.o
drivers/rtc/rtc-ds1374.c: In function =E2=80=98ds1374_remove=E2=80=99:
drivers/rtc/rtc-ds1374.c:667:6: warning: unused variable =E2=80=98res=E2=80=
=99 [-Wunused-variable]
  int res;
      ^

Signed-off-by: Mike Rapoport <mike.rapoport@gmail.com>
---
 drivers/rtc/rtc-ds1374.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 7067232..3b3049c 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -664,8 +664,6 @@ static int ds1374_remove(struct i2c_client *client)
 {
 	struct ds1374 *ds1374 =3D i2c_get_clientdata(client);
 #ifdef CONFIG_RTC_DRV_DS1374_WDT
-	int res;
-
 	misc_deregister(&ds1374_miscdev);
 	ds1374_miscdev.parent =3D NULL;
 	unregister_reboot_notifier(&ds1374_wdt_notifier);
--=20
1.8.3.1

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
