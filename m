Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45837 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdFSOdO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 19 Jun 2017 10:33:14 -0400
Received: from localhost (80-110-36-81.static.upcbusiness.at [80.110.36.81])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8A60F212A3
        for <linux-rtc@vger.kernel.org>; Mon, 19 Jun 2017 16:33:10 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: john.stultz@linaro.org, tglx@linutronix.de, sboyd@codeaurora.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patrice.chotard@st.com,
        a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com
Cc: linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v2 0/3] rtc: make st-lpc robust against y2038/2106 bug
Date: Mon, 19 Jun 2017 11:36:19 +0200
Message-Id: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>
Message-ID: <20170619093619.9Kuny7Gu3RCZQPyMj4hh_3rZC0ebO1b4RhQbfq9WsKM@z>

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
