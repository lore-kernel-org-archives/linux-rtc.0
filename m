Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE01A4C77BC
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328713; cv=none; b=ljn2T05RTh27aUIi5SF38vollniU5XNgkGPrZS9jUI7HJuDIpoGuhZOSQwSJaZ6Y+fISiblZMwUONFceykixbZjP6G9b2J1gIGlD/rivh7hInijGsSf0XjBz440Nwhmd+qXy7cbuH8A2FVNNP/NCQKEzQ2Bv+EcryUROEAuuebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328713; c=relaxed/simple;
	bh=aBhiBc53YA3GDhUV9SnPyRNrnQKHyJ4QjY/pswKB5us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U30mP38NH/xw31RhGGm+BsXOoZzJHXXcdSMfWyp6DfVuUaLGFB7BpX2B2cic+bt2gumVQqmvZggChO3WL0WFnbrkzeSQPQlklkKh6R6WHiqp2y3qwqVkyBT4eYtic3cJLZZ6nPwte31zGcGz9+jLubcW7qiirgguPu+5M0w1qQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferrisoft.com; spf=pass smtp.mailfrom=ferrisoft.com; dkim=pass (2048-bit key) header.d=ferrisoft-com.20251104.gappssmtp.com header.i=@ferrisoft-com.20251104.gappssmtp.com header.b=cZPewnzE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferrisoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferrisoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferrisoft-com.20251104.gappssmtp.com header.i=@ferrisoft-com.20251104.gappssmtp.com header.b="cZPewnzE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so2367476a12.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferrisoft-com.20251104.gappssmtp.com; s=20251104; t=1787328710; x=1787933510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HPAM+SQP2Ol/FHmKFN7iyLYiVV7aXF8S5KkoBqF9vbs=;
        b=cZPewnzEMCCPsKmYftfW4lBsqTZbthK5rx1uieOZrwvXYtLApZSeFUFNfjb5zIlQ0s
         FFLmIYjDFDso1X97JwMuvCE0ni6JnLHtMKGAA9WJJyIqKESIhHXkMwK6gf3wiS30VB/R
         tYpI/oDb+BKXPyj/De83feyyxpA0pQGK7c+OZIb0FK3UtQqG9e77E7huPnKXxkxF+KE1
         G13lHPX9wgWQNAURmx7nchnU2kD5fQXMl0xJCTJXnrAYKF9IJbpihNgXQ1qVYB/doNS6
         D8l+Tw+v0Ci67gym8Wm3lHk5OaUmtrh/GyqGM9q+0V//bOzo9SX4y1qOj/xBnowFAAqw
         Myyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328710; x=1787933510;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HPAM+SQP2Ol/FHmKFN7iyLYiVV7aXF8S5KkoBqF9vbs=;
        b=aLeiWRW9UDAHeiM/Hj3DElrKGARzF1yMCyLXp8P8z37tQEomedHXCK+/7ASHxTgbeI
         +p1iibkzUPqTMetteV2Cw4593ecjqucFyqaDDFyV1ZxOxwG4IYGb4pcS896JYu6QFGkE
         RzcsCdKHPaBPd+qNF8o+3EwTDD4RAs4SAGisGdD/BfRxg1+GQdEiE1jg5Em6kya5GpxX
         0ppft15DicFsJNJfVdV1pO7txcLyEtjjP9AEJjrfs85kKld1ImxB1EUGntxKl4wqT9qd
         XV0MI35pNeDWpQCCeGu5j8WXSWUQjdtXVmv1cGMcQW6xTnYm/PRQvJLOFMiQ740udKia
         HeEQ==
X-Gm-Message-State: AFuF++nEMHG1C/ees4u7YqIlT+gi0DOcE+o75WkWyTA8fdiS8J7FIAqs
	dz4OKbuuNR1MRdm7ZLrIOa+jYWcvWA2qkyOvbwVxMi+nYdt0x5KLToHZy0ex/snQ+kOO
