Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A046C821
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389647; cv=none; b=qN0sAV8CRdedBkbmNLnsYGxlFDTOMnUc9SgbrrUsTOcHdQQbk/1f8ezVWpjxSjkSezbn3WTxTckB90sxbBNX6LGCaVM6w782rAY8JxNTUfMp8w0UlYqvZ5uFEpMlLhjJ9tx7lE5FIl0U1pp3pj1G4O+xRwqPN+eDrMpf/1UZ71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389647; c=relaxed/simple;
	bh=q8bwhVOS2Q2tpx89t9Vl5SDienAaREAdOX3DiRJmeU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MJmIA6STTC9WkVGspIML0/FsE19ziTNANq5YuOGeGLsMmkjdVQ+qAK9dwHGvo/GJBygFma9AjwPqxl77usUDxnhifsPRrYShWjdTpgrjLEdlhnZtQsugPxADprhBYfkDHis09+hnQ258Lv12l9nstb3ENIAEdz4x0BbTeeYbqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFuc6nvk; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFuc6nvk"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-804e42309a5so567252a34.2
        for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789389644; x=1789994444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=718Ayf180iqV39sL4SEKsU5v63hqKWeZ6vfIuYMZ+CA=;
        b=UFuc6nvk0usc0NYbQvNXEb/3/R0WYKXvobdpHyAmqBGfymIMLZZUyl1b8ppPDyfOtt
         DprP/QB8sG3nJS0g/r/LCCR7OsLXxUPy+EvJzlk786HoBdHBzFDrdlatpFfFetcW+X0i
         IfBdWMxQKUtGHsErygAo1bN8yQpljpcxwsFFuBXAwpyiYXMJSwjL0GaXzdH+SABrYHUk
         bcIm1trXMrgcLQxhl95AatItVvAB2DkE4QrZARbAdYy7DNewgAcAhwb3IDck6GBL/wsD
         W2FNWOBUeeInrB6CT/Yti+DMLxfPMKscMPaEOejPaaCYWxOq6f+YyAXPGf70/dOpqkSu
         fosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789389644; x=1789994444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=718Ayf180iqV39sL4SEKsU5v63hqKWeZ6vfIuYMZ+CA=;
        b=ogQPfaQ9C60hFO5eOyQnXDX85633Tjbp3GcFnyvxOfxamV4c+2J78Eq76uRc95yy43
         ZwtW/g3Qb/MqK4KrDlCd5py6m4tCYb69bvhMjLrqcfMVYJ1PeZeiFWGalQC7aXHPI7Gz
         MZ3FBHB4M66ZgnYXGBe8TSFIJ6ujtNJVlsEwUo8bzZqa6jSzOy0nBd4vAlbhcTUQwp3x
         qAqpmchCsZY9Yi6EYZG5NH2V6i/p+6BV6vpy8unz9iDs/KmfsqtJjDYyiqDdSomqIfzO
         8O31Iv2BXnipZ7grjS9r3ktM0YIDXt+IHDGaNxhEpP6UVsZInK1zNWe9IZCOqeS/e12f
         JzMg==
X-Forwarded-Encrypted: i=1; AKwUvBxMNTidRiUq0PA1D5Wb21cTCyUov5bb73tPwN3jBmgrXX5e60EPpX+4NDGA7DZWtYKHkXjsSRdVu0I=@vger.kernel.org
X-Gm-Message-State: AFuF++mqtn7XMIM42x1Xzn11Cooov/EQEctx0+Jm/xjMoiNBTnLsyZ9+
	Y1zlXwHskmKoMEZksMXTm+RbPVZkhRDokbOgLYfwgGvXxATWqf9rf9tE
X-Gm-Gg: AYBFou3M1i4csI0iWTsm7WT6Hn6jjHjsKKyvBPnQlw6DhRFej06OxZzO3RXKN6pctae
	J2freSye+q9lxfC1VOwslGW4/tUA1GcUMoAXD6ZhcZAej+k807Q/vQ1OFM9E+i22BTFLMNCKnW5
	YR6UdakRfezM4EB8q+z+dYbvVaQMqmyl5WD7nk84ENgU+QOu41mic4FsigSOcziA6bCLFCxE5hs
	Z5YOwBuJ7Lt6kVpoO8dbg6CZniQ6Ayd1ytWHOzCD+F7XpggzuMR4s7xaxEX4SyeTKH0tyiPzblL
	f9zXRyh2X/dXiRa5izNyr3gZL2sZFjBhLb807oG+H5dqKBKVIKl3oxSqU6+NU8riWQH6mn7QjaG
	Z31mxFLAJFUJhkl67bPvEmucTX4dH+FAx6s8EUyd1jRzOa3jltnLXeXcGNuGmWs3ezgIgrfSgqu
	tllqItOlLS780Do1yJYV67MUkkxW/8HljCYzOZZEGzO9hwjRpxhuAHcDB3AKcvnBlLz8/CKQXsz
	xAiAqIUUOtl+wu3
X-Received: by 2002:a05:6830:380f:b0:7fa:5c68:d053 with SMTP id 46e09a7af769-8089a453a04mr1442257a34.29.1789389644050;
        Mon, 14 Sep 2026 05:40:44 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-805cb5ba734sm6527788a34.0.2026.09.14.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:40:43 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: pxa: fix IRQ leak on probe failure after pxa_rtc_open()
Date: Mon, 14 Sep 2026 19:40:37 +0700
Message-Id: <20260914124037.2204337-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxa_rtc_probe() calls pxa_rtc_open(dev), discarding its return value.
On success that requests both the 1Hz and alarm IRQs. If a later step
fails (sa1100_rtc_init() or devm_rtc_device_register()), probe returns
without releasing them -- and pxa_rtc_irq() then dereferences the
devm-freed pxa_rtc on any pending/spurious interrupt, plus a retry
fails with -EBUSY since the IRQs are never released. Not theoretical:
commit 34127b3632b2 ("rtc: pxa: fix null pointer dereference") documents
sa1100_rtc_init() failing this way on a real Zaurus SL-C1000.

Check pxa_rtc_open()'s return, and route both later failures through
pxa_rtc_release() via a new err_release label, mirroring the existing
remove() cleanup.

Fixes: 3cdf4ad9633e ("rtc: pxa: convert to use shared sa1100 functions")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/rtc/rtc-pxa.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 62ee6b8f9bcd..e01e683c2f61 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -338,7 +338,9 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	pxa_rtc_open(dev);
+	ret = pxa_rtc_open(dev);
+	if (ret)
+		return ret;
 
 	sa1100_rtc->rcnr = pxa_rtc->base + 0x0;
 	sa1100_rtc->rtsr = pxa_rtc->base + 0x8;
@@ -347,7 +349,7 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 	ret = sa1100_rtc_init(pdev, sa1100_rtc);
 	if (ret) {
 		dev_err(dev, "Unable to init SA1100 RTC sub-device\n");
-		return ret;
+		goto err_release;
 	}
 
 	rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
@@ -357,12 +359,16 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(pxa_rtc->rtc)) {
 		ret = PTR_ERR(pxa_rtc->rtc);
 		dev_err(dev, "Failed to register RTC device -> %d\n", ret);
-		return ret;
+		goto err_release;
 	}
 
 	device_init_wakeup(dev, true);
 
 	return 0;
+
+err_release:
+	pxa_rtc_release(dev);
+	return ret;
 }
 
 static void __exit pxa_rtc_remove(struct platform_device *pdev)
-- 
2.25.1

