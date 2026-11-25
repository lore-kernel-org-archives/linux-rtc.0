Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591263;
	b=W0pQJZchLkUzwkLmrtY85lRl0nxppFiEx6fTX4Fk8rRtwkAoJiUxs9G+K2ACTwXonWQF
	 Mx6ST05dAFCWnK5hUPUHs5UClBQtVm7QKQRQGl0xkutUZEZpuvCQGiRU6n4igOyzmhUW8
	 kZcVR/W2M+rH3RSIfhejUOwHZW7LxfYhNI26TIKp0IAnALEujFkDXEqcWYcSPaQgz2DJk
	 U1pzuZOE36GiP1GmgLjexWLavzR4hnihwcSrmz6xAoDZ9ts+RQAO1UMOCwDzwGf0L5lwB
	 +yIUiFfm4t8Ghhayf7b/uWRNk8p2A/QDU8zYfvEGLBqGcr3bdLrn6UYwCeLmz1XplxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FtVSmu/GGPVuhZAgkgs5kn9m+hoaQiyFsreDAgh6jZo=;
	b=hAxrtAgpEpVla7L7tPMGNnpZovLXFqSWYk6dJI8wvI5fAAfeYd1b0Co8ighRln35WQPp
	 cpK83K4Us56pRTqK4jUYH0ialw5BNe0q/+I31wiZoze91MPjjGzbnHkvB8eABlGN49Z+m
	 +lazXvSU8oJqjctJ+f4Fd9bugdWwOYu4uKG5v06rr22Vdx828pLUUDb3PT90ZuM3VHzgS
	 ZRaxQjAwP2sgxAmYz198vSKxZR/1qjrJmGWEeqHq/+i3+lwHs8QP4QvRhUZaoG8gH9h0w
	 uD6JSZy7EzoqsJ0wenCiABYz4c9VMQSVBvNyfyi/gBlYUr9kgXosH18CFE3NLyt5mcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iy+ARhJn;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8A606A321
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA8A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iy+ARhJn
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38190551625so10862836eec.1
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591262; x=1796196062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FtVSmu/GGPVuhZAgkgs5kn9m+hoaQiyFsreDAgh6jZo=;
        b=Iy+ARhJnmfYE7tL3sQzw0P10feOOpCgboqPDl7Wg7r4INy9tTccRM2trmVkf3w30S9
         e8WFyGIq0xuS4BA1369M3FtefEHx3BbtOa3uys+535IBCXNNeE91XQ/1WLIYl3Vjo5kf
         ir2OFjcBn+rRs5j7A4iXv7MDI+XDB75gU0KQqHFnlhee3dVTcfC8ygLXM1BixPfoTXeO
         uMHpK8pjdLINIuYPinCY5qGS/LGuS45DYTZbxLtjic4z959+W3o2sJFMJuDh9E/w0bsZ
         z8AVlPQa0i7fmxK+vEYIqBWspZyfrO4W5P4/6nTcCJSFOpljLrMUaM0NpNcLy546Dk38
         B+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591262; x=1796196062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FtVSmu/GGPVuhZAgkgs5kn9m+hoaQiyFsreDAgh6jZo=;
        b=2R/4VeCK1DkAv0bdUs+g5tSKEihAtJ/U/vohSxaqVdcSIwqQOF215Y33zNNkcAkJIs
         ohwSMDbuuGcT2fb0UNf7ULCLvxsRWeOfsnm6ucl6R+jMh/bqBWzKA5ipUjGPH5ZRrA+o
         +hwbp17sO/PRS62C0QKAHsyD9I2LqaxGzDDgbZt3O6XCt6hBg5S5dZEjK+4A1km3GB9T
         rt+LZ/4wRfgFcKQ0clYCiiXCU0jeBtGAsEArjO5rz/9iWEXtqHnAPHpmyBgpfmy1EqzD
         eeRcXvBr4LIC9GvKIttjACPG3nwhtsffUfaDh4tJb7OZ2iro7ygb8Fk9ZHK5kK04fDn/
         AVmg==
X-Forwarded-Encrypted: i=1; AL+hErF45KgS1OV6KvavPTRLTRp0OsjCKp/4HAkultGrpJtq497hd+yhKX2LCpJjtdGqmCwu1g+I1OOXlYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/S7SHlJwL1mTLmhQEkntVqcHqwFoDq3G0XcGe6n6sx78FP8HjF
	vP/DKNdsZ4QbG20nGviYi8B9461y7bKFupt+iGp19TZv3yJjPcvx17pP
X-Gm-Gg: AZFdTZeGrv5ebDYsnIRW67rmv3STZ9LxHqym5prS6ZTRmxJJN14YAYO65iAqx3v1Zxw
	UaKzjNEUXXw2NHv8UjiJnLTbdtQycLSS8HudjFzxHjL7Lr/Rg+3GGrzcuO9/R0rA2V5v7spLCt+
	mupPrx2lLFZBc601cyaYjBJgMmZETZ0Q2yQzK8Jj6yP67AZzqHlrmCwx+MIwT8ZaEHy8CFNKhNB
	E6O5i/c8tOrFqhoHZGIOflJfwrQNnO/0s3BsNmw9f9/8wlu+uL85IwoRBTcGUhmGPznLB0HsHQT
	5fA48TwXj+II0HNwWpK51rqMAYkOvYoWLY4BktlOgXohxL6wS9QReuPhTmX4Dhzl5LojE73mLtW
	Wz64Q1bodGOyNpR56zd13fz3DfTDbtKxbftCJEXU9a9gfpIo3PWdw9LHP5BKrxY3NQhasZbOFAw
	XB1Wx7mes6G9CeUdLtzHk5yDeVPz9vs9ZJEwREYuW1J73amPZBLSO54qa6EGqWRlHi2vOhs2T7Q
	bK+SttS0/7O3DAntODc3PMqeOrsO38BmFkwui3WiM6yItmo7VJ9CkHpVxZUYUvOYxNRHNPjE3bX
	mZvjN3HStorM3bwmeFtLTiPvWhMfKMqlnEwS8wWLPODkzfz167kDJ1ntmyCpNdBm3XTi57eHDFv
	8IvZvjK0AHw==
X-Received: by 2002:a05:7300:f68e:b0:36c:a42d:9bc9 with SMTP id 5a478bee46e88-3857015357fmr17092295eec.25.1795591261375;
        Tue, 24 Nov 2026 23:21:01 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:01 -0800 (PST)
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
Subject: [PATCH 08/12] rtc: jz4740: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:22 +0900
Message-Id: <20261125072026.2997493-9-prasanth.r@lineo.co.jp>
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
IRQ, warns "wake irq already initialized" and returns -EEXIST, so probe
fails with "Failed to set wake irq" and the RTC cannot be bound again.

Use the device-managed variants so both are released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: 3b2dc19ff9a1 ("rtc: jz4740: use dev_pm_set_wake_irq() to simplify code")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-jz4740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 32c331f3f..41501c9ed 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -367,9 +367,9 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	device_init_wakeup(dev, true);
+	devm_device_init_wakeup(dev);
 
-	ret = dev_pm_set_wake_irq(dev, irq);
+	ret = devm_pm_set_wake_irq(dev, irq);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to set wake irq\n");
 
-- 
2.43.0

