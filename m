Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807C442B08
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594312; cv=none; b=B7XNbcwXdLMlK/wi9ne0IQY07rDxg3mVYQpTmk2wvA8VYO6tggJDZT6phKDQj6cr51lx+L7m30yjSY+4v+n23FotstyYsxp5aNpN4MZFx6ryyqmXkdphNYYgwPObE3SaemTgNEk7r9ZTblwqLMnaVzJmrM2Za5o9rUT85tzSB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594312; c=relaxed/simple;
	bh=zH90TPfbc7bih59qo7NqLj1h+qIppWyv1O0y0D/3j0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAeKJ6NnQiS/WL1H2N13+IbaLB7rS06pFGKV1kBlpgLqqps3bpXQf2VWA7nkrCoYwsZ90MsK9+dLirG8M5cITSktcfgOWych/ZYzWc/7tmsVJerARn8U9EdLuUl91jKL3zTQatptPku4GCNeSteQgpos7j6s02BuPzNgvygEzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IJOK27uJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IJOK27uJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=waChKzokR8r35UkYP2HJSz7qwFtnyH8Dc+MEhpYMKDk=; b=IJOK27
	uJVQRR+jrkNKw4bJ/ZE19hLSUQMlP687iq1aKHoNDADlG/Zg/mO/70UJPyyCA6bq
	NgMkolEimB6G7CvTEqz6R3rYWsQ0YjgcxBgm77dwUs/m96X44dGIQevnkw88Kslb
	fXuht+SrvDjLK6GsyvlijtnUUsgfDDtUu7GyTG9TE5xZjNa0lo6iISeKe317U7YD
	gxW4ANnjC5hZHs/Mt35ooL/p8U/OJGBTxRkKEVOW9sPehc7Kis/jkPNeH/dTlPQa
	qaEFISfUwVhygWUImMYl4MGo22k3sEIPiqyZiOsLEeVs/7WDfqqyeUnG6Aot7WbU
	o26IuDaXBAkKWtoA==
Received: (qmail 1715344 invoked from network); 16 Sep 2026 23:31:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 23:31:40 +0200
X-UD-Smtp-Session: l3s3148p1@Cm6KZKBb2sQujnt4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-rtc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] selftest: rtc: rtctest: don't mention skipping twice
Date: Wed, 16 Sep 2026 23:31:09 +0200
Message-ID: <20260916213108.9234-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
References: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The framework already annotates that we are skipping something. No need
to do in the tests themselves again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/testing/selftests/rtc/rtctest.c | 31 +++++++++++++--------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 8047d9879039..077cdc2c6f87 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -49,7 +49,7 @@ TEST_F(rtc, date_read) {
 	struct rtc_time rtc_tm;
 
 	if (self->fd == -1 && errno == ENOENT)
-		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+		SKIP(return, "%s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
 	/* Read the RTC time/date */
@@ -118,7 +118,7 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
 	time_t start_rtc_read, prev_rtc_read;
 
 	if (self->fd == -1 && errno == ENOENT)
-		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+		SKIP(return, "%s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
 	TH_LOG("Continuously reading RTC time for %ds (with %dms breaks after every read).",
@@ -156,7 +156,7 @@ TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
 	unsigned long data;
 
 	if (self->fd == -1 && errno == ENOENT)
-		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+		SKIP(return, "%s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
 	/* Turn on update interrupts */
@@ -185,7 +185,7 @@ TEST_F(rtc, uie_select) {
 	unsigned long data;
 
 	if (self->fd == -1 && errno == ENOENT)
-		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+		SKIP(return, "%s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
 	/* Turn on update interrupts */
@@ -229,14 +229,14 @@ TEST_F(rtc, alarm_alm_set) {
 	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
 
 	if (self->fd == -1 && errno == ENOENT)
-		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+		SKIP(return, "%s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
 	alarm_state = get_rtc_alarm_state(self->fd, 1);
 	if (alarm_state == RTC_ALARM_DISABLED)
-		SKIP(return, "Skipping test since alarms are not supported.");
+		SKIP(return, "alarms are not supported.");
 	if (alarm_state == RTC_ALARM_RES_MINUTE)
-		SKIP(return, "Skipping test since alarms has only minute granularity.");
+		SKIP(return, "alarms has only minute granularity.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
@@ -299,14 +299,14 @@ TEST_F(rtc, alarm_wkalm_set) {
 	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
 
 	if (self->fd == -1 && errno == ENOENT)
-		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+		SKIP(return, "%s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
 	alarm_state = get_rtc_alarm_state(self->fd, 1);
 	if (alarm_state == RTC_ALARM_DISABLED)
-		SKIP(return, "Skipping test since alarms are not supported.");
+		SKIP(return, "alarms are not supported.");
 	if (alarm_state == RTC_ALARM_RES_MINUTE)
-		SKIP(return, "Skipping test since alarms has only minute granularity.");
+		SKIP(return, "alarms has only minute granularity.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
@@ -363,12 +363,12 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
 
 	if (self->fd == -1 && errno == ENOENT)
-		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+		SKIP(return, "%s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
 	alarm_state = get_rtc_alarm_state(self->fd, 0);
 	if (alarm_state == RTC_ALARM_DISABLED)
-		SKIP(return, "Skipping test since alarms are not supported.");
+		SKIP(return, "alarms are not supported.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
@@ -431,12 +431,12 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
 
 	if (self->fd == -1 && errno == ENOENT)
-		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+		SKIP(return, "%s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
 	alarm_state = get_rtc_alarm_state(self->fd, 0);
 	if (alarm_state == RTC_ALARM_DISABLED)
-		SKIP(return, "Skipping test since alarms are not supported.");
+		SKIP(return, "alarms are not supported.");
 
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
@@ -502,8 +502,7 @@ int main(int argc, char **argv)
 	if (access(rtc_file, R_OK) == 0)
 		ret = test_harness_run(argc, argv);
 	else
-		ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
-						rtc_file);
+		ksft_exit_skip("Cannot access rtc file %s - Exiting\n", rtc_file);
 
 	return ret;
 }
-- 
2.53.0

