Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591273;
	b=ztfYzqcYw2HPRSYBtNaD7v6v3E8ssExHYBwMENNTWu7OWi+DqjwKLXX/X5EPNqFjuxSP
	 nXDX+cztB2aImg7Gk9jLa6FO/vF+tqr0wl4GnpYgXygzUe9hysky4Noa9vcDMPRxfLhFd
	 qib24yf63gXMPgnHrG9Wa29XWWvFoQJ5A3YNSwxdBF6ZZTsxhTA3VJh44VL+WqRcopuBG
	 868IkZ7PAyKBE4ZHjTZgzFtsQMiNQ2EBR/uPsP6H40k0RER+BewAzU7zV18mRYuZOHtmj
	 HVsRUHBhsDeNGnXwyZBSLAMBeoA5tu0+yUHgiXup7rMwq6r0SSZR9e9gpdPljAhV4/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=io0jgXINzxf8Pk44PIZlHBE77FZbFSzj7shA0YE3rU8=;
	b=JfF0kKg5OqKw2PcGZxRMMdzSUcdkKFlyLmbraQodbYFEabHXtDGApR9JhuD18GiJNNbU
	 vigkGCkKfSwEJn9jWDNmIKz2rzg0ekKoffDSnvfqdr3j84yBjQMZ5Mc0MeIbkzyr8nqEb
	 t6i4Blhm4f2zxTNdYDn5/Jl7SHTp981MDazXkz3Zi8TOMzL5uoW6VhOAdQ7NgjwqybAw/
	 MNrD+3kXXWEvpogKJeYhnyhnZMdkPcRkg9qclc+i/7aBZKC7Ji1+086O9qOVGjEeX17rS
	 sX+AgzWIEf+l7bQjnSpULvfuoAQDs5TbXLxY8lFOemtL/GhdRyCr58oOoILO180wPyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvlzmq0J;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D7606A326
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 887D7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvlzmq0J
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-385d8a00598so8000524eec.1
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591273; x=1796196073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io0jgXINzxf8Pk44PIZlHBE77FZbFSzj7shA0YE3rU8=;
        b=zvlzmq0JNRMXODOQ6bRMsc1ufObKLRC6fNoaiRRx17W/nAwJ8ADIQ0uKyr6gvX9JFz
         m6gr1/uYcXgDGvUckNyp9lBTJzAWaidG0ZC6dMzAKqfwI4V3m3vztqALvmEWtVxVr0rg
         TYVA/PKiXaRL4uAwh3b6Kx3wq7pKq37/UYCIulPnhPymM+wdD7jUTIWEFkXFarYe+LVa
         +3HR+JmEEy0q7fp0a0caTsjfERsEoXcUc9ogr5Nt9vzJh6tZHkA49CMrOUS1hMshNiVB
         H325aAxrN77sQ3lDk74FDht/k98on8uKDEGh0gfxA7hWH1U+Jvi0UGFjeXgbj5cE23QY
         h7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591273; x=1796196073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=io0jgXINzxf8Pk44PIZlHBE77FZbFSzj7shA0YE3rU8=;
        b=e3xNGtraLLiaqfxI0TNns2f15aNX3x9q2rSBi2s+wzhTaSAQDO5RDqJYEErRcqJQRq
         +eNt2PNn3HT4YF9EnHlvpwUSt0Qxq/AqUcyvgOt3WmaBUN9SoFYITilW6VzQVoSPK1Eq
         2PqsDnrv5kkmgMJV33rlcjn2aq3gWN944vRUYG9OA0rjERcTeWvKfYOKePZwYJqFZT2U
         kfcKb6St4vpUd4kvbjGXtljGYTH5WR0V2+nAPjUaxN9wwSPVAgwB5tyqkOff0qm8ESOj
         2TXRTf3wOqQwMlIU8IFU98lp4IbRHJdMlC5YGQALYpVqReEvK7LkBrIeV91De1Xwebtl
         zpiQ==
X-Forwarded-Encrypted: i=1; AL+hErF4Olb1sYg5XgLXl7iFica/mhRp0Lv/G9cXVYSIGetfnQVlrYJF7Jz/tMETncSylM/9MxM+JLrmxNk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8f6L4wLZcNydzqGJF1UHBfwPJR5o7beLzPgLVaGQ30pyGtHUn
	hHYVhO5xKt7beQWfVwdJYMJEdZtxRjtlLmds7vuZQck77ebQGP4c5scI
X-Gm-Gg: AZFdTZeBElTFDMQMNZ0w4fIk0is5CHTYTiGT1bGj2TxKYh4cBhl2QCbIFSguPwb1XRg
	mExDvNjJ4E/4t/pT9w9/OJD0GogxMM8scuQuN9L6A4UZENI4tsyiIe16klJNQkuYt1Q8FbTmaCi
	ko6GmG77sKrzQW2/ekTc7Cx4NVtm4BTBMQ0u3XKXtxhWJiZ1NPSWZTwpcU5CrQfZt8cWApqn80m
	a3TQmY0ooCaWqY8keTd7VUrKetFvXj36WIxtbzu9Vw4eSzLjsJGJCf6h3EQKNaiYV48MjkJRgHh
	LUta9x4gS/AeZxJJeQOqoouEB/MvJUyCfGlB1qa+i+3yXH6F/LM5HdYDOlQ2Oxzd/nuABifhheZ
	IsYOGk0biSxfpR2hjT7L/gk4BgQf1yCw12aSyRB+5qRfksx5t9GCWwVesd6VC3bnrN29+t+Ob6Z
	EtNr5Z1QxhWXRgD2dT1cvtQqw+YIc0JAw81qfSpVY/PwlyU9fUXcT2Ydjxx19w5ksfGG8MJiCvl
	YfxeBU7QpgkHT1EXCNqFOe9dCDHe2bpccAlNnj8q1AHPeeTxgXY1qyGiDnQMhQWmK8JNezVycwN
	Nyuk8uwOxBej//8we586jr7a8VBnoEZGgjKmKqeGdJNQVG2zAVu2z1bZT4ck/F9N
X-Received: by 2002:a05:7300:fb97:b0:381:6ac8:ef2e with SMTP id 5a478bee46e88-3856ff5db0bmr24055433eec.25.1795591272607;
        Tue, 24 Nov 2026 23:21:12 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:12 -0800 (PST)
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
Subject: [PATCH 12/12] rtc: rv8803: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:26 +0900
Message-Id: <20261125072026.2997493-13-prasanth.r@lineo.co.jp>
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
driver prints "failed to set wake IRQ".

Use the device-managed variants so both are released on unbind, also for
the wakeup-source case without an IRQ.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: 2f80de657f83 ("rtc: rv8803: Add power management support")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-rv8803.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 7445c8151..9dbbaffcd 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -700,14 +700,14 @@ static int rv8803_probe(struct i2c_client *client)
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
 			client->irq = 0;
 		} else {
-			device_init_wakeup(&client->dev, true);
-			err = dev_pm_set_wake_irq(&client->dev, client->irq);
+			devm_device_init_wakeup(&client->dev);
+			err = devm_pm_set_wake_irq(&client->dev, client->irq);
 			if (err)
 				dev_err(&client->dev, "failed to set wake IRQ\n");
 		}
 	} else {
 		if (device_property_read_bool(&client->dev, "wakeup-source"))
-			device_init_wakeup(&client->dev, true);
+			devm_device_init_wakeup(&client->dev);
 		else
 			clear_bit(RTC_FEATURE_ALARM, rv8803->rtc->features);
 	}
-- 
2.43.0

