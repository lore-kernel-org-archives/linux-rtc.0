Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbdHKJPS (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 11 Aug 2017 05:15:18 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
To: ldoktor@redhat.com, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, john.stultz@linaro.org,
        tglx@linutronix.de, sboyd@codeaurora.org, shuah@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/1] rtc: rtctest: Support opal-rtc and rtc-generic
Date: Fri, 11 Aug 2017 11:14:54 +0200
Message-Id: <20170811091455.11041-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On ppc64le machines the opal-rtc, resp rtc-generic in guest is used. They only
support minimal set of functionality and fail this test in not-yet treated
way. This extends the checks and skips to the next test when feature is not
supported.

Lukáš Doktor (1):
  rtc: rtctest: Improve support detection

 tools/testing/selftests/timers/rtctest.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.9.4
