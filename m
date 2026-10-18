Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C43D411B
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295092; cv=none; b=uuRO21hX820KXiUXnMHKJ41EwurkBn0tPS1l7sB94hpoMz6SB6cxqMKz5CKKyEXXh7pp4Emxw4cLXwAOnWzL9COpa34ddjTVij11KC3kd3JwbeAgeLNFQrFxZGFd5eb4LdKD2ZCH1snS+ZbbuHKGsaVTiYv34G126PyDqW+ldt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295092; c=relaxed/simple;
	bh=hg7raEooga7xKeO4WaQ+tcvC2LaGZVambn4vonEIGFc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rEvclBS0HvUfCDixpkH7mG9CjbLw3n+4ptnThJjwwb73MDFDo7Tv3lRoe2BBBuXBRw2gC5W5Qtk/3y8ZP/6pNvR+lWyTA0hArTdwXYlkNu7fs816pDvlHhoKc2NZ/N/JF9bnj9GPIR9BqgABD7b1fGtNADKMbBVaQqvTrSbzklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ocWBWudV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocWBWudV"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91791ec1b83so9498166d6.1
        for <linux-rtc@vger.kernel.org>; Sat, 17 Oct 2026 20:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792295088; x=1792899888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T5pPwZ/48zpt+uZ5MPec+XhKwRcnWB3U80AGWU6HU3U=;
        b=ocWBWudV2MFoM/2sL5ksJSpXpLLDg3cXs5h5j2FF3sNs3EzPwW5btGrbmdmijUXk/L
         kDFS/gqGgsjN6GEweDJg84RovvZWoAQLIKgSMS7y+CMYn/5XFS4E1ETVEw8/4hm50vz2
         sES1W6Q74E4Qjt93tAbroAwm6MgM8vtH2dpA6fAxLz4Azy8IR21X8wKHhDAJkZ/LIgzY
         FaIIoIPZCbieshM4NcyAe+1eFQbPIePd83PzQZvqP4ZQxaVRFKHVs83IYqS0W6mSfsUi
         uYzuoUt8RsPRc76S9EsS7NikbqGh4ihXGVdPzFsT6SmgUUpcJWXaNcUfLcn9cepC521m
         Iq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295088; x=1792899888;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T5pPwZ/48zpt+uZ5MPec+XhKwRcnWB3U80AGWU6HU3U=;
        b=YyCMSThW2G/vsDoggazHqN9zG5n1lcFKWF8qiAlVcmK4+oQ5kZ579H8+FliPYOOEet
         Ukwp3D2Ph1cfWMeVOCr8dF1ohY94OZM+jIB2EBKEOq4P0Ijv2zBLxysm+vfFNIou3JcP
         NM3vOj4cYX6khxU/09WZFsuT/gRs8qQ7eWWmvncGU7DfE2wTNlOL1xQIyQzSIaaO01CH
         ZfhixP+Il/ePeulGe4ham61S5fdkn27eQ+ons7dEIci22bxxlRgcn9tcG09A6RcSiYK2
         2DXvqm3pGKTruAK8CP2hIBgsVYwapxbk5vhiIEU+Hhec+VOXTABVpae9fJPM0Npwmkgo
         tEnA==
X-Forwarded-Encrypted: i=1; AKwUvBzmiRj3+HeSTFEUCgLrQlNfpU4djJG7JWJbm4zlIb51atGDoBy2soe2iO8hXnCaQDoOtLbUGR2yo7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDMkrx7HsYvlcpVyDgRzTOhN9E1uMNkwocpYPIdZHnIrbXsdcr
	SJkduXXK6AIxtPmp5zoHYq6n0ECZ1izIuL8t8/v1YhZL8wKqwCcU7eE=
