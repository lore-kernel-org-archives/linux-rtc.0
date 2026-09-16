Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE248F833
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594314; cv=none; b=uiIZgOAvI+/nsukHc43Zj4xEuGLWvqnrbzV7wsRcJ3BfBjsazrLmWAKWLyxG6wI+09qx64Rr4r8Us/ZFSoU4Nnm1IXrXhY5XhURAhVp5gVd7BR7xwB8Zz/rvae7C4gNl4PhJnCvEd0PfWlZbKseP2hQa6UbzCnykP8LVT78hK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594314; c=relaxed/simple;
	bh=1DHSr8bh4abwlIz0FoHBbbLkBEesDe6+96WV7AzDtCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTsu71DffF9rFgHXH4zJBp/s6r9/i/OdEu9qh7sFSij5ZNr7l/ZjojblnjbjUkcELbj6slxt5v2ejy0GV965EmN3uHkEIRvSGt5ErP6iHp2FL9KVp1Rj11DfXKmnJ3Rw402GW3lWuB+5xXMcwZPNry+yaWALxeyHoyzIMjHDaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=L0JJBdG2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="L0JJBdG2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=spZ5aNvOpiG/e94c8K+wmvSJl9kN3mWTpFV4sJ0UNh0=; b=L0JJBd
	G2bMpiN92U8ptFTAXiDskOudT/gxtb9jOmRdrgUwdAgXA63wwsXC9PEoCwhh2sAy
	8ud++UZYHAja8XHFiOuwXSa//x7Ip3o1ZFGnO1yT8P+QJ9AYGRaB4T+48B7P9l5o
	+/KpUJAig+wEpT7jq+K2cT3s85hH80sN7tQ4Fw5WwSSWpiJnOxfOTxt0zYH0TE5b
	z3C4GwNUnEV6+0enlJdijQlxf2vz/ht1kO1H+BpOj2fnzZp0re26fLC4RZ1Rgd8w
	gflBrfXN2iRir1NHGW6OUlL9kIqedoB2JTb/OCDE6csq757dAwkTyoy6REDi3qft
	FS9E4wGeAzRVSKcg==
Received: (qmail 1715372 invoked from network); 16 Sep 2026 23:31:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 23:31:40 +0200
X-UD-Smtp-Session: l3s3148p1@MPeVZKBb4sQujnt4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-rtc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] selftest: rtc: rtctest: make missing UIEs really skip
Date: Wed, 16 Sep 2026 23:31:10 +0200
Message-ID: <20260916213108.9234-7-wsa+renesas@sang-engineering.com>
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
 tools/testing/selftests/rtc/rtctest.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 077cdc2c6f87..962050a32985 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -163,8 +163,7 @@ TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
 	rc = ioctl(self->fd, RTC_UIE_ON, 0);
 	if (rc == -1) {
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip update IRQs not supported.");
-		return;
+		SKIP(return, "update IRQs are not supported.");
 	}
 
 	for (i = 0; i < NUM_UIE; i++) {
@@ -192,8 +191,7 @@ TEST_F(rtc, uie_select) {
 	rc = ioctl(self->fd, RTC_UIE_ON, 0);
 	if (rc == -1) {
 		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip update IRQs not supported.");
-		return;
+		SKIP(return, "update IRQs are not supported.");
 	}
 
 	for (i = 0; i < NUM_UIE; i++) {
-- 
2.53.0

