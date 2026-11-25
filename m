Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591257;
	b=r3TSjrxt1Y5JE6+XzMXA2tvEjMcXtCRRI1YilNpSvSE9+L6SdE0c+o0ihVjaPFBwL3UN
	 OsooIIwew+TvuEdbOZVkjfE8bLfq5eIlI+yhMhfDLmj6gQCezUa55P6ml2SvwUDqA5e0D
	 yqe69VUW4tLNdPLIG46hFdGTkqB/RxTOYzkobVAfOGzZShhesoErK0t8t3pJt1PwQU4CC
	 /jGKnAoHx4ze007kw0rGx0KAgUF99OdZi4YSVKXXGVsw0Ay7C8eWIUf5MJEBfoZQ9Bob/
	 JcqYVR8/93kTGSQwSrRuipaAWXx0j8+3MUcNuTN64+64qK01n7i+wtvIuaNg8mfDdHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mS57S4IRnHol3XR4gXWGEuCh4B3ziPP7sFo4bO43kVs=;
	b=jiPqXBHCaaSJQRjFrpfaVv1sGWfcxCCl4IqYDScD8SgVI/DFgZrpCl3ci/f86GlQivZx
	 DEvcwn9R6prUmmTITHGo8qbiD+PK/naamtW7kzpdlUrM9VsVUUVd/vmy+BB5ZdeVc5LOw
	 NU5IKlnZnqsa0eUX7YTnNW3i0QVO+ktRdrU+PI3EfB63khzDZAQ1/zw4AoOqo5kEMEd6k
	 4xGQpgc2qBlYBo5v6chowtEnBsoJBGZ5vtSFlFVIgsYMSsDhtQCD5WYu9TSI/Ev6Tp0p6
	 mvKQm2Cz0EyuvWHJS0rShqcPZ8P/JjS/TkESg6mlIpJaugD1DzFb/fcjyw2gcren9Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ahpok24z;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655C606A321
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3655C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ahpok24z
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386cf1041cdso884753eec.0
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591256; x=1796196056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mS57S4IRnHol3XR4gXWGEuCh4B3ziPP7sFo4bO43kVs=;
        b=Ahpok24zDsEbOXQNlKYHt4yBPV5GdRQ85vl6VNMfx/o9L6WxDsTTxJB+jcDM/wOE5O
         9nGCTbsDrHtVeElZCf5yRibej2DJPipcwK0NWJqsjRZeck8kDNTAqRZguAP7KTVPeT0v
         3B5dgdECX0KZUdcDavgnn7KSfLZ6l31HeMWPOjuoaSdnlFYXl6/ay3EHkPuggXSy6WKv
         qfrdcYvt3zpc5FVAV8JHOooOuIx1V+iMxfThLJODz7zZfBX7rGBzFs/zy0Jbu8kxdCjp
         svXrRF4yLEkdJwUVfOMo9Qhg2gNcPH9RcyJsbBiGZj23SSM0Avu4oegJGIcoaT/O6BCa
         6dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591256; x=1796196056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mS57S4IRnHol3XR4gXWGEuCh4B3ziPP7sFo4bO43kVs=;
        b=NN1xjEYLhZW7m6Dk7y5k/k649b/4SJwHEFkD8n8jQU7a7T0YtC+rusZ+0a1qruCxXa
         ZzAFxXEZEVdYVFJcHEjAyOTBOp9apJ3PAbx6TJFswgveXEiH12Esrsjs5MeAGgQrTTtV
         Czu/TDkbDa/lbv3GiVJxmUwf+yUU0oVa/ICZh7HZirHitG8YuP3tErWVk8fucocoKub5
         o9wmuVUxz197hRo8HPm/9xVyzicD1M6avWSFoIwSN11yQ2JcM8s426sJOmfuGa5FQoSL
         8H+Mu7gdzDMwrCy+MUK+v2ZJsHwRf290NtU1056Fn4uhqI7lpvoD5RC9L5Wby//CZ8dh
         XrxQ==
