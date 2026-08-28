Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A0377A83
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935497; cv=none; b=fccVOvRY3orUzDt1wovhPdMcxIJnlUBC9Huuf2DLx6rVbV6gjZJb5VfOiDuT1K05gp4nuCBGq4bvtRlMjaE7RY0f2T2FAR86Oax7tLYR1twJup5sfSIDahBpOTcdoTJmd/4fpAkMNMhxeVEJMCYDzrhDnNZ/OWp5j8nEDeCD908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935497; c=relaxed/simple;
	bh=MaAAHQxxeuQW7h5KWHAzOdXY9T2/4cCdUoKT/r2MLX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3qSXZc6WUUcetQnspIPp9PMWloDxlYePhO7DwtztW493GqPgVQbuoPxi2w4HFI2DzBDRwg5aAEFXammbsUvQ9QmqWGcQk2caQaE5RyDdPZptuYP7c/YmXB/s87dl/VM4kY2mbNVjD82h8+kBA3qXT3A5kKMx184zvuMP3Smvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=PUykPEag; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="PUykPEag"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202608281644481193bd44b4000207e6
        for <linux-rtc@vger.kernel.org>;
        Fri, 28 Aug 2026 18:44:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=kXLCFidKi6n6sOXueq9fqumGD6TSvCxnTaxk9VwuH28=;
 b=PUykPEag2AvzTBQzKTlowarLf2HLQCa9Ees8wFxZ/xKzUmlY5g1sbhamHWtzacwF0dI4Fb
 4jliY9/ptEHpTwoIdLfM8HojXvZbNokocFHkOsLGsOJ4PnuF5mrjj9cZ9bapYu7hQRZbuHeI
 Lr025xu0xEAirYyvrTxpcDJ9Fcz1MFl/ayI/QHCuzSAvncQ84MNn1Mp5vKsuU0NMzGQ5PVBI
 wDztRw9p+XnkY6o/6zcWVbpRvB6ngp1KdVm6+X8HjFQsJi01BmiSfqIFcS+wq3aGGKKmhT0G
 fF1ZNFKbbzQXKEIRkSgM8leujB0BtSZLN6PjK/OXOioDwpb6dl/s7/vQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-rtc@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] rtc: pcf85063: Update interrupt support
Date: Fri, 28 Aug 2026 18:44:38 +0200
Message-ID: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Add hardware-backed UIE (1 Hz update interrupt) support to the pcf85063
driver. The PCF85063A/RV8263 have no dedicated update-interrupt source,
so chrony and similar tools that rely on RTC_UIE_ON fall back to the
kernel's software polling emulation. This series repurposes the chip's
countdown timer (TCF = 1 Hz, T = 1) to generate a periodic interrupt on
the INT pin, serving UIE entirely in hardware.

Patches 2-3 are preparatory: they fix an AIE race in the interrupt
handler and a lost-alarm-flag race in the clkout helpers.

Patch 1 fixes a pre-existing use-after-free in the clkout clock provider
on unbind, found during review by Sashiko.

Changelog:
v3:
- split into 3 preparatory patches and the final new feature patch
- replaced racy regmap_write() with regmap_update_bits() in IRQ handler
- the timer flag (TF) is write-0-to-clear, so every read-modify-write of
  CTRL2 preserves it by writing it back as 1
v2:
- https://lore.kernel.org/all/20260820112437.3715237-1-alexander.sverdlin@siemens.com/

Alexander Sverdlin (4):
  rtc: pcf85063: use devm_of_clk_add_hw_provider() for clkout
  rtc: pcf85063: do not clear AIE in the interrupt handler
  rtc: pcf85063: preserve the alarm flag in clkout register updates
  rtc: pcf85063: add 1 Hz update interrupt (UIE) support

 drivers/rtc/rtc-pcf85063.c | 139 +++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 21 deletions(-)

-- 
2.55.0

