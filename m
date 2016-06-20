Return-Path: <rtc-linux+bncBCU67L5YYYNRBGFJUC5QKGQE6B5V5UA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0141.outbound.protection.outlook.com. [65.55.169.141])
        by gmr-mx.google.com with ESMTPS id h76si708491ywc.7.2016.06.20.09.06.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jun 2016 09:06:46 -0700 (PDT)
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo
	<a.zummo@towertech.it>, Joe Lawrence <joe.lawrence@stratus.com>
From: Joe Lawrence <joe.lawrence@stratus.com>
Subject: [rtc-linux] __rtc_read_alarm missing month/year field bug?
Message-ID: <5768148E.8090304@stratus.com>
Date: Mon, 20 Jun 2016 12:06:38 -0400
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

Hello Alessandro and Alexandre,

I noticed an interesting cmos_rtc.rtc.aie_timer on a Stratus machine
running the 4.6 kernel, with an expiration time that puts the alarm way
out into next year.  This is easily reproducible on this machine by
setting a wakealarm sometime in the near future, then rebooting.

>From a fresh boot:

  % cat /proc/driver/rtc
  rtc_time        : 17:55:10
  rtc_date        : 2016-06-09
  alrm_time       : 14:04:37
  alrm_date       : 2017-06-09         << 2017 ?
  alarm_IRQ       : no
  alrm_pending    : no
  update IRQ enabled      : no
  periodic IRQ enabled    : no
  periodic IRQ frequency  : 1024
  max user IRQ frequency  : 64
  24hr            : yes
  periodic_IRQ    : no
  update_IRQ      : no
  HPET_emulated   : yes
  BCD             : yes
  DST_enable      : no
  periodic_freq   : 1024
  batt_status     : okay


I added some debugging code to the kernel, saw this on the next boot:

  __rtc_read_alarm: A - alarm->time.tm_year = -1, missing = 0
  __rtc_read_alarm: B - alarm->time.tm_year = 116, missing = 3
  __rtc_read_alarm: C - alarm->time.tm_year = 117


Corresponding to these parts of __rtc_read_alarm:

  int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
  ...
  	enum { none, day, month, year } missing = none;
  ...
  		err = rtc_read_alarm_internal(rtc, alarm);
  ...
  	/* Fill in the missing alarm fields using the timestamp; we
  	 * know there's at least one since alarm->time is invalid.
  	 */
  ...
  [A]
  	if (alarm->time.tm_year == -1) {
  		alarm->time.tm_year = now.tm_year;
  		if (missing == none)
  			missing = year;
  	}
  [B]
  ...
  	switch (missing) {
  ...
  	/* Year rollover ... easy except for leap years! */
  	case year:
  		dev_dbg(&rtc->dev, "alarm rollover: %s\n", "year");
  		do {
  			alarm->time.tm_year++;
  		} while (!is_leap_year(alarm->time.tm_year + 1900)
  			&& rtc_valid_tm(&alarm->time) != 0);
  [C]		break;


I noticed that the missing year and month cases increment their
respective time units inside a do ... while (condition) loop, pushing
the default 'filled-in' values to now + 1.

Should this 'roll-over' code check for a valid date before incrementing
the alarm time?  (See attached patch.)  I think this might also apply to
a missing month field as well.

(After the patch + reboot):

  % cat /proc/driver/rtc
  rtc_time        : 18:24:02
  rtc_date        : 2016-06-09
  alrm_time       : 14:04:37
  alrm_date       : 2016-06-09
  alarm_IRQ       : no
  alrm_pending    : no
  update IRQ enabled      : no
  periodic IRQ enabled    : no
  periodic IRQ frequency  : 1024
  max user IRQ frequency  : 64
  24hr            : yes
  periodic_IRQ    : no
  update_IRQ      : no
  HPET_emulated   : yes
  BCD             : yes
  DST_enable      : no
  periodic_freq   : 1024
  batt_status     : okay

-- >8 --

>From d6feacf20b312c8ebfee902b8b84f68c1a82f035 Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@stratus.com>
Date: Thu, 9 Jun 2016 14:52:28 -0400
Subject: [PATCH] rtc: check filled-in alarm values before incrementing

In __rtc_read_alarm, check filled-in alarm->time.tm_year values (those
not returned by the RTC and defaulted to now.tm_year) before
incrementing them in the rollover handling case.

Signed-off-by: Joe Lawrence <joe.lawrence@stratus.com>
---
 drivers/rtc/interface.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 9ef5f6f89f98..3098ce4167ef 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -258,10 +258,10 @@ int __rtc_read_alarm(struct rtc_device *rtc,
struct rtc_wkalrm *alarm)
 	/* Year rollover ... easy except for leap years! */
 	case year:
 		dev_dbg(&rtc->dev, "alarm rollover: %s\n", "year");
-		do {
+		while (!is_leap_year(alarm->time.tm_year + 1900)
+			&& rtc_valid_tm(&alarm->time) != 0) {
 			alarm->time.tm_year++;
-		} while (!is_leap_year(alarm->time.tm_year + 1900)
-			&& rtc_valid_tm(&alarm->time) != 0);
+		}
 		break;

 	default:
-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
