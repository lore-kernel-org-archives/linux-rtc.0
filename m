Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37819 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbdHKJPV (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 11 Aug 2017 05:15:21 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
To: ldoktor@redhat.com, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, john.stultz@linaro.org,
        tglx@linutronix.de, sboyd@codeaurora.org, shuah@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rtc: rtctest: Improve support detection
Date: Fri, 11 Aug 2017 11:14:55 +0200
Message-Id: <20170811091455.11041-2-ldoktor@redhat.com>
In-Reply-To: <20170811091455.11041-1-ldoktor@redhat.com>
References: <20170811091455.11041-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The rtc-generic and opal-rtc are failing to run this test as they do not
support all the features. Let's treat the error returns and skip to the
following test.

Theoretically the test_DATE should be also adjusted, but as it's enabled
on demand I think it makes sense to fail in such case.

Signed-off-by: Lukáš Doktor <ldoktor@redhat.com>
---
 tools/testing/selftests/timers/rtctest.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
index f61170f..6344842 100644
--- a/tools/testing/selftests/timers/rtctest.c
+++ b/tools/testing/selftests/timers/rtctest.c
@@ -125,7 +125,7 @@ int main(int argc, char **argv)
 	/* Turn on update interrupts (one per second) */
 	retval = ioctl(fd, RTC_UIE_ON, 0);
 	if (retval == -1) {
-		if (errno == EINVAL) {
+		if (errno == EINVAL || errno == EINVAL) {
 			fprintf(stderr,
 				"\n...Update IRQs not supported.\n");
 			goto test_READ;
@@ -221,6 +221,11 @@ int main(int argc, char **argv)
 	/* Read the current alarm settings */
 	retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
 	if (retval == -1) {
+		if (errno == EINVAL) {
+			fprintf(stderr,
+					"\n...EINVAL reading current alarm setting.\n");
+			goto test_PIE;
+		}
 		perror("RTC_ALM_READ ioctl");
 		exit(errno);
 	}
@@ -231,7 +236,7 @@ int main(int argc, char **argv)
 	/* Enable alarm interrupts */
 	retval = ioctl(fd, RTC_AIE_ON, 0);
 	if (retval == -1) {
-		if (errno == EINVAL) {
+		if (errno == EINVAL || errno ==EIO) {
 			fprintf(stderr,
 				"\n...Alarm IRQs not supported.\n");
 			goto test_PIE;
-- 
2.9.4
