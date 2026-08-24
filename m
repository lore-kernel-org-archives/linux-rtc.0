Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2737361979
	for <linux-rtc@vger.kernel.org>; Mon, 24 Aug 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558900; cv=none; b=lWyYkHyS1H7LWGbOm2FBI4Ld8d3uzlsurN3Ab+DsO/w8hL2KuOisYYVYkE35KAkMUeNPk6UpMkgnIzsiv/vQvCe46xaJy5ylRBy5VQoqpNlQCgOQNkB/1tRoFEHlAu0ov/j5oD8PxY1IBU0DImUKb5zD915d3dVzxuPk/5H3//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558900; c=relaxed/simple;
	bh=3G3ulFFSHUc92tcBjHrT3b0QYJS6jk2XY7uHx8whOEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=opA3qxEa9G4xA4ZBig4CY/fPtjB+4/agMjW2VgBj4yDLkE6NnSs7+DtXjgYJWaf6Hr8D2Z9gjrGDNerR6u8WomcxrH4P0zYP30KJ9ITc7VeRoYwheCDq4JP/gta0Z9u57+w0JLjKbLUUleBWKCnhPA1i+flJqntG1KB/Su/zhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=M4mClQCs; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="M4mClQCs"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202608240808060a4bef8581000207f0
        for <linux-rtc@vger.kernel.org>;
        Mon, 24 Aug 2026 10:08:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BdgGWbXQkpW4OTCJgHhpsVIoB/AjFsBplkgEDxA6l/s=;
 b=M4mClQCsUKYK0m4i1G9B/xQ11nTpPaKS31dNqPap+EdAYkEVlnbt+PNbh2XtnN3ked9e4c
 mlJiXDEizv8S7l48vlZszLvLUeU6uwAM6E7JX7zT6+0X7g408wt+hFmA4T61oqTIYTzLk94G
 qET8pgSQlc+HxIMdVfcN5G0B7a2Rrs+dUPByyNLh9t+s0JvnwwcjM4jflYLE/rTHlfh9ZQpZ
 ck/e+LsBU5dMPYkVUdajikxzR77gdJvG5ohRILZjNAGJHGV/pbzKQBv/h47jmmW02GVxQJvz
 NCNZv/QGnTqIBV7J5FSBXYgPtPjtKJsGN8AVI6N6g+cCVUN+5493N78Q==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-rtc@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: pcf85063: disable the clkout output by default
Date: Mon, 24 Aug 2026 10:07:59 +0200
Message-ID: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The PCF85063 powers up with its CLKOUT pin driving the 32.768 kHz. While
it's possible to request a specific default frequency in the DT via
assigned-clocks/assigned-clock-rates on the RTC node itself, even without
a real consumer referencing the clock, there is no such possibility to
disable the clock output by default.

Therefore gate CLKOUT in the driver before registering the OF provider,
mirroring the pcf8563 and hym8563 siblings which already force an off state
at registration. Doing it before devm_of_clk_add_hw_provider() leaves the
real consumers in the device tree free to re-enable the output afterwards,
while an otherwise unused CLKOUT now stays off.

In practice it means that with CLKOUT disabled the RTC consumes around
250nA at 25°C and 6-10uA with CLKOUT enabled (5v Vdd). Which means days vs
hours on a supercapacitor.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/rtc/rtc-pcf85063.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 01e209d88f5f3..0b6d8083b6456 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -523,6 +523,12 @@ static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
 	/* optional override of the clockname */
 	of_property_read_string(node, "clock-output-names", &init.name);
 
+	/* power-on default is the 32768 Hz output on; gate it until claimed */
+	ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
+				 PCF85063_REG_CLKO_F_MASK, PCF85063_REG_CLKO_F_OFF);
+	if (ret)
+		return ret;
+
 	/* register the clock */
 	clk = devm_clk_register(&pcf85063->rtc->dev, &pcf85063->clkout_hw);
 
-- 
2.55.0

