Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33600 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeAKXA1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 11 Jan 2018 18:00:27 -0500
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] Documentation: rtc: move sysfs documentation to ABI
Date: Fri, 12 Jan 2018 00:00:21 +0100
Message-Id: <20180111230021.11470-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The sysfs documentation should be located under Documentation/ABI.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/ABI/testing/sysfs-class-rtc | 90 +++++++++++++++++++++++++++++++
 Documentation/rtc.txt                     | 32 -----------
 2 files changed, 90 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-rtc

diff --git a/Documentation/ABI/testing/sysfs-class-rtc b/Documentation/ABI/testing/sysfs-class-rtc
new file mode 100644
index 000000000000..7bbfa59a1a7e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-rtc
@@ -0,0 +1,90 @@
+What:		/sys/class/rtc/
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		The rtc/ class subdirectory belongs to the RTC subsystem.
+
+What:		/sys/class/rtc/rtcX/
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		The /sys/class/rtc/rtc{0,1,2,3,...} directories correspond
+		to each RTC device.
+
+What:		/sys/class/rtc/rtcX/date
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		RTC-provided date in YYYY-MM-DD format
+
+What:		/sys/class/rtc/rtcX/hctosys
+Date:		September 2009
+KernelVersion:	2.6.32
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		1 if the RTC provided the system time at boot via the
+		CONFIG_RTC_HCTOSYS kernel option, 0 otherwise
+
+What:		/sys/class/rtc/rtcX/max_user_freq
+Date:		October 2007
+KernelVersion:	2.6.24
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		The maximum interrupt rate an unprivileged user may request
+		from this RTC.
+
+What:		/sys/class/rtc/rtcX/name
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		The name of the RTC corresponding to this sysfs directory
+
+What:		/sys/class/rtc/rtcX/since_epoch
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		RTC-provided time as the number of seconds since the epoch
+
+What:		/sys/class/rtc/rtcX/time
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		RTC-provided time in 24-hour notation (hh:mm:ss)
+
+What:		/sys/class/rtc/rtcX/*/nvmem
+Date:		February 2016
+KernelVersion:	4.6
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		The non volatile storage exported as a raw file, as described in
+		Documentation/nvmem/nvmem.txt
+
+What:		/sys/class/rtc/rtcX/offset
+Date:		February 2016
+KernelVersion:	4.6
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		The amount which the rtc clock has been adjusted in firmware.
+		Visible only if the driver supports clock offset adjustment.
+		The unit is parts per billion, i.e. The number of clock ticks
+		which are added to or removed from the rtc's base clock per
+		billion ticks. A positive value makes a day pass more slowly,
+		longer, and a negative value makes a day pass more quickly.
+
+What:		/sys/class/rtc/rtcX/wakealarm
+Date:		February 2007
+KernelVersion:	2.6.20
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		The time at which the clock will generate a system wakeup event.
+		This is a one shot wakeup event, so must be reset after wake if
+		a daily wakeup is required. Format is seconds since the epoch by
+		default, or if there's a leading +, seconds in the future, or if
+		there is a leading +=, seconds ahead of the current alarm.
+
diff --git a/Documentation/rtc.txt b/Documentation/rtc.txt
index c0c977445fb9..f521262cdc85 100644
--- a/Documentation/rtc.txt
+++ b/Documentation/rtc.txt
@@ -136,38 +136,6 @@ a high functionality RTC is integrated into the SOC.  That system might read
 the system clock from the discrete RTC, but use the integrated one for all
 other tasks, because of its greater functionality.
 
-SYSFS interface
----------------
-
-The sysfs interface under /sys/class/rtc/rtcN provides access to various
-rtc attributes without requiring the use of ioctls. All dates and times
-are in the RTC's timezone, rather than in system time.
-
-================ ==============================================================
-date  	   	 RTC-provided date
-hctosys   	 1 if the RTC provided the system time at boot via the
-		 CONFIG_RTC_HCTOSYS kernel option, 0 otherwise
-max_user_freq	 The maximum interrupt rate an unprivileged user may request
-		 from this RTC.
-name		 The name of the RTC corresponding to this sysfs directory
-since_epoch	 The number of seconds since the epoch according to the RTC
-time		 RTC-provided time
-wakealarm	 The time at which the clock will generate a system wakeup
-		 event. This is a one shot wakeup event, so must be reset
-		 after wake if a daily wakeup is required. Format is seconds
-		 since the epoch by default, or if there's a leading +, seconds
-		 in the future, or if there is a leading +=, seconds ahead of
-		 the current alarm.
-offset		 The amount which the rtc clock has been adjusted in firmware.
-		 Visible only if the driver supports clock offset adjustment.
-		 The unit is parts per billion, i.e. The number of clock ticks
-		 which are added to or removed from the rtc's base clock per
-		 billion ticks. A positive value makes a day pass more slowly,
-		 longer, and a negative value makes a day pass more quickly.
-*/nvmem		 The non volatile storage exported as a raw file, as described
-		 in Documentation/nvmem/nvmem.txt
-================ ==============================================================
-
 IOCTL interface
 ---------------
 
-- 
2.15.1
