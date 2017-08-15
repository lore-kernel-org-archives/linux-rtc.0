Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbdHOIqE (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 15 Aug 2017 04:46:04 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
To: ldoktor@redhat.com, a.zummo@towertech.it,
        linuxppc-dev@lists.ozlabs.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com,
        linux-kselftest@vger.kernel.org, john.stultz@linaro.org,
        tglx@linutronix.de, shuah@kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 0/1] rtc: rtctest: Support opal-rtc and rtc-generic
Date: Tue, 15 Aug 2017 10:45:59 +0200
Message-Id: <20170815084600.6285-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On ppc64le machines the opal-rtc, resp rtc-generic in guest is used. They only
support minimal set of functionality and fail this test in not-yet treated
way. This extends the checks and skips to the next test when feature is not
supported.

Changes in v2:
- Removed the double EINVAL check
- Added missing space before "EIO" check.

Lukáš Doktor (1):
  rtc: rtctest: Improve support detection

 tools/testing/selftests/timers/rtctest.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.9.4
