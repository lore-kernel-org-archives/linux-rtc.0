Return-Path: <rtc-linux+bncBDKOBWPM5ABRBX6WUO5QKGQEGH2RKFA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id un17si5444521pab.0.2016.06.21.00.23.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:23:11 -0700 (PDT)
Received: by mail-pa0-x241.google.com with SMTP id fg1so738933pad.3
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:23:11 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 15/17] RTC: rtctest: Change alarm IRQ support detection
Date: Tue, 21 Jun 2016 00:22:48 -0700
Message-Id: <1466493770-11895-14-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

For old style drivers, call a call to ioctl(..., RTC_ALM_SET, ...):

    - char/ds1302.c will always return -EINVAL
    - char/genrtc.c: will always return -EINVAL
    - char/rtc.c will succeed regardless if IRQs are supported or not
    - char/efirtc.c will always return -EINVAL
    - input/misc/hp_sdc_rtc.c ... that ioctl code is a good lesson about
      ifdefing code out and punting implementation ... and it will
      always return -EINVAL

For new style rtc drivers, a call to ioctl(..., RTC_ALM_SET, ...) never
results in a call to __rtc_set_alarm, since struct rtc_wkalarm passed to
rtc_set_alarm has 'enabled' field set to 0. This means that
rtc->ops->set_alarm driver hook is never called in that ioctl. Since no
driver code interaction happens as a part of that call, using its
results to ascertain properties of the driver is not going to work. To
remedy this - use the result of RTC_AIE_ON to make the judgement.

This patch also changes ENOTTY to EINVAL as a error code value that
would tell us that IRQs are not supported. There are three reason for
this:

 - As mentioned above old style driver never retunr ENOTTY for this
   ioctl

 - In it's code __rtc_set_alarm() returns -EINVAL if rtc->ops->set_alarm
   method is not provided by the driver, so one reason for change is to
   be consistent with that code path.

 - A call to ioctl(..., RTC_UIE_ON, ...) will result in a call to
   rtc_update_irq_enable() and then __rtc_set_alarm(), which, if IRQs
   are not supported by the driver, will result in a non-zero error
   code. Returning ENOTTY in that case would:

   	 a) Not be consistent with other codepaths of
   	 rtc_update_irq_enable, for example the check of
   	 rtc->uie_unsupported

	 b) Would break update IRQ emulation code since that codpath
	 expects EINVAL

	 c) Would break test's logic for feature support detection in
	 the case of RTC_UIE_ON ioctl

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 tools/testing/selftests/timers/rtctest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
index 624bce5..0cb4628 100644
--- a/tools/testing/selftests/timers/rtctest.c
+++ b/tools/testing/selftests/timers/rtctest.c
@@ -144,11 +144,12 @@ test_READ:
 
 	retval = ioctl(fd, RTC_ALM_SET, &rtc_tm);
 	if (retval == -1) {
-		if (errno == ENOTTY) {
+		if (errno == EINVAL) {
 			fprintf(stderr,
 				"\n...Alarm IRQs not supported.\n");
 			goto test_PIE;
 		}
+
 		perror("RTC_ALM_SET ioctl");
 		exit(errno);
 	}
@@ -166,6 +167,12 @@ test_READ:
 	/* Enable alarm interrupts */
 	retval = ioctl(fd, RTC_AIE_ON, 0);
 	if (retval == -1) {
+		if (errno == EINVAL) {
+			fprintf(stderr,
+				"\n...Alarm IRQs not supported.\n");
+			goto test_PIE;
+		}
+
 		perror("RTC_AIE_ON ioctl");
 		exit(errno);
 	}
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
