Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E9258EF3
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346648; cv=none; b=VefcD9jXSWa8yygv2XsGWYgZSjX9K0tknwEJTZ1U+5y56rgf5noCCT4XGJWJOdTmwAZIPa79C19IRlCU+EztOtbRKLZm6QXliC4U+BhTXPacesnten69CB7i1tKUpUdrCn92Zp3pMd41WfNrIPteKez05Ji0cZWAgfqUufAr36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346648; c=relaxed/simple;
	bh=EMceISQQR3TXbTd9em81YjXZYjPC9ENRztR73avuZU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8IkjcEnprPn2o8YBDpLytt4FeUzgOcUYTTwRxnXbw2ESqdSR6nR5VEFA81XlUoPjagHu1xWaks6uOYu6k2rj4mEoFAGBPbM+9nc4+Tba01rKkTlv5rbu3esJNmihpDIGYGB7nVgCX5CHuL3TcOC5GkPGwdvWTQaU5n+K8OwEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1ROBJ3U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1ROBJ3U"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d5655cc850so18542605ad.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346646; x=1787951446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eH1PdMyWZxJGgwaNLBlqd6pxOyFz86/WZ6+VDJYAAdo=;
        b=l1ROBJ3U9g3/6EC9TQuy1mp9rmn0/MXbyTagogE3lLqSB4f2cf6BUuY03smzYRQs3m
         flasQRfRZ6e7tQw8Ri7I66SQ2v88D1TJ5CETmh0D0ki/jUCU4uYF/YrROYcX3+b7GWfC
         d4XeazmBeeQcLwmR7Z8iNAVGNFNblgOgx22TZ6PfBkVOKWYwHjnh3wqWwcntw7g6+7aD
         lfBXeBGLOlN+Uso4+XXkGCJWBs6H4SK1hiBw6VNl1phRjh3nuvA11CzxL3q8MY26gVSo
         LLv+wuBCcc5f62jHdKIxV0EZ57odOZOoQe9r7DMtlfQFd3EF4XmNnSG8/+f3e1TKH9aP
         YZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346646; x=1787951446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eH1PdMyWZxJGgwaNLBlqd6pxOyFz86/WZ6+VDJYAAdo=;
        b=NYk0dC9LFfVG2AZ7qiZvLxpCAlvgH42jk2g0bl/2MTInfPGJB/TG9JnNX4i7SVfIwK
         elMwm6YoxBh5S2Ak46cyAclzqhDwdKSj0Gt40OF+HYdKYx6N0xzC4Py5jGfEx9mtNtE/
         fjfVMuXfy4IZ6Jl6zr3oGTcDCa4bsJbSdlWdtxrT85WP8fG7Zrvan+vBbka1KAZ+n8v2
         sR7H9fDbkJ4VhFgJqmmrmTp531t251xNCUcF/pqJYiLtvknwLArQqASZ2czDlltM7JvM
         S81bE35QkmOswhHNW9vizPeHkmPy6EphfjunjLYFCKmCDUoGXRSYaEcWCzPtMWOnOGFz
         gzSQ==
X-Gm-Message-State: AFuF++nYwSVceISfYPuMEPW9ZaA3oAH+J1+njitCgVEVpZ9FQ8A2Po6j
	Oy8MhDjgXPqfBswsa0s3ykqkeX1UGsE3Kl3I00PBJ3Wx+wKYBdH1ozP+
X-Gm-Gg: AR+sD12FQQZPgNaHozmnnSOA5JTRqvNJaMDHBzdx7HqQfFO1R83d5rDl1nPZXZWB+KW
	LjDrT5FRD0uz5mlYCgCiD9dvcToEY8UUKTYkR3Rwqp5hY65P9GXPAhzEUXAdekw3E1XFp/wDBck
	Zkz9NCu0F6zk8dwkQzJL8oR+b6PZB1DBK0TsZMCP29kauIRWJwTbM7nDSeqzDQlSjD6xrsGkgiq
	eidxSTr6EMqf5D0LsjZ0KdpAOJ+lznKT2JHJYxP9kBQU4KQ+t1JwCzcTBsd+mDqtHO6RKGmA/3u
	5W7RM3KsbEqiSw/I49SrCFRfQF4VrPh0HI7IdSJm0C9F3XB1qtpQWxJzlzcFdXZxhB4oVq+ut8V
	X2KOxGPbQ5+0YT3N40G6uj0V/YSEn2CST0DKpTwuvrMneZDGKVkFOspKDaXKqMoQpyvCbqdKbq+
	9zPM6MGT7pZSLYYrbh+lijmGlJjUau2Oi8RBN468ngCGDYOW+2AxxRypSFlRnWN0SgrF1Fgk2Dv
	VKZnWX03U1p47Ocb2cLiyQqgw5dWCmfvqx5wTI8Y3aK5jm78T6x58RhaxDI798Q509zzGiE
