Return-Path: <rtc-linux+bncBDKNBMNKRMJRBOFWT3FAKGQEHQEGPSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id j201si1975135wmg.5.2017.06.19.02.36.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 02:36:56 -0700 (PDT)
Received: by mail-wm0-x22c.google.com with SMTP id x70so73513965wme.0
        for <rtc-linux@googlegroups.com>; Mon, 19 Jun 2017 02:36:56 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: john.stultz@linaro.org,
	tglx@linutronix.de,
	sboyd@codeaurora.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	patrice.chotard@st.com,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com
Cc: linaro-kernel@lists.linaro.org,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [rtc-linux] [PATCH v2 1/3] tools: timer: add rtctest_setdate
Date: Mon, 19 Jun 2017 11:36:20 +0200
Message-Id: <1497864982-29284-2-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This tool allow to set directly the time and date to a RTC device.

Unlike other tools isn't doens't use "struct timeval" or "time_t"
so it is safe for 32bits platforms when testing for y2038/2106 bug.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 tools/testing/selftests/timers/Makefile          |  2 +-
 tools/testing/selftests/timers/rtctest_setdate.c | 86 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c

diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 5fa1d7e9..54481f1 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -9,7 +9,7 @@ TEST_GEN_PROGS = posix_timers nanosleep nsleep-lat set-timer-lat mqueue-lat \
 
 TEST_GEN_PROGS_EXTENDED = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 		      skew_consistency clocksource-switch leap-a-day \
-		      leapcrash set-tai set-2038 set-tz
+		      leapcrash set-tai set-2038 set-tz rtctest_setdate
 
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timers/rtctest_setdate.c b/tools/testing/selftests/timers/rtctest_setdate.c
new file mode 100644
index 0000000..2cb7848
--- /dev/null
+++ b/tools/testing/selftests/timers/rtctest_setdate.c
@@ -0,0 +1,86 @@
+/* Real Time Clock Driver Test
+ *	by: Benjamin Gaignard (benjamin.gaignard@linaro.org)
+ *
+ * To build
+ *	gcc rtctest_setdate.c -o rtctest_setdate
+ *
+ *   This program is free software: you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <stdio.h>
+#include <linux/rtc.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+
+static const char default_time[] = "00:00:00";
+
+int main(int argc, char **argv)
+{
+	int fd, retval;
+	struct rtc_time new, current;
+	const char *rtc, *date;
+	const char *time = default_time;
+
+	switch (argc) {
+	case 4:
+		time = argv[3];
+		/* FALLTHROUGH */
+	case 3:
+		date = argv[2];
+		rtc = argv[1];
+		break;
+	default:
+		fprintf(stderr, "usage: rtctest_setdate <rtcdev> <DD-MM-YYYY> [HH:MM:SS]\n");
+		return 1;
+	}
+
+	fd = open(rtc, O_RDONLY);
+	if (fd == -1) {
+		perror(rtc);
+		exit(errno);
+	}
+
+	sscanf(date, "%d-%d-%d", &new.tm_mday, &new.tm_mon, &new.tm_year);
+	new.tm_mon -= 1;
+	new.tm_year -= 1900;
+	sscanf(time, "%d:%d:%d", &new.tm_hour, &new.tm_min, &new.tm_sec);
+
+	fprintf(stderr, "Test will set RTC date/time to %d-%d-%d, %02d:%02d:%02d.\n",
+		new.tm_mday, new.tm_mon + 1, new.tm_year + 1900,
+		new.tm_hour, new.tm_min, new.tm_sec);
+
+	/* Write the new date in RTC */
+	retval = ioctl(fd, RTC_SET_TIME, &new);
+	if (retval == -1) {
+		perror("RTC_SET_TIME ioctl");
+		close(fd);
+		exit(errno);
+	}
+
+	/* Read back */
+	retval = ioctl(fd, RTC_RD_TIME, &current);
+	if (retval == -1) {
+		perror("RTC_RD_TIME ioctl");
+		exit(errno);
+	}
+
+	fprintf(stderr, "\n\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
+		current.tm_mday, current.tm_mon + 1, current.tm_year + 1900,
+		current.tm_hour, current.tm_min, current.tm_sec);
+
+	close(fd);
+	return 0;
+}
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
