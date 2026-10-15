Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83403563FA5
	for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085454; cv=none; b=syVdJLcVZGgprYXUrrUjXZaBu48w0NMHWZ10SqlOfYSAqsNAMAMYnmzVJNi/fE9PefEX+SP8cdp080qeEaxUMxsJyXAYckp9MCFTSBB2vksvWZqsUf+J9b3Gjq06e1vEJu93CMOsdcoxt5nC2dB1418skZseGhhGOBgLEItByJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085454; c=relaxed/simple;
	bh=jzXshqsq8LpTtp/eHftavX8CC47Hi2RgETXeFOYwq6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJDakvBt2pHygeGN/VQgY3QDO5sDneQH/JlcGw5UedYH7bqBVVo2Qe83i5BUT1qKFB44+VSgkqg3LCv/1d+p4et/VrHflyjdxqqAEmPO75Fpv6701PIiMXRZ6ef8BA4vr3F8tYXoakqOIlZsJCoPYT9age6Y6u4IsIV/nRAqjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XYO+kwr1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XYO+kwr1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917a707f37eso69149826d6.0
        for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792085440; x=1792690240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Ij/yqmblFjl2otRcuDhQ5WPtlcQLmq30NR3nWc3SBE=;
        b=XYO+kwr1XGq9ffky7iQedv7871Sf2Y4pvTbjHS7Q9wng5YxOySEgCHbulG5rwVPNwg
         oIZIU/XZgGjCFbJGZ0nKk9/yenG7YK0mCATWX4+Yu5AIg5ErS57SjfrNQSS3FXr7ohrl
         3ew4yRX1MW/diHWRFQylD39rD0PjNsqvu8Ap/wLlhatctfRJsFHY7M6z4wAd5HvnRdno
         1hemMZD8UIm9f48RBV8JzPRZXwDCme/0Z25BzQJxoz8D7NFLd4yBfEb0m1hddFTUx62G
         InHz28+S80Lnm2P+GJhER1zvC7m7zBf9HFY1cr1BoI2Fukg1VBIHluRahQO/1IbyvbmR
         51vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085440; x=1792690240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Ij/yqmblFjl2otRcuDhQ5WPtlcQLmq30NR3nWc3SBE=;
        b=OPwJL0+gsig/RaKNZeC8QMBhZ0Y038PjCOVZOW6b4shN1wUIXuFZmqIl9NVwKKGTSy
         BLCHZnn0DF6ukRtk9IUIO7sg60wM7/VfNL3JYtXEIxeMKVmyKZKi5dHviEV/9QES5PLW
         sM9szVrEH+gBJZ1sVkOY1AqLatfyN9ylNA2vNpcEqqlLg2RIiSdVccxF92meLerJQ0it
         RTDqTSlB2QpQd33ZcVFKA1WR4A3fOE3xrlCSO86Qs1WhJQQnlDHNXiWunufUzDi+Z8vF
         7yzYR2r5iAo14ZSe61bMXALOtTaxww0+0f/99P/j4t4eh6af1Ks+eBM3g2manAjpFuUO
         hexg==
X-Gm-Message-State: AFq9FYIhDKKilMjc6SE9vBetpNPvnzUCJt4nFaVTmNcKoPCSzyqgiTn0
	+/hgD1f9vFWby6GqkmWfefBKSg8ntLT6p2KibuQ1Jn8HNGLBtyCCLeZ2fL6pHeJnjsOsnt38Nfn
	XotBdTl4=
X-Gm-Gg: AYBFou2DWXb4rd0pOCKfUVxZYw05I9WFBRtxHg3Dgntld/7KOmxFqULmcskS8kJecNm
	t7De9+gas3v1PGf2F7TayBRCfvKVKiVul9VRastPkawCdmT2LzpFw+k2BSHErThi3jNo+sxHIJ6
	MQWJLEQxeGNwsB6nNoc7JV0dPoBlfglYDJB/ClrgLIDO7hVMpNxKZHBf97XTgFZl1m6MNoLX1z+
	4D2acDIbqmLXzcwvbsIXeDSDHBekUmBMkKMoT6O/g7S6hslQ/C3v5BhdfKTNAXe/T0R2W0YHSUL
	KzLsg23ceW2dEd6GbZ/l8Mv5J2f1UFLERPnFhSjBRMoc3NqOIDm3YVTzKpi9a0BbpdFfDzoRuz7
	donX3pOCIcTd+LvX4xrekdUCS1fLN73J31lN8kSQH3e56X7RQf62ayn4Z8/J7Zrv2a6NJ7m8BNe
	UKLfwGIYBhhkkuandXZFiyll/MfVcyLMPYQ15RQihhhnv7Y1s8A4Fi/2b8P/UPCOCvAwLkgoFCO
	o6wGiqnBiMgqMaPkHYDgspb+a/P838y7IKnpls15WpPR3kUcRSjKuGmvwlvOeItyhyYAKE=
X-Received: by 2002:a05:620a:4141:b0:93e:d364:ca10 with SMTP id af79cd13be357-93ed364eb7cmr2739104485a.12.1792085438698;
        Thu, 15 Oct 2026 10:30:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50095bbsm825062485a.9.2026.10.15.10.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:30:36 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com
Subject: [RESEND PATCH 0/2] rtc: cmos: Fix ACPI RTC alarm handling
Date: Thu, 15 Oct 2026 13:30:27 -0400
Message-ID: <20261015173029.3091872-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend of the series first posted on September 9.
https://lore.kernel.org/linux-rtc/20260909225132.1392883-1-gourry@gourry.net/

RTC update interrupt emulation can stop delivering events when rtc-cmos
uses the ACPI RTC fixed event. On an affected system, a test that waits
for five one-second update events completed only 40 of 50 runs. The ACPI
ff_rt_clk counter stopped at 218, exactly matching the number of events
delivered to userspace, with the event status set but delivery disabled.

The ACPI SCI handler disables the fixed event after dispatching the RTC
interrupt. Because dispatch queues work that rearms the next alarm, the
handler can disable an event that the worker has already enabled. Move
the clear and disable operations before dispatch so that rearming always
wins the race.

During diagnosis, an explicit rtc_cmos.use_acpi_alarm=0 argument was also
found to be ineffective. The automatic platform selection runs after
parameter parsing and overwrites the explicit false value. Record whether
the parameter was supplied and skip automatic selection in that case.

On the affected system, ACPI mode completed 150 of 150 runs after the
ordering fix and delivered all 750 requested events. With
rtc_cmos.use_acpi_alarm=0, sysfs reported N, HPET emulation was active,
and 100 of 100 runs passed without using the ACPI RTC event.

The in-tree RTC selftest also passed all 8 tests under VNG with
rtc_cmos.use_acpi_alarm=0. VNG does not deliver ACPI RTC fixed events, so
the ACPI ordering fix was tested on hardware.

Gregory Price (2):
  rtc: cmos: Disable ACPI RTC event before handling it
  rtc: cmos: Honor explicit use_acpi_alarm parameter value

 drivers/rtc/rtc-cmos.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

-- 
2.56.0

