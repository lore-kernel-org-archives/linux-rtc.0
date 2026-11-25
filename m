Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591249;
	b=pNCeNS8WNgFxTuOWPcHauIdkO/S8zX1skfuhw/B6VyNg0e8oFU/cmtUBfOt2j2MXrIBZ
	 gjTfXfB/JDoZ4uteGT42KD1Xu8Ozo3yJLtTu1QybZLOppva1S/D1qG8HzYLZ/QNs41f+h
	 laL+7dMsS75mr7AldAxXYy9fVgXt6VbLGqk2M5nxB0kKZCGgmb5qdYO5/jCKYY2/OfARd
	 LUlmF0m+8Pvl8mCcK0+MN8pxK10VrxrkXSPhZ1zdcCZdyGkxtIjkQbcq5mF1Ex2hx6/gA
	 bO6eIx8kMZtsRlPrFjfOTwHqfz0kGwhqfuEVTdIw1l8kfGyoWztLa8IJ6ZAsDEwlB3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RSZOWxfqWDFwRdZgOArsmxSLz/YxCgw0M+/5x+1CQb0=;
	b=TyBxXXLf5BJ2Se7VoEwGt/abRxB3vRqtp4jSsv2WagSYpMKlT6RVhKPay44a8K2u8KjR
	 fw7UfLfUjUVfhU48wf5U5GDbpjBrSYskltqBg2MpVqHyh1X7RDFTybyJsvOfmsdvXEJ/J
	 3FHWm2ymTrmkrNbKByjZTzBqZHQAWMZy5P4eKDOHy422OcwFVWcnVpbsJQ1wtygO5lAln
	 5uBRlGmStTMabON1lmJNf0zl/PHimzMTijD4BEz6PNh9h37GojNl53aAPNkwKun0MiaOO
	 g0+t4p3PvttbV7Njk623Q2x1YrBW5/lggdMRM2gPL08kVCMD6V6PdlSuZQtJyTUUCgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SF01Bkeb;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B18606A327
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B18606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SF01Bkeb
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so13915514eec.1
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591248; x=1796196048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSZOWxfqWDFwRdZgOArsmxSLz/YxCgw0M+/5x+1CQb0=;
        b=SF01BkebU3IJFo0TqaL9nkNgkmnDBdIGpz4r+Y5J7P3jIO+44nLuC2+rf0drEgEzI6
         K5YAlj7l4L2rlG0D3pLkixkRi39OMDl8pxagHQsgK+YlG7UxMdxlLloOOc+RhwwKq3iE
         qz4SPAkgg8altB6NPEmGmXvhfGBxKUgiAC+IZsPGhMQ8pcRZUbU86bCD0RMZz7/MJHO9
         fi3YQ1DKHwchljtorTcPbyKf+FibP8NHsjknmg5CuSgdicHZavg+PZ1FptZTOtxrRQWD
         MxaKXL8jGkeEwGy8iXX39NUTc/Egh44D0PD8rGv83AWuhhRxpaaIeNgUd9oRNwZZqeVC
         l87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591248; x=1796196048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSZOWxfqWDFwRdZgOArsmxSLz/YxCgw0M+/5x+1CQb0=;
        b=TjeUDHeYVzS2LWHpTTw4dsAk12l5T0yNHPYyyBIvxehL+nxaXl7rxsTMF3n+2YPXJ9
         KBiqZoraIgiSYTG2GPS0nGZVUeFI2HQ0xHZfxdqcyU0qEyO1baBbTzIi+lHoFltEpNcE
         dAUj+PgL+M4sPPMCBqKT5fV+vtqgaX4+K6nvI+2t+wMH5cwjUbPyAs1Aq9Bgk8L+ErH2
         eHLn2/vsF8E7hdPRvhrqfocp6vejq+phFGkOSwMJL0eEBoC2LkO/hMnbeNP7v95AmsUn
         I7fGwCHz3S7XRcvFUj3HjpnUZoHozHze6z3liA4zUWMYe0ig20qw82H0yUC+ImyIjyxR
         9lQA==
