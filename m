Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6D4756DC
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151159; cv=none; b=XSSbEja5AYlkGM6dBDYNFIhUAP54FV45jj0eNTl+AX988eQXbT6tN+DmeSgocfPOhMGdjO4GnpQp1nLedsrnEjWFHLCQNRz2peyAhAWt72zizo32iadJa8PFxpak3PmQMtROmemP+Q8VUD3fyBwJlF9jFEI4GxXMWKdBbb5MmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151159; c=relaxed/simple;
	bh=xSsWoQDL4dIlGNJ9wr1M+vrMDyqm0ULhiBw4GMXGvwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqwIVauzTSfTU8hMthTPQgrnkH/NPtRkW300x8CW+whbEfbWZxTQD1nJKFPX0ajDjiRXzUi4Oc4zlFuxZaPSgoJNlGaW+uZPid90B4O1Csq1XDkqRvudqjbh28O+/63/Kt4ASXG8qgw8qZtoiG8v7b6/smfk265garO+gwTWv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBkgMApS; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBkgMApS"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2e4ba830297so5757985ad.3
        for <linux-rtc@vger.kernel.org>; Sun, 04 Oct 2026 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791151158; x=1791755958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnok/HFBQll15hO2K4C4DwZm1VWqGd0S2304QV3/5M8=;
        b=VBkgMApScoPIcjnmMJCZcMMkZEXpRisBxPbqZhYV5JQtraCZOjdH61Pg1Vf7AhbocJ
         5XzWVMys8CePTucBbp/4oD/I/7FZNEmsIHsMiHV/wOMRE7jFAmKtd/hyf4eVQvi9cKuQ
         TX+EIv2m3+g4qwEr3WJzHTUhzyTFt2MfKa9I2lB0KjXIGY3LvuQFmB4WX5/bki1AvTLj
         G8YLzNajhYkKIxvb58LkW3vhuirV4B2pZDywn31/DHWt8dKH+EnGAM+mVwam5mNlxIPi
         kexIU5YcYqddua5nKBfQO2RCLx0OVFEvDVdVFMIuYRLBDDkLTv/L++JKqeYzbJEJlO1w
         g37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791151158; x=1791755958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnok/HFBQll15hO2K4C4DwZm1VWqGd0S2304QV3/5M8=;
        b=BnhO9Sprqd0qCyIek4u5DsAC8K06Ez3pHRBz9aF17mEbnHiyY6QKagz+FqvWd8qk8q
         gpkN2uyOiP7h0tBpZSKz/p0A1/TPfjOxMlbGZ1nxkKK6JMCkScJdxNiFIArxBmdd1/GL
         LRUmB0ONykf/YBZBAg7hwXx2+/u6b8BxN621tR0/39T3TkYpAggy9Akxijv85xaKoO3/
         rO5HcdnseZ7SrPqVfvorcHwbeqgrCUxtkW/R8aFpHwQLgveOZcQ65YBhKL/3mVp8Banw
         rM1G/u8v0imWlwB9RsoNlH2J3QXTthbJveJLmqoyWV0S0FY3ze0MInoFin0wpKN7tVFZ
         irGw==
X-Gm-Message-State: AFq9FYIVvU/NqLQAGhT6jKl/Vdl3o1EN+LxsRE2P6P5eO/pEznvgXiHi
	F0qMzvJQQsFVXMa9ItrXP2igPC6w77z9KSAPt57fAiQ5q8axnXz5nZj9ycrBxJ2X
X-Gm-Gg: AYBFou3T1Zg5Zp5SVIlB8iF4AWFzyzDzRFTFtELwwSCcHiWA+Bqc8q2kbf9osYTIRno
	nmi2/hY7CCN/074u8gE4L+JiF1/8RcKT9f7nx9hcLAHfUK98E95DY0h9Smaqo+vq13Qo7zKgFEr
	tsIbEY1KTffnKqgh5dhOnm6WfV6tubJDcCgWKLSb8twkuj6wxYq3n1iorbdbFy1Mren0ZrUflct
	2Z8XVOZs6LP6k5sN8XT3WwZR1FXbRB8FFWzR/ca91t9HB//+/90XsPLvf6lqpvu+CC8SDdRKtlV
	nXMRk3l9Ob7/yJP4PeYqzIXKLrEnD9GEN9Qthx9+VyUxHpSQeKxxiPsvtH1svnGxaTLA9ruDd8E
	8N4UUkNewunbkbUZbRi36qys1vXwimGxnxdMveSxt2uBspJ+LS461PmhFk0jEOgtXVZ7ocV0l6L
	Jm5ni3iqb5XAStCgtJ9XysCKDKHFHz9W7wR5nwpu7aNPdXku6ZuR6Ye0m1vn141IBhbV9yNUYWN
	IbVWyfk6Ypqn83/U9zIqGNmJ626RD+3r0GUcWVdcnRhFdlwhpdsuCNiHwroBOn9GyxOamsmVkoF
	ooF0WV3VPpeeaR/hsBchBsTCz3r+T8SW3mGW1ltP9gUtFDAl
X-Received: by 2002:a17:902:eccf:b0:2dd:c100:9435 with SMTP id d9443c01a7336-2e49b7ec629mr74653145ad.51.1791151157615;
        Sun, 04 Oct 2026 14:59:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e4bd7a0f07sm19822045ad.26.2026.10.04.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:59:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Johan Hovold <johan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rtc: omap: wait for !BUSY before reading time for the power-off alarm
Date: Sun,  4 Oct 2026 14:59:14 -0700
Message-ID: <20261004215914.397512-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_rtc_power_off_program() reads the time registers to arm ALARM2
one second ahead, but does not wait for STATUS.BUSY to clear first,
unlike omap_rtc_read_time(). The time registers must not be accessed
while BUSY is set, as the counters may be partway through an update.

A read during an update can return, for example, seconds already
wrapped to 0 with minutes still at the old value. The rollover check
after arming only compares the seconds register, which no longer
changes, so it passes and ALARM2 is armed for a time that has already
passed. Power-off or rtc-only suspend then waits for an alarm that
does not fire as intended.

Call rtc_wait_not_busy() before the read, as omap_rtc_read_time()
does. Both callers run with local interrupts disabled, as the access
window requires.

Fixes: 222a12fca604 ("rtc: omap: add support for pmic_power_en")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/rtc/rtc-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 540232d6f26c..4e9b4f601a9c 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -437,6 +437,7 @@ int omap_rtc_power_off_program(void)
 	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);
 
 	/* set alarm one second from now */
+	rtc_wait_not_busy(rtc);
 	omap_rtc_read_time_raw(rtc, &tm);
 	seconds = tm.tm_sec;
 	bcd2tm(&tm);
-- 
2.56.0

