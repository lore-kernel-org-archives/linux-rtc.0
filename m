Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565105;
	b=fa9km/JyYy7/lrRq7UFLzwFYqX3Pq0hGZy50WtAPlnhrmTtUbUbsr2CZygTHGcgFbPFk
	 W8KIMALW/r+4qq2/t+RmaiiBK4n3koyDg4vauXkB5sB3lK85waX8NBaq/03iwifC0cKdC
	 Lvf01s/b7EXwKR+N06dlaSsJPJ4aqbFJatQY88i6ZaoO7Z6QKzZHUQBp7B2Ky8T22ORf7
	 eI8MH+fWIIwRPozQk0MN6t5f6b2AJ/ScU6A6F2BxzDHcQVkDiOszf7EDqwJNXsxVb0EVD
	 1E2vFkUfqO39TFPfAPPbcygKY2T/8iyhrSUeuDEcwlnpRWStU0+EkVZGxzljflI0axQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565105;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ALR4zBR6SVClQY4bJdoRAjT8Hkdfso/njcb/SQ7xLRM=;
	b=f81bPXbtgqKCQeNOp4hf8j3xPkeuKDjn6UZWib33cOmmxKYr7e6XdXKGRpaqJBNx9icL
	 G7chgsASTGiwGAQl365GrQo+gfci5Tc+Fw7JlUlpw7h/JeQGE2jvvkNiZtyWTUVR1xOk+
	 CLj/ayLazp4Bc2jM063nnvtRu6kmQwybMUitZJaKsvDbjKan/OFp1HtiKX6IjC6iO2WL+
	 kSYnaYrh1OSr3V3mRKP98rG+veAlm+X1zSoujYBHv2qcVCk9zAsdrD6nN+1h19N7LBIRk
	 mDjRpq9nqPYzFpkGNDnx22t1bIRpyhHj1lxZ/Lvw9KUB6vehDXW5sbd19RJpQdTNQjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ppanscsz;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D9606A31A
	for <linux-rtc@vger.kernel.org>; Wed, 21 Oct 2026 06:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 820D9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ppanscsz
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 861ED3F98B
	for <linux-rtc@vger.kernel.org>; Wed, 21 Oct 2026 06:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792565101;
	bh=ALR4zBR6SVClQY4bJdoRAjT8Hkdfso/njcb/SQ7xLRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ppanscszpRNrDIlQFjCSROSYmZeiKLugXq1L+8tXtgAkYl4MjnIYJRZ09d2k6cddD
	 dZtEx2YfrLA7nspHC0zRJ5Th0TSV+1BnEZkFLgsYdw2m51i0Y+luJ5GDo6fiEToLHK
	 SkDw/l+CNk1nwMtZQXZsiQp4QCCDEboXfRStpbi6oGju2LRc4RsVlPBZBhpB11OdBm
	 NwNIYOBNTL8x9xJoIAU3++JrW7ymkHO9Oc7Eif+Fjat/URQEMrIQQCMAHqgexK2FFx
	 i6FeZZd8WBRZg97ECTA6Ap7K7Mq7GCzTwSX4al+QX7U6SlO4Ctkxfq0kM4KRfZnT22
	 9p404K5P4QsLbxSoj2YLTEzo6OVPMLRd4qltlVUdXCqtt2QGu2U5zYLk328YMiScVq
	 i6AI8/3lTqXmcqg1QQzhK2XD6LQw8sZYubYQnQW2j9uvWR5rY+KXQm7UQFS/4vmlyG
	 +vwqANe68GR3/5V+AW1zcxNtF+bRcdCFVa4T4g5aG9Mfrja4E+YIUPF9MiIVpHaAoE
	 jMlVcyB4bGTxPnUEvuw7Hbg+/OqNIt5S6H4RP0SVJW8rCEKhvkzgm7wFu3Qin4ose/
	 tclvwro2qCz/6mC5thxgyBMnptaJACG4C0GBl045bGZBru/PMVGJpUnJ2nuiZsAkPh
	 G0i1ZT73bc/RBel9LW9acih0=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e954d87b48so6731305ad.2
        for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 23:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565100; x=1793169900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALR4zBR6SVClQY4bJdoRAjT8Hkdfso/njcb/SQ7xLRM=;
        b=tdS1LhOhJtdgE2PUk6w5M+azCOWXKt9nlmvj/T2E8NdNWlXeG5PKcckcVYBwusWVZn
         LhDrYf1KAVwpLv5QGNF2zhZcmH1tqyKdR5JDD3l9E2jfxwX4hQdow28G29Mk4+wYr5wu
         QzyJVeFICCqG+UAWu+oZfG8lPLgwTYfaIroyGkkRslUQ3+OmvuNwWWfiE+z807ZxfOwP
         NbowK8W5AsfC1Sgw8f4LsYDL7EoPJyqY9Mf4+y9AlrE0UG6XgyRFT0iFt3eHxPxnHKDc
         3iDhuOaA0I0cWiRxISLMRutCMMGQ/SmOJSJ7jbgcFn8VNX3SHBhgOGX+u9HvFzcuPLAE
         OPPw==