X-Received: by 2002:a17:903:1b23:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d64b036caamr189046405ad.10.1787346646380;
        Fri, 21 Aug 2026 14:10:46 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:10:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 00/17] Add RTC support for Renesas RZ/T2H and RZ/N2H SoCs
Date: Fri, 21 Aug 2026 22:10:15 +0100
Message-ID: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This series adds support for the RTC IP found on the Renesas RZ/T2H and
RZ/N2H SoCs.

The RTC block is closely related to the RZ/N1 implementation and can
reuse the existing driver infrastructure when operating in SCMP mode,
which is required on these SoCs due to their 195.3 kHz RTC input clock.

While the RZ/T2H and RZ/N2H variants do not implement the RTCA0SUBU
register present on RZ/N1, this register is not accessed by the driver
in SCMP mode, allowing support to be added with minimal changes.

The RZ/T2H RTC variant also supports a 1 Hz output signal on the
RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
marked as reserved in the RZ/N1 hardware manual, making RZ/T2H a
distinct RTC variant despite its overall compatibility with the RZ/N1
implementation.

Patches have been rebased on top of rtc-next commit 78acddfde751.

v5->v6:
- Dropped the output log from commit message.
- Added missing sentinel comment
- Collected Reviewed-by and Tested-by tags from Wolfram

v4->v5:
- Collected Reviewed-by and Tested-by tags from Wolfram
- Added Suggested-by tag from Wolfram.
- Added a new patch to disable interrupts when arming a new alarm
- Added a new patch to handle unset alarm weekday in
  rzn1_rtc_read_alarm()
- Shuffled the pm_runtime_put_sync() patch to be applied before the patch
  that replaces the .remove() callback with devm_add_action_or_reset()
- Renamed rzn1_data to rzn1_rtc_rzn1_data
- Added a print message to indicate that SUBU mode is not supported
  on the variant.
- Added a comment to indicate that the xtal clock is NULL when SUBU
  mode is not supported.
- Renamed rzt2h_data to rzn1_rtc_rzt2h_data

v3->v4:
- Added Reviewed-by tags from Wolfram.
- Made use of tm->tm_wday directly instead of recalculating the weekday
  from the day-of-month.
- Updated commit message in patch #3
- Shortened the comment describing the calculation of RTC_PCLK.
- Updated usleep_range() value to use 2 * rtc->sync_time.
- Added new patch to gate SUBU register access based on OF match data.
- Added new patch to make use of pm_runtime_put_sync() in
  rzn1_rtc_disable_hardware().
- Added new patch to drop trailing comma from OF match table sentinel.
- Added OF rzt2h_data for OF data
- Updated commit message for patch #15

v2->v3:
- Added new patch to fix weekday underflow when alarm crosses month
  boundary.
- Make use of devm_add_action_or_reset() to simplify driver teardown
  and remove the .remove() callback.

v1->v2:
- Dropped wakeup capability support patch.
- Dropped header sort patch as it was already fixed upstream.
- Updated commit message to drop reference about RTCA0TCR register.
- Added Acked-by and Reviewed-by tags.
- Updated Kconfig help text to keep it generic and not specific to
  RZ/N1 SoCs.
- Initialized rate variable to 32768 to avoid timeout_us of 0.
- Made use of RZN1_RTC_SUBU_RTCA0FX mask for SUBU register access
  instead of 0x3F.

v1: https://lore.kernel.org/all/20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (17):
  dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support
  rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
  rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
  rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
  rtc: rzn1: Fix alarm range check truncation on 32-bit systems
  rtc: rzn1: Disable alarm interrupt before reprogramming alarm
    registers
  rtc: rzn1: Fix malformed MODULE_AUTHOR string
  rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to ARCH_RENESAS
  rtc: rzn1: Use pm_runtime_put_sync()
  rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
  rtc: rzn1: Dynamically calculate synchronization delay based on clock
    rate
  rtc: rzn1: Use temporary variable for struct device
  rtc: rzn1: Consistently use dev_err_probe()
  rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
  rtc: rzn1: Add OF match data to gate SUBU register access
  rtc: rzn1: Drop trailing comma from OF match table sentinel
  rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs

 .../bindings/rtc/renesas,rzn1-rtc.yaml        |  35 +++-
 drivers/rtc/Kconfig                           |   5 +-
 drivers/rtc/rtc-rzn1.c                        | 197 +++++++++++-------
 3 files changed, 147 insertions(+), 90 deletions(-)


base-commit: 78acddfde75177a27000f076e3e828743e38877e
-- 
2.43.0

