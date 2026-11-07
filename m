Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067679;
	b=O9UVJAJzvHKlYr7PuLTuSvgLIBGRruM/mG2VcFaXYrMNApUJPZ3z0b5ryge6IxAW4jQv
	 2XHgANxffxpQDa9OZJloFaQ9MmvHFdqZNP8p86GrCu65p24o/1QHG5jyot808MOEt8Gqr
	 dAgePoZFRCQFvl9aW7GeEAaCFBT7m5oyvgVYzsdVkzeS1bl0OQgSHu03WdbUoI9pPqOOI
	 tXgdNbdW1mmYYKS971DrkurdLM6Mop5npGLHnCk52B1KlIn5JaSvAQimAPelt6mNNtil9
	 3UH5Isg5DoKQOTItekfRrXcU8Un9f6s9hpwchletQ4+gStWlh/J+kQf32JdxeQnEc5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=w9ad/RtjHCJ7QFgHhoqC4kL6cny/ndwNqseOOI9y/+Q=;
	b=c+y4tjzgqI50OvDtIHZ1Y1ESIkqX/XFbcgZu2h6seJ8fg/JOKA9jLJ2EM4EEOeFEsGfc
	 0ou4f0OwWbq67IxXdfMdC6unurAdd+44ZylLvMuO3lJ50ZYGO//JIl6Ka83lUiHsTDXvm
	 amDmhLZW/pNVZXtcFG089apAH9RMlI1LPyx92RM/iaPYzGYlioamoVxaFKYdsExEnJiyN
	 dR7kRIZnlbsjrkUbNpNeELuZGphKmuIzz8qa5m8Pabdm2nWAU2YMmYD4CrVex8zCR+gHd
	 O20ZPpLYEfLJ2RRh5FvBEsa3s0yCf2/el78je+arxryYmRD1b88O4t6jjV/JcHBx3Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPvdF6aA;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9746082BD4
	for <linux-rtc@vger.kernel.org>; Sat,  7 Nov 2026 16:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB9746082BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPvdF6aA
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1aefd1bf74aso507628c88.1
        for <linux-rtc@vger.kernel.org>; Sat, 07 Nov 2026 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067678; x=1794672478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w9ad/RtjHCJ7QFgHhoqC4kL6cny/ndwNqseOOI9y/+Q=;
        b=vPvdF6aAyOOGfXmtGZoL9hYy3XjlZTVFvFMW4LYLACarr2+XYknq2u4wzpWrixOJNS
         yMl+JagsDkAZ0AD7fiCRjB2X0DdfrJKvRvESGFGieQEWCouMREm0LHPbJ7QlWcpdcBNC
         /SZt4iusqNDs2ce1E8c/bc81OYjYYx/SBCc8WgtbKZa5YOp6c6Hj9o97zsB6ivPxDN7Z
         zeu28ZxlZpDHLeYyZKRKLFYHbvs+XOFlloKhX2fUFrLJRhVh1Z/T2930c550RWwmGXOi
         u0csKjzz2bOYTqs1PN8QzS/h0EuwnobtEr+2iPGF7Mn63y3nToz8U8E/aeFj0USlavUo
         7yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067678; x=1794672478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w9ad/RtjHCJ7QFgHhoqC4kL6cny/ndwNqseOOI9y/+Q=;
        b=rch9nhTNhRfNRWarEjTtRZ41vjLmYJmUXX8+QTyCYLZD2k+r2iAz7xIKnFGPBJyt+2
         z0NqkQXcpyBihTmca6dCE5fvpKDL6RjsWb4pJy4H7C7hGgelETAWa6Fm6FtQxuYum7/H
         7/yZgbYaLliaQ1DZoln9wi8YgaML4xW4oOoPRXH1izEToruzTyVAZthlUrWtnuKxZVbj
         aAitnTS9tCMSAxHbbQ1FDQji4/S/0cApbL5KOVEuwVSp1B+SFCgEcV5ZEfHD+FY70rve
         TXeOwu25cKJ6ORxRmE10GXO0sBOvWou8JfvWfPmma1ga7XzT01HMATmyAjoaQnFDGODc
         RGYg==
