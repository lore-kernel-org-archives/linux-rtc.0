Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E139182C
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421147; cv=none; b=rZ86RO8yo2K1KJUvtQoHj8c3QCmQ2mwusmYQ9SRqD0LpqtbJuRsnPzGKt4vamKm5HcoP7K64HDFfunbOioL1B/trIT0dhzdMJV6sRx7Efb3O/O8TrlQtSMuIau6PVlSicgav0rXo8m7WmNsHN56xIw/jIUkJXnZwjfRvaajLkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421147; c=relaxed/simple;
	bh=bqFq1sFhgxNS/knQASD1NGsWJNtqHqrXmQFR35YL73o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RZsetRHw2J99T3fABqydAkFH/iEz9/pMp2dExuOmxkhdgTBvHgHKbL1hMwbSm1zKuZjyWo8K/YpIBJ+dga+0PaJSrKYBdwQpZv5NT7ZMnA9k2awzPVjusKvv3r63+x8Rhv3x6y+slYBuo5vwpVJkXJTtzFrGHqwH/msWgbiMGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE3DOaW9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE3DOaW9"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482ea739de2so2607242f8f.0
        for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789421144; x=1790025944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uiicOJgcAHnqowOM1/oeJPpa4eohRRRcrqsrnETq/qk=;
        b=dE3DOaW9qpPmkZTf0RAytAEw4pKYc/qAdhnN6xxRgywwABCp1jsS4S9FCdVkimYf/I
         HKkLqYZpRDBGADtgUH4SswJV5D0D8xzAY8jrgbnru8RyjZVDSAegoUdlT78ShQy3hnSk
         /Hw6sRWvBxmEUtoU/JKnOX/8+YtyXAxRgNO2Om2EyjJ4xsqcXdTmWqZaJOuRDFw3WhpK
         3V6ZliMOV3rmA+INNcZ+kLCQJQeUQ52NqUwcn2lnl4nZuehUi9rnjFTUmw7johPr3MGX
         zemhdoFa3qfOxhyzSwUXEi3j/G0t+xCEDH6MvyhjXXELkJ/bAZnG1GAQ/rB/DLn7xpdL
         1R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789421144; x=1790025944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uiicOJgcAHnqowOM1/oeJPpa4eohRRRcrqsrnETq/qk=;
        b=bhZcO+1ZLMMKWDM3R9kS6wP8LSuXcg74e+2OnrVk4k3r9Wign6yTMvSk6xdsTkwYYA
         8BvLEgysPBsXO6oJlueyiXRczbu/E24G0clLTPcF/Eu7GjEcjVtRVviMDlxueuFLeRJJ
         poDY4eRDQ9jw1ORbElSuLSLeGleL1Xv8tn1Q3pNO3pL8N4q0/gy1gv/1xCZcMi72ji/i
         iBp69uBAFrCy2xSdMvMWpLp85EU5wBJO6N1Sgf1xJpSGXbFGFsRLSyyXkxgsfjMMvvUh
         F1+CYsxHipoLreJihJnF+HdoO9tP8sl/Ck5wkvdXCMT75y4jXW3C9thpVaRoLdMLOiuD
         STJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTNIWdwex8V81Ubvitb0Wk+ga37nKrBz7WF4pai5wqo8NBPuNGBot5i5TQbS48kbaoWpLw9ep3YUU=@vger.kernel.org
X-Gm-Message-State: AFuF++krO51+8D/Nx6/tC4zztTKrhKScUK90R6tHVi2MvSKa1ewtE6dg
	bnpCVsgvVdTCLuXEZrvXTweEs5oeoCcLROs6dMrImmX+j9iyR+MhrDBA
X-Gm-Gg: AYBFou0x0Ai4LQkLktaF/D8dynPXk8RJfzjtR6QLGm1ggIAtprP8gvt5QGfeAkpwg+j
	CNtzPgL4GiaOYuruUMtqSCbjIfhKuSuFqUZpNJQJlgzGrWyrxy8va4F/C2+BM1UMPuLW7O5wUvt
	hBuPgITd/1p6DMJnyD85o0/WXzIyj9KQ2Z5IubVyH+j+Dt1W2ky48kEW4OnSoZsSANhxI3bxBN1
	4OsQzjlBAoELEgk5Vsb28aQSULBpjOvKWSVFQdyTu3bjUf/WUg2F1gVMqlFu1KZCRy+09a3BT7W
	1wW34pAQVSzsv1tcVt/Su/Y+N08VlqNfRMJAA369gmyLAYU+Rw1FQYryvcgwGlZGvmU9igcGKwu
	9dTjkcywKyRt09yN7uD8Y6SM5GNrn7QKM9eW4hysRYIL7Fq0oLe3RlMhqW6uvRAvOp8rV0ZS6tT
	zfZ3hF6y8SqhyWqx7sJa7nzTFEFHiiTNBj3NZfM/pFHEBSvSxmLUNYX0QtZ0iHieFmFGa7vA5eQ
	TaowX0vKZhEI86tfihtQ4x4AtB9fY7jW2lUZK7Udz6csIGmvpLFfcDv73WRSJwTS50KGr8W2DSe
	orF0x6TWNaFKW76izwMB++bNpSZqp2YBIG9ArjZFApb4Rn7lHlJkCK5nj5McwyKteqanMoaZKxb
	UJw==
