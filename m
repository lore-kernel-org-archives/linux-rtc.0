Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591251;
	b=GdzeCBBPUw8q6/gh0BDTwphbubzjcEBNbzUiJF/mb3o1qUV9fdGCfhvQ22+3XwrodXrN
	 RW3RDW4tNGErYJP0A+8tx2325mzETk5iEwj1MlZsS5uQiS+lNHDrxqxlDM7GOZd+VlPQC
	 Ynw464L09yxDBim7fFvU53z8zlrtQ7dElUA5JTxO1bUcLUc6sIY+eXAEv7snMz8jTypXV
	 WX1xxf3aDSSjq3EqQKNHIipu8VLyuf5cCzn2vSi6zlCrw1NYS0tmw0H320N5VDEfPiom6
	 mqquajWucG1MMo/6Pk6GRGt8Jp93ggdfx585ak6P+GqvZ8UYgtGs/1bDMrxbEcUdHTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SGK2H2xiYDiUmvolMkB/QNxXM88jn7GQua/KqoQPV70=;
	b=GUeMFItroj+NxlPMFkN/Q9mMd1UJflPFrdQqijdI0QXab5rOWzIkCTyHL5Kvm/XdmEQ1
	 nGsAp0JxybEdY3fIXZJ1vOPsFKQ8Yt+t32GvrIPmxVl1PMth7Tu+LAULsUP2QYwRRCRt6
	 AcGXE7kLQyXklx9FQq4/eaZZyiEM6ok+DXDSXHY49t9lUkJi9V1daEn0YDnWcgODh2jVz
	 33Kq94RoqGEWPZd2a5dqyYeP9MQPQx6BngJMzD+dmWFdkdRnzR65SUGCeLQUAaMtcNNJc
	 qRfOhx44yJTvBGjbAv0ujbQDdMxlZidwjb5nOBoF9UBDj/Gv5yy9wkZ7GFS1Xs1dOsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Pslmt7/I";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C0606A326
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A0C0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pslmt7/I
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2471734eec.0
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591251; x=1796196051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SGK2H2xiYDiUmvolMkB/QNxXM88jn7GQua/KqoQPV70=;
        b=Pslmt7/IwzdLTzaZBhL/ixPjHqZfMcA1cAUQ1LC2WY5SBk0IYS3ZZXHa1PQHWnLwWX
         kOBaSXb/JdrdAraGCioXtnitVHEe93RLatLdbeeueUQJqide5uukZQFihgSg9I1rzAG7
         AchpG/rQLYeNej5klYg9xnPaFXonExrqpdQ2nWwUy0O4WT5jB0tdLrXo+EJKjNGvCVs+
         l8szTEAk3Ny5nS9177eB32V4StSMMlMwENtYWEdD9w/XOk+05hQQ1JOoWkAljvTnsxlD
         OCPGOejIlFWaAeQbIsFuchvJRfxN4r5FSYcc335qfKMzcQimGst2WnD9iKAz/yc0WqHz
         KqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591251; x=1796196051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SGK2H2xiYDiUmvolMkB/QNxXM88jn7GQua/KqoQPV70=;
        b=xEK22nXrYXyjaY7hW65oLJ9CpCZgBAvQlb5AIZhIiCA1as4p/nPFMg1REJxLDc6u4G
         gmUmdbVuE9Le8R9RpprolpV+re2DPtsr1ITVE27kcuKl8HhUhT5VGazHBxin26CZG2Ed
         7BX0XwM+GlFyctKGxaqqCWuV4VeJ/he0RwkRjdi7gqbAo+nFBzW/MbBZB2WuGREdWlIe
         iSk/aZmZeyAqJebA/8zLAh7MhCNl71ucDeUoe+WP9CrVDljgIrrxIaUEFVxCGgm3wiOt
         rSInzRoZlAb3AnsuEllZF86UVTOhqd5Agrq6y3UUCEh2qpUf8plXFCRaixvkdwcFTAfh
         LNHQ==
X-Forwarded-Encrypted: i=1; AL+hErEWf5pwbv9HoSPfomtywVZqSgoTWf0BrstxKgYEJtVBneU41Mu4TTkV4XXdR+5/Je6tP/sEGK61+ac=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HMA+tHVn4g0g/KN6ChNLYObIDw6xYlJ9/K2HsUJ25xIFgAhTa
	XLos76TCpmi7odaWkhKGb9p7eoKS8JWI+Ok4cV/63PY0BVD3363xgWSN
X-Gm-Gg: AZFdTZfEO2dbjWelctx9wA0QyDnlbqoXZ4Z0Luhm4mMQ/w7JdyB1GdqBPDXwx3bLw67
	/XXiFl+rYWqpcJZeRmcBQlNAWph+tqHdclJnqBacA+sWnCUc6+5kcRx41xRnvi3piiLwXxewjvs
	d/nPG9Md3VO9kG7yCDaC7VcI/0F4hrXqLbIPSamLFIB/mfKu0yLhFzMLun41ptA/H4bfWp+xqXW
	sv7nvwj1jh3k7bZ38/Vxlh2fW3yxbq4xNZasgUDh3Lle+dWilpZBqP+LmTGipTJPN45UCMLa+p9
	SwEqcCbz1ViO6o8xb19xoVb+Vh4F7s3s3qehY4H0OQRZtrdGZfqe5OhhY7rUvgYasaGxS5plmX7
	V4wfnDW6w0sdNXMcFUjtT8h7rERgcckxaqKRUSi3FlP0Kkjqn2AwMAmLH6tWHyZ7C7uw/elFEq8
	2eGB7w1C0yw8M5lYwlwbKA6QB2lvHhbnn2Sz4rcyNjm/d0kEPozgmvGh4uuXR/L+gJMg9KOvTp0
	xht2+pNoeAIhlBCHs/vlvlcPWxMQPpletNHWcWtD67kIgK7uKBdkey2tmKM5q/ECIxqT9LxERHq
	/Qklnq7kpJUg1PJfHvuZZevCPF3suOD8P21A1a+pxARIut0jYPvElUSBib9k9GWB
X-Received: by 2002:a05:7301:6e9a:b0:37e:9a3b:76a3 with SMTP id 5a478bee46e88-3856f14b9edmr16647445eec.11.1795591250594;
        Tue, 24 Nov 2026 23:20:50 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:20:50 -0800 (PST)
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
Subject: [PATCH 04/12] rtc: mxc_v2: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:18 +0900
Message-Id: <20261125072026.2997493-5-prasanth.r@lineo.co.jp>
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

mxc_rtc_remove() and the probe error paths do not release the wake IRQ
set with dev_pm_set_wake_irq() or the wakeup source enabled with
device_init_wakeup().

When the driver is bound again, dev_pm_set_wake_irq() finds the old wake
IRQ, warns "wake irq already initialized" and returns -EEXIST, so the
driver prints "failed to enable irq wake".

Use the device-managed variants so both are released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: fbc5ee9a6955 ("rtc: mxc_v2: use dev_pm_set_wake_irq() to simplify code")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-mxc_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index 35a18b75c..fe3a55b00 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -301,8 +301,8 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	if (pdata->irq < 0)
 		return pdata->irq;
 
-	device_init_wakeup(&pdev->dev, true);
-	ret = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
+	devm_device_init_wakeup(&pdev->dev);
+	ret = devm_pm_set_wake_irq(&pdev->dev, pdata->irq);
 	if (ret)
 		dev_err(&pdev->dev, "failed to enable irq wake\n");
 
-- 
2.43.0