X-Gm-Gg: AR+sD13ir4qOROv3mfvxCUz66TneYKB3MFyrW8rsnruL4r2SR8dMlESl2usF0blo4kR
	nS4TiZEUmKCwfBEiiHShuI3NTYnv4mKNRugH5YLEYFnis8jW6WznkrBSb1aDgMK5t73qFQwrSTX
	7FPCSjzI46orHbmhqlunZ7SQo9CyadBoL5leZQ/c85jDVhTJTynjsvoxs6K/2dZF/5oft6fQ1YU
	Y2wIGhXxefFAVIRf4gajcvLS4ScxYIhV1HUMPY3OivANdwwSI7qRzHd/trz1w8vb7aMk3lbOs6d
	8BglTTHIbVlM4f1qE/BtWsJ4THZDbCpbGtujqaxxRyl3jwxOgbam8IcJHipULuZFSYTBlfdFbsq
	x01MPjLmZhPkicPhwQzXVA/IX9e9kIrb6zBl1GfbS9+IBbsP5lErGbs6iX8WPAYgqy6E7CvbRIs
	WWDrMMcmm1A5TDNd/Lub1l83/mUBKPR1XVASTjWqOQsAbNQScLfffTYUkaMjxmiRfpnuMwrxsT/
	zK3ReY=
X-Received: by 2002:a05:6402:322a:b0:6a1:f895:1ba with SMTP id 4fb4d7f45d1cf-6a42f20b899mr9009049a12.12.1787328709973;
        Fri, 21 Aug 2026 09:11:49 -0700 (PDT)
Received: from 0005.eml (45-11-61-69.ip4.greenlan.pl. [45.11.61.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c2cbsm7593937a12.22.2026.08.21.09.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:11:49 -0700 (PDT)
From: Greg Ociepka <greg@ferrisoft.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH] rtc: pm8xxx: do not fail probe when UEFI offset variable is missing
Date: Fri, 21 Aug 2026 18:11:48 +0200
Message-ID: <20260821181148.1642208-1-greg@ferrisoft.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On machines using "qcom,uefi-rtc-info" the Unix epoch offset for the
read-only PMIC RTC counter lives in the RTCInfo UEFI variable. The
driver reads it at probe time and treats every failure as fatal,
including EFI_NOT_FOUND.

That turns a merely-uninitialized clock into a permanently absent one
on firmware that never creates the variable. The ASUS Zenbook A16
(UX3607OA, Snapdragon X2 Elite Extreme "Glymur", InsydeH2O UEFI) is
such a machine: qseecom and uefisecapp come up fine, other variables
in the same Qualcomm vendor GUID (882f8c2b-9646-435f-8de5-f208ff80c1bd)
exist and are readable, but among the 110 variables exposed through
efivarfs there is no RTCInfo -- and Windows on the same machine does
not create one either. Probe then fails:

  rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver rtc-pm8xxx
      failed with error -2

This is a chicken-and-egg failure: pm8xxx_rtc_write_uefi_offset()
would create the variable (the set path uses EFI_VARIABLE_NON_VOLATILE
attributes and efivar_set_variable() creates missing variables), but
it can only run from the RTC set_time path -- and the RTC device never
registers because probe failed. The variable can never come into
existence.

Treat a missing variable like an unset clock instead: warn, keep the
zero offset, and register the RTC. Reads expose the raw counter until
the first clock set (typically the NTP-triggered RTC synchronization)
computes the offset and creates the variable; from then on the machine
keeps time across reboots. Userspace already copes with an implausible
RTC value at boot -- systemd only steps the clock forward from its
persistent timestamp.

Other read errors still fail the probe as before.

Verified on the Zenbook A16 across consecutive boots: on the first
boot the driver warns, registers rtc0 and sets the system clock from
the raw counter (1970-01-04 here -- the counter had been running for
three days); the first NTP-triggered clock set creates RTCInfo; every
following boot restores correct wall time from the RTC before any
network is up.

Fixes: bba38b874886 ("rtc: pm8xxx: add support for uefi offset")
Signed-off-by: Greg Ociepka <greg@ferrisoft.com>
Assisted-by: Claude:fable-5
---
 drivers/rtc/rtc-pm8xxx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index e624f84..4627f4e 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -589,7 +589,21 @@ static int pm8xxx_rtc_probe_offset(struct pm8xxx_rtc *rtc_dd)
 		rtc_dd->use_uefi = false;
 	}
 
-	return pm8xxx_rtc_read_uefi_offset(rtc_dd);
+	rc = pm8xxx_rtc_read_uefi_offset(rtc_dd);
+	if (rc == -ENOENT) {
+		/*
+		 * The variable does not exist until something stores an
+		 * offset: pm8xxx_rtc_write_uefi_offset() creates it on the
+		 * first clock set. Keep probing with a zero offset instead
+		 * of failing -- otherwise the RTC never registers and the
+		 * variable can never come into existence.
+		 */
+		dev_warn(rtc_dd->dev,
+			 "UEFI offset variable not found, will be created on first clock set\n");
+		return 0;
+	}
+
+	return rc;
 }
 
 static int pm8xxx_rtc_probe(struct platform_device *pdev)