X-Received: by 2002:a5d:5e92:0:b0:486:f8c4:21e with SMTP id ffacd0b85a97d-48702b16c03mr5089854f8f.28.1789421143402;
        Mon, 14 Sep 2026 14:25:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-af2f-db01-e46b-1486-90be-3932.310.pool.telefonica.de. [2a02:3100:af2f:db01:e46b:1486:90be:3932])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fc02sm28563643f8f.16.2026.09.14.14.25.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 14:25:42 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Date: Mon, 14 Sep 2026 23:25:37 +0200
Message-Id: <20260914212537.1452-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit systems with RTC_HCTOSYS enabled, rtc_hctosys() rejects
RTC dates whose seconds value exceeds INT_MAX, even when userspace
uses a 64-bit time_t. This leaves system time uninitialized by the RTC.

Commit b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow
time_t") introduced this limit to protect time32 userspace from future
RTC dates that can break boot. The same limit prevents systems with
time64 userspace from initializing the clock from valid post-2038 dates.

Add RTC_HCTOSYS_TIME32_LIMIT for 32-bit kernels, defaulting to y to
preserve the existing safeguard. Allow integrators to disable it once
their entire userspace, including init, supports post-2038 dates.
Warn on rejection with the RTC date and option name so users can
identify the cause and find the setting.

Keep the option independent of COMPAT_32BIT_TIME. Userspace with a
64-bit time_t may still need legacy syscalls for operations that do
not represent post-2038 dates.

Fixes: b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow time_t")
Link: https://lore.kernel.org/all/20220908115337.1604277-1-arnd@kernel.org/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested this exact patch on SAM9X75 Curiosity (32-bit ARM, rtc0),
using three full kernel builds and six powered warm boots:

  TIME32_LIMIT  COMPAT_32BIT_TIME  RTC in 2026    RTC in 2040
  y             y                 hctosys=1      hctosys=0, epoch + 2 s
  n             y                 hctosys=1      hctosys=1, correct time
  n             n                 hctosys=1      hctosys=1, correct time

The default-limit 2040 boot logged the rejected date and
CONFIG_RTC_HCTOSYS_TIME32_LIMIT=y. The other boots did not warn.
Legacy clock_gettime and futex returned -ENOSYS with COMPAT_32BIT_TIME=n.
Tests used a minimal time64 initramfs without NTP. Current clocks and
all original boot files were restored after testing.

Host tests checked Kconfig defaults and dependencies, the INT_MAX
boundary and error paths.

 drivers/rtc/Kconfig | 23 +++++++++++++++++++++++
 drivers/rtc/class.c |  8 +++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05b9233b9418..a594c041bc35 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -30,6 +30,29 @@ config RTC_HCTOSYS
 	  the value read from a specified RTC device. This is useful to avoid
 	  unnecessary fsck runs at boot time, and to network better.
 
+config RTC_HCTOSYS_TIME32_LIMIT
+	bool "Reject RTC dates after the 2038 cutoff"
+	depends on RTC_HCTOSYS && !64BIT
+	default y
+	help
+	  Reject RTC dates after 03:14:07 UTC on 19 January 2038 when
+	  initializing the system clock. This preserves the existing
+	  safeguard for userspace using a signed 32-bit time_t.
+
+	  A rejected date leaves system time unchanged, normally near the
+	  Unix epoch, and the RTC's hctosys sysfs attribute reads 0. Userspace
+	  must supply the time if no other source has initialized it.
+
+	  Disable this only if the entire userspace, including the init
+	  system, supports dates beyond 2038. Otherwise, an invalid future
+	  date in the RTC may prevent booting.
+
+	  Disabling this check does not require disabling COMPAT_32BIT_TIME:
+	  userspace with a 64-bit time_t may still use legacy system calls
+	  for operations that do not represent dates beyond 2038.
+
+	  If unsure, say Y.
+
 config RTC_HCTOSYS_DEVICE
 	string "RTC used to set the system time"
 	depends on RTC_HCTOSYS
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 01ba04028f1f..18ea141ab8c2 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -72,12 +72,14 @@ static void rtc_hctosys(struct rtc_device *rtc)
 
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
 
-#if BITS_PER_LONG == 32
-	if (tv64.tv_sec > INT_MAX) {
+	if (IS_ENABLED(CONFIG_RTC_HCTOSYS_TIME32_LIMIT) &&
+	    tv64.tv_sec > INT_MAX) {
+		dev_warn(rtc->dev.parent,
+			 "hctosys: rejecting %ptR UTC due to CONFIG_RTC_HCTOSYS_TIME32_LIMIT=y\n",
+			 &tm);
 		err = -ERANGE;
 		goto err_read;
 	}
-#endif
 
 	err = do_settimeofday64(&tv64);
 

base-commit: 587858367581b9c55c3690f4e63382ad622719d4
-- 
2.39.5 (Apple Git-154)

