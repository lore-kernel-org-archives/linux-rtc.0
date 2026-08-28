Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D19360EED
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935500; cv=none; b=mb0ueQ2faFM4kX/mpHEJJwINpza5KfApFaB/hnH1ZS/tgm79qBmma991QxIlv0nOLXwfAyHnO0+YiA0/yHGupVOuM9llEnWK5VkJ58svixaZrsKoOCMRpqCqJvgeu/03AVVqtX91HgsW883kysuJPs9jydGMZw/iHPJeMUqUTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935500; c=relaxed/simple;
	bh=457CAtUxAcs/Gwar0TINkysy9s5JEuWwKe+C6AqVrq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPT7Do6cNreLQQqk+p/35Zt9FgH/FC2cNvp67WjjbbhpppICbcjPjcNowgD4J1GZAGcXnh6o7GZfUCX2Vw2GKvkNWM0rHO49+26rXLf4LBCPy9neLO2+Wpk9nK02bH3bUThekirfN//QMfeTEjPNpfpR884JEUDQpMFt7Q1+peM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=T9+BO9MN; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="T9+BO9MN"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260828164448e51a5531d7000207e8
        for <linux-rtc@vger.kernel.org>;
        Fri, 28 Aug 2026 18:44:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F0SPxnW9ihACmhsmRod40BgEcDghFlQJr7zg3/N/fbQ=;
 b=T9+BO9MNZRcou0Lo4vVVYvmasYLAZyVJWpdfWcr9108LBjzv6lQjuV5XFt/76FgQ3FkFiU
 TaW/cIt6FZz0AA2xGNeAeqpcwFJ3pywRkF2t8UP/EOjYy0OZslipCBe2fkV1c182OLVEqVbB
 bHjJn5m9viQOarOgdiJ1mOXV3zh4jHj49oxM2BizjSwxy7DWOvY/3dZHOj2zec2qk4GLx4j/
 531dNt3/05/0GhGtfxJOOkgkdQVxJly6hMlNp44dwIuVslQKKlwGnHJOEIkJy4VbA3RwDVyZ
 tjOqRzmutklRltZM2jhf7xLYDF5Ye32aCXTHaMY9gwGuxZkrwcQhbWZQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-rtc@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] rtc: pcf85063: preserve the alarm flag in clkout register updates
Date: Fri, 28 Aug 2026 18:44:41 +0200
Message-ID: <20260828164445.3907839-4-alexander.sverdlin@siemens.com>
In-Reply-To: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
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

The clkout rate and enable/disable helpers update CTRL2 with
regmap_update_bits() but leave the alarm flag (AF) out of the mask. AF is
write-0-to-clear, so an AF that gets asserted between the read and the
write of the read-modify-write is written back as 0 and the pending alarm
interrupt is lost.

Add AF to the mask and write it back as 1 (write-1-to-preserve) so a
concurrently asserted alarm flag survives a clkout reconfiguration.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- new patch

 drivers/rtc/rtc-pcf85063.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index af900fe8ae15e..a3af86456ccfc 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -431,7 +431,8 @@ static int pcf85063_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] == rate)
 			return regmap_update_bits(pcf85063->regmap,
 				PCF85063_REG_CTRL2,
-				PCF85063_REG_CLKO_F_MASK, i);
+				PCF85063_REG_CLKO_F_MASK | PCF85063_CTRL2_AF,
+				i | PCF85063_CTRL2_AF);
 
 	return -EINVAL;
 }
@@ -460,7 +461,8 @@ static int pcf85063_clkout_control(struct clk_hw *hw, bool enable)
 	}
 
 	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
-					PCF85063_REG_CLKO_F_MASK, buf);
+				  PCF85063_REG_CLKO_F_MASK | PCF85063_CTRL2_AF,
+				  buf | PCF85063_CTRL2_AF);
 }
 
 static int pcf85063_clkout_prepare(struct clk_hw *hw)
-- 
2.55.0