X-Gm-Message-State: AFq9FYLpX5+RIkUqECXEQav9sMswT6+IYGdvUW0UCkyspfyXL1WUiEuj
	4080NqekqO0oZbQxXC4eTWfTuL92Kjomahq8Vc2Ri9OVlEzOS379ZxHnsbDHo00JtX6ciPSZtGf
	v4DNSc3U7pujHtx2FgEwzqfYit9DH6QMU6zy7JU93xtlwaTNVEAdyRUHSuK+D7Bmxjf67dOF0TW
	5MGw==
X-Gm-Gg: AYBFou0EfLAjWI1FJ2+FW8/nXIaudo9/XHoA3fYg3+Ctt7B3ODotgOuxwF6xlyQqKUt
	n5haefO7QvxtxJeRkwX83wbjKaSg1PasIVKpSsvLdWUWcZ8GPDzOtnaDXYWWxWVKULzeRnR3g25
	0swrcrCbODhJeKxQ79VFcGOwcUPaXWHZPZ6gJI3fHwLy/W85e2A+NOpBeJgo2G/ej/Tp7Xdpbvl
	h3GiM5XXCDHjPu3i6/4GqC7me64F2ryhXCPZ5lfGOFRhSwnKK0AlzDyR84L3eBldtejREa1H/Ih
	aK0zKfNqWtN+O1GrR7epicRH1wz0cz3iBxxkdcE/yPIoGV5W4oXUrNw13hNyrzttv3mI1QFi34Q
	gd+ZXGDUOsmhHaWlIghBjzC4chLb3b0PTwPRD5ZgUuFM7H1L8xK6sThcyBweHs37joGal
X-Received: by 2002:a17:902:e847:b0:2e9:568f:75bc with SMTP id d9443c01a7336-2ea43f51cbcmr9608315ad.39.1792565099695;
        Tue, 20 Oct 2026 23:44:59 -0700 (PDT)
X-Received: by 2002:a17:902:e847:b0:2e9:568f:75bc with SMTP id d9443c01a7336-2ea43f51cbcmr9608205ad.39.1792565099250;
        Tue, 20 Oct 2026 23:44:59 -0700 (PDT)
Received: from noble-leuven.tail872496.ts.net (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4108a9sm7208575ad.21.2026.10.20.23.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:44:58 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liam Beguin <lvb@xiphos.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2] rtc: pcf2127: arm the alarm IRQ as a wake IRQ
Date: Wed, 21 Oct 2026 06:44:02 +0000
Message-ID: <20261021064432.551943-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
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

When an alarm IRQ is available, the driver calls device_init_wakeup(),
so the RTC shows up as wakeup capable and enabled, but it never marks
the IRQ itself as a wakeup interrupt. The PM core therefore disables
the IRQ for the whole system suspend, and the alarm cannot wake the
system: "rtcwake -m mem" on this RTC only resumes once another wakeup
source fires.

