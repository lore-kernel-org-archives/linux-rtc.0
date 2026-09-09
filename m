Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F949BD76
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994320; cv=none; b=RPLdxHPUtyIN5nn0DD1eYG6VgpdXJ5Hc8zuhH7TLIFbeK+yB4FxzlEXHTVMY/8zrow5GzmTh4RP5dt9duf0UlQCetDZHKO/RUvY0SIooHeEUrY+aPMcSenxCtY1olUdhWWfDrFwHq1+gltXqM8m1P2O/awxBWMP13J/wfFb3b34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994320; c=relaxed/simple;
	bh=+zx0Es27kLaPv59lhsle3IxCZWQ7rYW77UlTXnD4G34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hn6hSqd5npkoBAAAet4YViYlCGKxI3JaTBkZOHOvvrjGiKrG2vAx6/g1NNsRnvTL1dA8ay7Qpk0jmMFxZwsrmmvP0YAIG4ybm+lTy3a44aQHIcRl+hf5eucPBRtOlDdXhbL9YlHb35WdeT9D6GA8N37yNanm86bpEdqvMDLZ8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MZlDiNzx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MZlDiNzx"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90e8e70fa02so68478646d6.3
        for <linux-rtc@vger.kernel.org>; Wed, 09 Sep 2026 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788994309; x=1789599109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1pvaMPa6UbQ5WwIuJKDQQUXZykQOh5nAfFmGb0Yzfs8=;
        b=MZlDiNzxvb0c2UOvhdsXcAfiYdyPi7CZlYHZ0CgMwqY0V99V3Ck1KRjReQdXPT4MzV
         nAdl7x3vaHNMTMAkpr6kO2YJ4DX+kpIofzAIheZ16AQ2LqmBUgqWJ/DMtdaUB3bySDpa
         3IR33pIFDN+z53Xp8z5CIhzmy8OumatPRa1JhohRKv2RXtDf8TbAVHg2B9VgCTZqJAme
         +MW0K33r6rfUIzU9vs+9nXgh85UsBCWeiBvM3qQ4Zw2ry6I9vh4NrU9yHBFCkTwG36IA
         g1HTfDJbI4xtZeSordQ9Mq1N1UPaA+GTw+jofbBMHTY9K0kq4akhYMsghy/egfCJxZAt
         tSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994309; x=1789599109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pvaMPa6UbQ5WwIuJKDQQUXZykQOh5nAfFmGb0Yzfs8=;
        b=B3SGFZsQWdr031ZXE6xBLx4KZDr2DeYcSV1sCJbyEYb//gzaNASVHFY0EgAbKTLyr6
         xyjj58wghKOS7lWmwlIY+G6aihj87CIg4IM20JUGhFiS8fV6cTu+RkFFfeKTWn6+UCd/
         64eSJtrLUgoflm3i6HPgxmJ3tv0M0esOIr9aqqzyzaIE1p2CveWXX24oe7pA1oDwhObR
         STqaVab4muGnga+9trbHXSD38OrWUyXqABdJO+7cmHz7ud2HcAVu+Y1+oZbtUYiDtBtm
         6Pn24K+6Arvdo2/uCMb9pPcm1ioIrX5OeJJ3IOvroRX/hBT5cJQA1KAI2Uo4Y/Fdvu7z
         1xrw==
X-Gm-Message-State: AFuF++nO9WyAx7Z1jsi2Ik9Hat4SfOpsw76R9K1Lky1Kzs6JpwlQ78w4
	+skUPXl/CpMvffrL6/wFfFVUCPug20abaSo6bvB8G6MzFXwW6FoMEN4plbQxa9hqczVV5zWAdJT
	o8PKr
X-Gm-Gg: AYBFou3V9O09GiaftAkuxn6Uv2NcrxhkASQG+LT8UDih42hO8aNWBb3FIXzUMArlGov
	ofVj5k0Q2XNve1uKRqqSr/GucuVFKtDA2WdvpzHyWs8ZkDXTN/DvE/psA0S2QprB6To4J7gVbHe
	FxLtIcz3I8iaEOMFz/9j7gqNmXjivTbgsVh826n49RBo36mz8Rh5eat8UjuwCj+bSCLPtn4CN1b
	j/DKoEuy5w4hgY7LQboYzN8f4BQbIIBtYbi9twmDFEwgHbzSKhkR/s5adjWyiAy2k/ddCJ2v8Mb
	fb8DPsoSTxHE15X3UWGBIchHlkW07H31FLRtEO3oKolf8TEQ8cgIn6ZmV2jJppxx4I7n75Ktzif
	UuZhuiYscrX666IRnM9FGe3zEKtFQrB5EYi+FTpjhL8Jgfz1Ws3XjsLGEgBqTRwXrfEwu93/Z5V
	OdEqNvumtMIEsv3iIQL/7adI4HM7dBeEiExPf7zY/6pdVdI0Mq986kXjwYKN8SXa8xWxACcUtj3
	mt9NGikw1xgeP6hmkDf80auq3xJ9SOS4bTvt9nP/6yxIJFSeynX6ratfyMF
X-Received: by 2002:a05:6214:448e:b0:910:44e8:e643 with SMTP id 6a1803df08f44-91044e8ef30mr441664476d6.15.1788994308771;
        Wed, 09 Sep 2026 15:51:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm59976696d6.20.2026.09.09.15.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:51:47 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com
Subject: [PATCH 0/2] rtc: cmos: Fix ACPI RTC alarm handling
Date: Wed,  9 Sep 2026 18:51:30 -0400
Message-ID: <20260909225132.1392883-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.53.0-Meta

