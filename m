Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591244;
	b=PV/mBvwM0JdxDW+KK4Ud6aSaEG8hJL7tHkMW9C0B3rNvIATwcXiDIiUEqPABnCAr0MGM
	 TnB70OvjT2hWOUedWzavKrGgMQ8+5rueA8Ml6DQmn0gZ+O1SQyuDm7vtTwpPs6m66/Bxk
	 xOEm45MjwrzYiQjjhdaMQKORMu2j/35ijifgDGRVzQyTJjfK4dK7qUOkrVnStyS6CHum/
	 7zXEsmVoK6DCBL1my/8aUlrosCRyOm6TQZN2pkPzIGCFuDfs7KuKZDzmjmnzoAwr52jfS
	 3ojWEVj1pImyLknJBodwrUAfVrVhpKO/vnpS9bSrbPNBMTe5uP5k/lpYHVTgDCMSz4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nUaNgcTUDEPyq+ELt5mHzYxdOi1l+iUjqzlMWdA9j6w=;
	b=V5wly96dkzbNOTM5ITPDI9YLB+AfrTjrVyM1HhsOGWzrcy9zVlVb0PZ+MtMNr/p01H56
	 dzMh8RY7WWFcxnmDk1aovwm3r2HtuuRLBsAXQksDOgmka3Z6s80WwiJXppMnuFPCwqF4s
	 JXJrGiYmpIc74gO7Em6Zf7Ped5pR1s87vQ0EJ+T4vm54+4MTB8lkJytyLmzAqMTxWem5i
	 w+d5LxtpaiG5oUYX4QXgxB6jm9TKRLgJW5DnTatHmR40YpHmE/0EbLdhTjoX0KHkzfN2Y
	 M7FNFFOQFrfZIU6mUnpx3BE8wKWDqScz4ibYQx3qnleB0HDkQfil5ukzLapkNiWFr8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zg+3opkg;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F053606A33E
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F053606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zg+3opkg
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3869f03af6aso4665563eec.1
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591242; x=1796196042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nUaNgcTUDEPyq+ELt5mHzYxdOi1l+iUjqzlMWdA9j6w=;
        b=zg+3opkg5DAVMkzoSLk2Ba8hlW9lTsXsKayWkT8wdiBC+gwdUn6rV0dpNt0aZVRnSx
         9WAdXrLBZsS7cTiuMB5ogtC/gcgAcqBRebSmbp2eWcMpAV/9xOdaq6Gl9hCW6pcKxT61
         Ohr7cpf4625HgGrZt/1t9QF6YLUVcgQP0h1edyCoRga2Zm4bvLjtcz2jABpUSGixrkps
         0CX48DwkyidvfLm2nPdd5O1IIpfm55jfW9ACUWD5HobF4Hz8YQtEfFEhdajw7g6igROA
         K/dpscOSU8vCY+R8NIlMJq2JPu+1J3B7pJSLdapP62KMZ0OAQbhOBXEY5VkcdJ6ewle1
         SEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591242; x=1796196042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nUaNgcTUDEPyq+ELt5mHzYxdOi1l+iUjqzlMWdA9j6w=;
        b=LFCqxxQalaUIeIm2iJrba1OLoIXlq6ZU99EmmRX12qv1218zQbw6KwRcZEEfsML67r
         Znui0OKci2cIrvY8cdUysaLWI0zTuGAFrU6ckgij//zeQ6UgDsrSGeIqBPr3shTDHjb7
         xC3CTXcq9+UX+VuF9YhNCicSB5TJ/ymXIJHA+kSmHPTnM36wCMY2ziIXGahWzGoANjGK
         JV+NdKtorzTpE7TPy4SK1DgwXLu5hrLbOc0tJf9IMN6vy/MIz8x7U9Ea584Xi4mqHKmW
         xdUe5igPlbe5ABr5MG9vKG+jIDzu/GyXkt3R0fxDs+/Oi1fKjAGwvcwAgf0CKPnAeNSr
         23KA==
X-Forwarded-Encrypted: i=1; AL+hErEgTh1owcgEVQKXTmDsNBVzlL1iligbxSWRXO9y/fYG49p8pDRbWmczBVgYbqYJVbtNCS83I4FYfPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4UyeFS0spk6BS6QZSYdY1uvI1tbjeyT4sr5x+hYyDrUXFkqFx
	le3ZCdqIMTL59p7sAp3i85RbFsATXRJuA4fJcO/5P+QzSZhOu8WWTGsg
X-Gm-Gg: AZFdTZdHItudg+EEyBXsHHPwFhnTyOuf6IzHldtCPVUeGaTWQwTgtc6W6Q7rUz6n5O8
	hFNnzGUB3Sepkp7bXf3FoL2uLEWCsTNQ1EXdbeqjzLvZ8VFNZ/+TzZy64PHA+GsMfgwlcaIuSpe
	OvV52gGfqOJpt/iXaCOtdvl9RpbwLTAdKL8OhXFP9L96Mw4b2g2xqYEO+8LBK/eemxweIQ+ikct
	wMbfOb6M8UoZN7W/6XGQ8gJUinyHV+D8yWAtRU0wfD6eG86yG562QKYB2I88k4GiOo2vU5Xgf9g
	Dejyzo1r46CmrlqDYlToAhWgY1im/bglTf+/rcn37PzpEnNy0j41xCTeJXVv/vFf58f8o3yY40Y
	lcI9kgy92mj+FGo+PnZsA0IuO09ykUH12RhM4KEwjVpJGH/VqxfAJMinxRt8S27zpdsGM6LgUU/
	jnlDRoXHddfMI3qiq3tRUyibxTJcAIfDHRVi11Vp070W8P4L823HMKs+ON6RJC7+LbUi3OuBWwE
	ypFtOAEBIpAxpgrXCG1rrc3GMzeUCvamoogqU489cuvoBNbPVVEBm5fYlMvN6dPklDFTDzqP3Dp
	QaJEFgatTyRFT6VokBVRGB/9PdznwknNwkSku/mUStf56yEix8LlMFJQ0VHHPFCr
X-Received: by 2002:a05:7301:7309:b0:382:2ae3:b1d0 with SMTP id 5a478bee46e88-384b3e788a3mr19263978eec.13.1795591242157;
        Tue, 24 Nov 2026 23:20:42 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:20:41 -0800 (PST)
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
Subject: [PATCH 01/12] rtc: snvs: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:15 +0900
Message-Id: <20261125072026.2997493-2-prasanth.r@lineo.co.jp>
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

When the driver is bound again, dev_pm_set_wake_irq() finds the old
wake IRQ, warns "wake irq already initialized" and returns -EEXIST, so
the driver prints "failed to enable irq wake".

Use the device-managed variants so both are released on unbind.

Tested on an i.MX6Q SABRE-SD board by unbinding and binding the driver
through sysfs.

I used an AI assistant (Claude) to find this and write the change.

Fixes: e7afddb2b4d2 ("rtc: snvs: use dev_pm_set_wake_irq() to simplify code")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-snvs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index d99a352d6..647952dcd 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -383,8 +383,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
-	ret = dev_pm_set_wake_irq(&pdev->dev, data->irq);
+	ret = devm_device_init_wakeup(&pdev->dev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to init wakeup, %d\n", ret);
+
+	ret = devm_pm_set_wake_irq(&pdev->dev, data->irq);
 	if (ret)
 		dev_err(&pdev->dev, "failed to enable irq wake\n");
 
-- 
2.43.0

