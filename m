Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BE46982D
	for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791759453; cv=none; b=H43hC4u72TfujFcR38AvxgKVYwvVMoHewZ9RudlExNIr6BGTxi8Lyg0Jk/6/DiadDmP75A7mU4TSeT+ycwq+wAgTYAZeBPMsZyPXs+7S0JKBCetil2DwuaU6DGS+34O0jjfeG85OBsLFV068iCJu/DsxQYbhgZO/YpvUDMIXsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791759453; c=relaxed/simple;
	bh=A3frJRbgFu5+5O2R8VBv3Aa+UByoDPMczSVLagotiBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxZL0AQVNkd5YHFeuqJYFAo7c7mPAnyenFKxvHdJEQo62OjIXCyI/6G2GZR+PLRPHgw+txf/CkbeP/fVOOR6iFV/5deL2w3GYS8/PqnJ5w8D0/n/wBx75U4l2hiL875TUKyHx9DFA7fF8mfiCZ3xUW1N1/APyi4hstc+imLjfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIkgS7s8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIkgS7s8"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93ead211f14so143917685a.1
        for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791759451; x=1792364251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8uKt/ohPfRzbFT8UsrIleN1or4CaNtgzFDPt385SpQ=;
        b=iIkgS7s8L8qVDoYxsEHy55/6uIUUhrptjsuVLqn9VmB9b/KPhJmvcf82s5+K0/hb6d
         x+/N6JRObnVgExwdqmz1p9c8GZzVaWJHZ5UVA2+pLYdG41OXzPVwchkuvdac+4t3o3DE
         ODVwdwhBiemi7UU0udwe2rnmUJN2Q5yxO7Z5vQJ/iZPv3cV+WZVcS8yJD/oeTOjpm88r
         /PC4t73E/kLI3poq2pVhVaTdn3kPzxKqdM+HVy3lXlnDvm7wJuYwsiOIumJjV4U5ZR7A
         r7Y+odcFsrdaCH70TMsd2czw/hJ2BjQmjZSei+6ZFzeeZ96MKDjrhh6C48v1o0ZpdsXj
         f4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791759451; x=1792364251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n8uKt/ohPfRzbFT8UsrIleN1or4CaNtgzFDPt385SpQ=;
        b=T2opppR0MVsFLMVycKHJRJSGSlBy5lzJWj3hvH7cddthaxg4vxDagH1McjLtzDrrjo
         RO9ScXGOPQX0MA3W5TV4WTBHL/L/i7XuiSxe2ND4emsD47I6G8RTCFrebOVXAxfrBvAR
         VA5j/QrPGOpvm7/VkKr9+qHfsT2Yej6GSneSM9N1PA+XKA72YPDI7CvMTUCCxBy3Z/4x
         0LbDs0GZ1tx/Tzi0eB6DZA07tIsABH9aJA8DJ/gOuBcY4lpAu4FyHMl2U7ptG9ihkEIr
         dlZV4a4vhSaiP7E4ycX0/j+HSAXck95rycxptedpWiw07KvnA6vEVsxuLoSz6diKldA5
         wILg==
X-Gm-Message-State: AFq9FYJ0kHL9VmCwTcrFlsDRetiLt8gt+3a0Cj8WNlQfMkSnIUKYujT+
	jubYhDmcZoveP0HxrdZWJ+SCEkC/+mu/05Hp1Tt9vQLkTuOeraaGGvA=
X-Gm-Gg: AYBFou0BVI4gKtUTsV3oQOZ+yEg8eM4OPszM/OQqem2bAuNzX/jGaCxxYyHh0hShG8A
	1oXuXPXSIoQo9FCGPZMa6nL7BlFz6+gTv2GKuxcwaBVbf/TsChdLEzYTbZFaoTpDxmWXK+2kw3Y
	zHOtMpqfsJ814IMtIyWipU/77qZ14zXL4iwmm0isFVm+/iIlXnMV+lnw3zA0vwyNuZdCFT2AYqp
	dOJlZX6GXwz4VWA6lt6cK6DWxhDlSJQ2msCRyaLlyluUt5TxCjHKKC/+xN2+jcV7WQCoKK+NkJF
	iFbmf3ATHcKyEY9aZN0yuEt66qI8E5tNsZoTeIF4Ryo9yIcvxxr8dQF8QRQua4eNqqLaq58/9pz
	GiwgdrZVkSiCLJFQxM2rd1wrLpy/l1r8GUy65ucy5GmtvelADlo7UmLDkLmPmhPvurvKN4bypm7
	Mssw2ZiDNk18tSoU4S+5+OiwoFiB5cqQUNRLP2625d17BrVCJ6tyIxFXIDNf3rnXTliJOVrxGCE
	RCVVwxTXyE17rSniVvebluwnc4vaL/ATX48BWfA6c22Y5ec0D3nn4j3Tzgr+yJ32IED56QjkNXs
	Z8ld5IQCS9XyKxjAChl3DCdSXcy+
X-Received: by 2002:a05:620a:4102:b0:93e:6481:c8e0 with SMTP id af79cd13be357-93ec1351090mr1103172185a.10.1791759450718;
        Sun, 11 Oct 2026 15:57:30 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98cd599sm723647985a.39.2026.10.11.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 15:57:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 1/2] rtc: renesas-rtca3: Initialize the RTC before requesting interrupts
Date: Sun, 11 Oct 2026 18:57:24 -0400
Message-ID: <20261011225657.rtca3-irq-ordering.1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011225657.rtca3-irq-ordering.0@gmail.com>
References: <20261011225657.rtca3-irq-ordering.0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alarm handler passes priv->rtc_dev to rtc_update_irq(), but the RTC
allocation is managed after the interrupt requests. Devres can therefore
drop the RTC's allocation reference before freeing and synchronizing the
alarm IRQ. Masking alarm interrupts in remove does not wait for a handler
that has already entered, and a pending alarm flag can still be handled.

Allocate the RTC before requesting the IRQs so that the allocation
reference remains valid until the IRQs have been freed and synchronized
on both removal and probe failure. Initialize its operations and time
range before requesting the IRQs as well, so an early alarm interrupt
cannot queue RTC work before the operations are available.

This issue was found by static analysis.

Fixes: d4488377609e ("rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S SoC")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested with Clang 22.1.2, W=1 (arm64). No runtime testing.

One existing FIELD_GET comparison warning also occurs when compiling
the unmodified driver with the same flags. No new compiler warnings.

 drivers/rtc/rtc-renesas-rtca3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index b3875d041de5..c304ed60edc6 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -765,12 +765,6 @@ static int rtca3_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to setup the RTC!\n");
 
-	ret = rtca3_request_irqs(pdev, priv);
-	if (ret)
-		return ret;
-
-	device_init_wakeup(&pdev->dev, true);
-
 	priv->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(priv->rtc_dev))
 		return PTR_ERR(priv->rtc_dev);
@@ -779,6 +773,12 @@ static int rtca3_probe(struct platform_device *pdev)
 	priv->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	priv->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
 
+	ret = rtca3_request_irqs(pdev, priv);
+	if (ret)
+		return ret;
+
+	device_init_wakeup(&pdev->dev, true);
+
 	return devm_rtc_register_device(priv->rtc_dev);
 }
 