X-Forwarded-Encrypted: i=1; AL+hErHhWRsYWBF5+stuH0/uuOlBfyM0AWVcEbA4pht12Sd8HFKMtVxD9NpJX442fQqHeQ+3SmX7c5x9D0A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UXuRWl+ckCc25f0fHlMcT2O00xhMkoZ0ks+yXcPTOo7+tc2DR
	MAoI252Op4aKiN7BlhfREIlMjxmPi9fweJgwsD79be3M7HgDr4GGQwyG
X-Gm-Gg: AZFdTZdElgcRrwnrHFycaG0THchqQhgJ6J8hj8BwrPrLRmQ1WJ2mO8IgHqYlP297mSG
	YYHv74VeSpUqoY7m0nJBavAjLT3rJGMlWqB/TLVN5ySOia0uHln10wVPXKzPLViT+jMfbXWnyWs
	lRt1Zccq2xzCj/NnoracfZ28CrMxKNAHy+n8qCutaNo33+GryiGZXdCgDf9Q1FBLhVy3KHO6XGT
	w3UpTlwSZ9o8wbo9mPUHUlJgsPOoqW4gIZyrzGtFnuKr86rmRXzZM9yoWYCwvn1YR0SCiaLpYhp
	ML1R0G+cGuAtdaDS/fNx5VvPqUoG1cAupcZke661DLOsU2YUtv6ZE5yq2WpgE9UVsy+HH0miOM5
	lL3fvfZx0YcrILIgro4Zj0CMIqubldv9ae6AzjvaSsWf+1EEO0KZcDlu0ozHuhiGvee/iZQE2qk
	ebP6CTySn+9pwT2vZmBoXTcD3Vh8j12dE+J9Bj3THL/hf9tb6Y9j2EWmUAS2ke+vXlPWC3LvCfA
	kgBb9CdaUB02eYeBb/isTEe5ZIT2uooL6GQ3YWow2ItbZfTGxu3L3yWlLN58DKzhxtb+a6Vi758
	n++rwOLa/icXIoqJ4O3AAxLU+028YmE51z5W02TGduWslXE5ix8bOnXOn2wfLO+6
X-Received: by 2002:a05:693c:8951:10b0:386:b4a1:d92a with SMTP id 5a478bee46e88-386b4a1daa3mr7689219eec.1.1795591247853;
        Tue, 24 Nov 2026 23:20:47 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:20:47 -0800 (PST)
From: Prasanth R <ragaprasanth@gmail.com>
X-Google-Original-From: Prasanth R <prasanth.r@lineo.co.jp>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Paul Cercueil <paul@crapouillou.net>,
	CL Wang <cl634@andestech.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	Prasanth R <ragaprasanth@gmail.com>,
	Prasanth R <prasanth.r@lineo.co.jp>
Subject: [PATCH 03/12] rtc: mxc_v2: fix unbalanced clock disable on remove
Date: Wed, 25 Nov 2026 16:20:17 +0900
Message-Id: <20261125072026.2997493-4-prasanth.r@lineo.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
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

From: Prasanth R <ragaprasanth@gmail.com>

Probe leaves the clock prepared but disabled, and the RTC callbacks
enable it only around register accesses. mxc_rtc_remove() still calls
clk_disable_unprepare(), so the clock is disabled once more than it was
enabled and the clock core warns "already disabled".

Only unprepare the clock in remove, as the probe error paths after
clk_disable() already do.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: 83c880f79e88 ("rtc: add mxc driver for i.MX53 SRTC")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-mxc_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index 965170bb8..35a18b75c 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -365,7 +365,7 @@ static void mxc_rtc_remove(struct platform_device *pdev)
 {
 	struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(pdata->clk);
+	clk_unprepare(pdata->clk);
 }
 
 static const struct of_device_id mxc_ids[] = {
-- 
2.43.0

