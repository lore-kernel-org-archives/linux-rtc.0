Return-Path: <rtc-linux+bncBDKNBMNKRMJRBNVWT3FAKGQEVWGD7UI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x236.google.com (mail-wr0-x236.google.com. [2a00:1450:400c:c0c::236])
        by gmr-mx.google.com with ESMTPS id o27si1991060wmi.4.2017.06.19.02.36.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 02:36:54 -0700 (PDT)
Received: by mail-wr0-x236.google.com with SMTP id y25so29203481wrd.2
        for <rtc-linux@googlegroups.com>; Mon, 19 Jun 2017 02:36:54 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v2 0/3] rtc: make st-lpc robust against y2038/2106 bug
Date: Mon, 19 Jun 2017 11:36:19 +0200
Message-Id: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 32bits platforms "struct timeval" or "time_t" are using u32 to code the
date, this cause tools like "date" or "hwclock" failed even before setting
the RTC device if the date is superior to year 2038 (or 2106).

To avoid this problem I add one RTC test file which directly use RTC ioctl
to set and read RTC time and alarm values.
rtctest_setdate allow to set any date/time given in the command line.

On this version 2 I add check of problematics years in rtctest like suggest
by Alexandre.

Finally that had allowed me to test and fix rtc-st-lpc driver.

Benjamin Gaignard (3):
  tools: timer: add rtctest_setdate
  tool: timer: rtctest add check for problematic dates
  rtc: st-lpc: make it robust against y2038/2106 bug

 drivers/rtc/rtc-st-lpc.c                         |  19 ++--
 tools/testing/selftests/timers/Makefile          |   2 +-
 tools/testing/selftests/timers/rtctest.c         | 121 ++++++++++++++++++++++-
 tools/testing/selftests/timers/rtctest_setdate.c |  86 ++++++++++++++++
 4 files changed, 212 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c

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