On the i.MX93 11x11 FRDM board the PCF2131 alarm is routed through a
PCAL6524 GPIO expander. Without a wakeup request on the expander pin,
the expander's own interrupt is not armed for wakeup either, so the
alarm never reaches the CPU. The BBNSM RTC on the same board uses
devm_pm_set_wake_irq() and wakes the system as expected.

Register the alarm IRQ with devm_pm_set_wake_irq() so that the PM core
arms it whenever the device may wake the system. A failure is not
fatal: the RTC keeps working, only wakeup from it is unavailable.

The I2C core already sets up the wake IRQ before probe for clients
flagged I2C_CLIENT_WAKE, which a "wakeup-source" DT property or a
wake-capable ACPI interrupt sets. Those boards can already wake from
the alarm, so skip the call for them: a second registration would only
trigger a "wake irq already initialized" warning.

Fixes: 8a914bac44be ("rtc: pcf2127: add alarm support")
Assisted-by: LLM
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
Changes in v2:
- Skip devm_pm_set_wake_irq() for I2C clients flagged I2C_CLIENT_WAKE,
  as the I2C core has already set up their wake IRQ (Sashiko review).

v1: https://lore.kernel.org/linux-rtc/20261020125124.1097546-1-aristo.chen@canonical.com/

Tested on an i.MX93 FRDM board, where the PCF2131 INTA reaches the SoC
through a PCAL6524 GPIO expander. The board ran an Ubuntu 6.8 kernel
with devm_pm_set_wake_irq() (fd8318a32573) and tcpci wakeup support
(a5d2edb2c9fa) backported. With this patch, the PCF2131 alarm wakes the
board from suspend-to-RAM and from s2idle, also after unbinding and
rebinding the driver. Without it, the alarm doesn't wake the board from
suspend-to-RAM.

To cover the I2C_CLIENT_WAKE path, a test module set the flag on the
client before the driver was rebound, as a "wakeup-source" property
would. The I2C core then set up the wake IRQ, the driver skipped its
own call, no "wake irq already initialized" warning appeared, and the
alarm still woke the board from suspend-to-RAM and from s2idle.

Compile-tested on rtc-next (arm64 defconfig plus RTC_DRV_PCF2127, W=1).

 drivers/rtc/rtc-pcf2127.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index ff2023908..b9ff52630 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
 
@@ -1188,7 +1189,8 @@ static int pcf2127_configure_interrupt_pins(struct device *dev)
 }
 
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
-			 int alarm_irq, const struct pcf21xx_config *config)
+			 int alarm_irq, bool bus_wake_irq,
+			 const struct pcf21xx_config *config)
 {
 	struct pcf2127 *pcf2127;
 	int ret = 0;
@@ -1251,6 +1253,13 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	if (alarm_irq > 0 || device_property_read_bool(dev, "wakeup-source")) {
 		device_init_wakeup(dev, true);
 		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
+
+		/* Skip if the bus code has already set the wake IRQ */
+		if (alarm_irq > 0 && !bus_wake_irq) {
+			ret = devm_pm_set_wake_irq(dev, alarm_irq);
+			if (ret)
+				dev_warn(dev, "failed to set wake IRQ: %d\n", ret);
+		}
 	}
 
 	if (pcf2127->cfg->has_int_a_b) {
@@ -1478,7 +1487,9 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
-	return pcf2127_probe(&client->dev, regmap, client->irq, variant);
+	/* With I2C_CLIENT_WAKE, the I2C core has already set the wake IRQ */
+	return pcf2127_probe(&client->dev, regmap, client->irq,
+			     client->flags & I2C_CLIENT_WAKE, variant);
 }
 
 static struct i2c_driver pcf2127_i2c_driver = {
@@ -1555,7 +1566,7 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return pcf2127_probe(&spi->dev, regmap, spi->irq, variant);
+	return pcf2127_probe(&spi->dev, regmap, spi->irq, false, variant);
 }
 
 static const struct spi_device_id pcf2127_spi_id[] = {
-- 
2.43.0

