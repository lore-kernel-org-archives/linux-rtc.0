Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848118;
	b=JeRp/KEyQh4OqXSF6ThZU1HSRFOIsvkVg1AQMREj1BdeNJtvChRHpfJ3rZWdxAkdgW3q
	 BdK6Fq7Xb0XP2XGkd6irlVSZSPCLoS9fdPiWF0NX3fgd0Hu66c82e/ZwcInn8uXxo9Gw5
	 7xGdDvEyF3lEwn7V2RUEi8vbszoTyUYz3UzW4NQKm9Tr617leERllULi4uzO7v3I2d9fU
	 GA2/+/GW0gkGLQ8ipqsb+ewG8o9+IJ45+UVIHKBinE38oseYhK70+aHfAuvQMNTsGjxv6
	 /sb4CxxPTdzvCQYnoiq5T+bQTgVeiqkWnDT29o8YRb+zg3++hM4itx7wReUUuKNrXYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+hTcrw2qlCHhO70X54WC3Z16qJoO8Le0y8rhZa3WBPA=;
	b=wWua0FAA+umNS5n3pcURu13jx4tKnqNEqSXadgRo1NP8OChiHIfP//aEFWh0rSKQ0M5j
	 l0H8TPPV3BLswVeLTgPjZIUrAfCVR6wlEPKqVxuQMMjxXmoXCH1U+wqIL5/BPpl7Dol7K
	 CiQcaPm5dB8/DMpxIww38ejRkalw4G9fAMVbDq+/FyZhuAk8OU7kelhBgcNe6AN10ZoPm
	 P1bNO6RPMAAYyr16k2NbqsUx6XlPVYEeD/QhhJ0idg4Ds8Ox/RC+Ew3zWj/i8Hwd2pUbC
	 gvwPlU/42ApBH3XVM2g0Pdr/jeU42hOqGNWsifyud7q56lWcQy6d8kxw9yw2o3XIbfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wakel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XhKUI6Xq;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52C606A32F
	for <linux-rtc@vger.kernel.org>; Thu,  5 Nov 2026 03:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C52C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XhKUI6Xq
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb5375cd68so12513805ad.0
        for <linux-rtc@vger.kernel.org>; Wed, 04 Nov 2026 19:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793848117; x=1794452917; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hTcrw2qlCHhO70X54WC3Z16qJoO8Le0y8rhZa3WBPA=;
        b=XhKUI6XqNxb34vhkv7Xp1GhTqJ/8iFS/JNQCI+ZjY1NqHajvZqgZxCFZrDUwYMwvE6
         BP3hw1pJEKqMfWHwNp4VFifFDntIMLzANbnT39cBRcH2bcpyXKvyGeh/g2k6i4WZ+1DM
         waphUfBfdMgHKwUp0jio826vFDu9gAZOm5JagNhghm9vpnKVlVA3xf/GKx/Isqbl8W4+
         yoxLa6+9ZH3GPn0TmquzEUxOlC9dKnWE/YbAWz/aZGxDK9lov4bf9BhqFksAazbDyvQj
         0ELyOh6vCKlysmai1zFRysjZHoQ3AuJkQPY3bHNWaybinsO5k/NqxRmSG7+RkICE/i2J
         YWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793848117; x=1794452917;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hTcrw2qlCHhO70X54WC3Z16qJoO8Le0y8rhZa3WBPA=;
        b=x8oRPic5X5Aud6riq8SkArtssuOa+Gy9qgjvC5cT1sMuXO3fBnXLwoF2FAqqsCMwVm
         PD4DdzA7j1FUdnetUOtTM4mKI2w7gWwTnOVz39MzeMsFwvv0MmnrjdcAGB3pGAN/x//w
         fBvGhd1sfQoxSA7Eh3CseDC6kF0ENWOl0lVa0suMtqiLGrTXF7G2cHwa2rld1Cnc24EI
         tP17K1W8eX9LpjYLQnA6HuRHzd5u3TIHxry5N9fb9OEJ/tlDg8olwahW5nbqNzZP3x58
         IcMeD2GKosKmeH8GVGorC68C+SzapnF9G0bJWLsoNV4IRBJUeOiFjJ7fxdgV1F6+3HCj
         8Tbg==
