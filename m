Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591249;
	b=bjpLXxHHDDffu/FkDQJtvTg9FbDxYFR4EHF1DgakF1qvyZ164H5VrAxk+t/u5kkhnPYq
	 QA615twzC7ddh4hJ4Cf57ZZoBSzKI0tLlaOn3EWiqienq4r36KgUMDuuJ9OpJfSklzOWo
	 0lC7HhQnvNsOwGJNndNerHc/gyeAeTo5TzkkBgOOK+N3ucSxX2RHb1WRfC8GvrxwZlzTx
	 2O9kCj0SA4ai5NvbhWYuLOYj8fdoaVIyjZaPXjsMLIBVZfFjBzKOuyxnJnsBbHjKQPji9
	 DnyjCybcBMs+1VoDK8puE+Hrw3oRjByTSbM+L4O2HoMowYvT6TriVs9NyYLu9bQ4/yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9KKnP52JX79Zys90VqZLV9ybW1ETyKOn8HIAm5soPhQ=;
	b=sQz2IN+q1j1B4/AHpg3i07HkdlTI/2jsgagryMbjAAWmp7jaGIrlcXL6zUO6lfsgeDAo
	 Pbm85lUWAOS+eTANK7SfYRSkGXTRj9ALNxax2JdMXz6+pwBCmqg/bIi7tAuqHBhwVsaEe
	 Eno4StVkVr1Xjd4nBx3C2XsIgLtB/3k/s3xufGQt2+YtwwOf+83NwREBM0v+UKNiFnm+D
	 o6xBM81jgtI87PsGRtrA2lqx3rOAONqHUZICMDGpjBTY4BpUrGJoOoS+nu2Z1qM2XAU1X
	 bt1ZpNnxohEtcbnmeNSd5TpTYKUC47yAYu1juI9Z9Fyoo2Bln39rW17JcdDs4knCsJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixpso47F;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E213606A33F
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E213606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixpso47F
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso11667752eec.0
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591245; x=1796196045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9KKnP52JX79Zys90VqZLV9ybW1ETyKOn8HIAm5soPhQ=;
        b=ixpso47FlqXrkUDpNzWr0jwnuvA8bOv/T5syTQxSy9FvAnhAzAsu/3/W9DB23pA1Dq
         Zncv0gGYhIz8LoMM4AbEBMMXsqwxadxw44I8hOFy+Nw7s1mo76lwvhKOg3X80KQWvViM
         f8WltvMqzh0IibT4bEs8SfGOKHHW3Rx/jXtzaP0Xl/ltE2NjNIW35xEXkXE9C6UZYDOs
         FWsOtQIHQp1vAP+pTbNlH7HEYXFTr5u7FORe9OyZoYIEz/uV2n5Dt3b2AO5aZoJHbmnR
         mGmQD1et1rNRB9EtH/GJDeIJqkOai8BFvDGyA8w8NLUKQj00IFU5DSsjH4PM0+EwwwZE
         IBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591245; x=1796196045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9KKnP52JX79Zys90VqZLV9ybW1ETyKOn8HIAm5soPhQ=;
        b=1vvPJ82XGXP/CIMZbQbSgTE+u0YGkHTQ/iXCLNytdTC6JJAGJx6VMdiRkFNC3w0rO4
         kg8do1KMEM2kG2LwXWNhuVVwuyH7fasl+dpsptaNgcvfwXuODP/4AcscXP6UqjcaXyLZ
         fn0RCSLiyOW26UPqU+qE8yZuFpgS0rPtRrn1xmleccAsOc8BRVZA1kHn1HUIHHybcBLz
         IHbAvB8fvZWcYuKh0a4qAgRIkJfUJxEX5vqiTwF0fZmi//ZLq9mIv8/F0dq8TEQD8AUX
         MCTkzEyPuRu5EHo0TJYRpTpLWMQCQb0RGzgdfQ94XoshD5abMrE0Nw280ofgkwxaPzV1
         O3uA==
X-Forwarded-Encrypted: i=1; AL+hErHMkMIZTUWyfpQnN75GFauY9VShvykKXkiul9P5U7sIujTaifjrfi+z+h4jVT5vD+Pw5CJkkKCQpH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QjsItb196/PIgbmAocIHKHyoaay+DlZSH6huKZPiDdQ/nWCK2
	YVz46E/7OGkYB5IDUIDgaQ3ZQj7T4M5an/VUBqfpu6l/Wzzi9rx29dHD
X-Gm-Gg: AZFdTZfx1KvH6m2LzK0a9oiyxvZeAMIcOMWygzeVvpibgLQwT8p89Qmi8LEVbhwd+tI
	pG9U3H9CyKJgyyVOtnGu/a9taQglZHVYcCI8O74kQMEnCS+wLhsovTiXMwkh3XgvSe7hmfnwyFh
	XsK6JbGx5XTUjI6LTvHyl3Ry52+dEXP5VLb7mJztFHMFr8fdaIScKOHtJrZ9bcB1fHk7jw/s/gd
	81xmIB89TF4KdG/aDkj/WcpnY77joe0Qv9Hjy13a3UGNW16EgDvH7C5B7mi7A+yIBL1UbxA24wL
	nSkhbYr01FpZmsIyzO49eYRh9ghLabvjWQYHzQG32eHKeBUUXcuoYLMX9OAblF+UsP+CQfL9Mjz
	7rdGz62ZOCWKmgjVNBHJB9pnyIOasNiaTo/y/VTH8Yb4SArLsFYXPVR93cYhPjSW9UQA+HJ1uY9
	MYSLIu2qGVhYSQG73NFe+vknM1V5XgK/6Ud7lsUO3GEx3KYyN+94GVMh6RfqTGJvncn52pl8PWb
	b0TZbMfp3Sb1sJmVFUY0dgt8m6Veo2EDnJplNw14p71meyegAa51D+yruPUYI6dnv0Jzs8OY2HN
	2Y4lZ8sAo3QYZz9AtkNx4BHXyHrvYMQt5c69c7cnPLopOHpX8JV4/O3Tm51vaYTrwq+RkcNad2/
	12AbIqiSk4w==
X-Received: by 2002:a05:7301:3f0a:b0:384:8f9:bbf6 with SMTP id 5a478bee46e88-3857180d3b2mr28249889eec.38.1795591245029;
        Tue, 24 Nov 2026 23:20:45 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:20:44 -0800 (PST)
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
Subject: [PATCH 02/12] rtc: mxc: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:16 +0900
Message-Id: <20261125072026.2997493-3-prasanth.r@lineo.co.jp>
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
driver prints "failed to enable irq wake".

Use the device-managed variants so both are released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: bc0e731fc289 ("rtc: mxc: use dev_pm_set_wake_irq() to simplify code")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-mxc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index f91b0994b..90b383896 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -377,8 +377,8 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->irq >= 0) {
-		device_init_wakeup(&pdev->dev, true);
-		ret = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
+		devm_device_init_wakeup(&pdev->dev);
+		ret = devm_pm_set_wake_irq(&pdev->dev, pdata->irq);
 		if (ret)
 			dev_err(&pdev->dev, "failed to enable irq wake\n");
 	}
-- 
2.43.0