X-Forwarded-Encrypted: i=1; AL+hErEMaVOCdsEF5BLFO2jWVbnhHGWuOemP2hoQp5vcKGDHd+VvGXetF4xN70WP+2nAXNnuJXwTMP5uFgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BrNMFbWFzh7IevNtOVhL2LnlgGVaPaIytxCagRJjhNWdL3NNH
	mxOVfS1LiKj+VUd7dDYvYdNOT/Pqx/SsqZ8ZxfXtXFwgy3H60Wgl+Bek
X-Gm-Gg: AZFdTZdMmjVVEIx24qeDK09G+PYO6vutYsqFqR8o6lKTJZsq9fOEhbjp3RhfxpHnHU4
	V0C7P1E+Td5JwP6cgL3SUTbn0KnW/ELGGoUCe7UkuUszADtB2jaUlonN71qn8bsfjUusEWa7i76
	vRKVerqxia2WjCRav31ApuN5V9/IL00RbPiMdryKNbUotF5fYQewUisQnHNsH+Jvsyy8JXW+srX
	eBkK/C2XMgytkr3BzNfoJi5nvPCPeLVR+cqTIGQdezcQUNq081dxrJWo8KNj/4x3NHIzJkIptZp
	PKFZNkUKKAoPRDNyh+RHlMardLtywiePbSuyX+94fKo1wNSCl+N05e9MAQ9f2NCfyCU7hUoqTSQ
	RqSTk+Jm7Oe2batHx6Oe3uE7KVnxBm/HSXQ93ie+jX5WxUHUxHYcYvYxNTx3mxnn5Vrt83gHB9P
	1u6BCL1IIH5bWopoMpLx8HqhmZPAAh9Y7KVaYE0YxdUpQFlmKk2ZcWEfdEXtIl1vtBK6dCylE2+
	+Iu9/5V3ZG9maOb8VT80W96QeUBIrhwY6wXADWQOQQUjYsigG2yNSKAuHL3tAgWq5AAJD4UVgxh
	ayfbO/OB4vHX5ply39lgIDBPSUbHeLn/neqeAMKRn7M13EtpimbbV1apV9RbZegy
X-Received: by 2002:a05:7301:909:b0:386:a3fe:44f3 with SMTP id 5a478bee46e88-386a3fe48d9mr12442112eec.4.1795591256101;
        Tue, 24 Nov 2026 23:20:56 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:20:55 -0800 (PST)
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
Subject: [PATCH 06/12] rtc: da9063: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:20 +0900
Message-Id: <20261125072026.2997493-7-prasanth.r@lineo.co.jp>
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

The driver has no remove callback, so the wake IRQ set with
dev_pm_set_wake_irq() and the wakeup source enabled with
device_init_wakeup() are never released on unbind.

When the driver is bound again, dev_pm_set_wake_irq() finds the old wake
IRQ, warns "wake irq already initialized" and returns -EEXIST, so the
driver warns that it failed to set the wake IRQ.

Use the device-managed variants so both are released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: ed17a2bcbb75 ("rtc: da9063: Mark the alarm IRQ as a wake IRQ")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-da9063.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index b56b9d9cb..2bb32156d 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -466,13 +466,13 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 				"Failed to request ALARM IRQ %d: %d\n",
 				irq_alarm, ret);
 
-		ret = dev_pm_set_wake_irq(&pdev->dev, irq_alarm);
+		ret = devm_pm_set_wake_irq(&pdev->dev, irq_alarm);
 		if (ret)
 			dev_warn(&pdev->dev,
 				 "Failed to set IRQ %d as a wake IRQ: %d\n",
 				 irq_alarm, ret);
 
-		device_init_wakeup(&pdev->dev, true);
+		devm_device_init_wakeup(&pdev->dev);
 	}  else if (irq_alarm != -ENXIO) {
 		return irq_alarm;
 	} else {
-- 
2.43.0