X-Forwarded-Encrypted: i=1; AKwUvBxzCVdu5NFLL3UFfp1hZ3KNkxNFwF1+7KjSrLGldbWbnkM2o5dJ/L0xZ/QohuPykRg2u8iBQyqJ9dY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kJOGgK9gt4xAhhSbkNQtAp61eZlQoHwUOy+hnM4cLQNk5GPvq
	5kzjB1Zf1apPx8SiWFGuI7kIj5LYpdzfijpdV4ekSaEsK4Vz3UT0H5DQyb9xhxmiLe9MyCTu5M0
	cXg==
X-Received: from plof6.prod.google.com ([2002:a17:902:8606:b0:2e2:f305:e980])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8b:b0:2e9:7ff5:544c
 with SMTP id d9443c01a7336-2eb3642fe87mr148706835ad.25.1793848116599; Wed, 04
 Nov 2026 19:08:36 -0800 (PST)
Date: Thu,  5 Nov 2026 03:08:34 +0000
In-Reply-To: <20260910034821.2935214-1-wakel@google.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260910034821.2935214-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261105030834.3318480-1-wakel@google.com>
Subject: [PATCH v2] selftests: rtc: Support harness test filtering and arguments
From: Wake Liu <wakel@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

rtctest implements its own main() function with a rigid switch (argc)
check that only accepts an optional single argument for the RTC device
node path. This prevents kselftest_harness standard arguments from
working properly:

1. Passing filter options like -t <name> or -T <name> triggers a usage
   error because argc is greater than 2.
2. Passing -l or -h causes rtctest to treat "-l" or "-h" as the device
   node path and fail with access() errors before ever reaching the
   harness argument checker.

Parse command line arguments with getopt() to pass all kselftest harness
options (such as -t, -T, -v, -V, -f, -F, -r, -d, -h, and -l) through to
test_harness_run(), while preserving the ability to specify an optional
RTC device node path as a non-option argument. Also ensure optind is
reset before invoking test_harness_run() so the harness can inspect the
options, and bypass device accessibility checks when help or test
listing is requested.

Signed-off-by: Wake Liu <wakel@google.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
v2:
- Rebased onto v7.4-rc1, no code changes.
- Added Alexandre's Acked-by.

Alexandre, the other rtctest changes for v7.4 went through the RTC
tree. Would you be willing to queue this one there as well? Shuah,
please let me know if you would rather take it via kselftest.

v1: https://lore.kernel.org/all/20260910034821.2935214-1-wakel@google.com/

 tools/testing/selftests/rtc/rtctest.c | 44 +++++++++++++++++++++------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 552191fe1ca0..eb26d957835d 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -487,18 +487,44 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 int main(int argc, char **argv)
 {
 	int ret = -1;
+	int opt, i;
+	int non_opt = 0;
+
+	while ((opt = getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) != -1) {
+		switch (opt) {
+		case 'h':
+			fprintf(stderr,
+				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name] [rtcdev]\n\n",
+				argv[0]);
+			optind = 1;
+			return test_harness_run(argc, argv);
+		case 'l':
+			optind = 1;
+			return test_harness_run(argc, argv);
+		case '?':
+			fprintf(stderr,
+				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name] [rtcdev]\n",
+				argv[0]);
+			return KSFT_FAIL;
+		default:
+			break;
+		}
+	}
 
-	switch (argc) {
-	case 2:
-		rtc_file = argv[1];
-		/* FALLTHROUGH */
-	case 1:
-		break;
-	default:
-		fprintf(stderr, "usage: %s [rtcdev]\n", argv[0]);
-		return 1;
+	for (i = optind; i < argc; i++) {
+		if (non_opt == 0) {
+			rtc_file = argv[i];
+			non_opt++;
+		} else {
+			fprintf(stderr,
+				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name] [rtcdev]\n",
+				argv[0]);
+			return KSFT_FAIL;
+		}
 	}
 
+	optind = 1;
+
 	/* Run the test if rtc_file is accessible */
 	if (access(rtc_file, R_OK) == 0)
 		ret = test_harness_run(argc, argv);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.398.g882cbad275-goog

