Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591268;
	b=BeTqE8N+xdLV7ntvI5SUmfRyuvksdkAfU9jCKM0qweovz3mnqlTADWlb6TE8Apgu4M3K
	 /bHd1F1+bz2PfY/41JQZgP4PaymiWL6Zv9ntBxczkApCJnYpO+aCtOdP+NmLYEKrIhFw9
	 KajH/PMV7JCk8F74grwa3XCSe+dbi+UEmx8wHnixs9Y40Adu62yjGEXomgsAT2L3tPOqe
	 NGrWfO7kB4jfRGlkO13Z6uyQ9FpjvFPeIuOmmB4nkQXXGdCBL1HAYcujkVKsNPunpPYdv
	 KHS0Em4UnBjh1U0OQk6/LrHHUYJf9XyiPE/1UCoKLGt9vnA/uPTXrwHco3ZiTH1PFKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gcFff7HY6eDo+GTRdfvS1BQ2GmIPXiVD/xQ1R+6xH7Q=;
	b=tQat89YVV6DsBUZ0P//YIaRMWrIUlnqGNo3U6lP7sYIN2nM6+751PHA3onaszzeq2RUX
	 KW0SxB6W3nqRvod261zAtSfdBGBm/NEXlCXy0AVHWLgiK4JEoU66RJY4fpbWzsQIoNvOc
	 JAST4a+JONtltV4yY8hkfHKknSJS/OLHXAs0xK7HcaXaJtk9E7D2yv08i7lpBlKMb/YHT
	 jJUPGqi1EHiBgKjeAL146kJeB5tmu+uveOcFGXxka7Iw08KrkP2tsadAo8b7GsrqYSPW/
	 WocYOj8GUemebwJ0egLoOyqVXXnQ7hQw/GzOI26f5ypfsIKeKGchdpe+njieUOLhsMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rIn+NHvl;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CB606A32A
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E8CB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rIn+NHvl
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso7141010c88.1
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591267; x=1796196067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcFff7HY6eDo+GTRdfvS1BQ2GmIPXiVD/xQ1R+6xH7Q=;
        b=rIn+NHvlrg56h1dnMlFs6+X9dBZ02jArvhhXlygJf6mbhUs0vUPZGChcUZF7Gfuzgm
         vckkkTuy0yZKE5QZhej4Uh2SQs1dqwzcDVvxGOf0Nw8T4Tmbtk+/NqC/GmjIhnLKQouZ
         AxxnN9MjQE/G6NZh6XQDgdpa2+GBTVMWOs6G0WuWRSf5MrQiFQmB3ywz9kfYnQi2DNF3
         T5/W40rD9ilwu7OJPuvC9So/uPlgokueq30b7Q3y2Sq64kuLd5rXCb9uCGeqqtysbHfv
         /w+Z4RN69r1g7NgyLSkiITM2whZG3LeHkCHtr1e81j8q6AMRX3VR7PcW8b3idf+IN407
         8dCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591267; x=1796196067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcFff7HY6eDo+GTRdfvS1BQ2GmIPXiVD/xQ1R+6xH7Q=;
        b=koAkVXEwq1bIQBzOA/OtGUI3ZX41ETz/ZqZoH4cLdNVNXxif1NrsEJqpJxjPTb8XUC
         Hu2DbN6QngymON9+71738M94kDiT+/f7Ig1ug2QfErUfoGpXFz7oQXzG2uPpCBNSzbjO
         n+UAD3fs+LYKEAPGIy6VnkQNRdNC8IvfpnMgLVoXuHQwDOwW+pyXgXpn6PzyDAu0D3Zc
         /IFUdKWr+Y/rGpuYZcbIdeAMaPoBO/6grDcpc4UKnYTVl1ZFIV91gHaUuKuXS2/lKKFm
         XPu1lrGhBOncbQzAkVehx6415LM/m/3g4TF7K7QldByRd4D4lZC2ozDf3lioKmmRcXBw
         43Cw==
X-Forwarded-Encrypted: i=1; AL+hErH6KB37KfrHzOZs7Et1ZrvyZMx+llxdFG6IRa6grIsIqe1J87/a///POPPBJjaREsxZTdt12HJK9tE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6kDEgpS2puG4jaPgMoUaue198ErP9qy6ZvtV88xFnHNn2GFct
	sIKzvZFcJJ2YraeYO90GfLqpQHj2/QEL2aK27v2qLIffM1foIqRFzszb
X-Gm-Gg: AZFdTZejYW8OzCmF0NBC9uiou8kdSyZDziXmSTtqKDIkJu6BsaBA9Vgn9RG9A2pSgvo
	k25Vhe5ftwohXydSfIulK+rYg95qEWyEFhirzlw+I7uPsIzifyGU91aaya1S58BxSCeY7aIBlAh
	3angaH4TaB4jELJkqOg0noi1VyYKw9um41n6PNV90h8UVlpr/somrn6TjcwUxODu5EKFwUESVbM
	oSMqhGpoVJddNyP3Vtx4aYULIr1R3Pwih5sRTS8aI4GdNOqB4rRtMAh7czDJMrRxOgCv+x5QlRL
	VkAXyCBvZvsXb5OgHYEjF8zGtQoQGkvCM7mWZuJeAFaziLkEzrcozDR1+N0gf9jp/hQ8Bpbdthb
	MIbZamuW2VZq51Ytgo6kFGzTSJ438KxH/+a8xc8ky4S3ZudRl2MNnppBuN/IHQdbHl8PwgWzVRr
	lT/CdIjUl91Gjapl1e6+yZ7Bxr7GsJjR44Rr7c+KzFJVtjwMTfQLbCkLVGhJer+VJKaaoZjW46U
	GHQcfthG8kOH6dYmzkFYH65yf9d5w+ocn2vyarzhWmxwgjHrLoJyvVes1a76oluDIa1QBPWgnLZ
	vvfUdIo9OJ3jIda1iTbrmhdSdvZoqAX5jQJfczKpl9/FTg5RII50tYh9Pr+hEqS7
X-Received: by 2002:a05:7301:6408:b0:36a:270:ce76 with SMTP id 5a478bee46e88-38570f2b27dmr17934967eec.33.1795591267072;
        Tue, 24 Nov 2026 23:21:07 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:06 -0800 (PST)
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
Subject: [PATCH 10/12] rtc: pcf8523: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:24 +0900
Message-Id: <20261125072026.2997493-11-prasanth.r@lineo.co.jp>
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
IRQ, warns "wake irq already initialized" and returns -EEXIST.

Use the device-managed variants so both are released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: 13e37b7fb75d ("rtc: pcf8523: add alarm support")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-pcf8523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index bbd42358a..df70a374e 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -484,12 +484,12 @@ static int pcf8523_probe(struct i2c_client *client)
 		if (err)
 			return err;
 
-		dev_pm_set_wake_irq(&client->dev, client->irq);
+		devm_pm_set_wake_irq(&client->dev, client->irq);
 	}
 
 	wakeup_source = of_property_read_bool(client->dev.of_node, "wakeup-source");
 	if (client->irq > 0 || wakeup_source)
-		device_init_wakeup(&client->dev, true);
+		devm_device_init_wakeup(&client->dev);
 
 	return devm_rtc_register_device(rtc);
 }
-- 
2.43.0

