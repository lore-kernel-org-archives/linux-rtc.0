Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5C47A86F
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594314; cv=none; b=sSEvbwsrA03Y2gSjX8+09kRKOeUSUv7ItIYep0joc9inDUgizfBWTpIo1FMG0ZpEOApUaZmfzEzZlk/zco3Ql6s7fWL9ONpS/+nFrmhDwO/nQO87h2RgeOaNyhuofqxjHfgvqRUrSZdCv5hh0fL51B2BMkvGJgn1scz/7Uaz1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594314; c=relaxed/simple;
	bh=K4igtr3iiX3evWjg8416yvAUD0H7YOLhuJl6/2giCns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppAt3MK7nAD2eEr6Vo8s9hBeSXGGnY0hkEBafd6Wm5y8J/issJkmeGQLWjOZ9mTuI6C4K7x7Ncrdrtx22eDixCbqWR4LvwUbrHrWupJyIlGmK1Yo1GiX4gXO806DT0NELHz/1bpOYA6QC58iETli2mVpd+ssmxaH4HlbxPsvGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=b5HHuJXH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="b5HHuJXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=YsY9QTagmU65H3JMTO9aCIa0bito/VSaAufPr6APnU8=; b=b5HHuJ
	XHls1o0JYE4OJeo+uPzGM1Eizzg8H8uZyAWdQo1b5SY8E9G6IGN8OTwBBuZOY4LO
	y+na4hT7gq0IHtKvnsISJSkn78HKTH4/selrE7qR7lfdBpQ5RnSLeBS2WvC786Jn
	1Rq0s2Tmy2bGLBBtb46g9wWY/A57Nni6J2hWhDAAIxiGyEfGfkX/U9fSJBUAwU1P
	SQwk4TFzs3tLVQATDF7S5p3Oqk549WpQJRT5D6lpWRn4cJxt5pYc7FTueDqY2Owb
	BSB8BC0lQ88+kdtH0Bc48PRiQAfJrOhj9KYbzaOytD1DKqW2Pzk6aXwkWfyDh/Y9
	ar32zF/HhIi2sn0Q==
Received: (qmail 1715404 invoked from network); 16 Sep 2026 23:31:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 23:31:41 +0200
X-UD-Smtp-Session: l3s3148p1@xT2hZKBb5MQujnt4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-rtc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 3/3] selftest: rtc: rtctest: skip properly if setting alarm fails
Date: Wed, 16 Sep 2026 23:31:11 +0200
Message-ID: <20260916213108.9234-8-wsa+renesas@sang-engineering.com>
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

Use the proper framework call to mark a test as skipped. Currently, the
test is considered good, only the printout mentions the skip.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Maybe I am reading the logic wrong. But, the SKIPs I add here are hit
when setting an alarm fails. I wonder if this is really a SKIP and not
an error? We have already checked above if alarms are supported using a
designated check (and then skip), or?

 tools/testing/selftests/rtc/rtctest.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 962050a32985..46fbaef9fdeb 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -250,8 +250,7 @@ TEST_F(rtc, alarm_alm_set) {
 		 */
 		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
-		return;
+		SKIP(return, "alarms are not supported.");
 	}
 
 	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
@@ -322,8 +321,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 		 */
 		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
-		return;
+		SKIP(return, "alarms are not supported.");
 	}
 
 	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
@@ -382,8 +380,7 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 		 */
 		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
-		return;
+		SKIP(return, "alarms are not supported.");
 	}
 
 	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
@@ -452,8 +449,7 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 		 */
 		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
-		return;
+		SKIP(return, "alarms are not supported.");
 	}
 
 	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
-- 
2.53.0

