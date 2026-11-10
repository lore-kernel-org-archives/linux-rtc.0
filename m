Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307924;
	b=0Q2/iJ63KgzifRNieRb2sW/FgtK7ux+GU3fXi4MFmZkkdJnZF8/mG4zXqTbcgM9BbPei
	 1Ugk36UGwXFut5rGTjdaO08Gdbnjn8bMp1T/ds+VURmcdm6Iu+koIVBNjGMJytdFIpFDz
	 b30GJ634nZOr4HEYlRqjctrG0Qq0qxzw5M2ZPOQYx8LBT4N1+CkKkjhiaoi9GDbkPYx9H
	 Ew12ZUO1tfuJbWDaYXhQVSfWJYuGW7clFDf2LCpSQGgx/dH85brHWnSL/izqZMjaqxDhF
	 d+/4eggr9lnwWQzzpookoaKy/WB2oX8kCuvd8hesNWiIODJ90YJUD/K66Nl2JJmFNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=luY53rQnSHqOmqiVXG3ojpIoE98d8W8aTwUr99JyWqc=;
	b=ET1L5pvQiFzRjj/VcEe1rrLJ0ZhQnT5i5qw/pKAtMlabnnJUGgHfnBY8ivoE44m8lCbC
	 VhUrXxBOYEVqDUueqcpkpmYGcWxJnxTJpxeTo+TJHw7nwGmZWV+CLOCkejHM2t7+TmcwI
	 xTAU4TH2JgdW6xyAmiRBRpM+k5IkTGrk3497hqONND+zAaIh7O+l76VZy3lBknREyCgkP
	 nGkPF9QqKjIgfEIvzYe37/A8cEZiYQLLVeEMnGWmTEFELaONO7Q7ErDJdHwWXFQjsdCv/
	 dUSKxlc4qJEjllzNCZo2GLUWIrHy3gvDkOicJOjc7zI8kKtP2jmyGDCcDXzofgrytGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wakel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NcRlXcf5;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868B606A325
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 10:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5868B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NcRlXcf5
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eb2437d752so29772215ad.0
        for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 02:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794307923; x=1794912723; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=luY53rQnSHqOmqiVXG3ojpIoE98d8W8aTwUr99JyWqc=;
        b=NcRlXcf58L5cAm85xdwcRMP8p/gxpVW0B3VFJ8usn+Fv0oeYo7gKsPhzp/NOm7FFfn
         F1frWF9UacFCIYy7+uO6/e3rXu0yXIbTev4FjE7N+3HYbWJn4T4jIYrpcj6hnLZQXqcD
         jZrM4Qm0pFmQoIlaMiuFv8uGsuVg04jHZY7RhgYpcCuEjJLBc5WnZVvR1l4JwQpN4wGO
         MjDcz6jZyUQLEqfqbWV5Oo4YooBz2Fl0qruAepfk2QuGXsfwE5RQ0HYYHCTaLWyVGb71
         wAuCJniDC+kHUH+nYhYKdX0yTEpBkUgSKrIH2Z9vImolTGiPLvVHDmHpNz2QrAkeqRSk
         C5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307923; x=1794912723;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=luY53rQnSHqOmqiVXG3ojpIoE98d8W8aTwUr99JyWqc=;
        b=nXkf0n2SENLZn+glxSQX6fDCziZWci23AZM/9gE+oK5SjfovM56cPA2jibHPgFxREg
         Osb0yPPp1oul0UsmBH1w054eOYvGt7+LqPY3+0/6BctNnQ+LPHa0Rpg1MFJ7woqSsxCn
         uza34Z1xMw1MiN9bpEyOApWnY6oEgO13ehWCvwEGMLC9+H0tXb1u1KdiWZDcsAMYfXPN
         OhPyDcu42aI9zHR4GC4Df9AoyMpXXjroWc2RM+rZsJn1l112nREXO7qa2AMBd6aSMzMQ
         2/JKMGYmr4d7oPdPzPRhrxMPzy5uxw+pmQmjxLq9tqZA66hmRasqxfvX4K0av+sfI1Pc
         Mx/Q==
X-Forwarded-Encrypted: i=1; AL+hErFAAkLySnT/9+SHe4fdJCubJ4Eu0ua4S9IbRko0KhwkbXavNstQQwBX8ISomsimBLSDDmB8MAuK/Mk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dS2hXlCZ3T4X92IEfxOQCANjaGHsJvXC4jNo1AZhCqBuMQjiv
	DyALKQl1eBqJg+ftHytoRXVtFwlGdV1BUlo2lEYzpbk0c1j5M94E3xw7A6h2tBGzdQ0AetujuBm
	ADw==
X-Received: from pldt9.prod.google.com ([2002:a17:903:40c9:b0:2e5:a015:564e])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f686:b0:2ec:ed58:2062
 with SMTP id d9443c01a7336-2edb9278fa6mr19990085ad.35.1794307922487; Tue, 10
 Nov 2026 02:52:02 -0800 (PST)
Date: Tue, 10 Nov 2026 10:51:58 +0000
In-Reply-To: <20261105030834.3318480-1-wakel@google.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105030834.3318480-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110105158.975652-1-wakel@google.com>
Subject: [PATCH v3] selftests: rtc: Support harness test filtering and arguments
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
RTC device node path as a non-option argument. Only reset optind once
all options have been parsed, so the harness re-parses them from a clean
getopt() state, and bypass device accessibility checks when help or test
listing is requested.

Signed-off-by: Wake Liu <wakel@google.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
v3:
- Don't call test_harness_run() from inside the getopt() loop for -h
  and -l. getopt() keeps its position inside grouped options, so with
  e.g. "-ld" the harness resumed at 'd', missed -l/-h and ran the whole
  suite without the device check. Record -h/-l instead and reset optind
  only after all options have been parsed. Reported by Sashiko AI
  review.
- Kept Alexandre's Acked-by as the change is limited to the -h/-l
  handling. Alexandre, please let me know if you'd rather re-check.

v2: https://lore.kernel.org/all/20261105030834.3318480-1-wakel@google.com/
- Rebased onto v7.4-rc1, no code changes.
- Added Alexandre's Acked-by.

v1: https://lore.kernel.org/all/20260910034821.2935214-1-wakel@google.com/

Alexandre, if you're still fine with it, could you queue this via the
RTC tree along with the other rtctest changes? Shuah, please let me know
if you would rather take it via kselftest.

 tools/testing/selftests/rtc/rtctest.c | 54 ++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 552191fe1ca0..21c37764f9d3 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -487,18 +487,54 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 int main(int argc, char **argv)
 {
 	int ret = -1;
+	int opt, i;
+	int non_opt = 0;
+	bool skip_dev_check = false;
+
+	while ((opt = getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) != -1) {
+		switch (opt) {
+		case 'h':
+			fprintf(stderr,
+				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name] [rtcdev]\n\n",
+				argv[0]);
+			skip_dev_check = true;
+			break;
+		case 'l':
+			skip_dev_check = true;
+			break;
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
 
+	/*
+	 * Rewind getopt() so test_harness_run() can parse the options again.
+	 * Only do this after the loop above has consumed every option, as
+	 * getopt() keeps its position within grouped options (e.g. "-ld").
+	 */
+	optind = 1;
+
+	/* -h and -l are handled by the harness and need no RTC device */
+	if (skip_dev_check)
+		return test_harness_run(argc, argv);
+
 	/* Run the test if rtc_file is accessible */
 	if (access(rtc_file, R_OK) == 0)
 		ret = test_harness_run(argc, argv);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.542.g3ef89b7020-goog