X-Gm-Message-State: APuU4Z/ddLEJn6bsmHIsVDQ8xwapHKAR1r3Wy/QEIpRdyY5qriV/+Z4d
	+2dTKkdG7tYtFQYw6GaXSkikEEJC49bfATSTOsQbxa/xV7HU5uBZ0FXfkEplueCa
X-Gm-Gg: AYBFou1FU4snkIN1RaWWfrKSIGbON9iNCch3gnpX0ct9sdjqsgalgKq7RbAVTTHHWKJ
	wFXbALRwY9ZlbIam+96dJpbBSvmrrUw3k5UvD28mcVsNliVxGIF5qO7ns4bcKYRsLXWbNF8o3Ui
	HLKhiKCa3EYrXaxYNDNv6ovMj6e0EfOMums+zdsOxB8qU22x0vBkeYpG/TZPtrt+wi4Z87ppjdK
	YBnmK3D2uxdYmuZbx3uF77YUpaIl/OdxZ8eH/D8vvo/vzlFqDe6rNbRYebwiEAwUFoDAsZnKjtC
	Yyw9tvObe6HCHxZv+IyZJTY6CajJ/o08jy1L8Wjm+9AQIko8R3QqxDoWWtwv5ZB6Ji59XZWsnEK
	a6p2dALcUB64ZMNmjo11dJYr9d6oIfAQPboKiJE/tjNHuHaJbtXnpY6HLbYqAQUM3VYyEezl1jC
	W0hr6zccjvVNrJXvTIIkSXH8T6eWhSk/s06mW1lhq4wNf7A/pJUp9jrek/jpcxihFKHoTv9n94/
	J1H/xkgoKzXBT9le3vAlx21KRoIEerJYcysR6wQxfdCRe0Bh1HhcGKeROBwx32VOXGI0DvZEaHs
	AOFkeoe2pvVFZwqwKMaKPYT4vciFI+II/5mgglG8nc/wjPo4KwlD
X-Received: by 2002:a05:701b:4591:10b0:1b2:46ee:4cba with SMTP id a92af1059eb24-1b269b2154dmr3020374c88.18.1794067677587;
        Sat, 07 Nov 2026 08:07:57 -0800 (PST)
Received: from LAPTOP-LJ15R92N.localdomain ([49.43.7.28])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4fd2d6sm15683821c88.23.2026.11.07.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:07:57 -0800 (PST)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH] rtc: as3722: check return value of platform_get_irq()
Date: Sat,  7 Nov 2026 16:08:39 +0000
Message-ID: <20261107160839.422-1-akshatrawat095@gmail.com>
X-Mailer: git-send-email 2.53.0
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

In as3722_rtc_probe(), the return value of platform_get_irq() is
assigned to as3722_rtc->alarm_irq without error checking.

If platform_get_irq() fails (such as returning -EPROBE_DEFER when the
parent interrupt controller is not yet ready), the driver logs an
invalid IRQ number in dev_info() and calls devm_request_threaded_irq()
with a negative value. This causes devm_request_threaded_irq() to fail
with -EINVAL and abort probe permanently, breaking deferred probing.

Check the return value of platform_get_irq() and return immediately on
failure to properly propagate errors.

Fixes: b45062619840 ("drivers/rtc/rtc-as3722: add RTC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
 drivers/rtc/rtc-as3722.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-as3722.c b/drivers/rtc/rtc-as3722.c
index 9682d6457b7f..dfa3628ad95b 100644
--- a/drivers/rtc/rtc-as3722.c
+++ b/drivers/rtc/rtc-as3722.c
@@ -198,6 +198,9 @@ static int as3722_rtc_probe(struct platform_device *pdev)
 	}
 
 	as3722_rtc->alarm_irq = platform_get_irq(pdev, 0);
+	if (as3722_rtc->alarm_irq < 0)
+		return as3722_rtc->alarm_irq;
+
 	dev_info(&pdev->dev, "RTC interrupt %d\n", as3722_rtc->alarm_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, as3722_rtc->alarm_irq, NULL,
-- 
2.56.0.windows.4