X-Gm-Gg: AYBFou2Yt48rox0o4frCzUfFTWKqvzhglwrBjQVE+Ba6hANT0sylNcI+/ii5lMHRIzc
	tmC740Gm2C/6UGWG0X80O30AhmHZ7hJsk/Lq1bqtgL7dXUni1ogOHkFv4g/Zk5Thzc1Ntb+hDJ0
	z5WKfTsI1TeZNB3ihNhFxJh4fzACY9vAgDlNNpQihko/IvyseSIiP4UTNp6pcW7L7/lqppOkiUT
	KFl8bkajOc/Daj2hTTMHuL95H99Xa+ImX9huwLAZkeJ3mCIscTOSUdbJPRccdvQffa8K0gzaNcU
	1szr6qEGJmNEwEJ0LcOxptiyArQ/WLpEBD/uApp03P5C5soETNN9ckNnMStYWp4bfTtbdk/wNrJ
	F3104uCj6e/3nitETNx36X3TUEIWVaE/9bHmiw/zgR2z7+8FDAv6XdJMF0yG+AJeMkljJM2dz9d
	RDHEJYmzun9jWk9nwBOk9wmiGtxg5tEa3iwJ2P1uC1AWPY0TlXGWDc/5UzNg/LQw0ZYLK3e8EG/
	+Hx14bCxlfKxNM+cLt/9MuMkhFWfnun3JwlFrf/eUkX/Zf/fyHq7c3oWDmJAhcWN+nxfDnndv0I
	16fZC7ij5DRsjoZBHaMEcE2mqKkV
X-Received: by 2002:a05:6214:2f89:b0:912:588d:55e8 with SMTP id 6a1803df08f44-91bdf0aa995mr67665616d6.9.1792295088031;
        Sat, 17 Oct 2026 20:44:48 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bea60e66esm22559866d6.26.2026.10.17.20.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:44:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] rtc: mt7622: allocate the RTC before requesting its IRQ
Date: Sat, 17 Oct 2026 23:44:43 -0400
Message-ID: <179229507333.3965554.17726204422948048488.rtc-mt7622-irq-init-order@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alarm handler passes hw->rtc to rtc_update_irq(). Currently, the
managed IRQ is requested before the RTC is allocated. On detach, devres
unregisters the RTC and drops its allocation reference before freeing the
IRQ. If no other references remain, the RTC can be freed while the alarm
handler is still registered or running.

Allocate the RTC before requesting the IRQ, and initialize the hardware
and RTC operations before installing the handler. Register the RTC last,
once these dependencies are ready. Managed cleanup then unregisters the
RTC, frees the IRQ and waits for running handlers, and finally drops the
RTC allocation reference. The final irqwork cancellation therefore runs
after the IRQ producer has stopped.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: ba5d018135ef ("rtc: mediatek: add driver for RTC on MT7622 SoC")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
Compile-tested with Clang, W=1. No hardware runtime testing.

Based on mainline 0fcb05b72344f40806cbe810de8872f1698bf053.

diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
index 9e17dd09d567..c86c8cf3f2d7 100644
--- a/drivers/rtc/rtc-mt7622.c
+++ b/drivers/rtc/rtc-mt7622.c
@@ -324,11 +324,20 @@
 	if (ret)
 		return ret;
 
+	hw->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(hw->rtc)) {
+		ret = PTR_ERR(hw->rtc);
+		goto err;
+	}
+
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq < 0) {
 		ret = hw->irq;
 		goto err;
 	}
+
+	mtk_rtc_hw_init(hw);
+	hw->rtc->ops = &mtk_rtc_ops;
 
 	ret = devm_request_irq(&pdev->dev, hw->irq, mtk_rtc_alarmirq,
 			       0, dev_name(&pdev->dev), hw);
@@ -337,14 +346,10 @@
 		goto err;
 	}
 
-	mtk_rtc_hw_init(hw);
-
 	device_init_wakeup(&pdev->dev, true);
 
-	hw->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					   &mtk_rtc_ops, THIS_MODULE);
-	if (IS_ERR(hw->rtc)) {
-		ret = PTR_ERR(hw->rtc);
+	ret = devm_rtc_register_device(hw->rtc);
+	if (ret) {
 		dev_err(&pdev->dev, "Unable to register device\n");
 		goto err;
 	}
