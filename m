Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804337;
	b=Bw2GxF12ScRkO0aR3qsmhW5IwIpOgUN+j2NN9jamTlhYe7bJ/a6lbdzwJEVSDGwtESvJ
	 6LrZ1jYxhWlXzY9bbhNZzchE+G99QjwmReeBKiJWH77wtn+OE/LTTicotUipphATknQmn
	 cziqZSmJm/ycwKes/cIKY9Kv9eBlr6v4x7P/6XT1drefobVO9wjsAmX0GurUOTVrf53q4
	 tZl6uOvM2tkggFW8I4xjIlit+G+PcQqr8c6bfzyhkrJ/4C4i+X3BqbAmfjj927i2prZ2Q
	 oOV0Fa4i5dAaVjlXRgu/OlbvEyUVah/WAFT+hgHRrjLvmmWVFZ9fsHn4IYOMowwgNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZlCHGoRtMbV0sOxoCDUMJOhQ5x4ULZVSAr4XX4def2o=;
	b=kkGlj0UI/eHVtnnVH7CSiiqgP8rAVJqb7uJEi8nxvvAdJvzsHi/IVQ5WH7/reNgxy4eQ
	 hjcwu03Ud4vCw+q8A4fomQneoAn+VNvtEvlVoXM4/yMH8eJFxf4oHa99rqh9Q1SGMGrlQ
	 DRbK1ZsVplU2/+i3H9haty/NuurBQAx4dz2h28JHFLPZzI+/hUtVtaXJ3nBiIoyxNPMdd
	 gCxAGDp3/yyUHQ2UvlJmsgugqGQdJ+hBJfZuFZ4B8TaouvYpDjlOtWMFyV5Lqp8/3F1Pr
	 cX0kY6BZLy2Nq77Z/vHsi97/zC/zNinU0Fj8w2dMnUMiwQJm2hxB6SoBcj7nMC+5XbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTBZu8tc;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FB606A31B
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 14:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E01FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTBZu8tc
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9e53d011eso5577285ad.1
        for <linux-rtc@vger.kernel.org>; Wed, 04 Nov 2026 06:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804336; x=1794409136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZlCHGoRtMbV0sOxoCDUMJOhQ5x4ULZVSAr4XX4def2o=;
        b=RTBZu8tc9ZTv6AtCaet4trrXcWvfn1A+8EG4XmeivJYuWzW3XEQjCw8R1vBs/cRUjT
         Nxudl+1aCdsh49Hzj9MzoiTIXZCBpXQXxQDncIY62iCBpuRTra91eTSRBQ4G2c4Ymu0x
         kxoj9k4VfGCbHMscGnF14gPILbFhYNw5cTek1KnnD6bSCkagg30ey+rJrHeaw8X+ap4C
         x7jBBZqxkVmKfxIEiLemu/uvnS6Szid7oPCyAoNBCbpPurjBkEwExk345aHTYZZYFAiI
         tKnmKFBdTkLTTn5+VDS4ClAIDADuYuXtwPOfco2D8S1P8vsqrPOigtVs50PQ1DR58xAt
         evsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804336; x=1794409136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZlCHGoRtMbV0sOxoCDUMJOhQ5x4ULZVSAr4XX4def2o=;
        b=sLj8aS4pRT8c5f5bmuT3ZqkvJYiOK9RCU4ZVNShBOgSyB47YBPKCjBMZu6C5PJ6P6r
         8yFRd/GhOO9Fs+E+a+V8ePRST7iN9l1vkUH7f3S+nQEbUq4gmH98zpStC3JPSMdm7h/N
         rYWBDiSxmmYO0bKPBqlrTJa2/68e9EETAhkzUoFiCPRmPwRWY25LpBGqAVkhrvykoS/n
         B0bT1TgiyZoDUhYEhO53164xDRhHbs2g/wASVHnUn3+x9TfgAkI6S/7GQP0Oq3B+q+rJ
         QEyhWkcnaj/M6vsNXxyT341vmWVy9rbzSjFSzcvJ5fQTSfVmjvN0vfnsOOsLdbDwXaOn
         9ZbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNIGupt1i0pwph2pFD5+U5CLSdTV/Nr5bXcD9u+u52TNxpxzcF3kvYFIjdc9VKF7zIRmgDwLRLkFA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SA9UwcM2UDkeZxvH+awfKNcKPLCxBFySduSMryR733+0dT+l9
	Qses1WlV9IoUjdCFbv1oFMip5Fz6/wGfqiBSQSwUvckwrUqpPUP1MsuP
X-Gm-Gg: AYBFou2kiegL4Ajk/oRbbKGAx2AfpIs0HTk4II2RKERXsGP7ZWsBA3FqKmYaNXw26QQ
	7PNd8fDGj7HC6cW7b+lPuAF2TW4l2xM0F+TaQUy6Yr+IuMyePKE2DrR+OwbNAkYX4jGiU0GUEG1
	qyK+n/HhNzsI/EJDASzgveM28AbeYpKVuI9ts/utd3K+A8JU+a9R8j8kYFkfj6xKUMecMqwmIbC
	8PkylQvlynYCs6NDqFoEYGFhNqT8Z8mB2x/h/3jF+X7OgYWXURCyJA8E71pDju/wLuYknI6yHLr
	ViaiXSba6pmw74pZLe/VsJBHWLdC/8BjcSJM1d1s7Y4nTjzlWTFZlrqinNEjjiM0AWScPpJrmpW
	pc/fPC1YeiIR2InFwwHDKYe2k56dnb99LZz69PEmC6K9Y8dIeCdsf7ompApSP0Km6xzB7a/nk51
	zmVNn8AXI8jKbojeR3vZt+9Tnq3sp/GvZFW3EaOxMCzGMyXgIw3vL2lm4o47BF/CCEIbj9gDy33
	YTFn7o8Av8Xico7/mLVBYGB9ltinDi8QkTLvdEBT7BR6aOpJ1VqH30auAb6Ok6VIJKj0DXnrWNZ
	Arxt7bZ+1KiXt2SHhJ2dibNCG1p8tHqD8FncYAiugdLhYKwZp8vcLV/EitzJ13Tqgm9With03Vq
	BtjGfbyxh1lj3XxTQ84JL3nYuTpOI
X-Received: by 2002:a17:902:cf0b:b0:2e9:4175:3077 with SMTP id d9443c01a7336-2eb364962bamr175279525ad.15.1793804336225;
        Wed, 04 Nov 2026 06:58:56 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:5040:8550:f5e4:709a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08bd596asm9269185ad.1.2026.11.04.06.58.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 06:58:54 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rtc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] rtc: raspberrypi: do not mark the file comment as kernel-doc
Date: Wed,  4 Nov 2026 20:28:30 +0530
Message-ID: <20261104145844.32361-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file header opens with /** but is not kernel-doc, so kernel-doc tries
to attach it to the RTC_TIME define below and warns about it. Instead use a plain comment.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/rtc/rtc-raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
index 0547a96c6..657734b96 100644
--- a/drivers/rtc/rtc-raspberrypi.c
+++ b/drivers/rtc/rtc-raspberrypi.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/**
+/*
  * rtc-raspberrypi.c
  *
  * RTC driver using firmware mailbox
-- 
2.46.0

