Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500700;
	b=okZ6TVK1GyQv+KZqtV7QLg1LHkB1tiZz6EatMS8zQZZ6wiKobkuXy91V74QbHqHrGgnR
	 arpcNrOSNbnAefHn9v4bbMngC0lJf8ENQ21jAU8n+K6izHw8rD9Fr8l283E/BX3Kqv4J7
	 dqoQzYt7msDQ5/abYTg7ICO/Eq7NEHpRPYfuVEHatXCPv+kL2fsoIiSwgWTb1wz30HkTE
	 k5Vytil2WwkJPjLg8i3jV4HMpFd9h0dd+EY0MD8/1PrxBij/mwBQl2ozPZCabHpUXw/kM
	 tIyV+b2LdjE7IgkQ4Uxd4Sxn4fEySalijBs8ViRzeTkQqkGQSvSt8ECx0LhItfQ4FCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500700;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rr5qnupZ01hcs8l4he6jIrxQZlpNO9qC8S24R6evHNo=;
	b=v13oS6U3bSNx15ghr4x3n/bjCkwgDZSaj+Wt/5mt95pNGJTDLNHoy2/MCaaQT3v7xRxg
	 utIruXEW1MEi/O8NhDEYwwp6OOifD3GlVNeY7pcPXvM1cjLw4Hd+QjLJ+M82PWKIbBK1E
	 SS8RDc+c6vVCzapbWeLxWs5ECnk1XhYk0P1R5HIYMVGIb8tXhhtff0oBxq50iJ7/SO0TQ
	 gfk9OYONRqXfIM99p5RrsbhjGCpvl/DHHeuH2hu5iZnEH0QBDek8cbcev+vZQ12iJ/xk0
	 LDMiKcfEpgRDOaVBUKV6MPW3VwKZksfTOol6NogT4tE+QZP82lG0laSfAqm4NJ8jAyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Ni6+PenU;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD47606A31E
	for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 12:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD47606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Ni6+PenU
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 421BE3F784
	for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792500697;
	bh=rr5qnupZ01hcs8l4he6jIrxQZlpNO9qC8S24R6evHNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Ni6+PenUjCMz6rFbOqB5iwFyLSjOeJj3F4dA/Jya8Xs8yk/lM6xBaeT0sk7ONG0FX
	 tSPhfA2qdpLe32kC0bcA0ua/RnXHTcJhO6yiEutDzZee8++NhKSWJ8PYz+1xFzHOTB
	 tp9+ZcQMvQwLjsGHjNj5IBHSS8t/MQJSYal18lzvt945AGCBz32iXCsdnVvjmGrT2J
	 1wd0v+kUP4Rlu3+fmqUP7XDX11xTw/ZcDep+dFwatcl5Z2ZVbaeYHUvULnJ0D+NXBG
	 Jj/GwaEtKlUpFhWvRKXeB1zk79GuXW/Gx/pqHUy/SxHEQsn2rz4GXAC6X1ausx2M8f
	 OLfqycf20O4u/TD+FKVA4UEKomGK7+q8SrS5PfHpMaGmUYj2C/joS/lZh7fmkXTpQ6
	 FlQkR+/W0UBKHKdgbIVIEmkt8WyVNqai6GL9NIIh7GP4UAn8rBn4ptD9GC3WqsWh3o
	 jULpGjwKhaB0/uVSyqGoe144UG4jzFsaHW2VKGp5Ktr8ZfYl+XOASJmx24meJT5OrA
	 b9X8ODMommEPCvY9agtjtkTJdLqBv5+cPJUDOpLENWbNGu82/0xxcycGV/a9AWkxDM
	 LWAGbM2GKTztPyT8uUqJzyavewm8VTILBVIF5/OQSBvQP70bxVTZm2I50MomKhQ9q1
	 R1j8Wnwdzf62o587Xpirv+Xs=
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-88c768886a6so1996923b3a.2
        for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 05:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500695; x=1793105495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rr5qnupZ01hcs8l4he6jIrxQZlpNO9qC8S24R6evHNo=;
        b=hlrnEHevxNrke3LKCVcJLYcGb8k+NIQCz/ndKI+RJ2eF1FNsWYIIWDM66jh1K4xqMj
         vQxhDkjs92QUD8DuxezuHAtwiIrgABkY0KfGuHVihH3unTU3k+TBT71baVTddaHQzxpT
         4NLfJDYWL3pVkaltIVtcLOP8yXgfkNmf0L/1QZJC1WSsD8z2r1v38ojrJ+/7sprYM164
         vYX4oBZZPOSPsW65o85ZWuqahn3zaBx7QHMNllcHVd25JczFc1UEqqBFbNWW2byHNG+I
         iwQ+h0KTqqc+LH347osKl69VYTWNlqTaPDHDeN00b/zWUd5pt1s2iJtajT3TQTgXBvM2
         pSyg==
X-Gm-Message-State: AFq9FYJn8NAcSTFWzhj3ENUtXG44d0XXZRGh6wZRJf/lA4vvKVAUPIEC
	8hNB8eF9bZrRPRmJ59dGL1KzXwyYLxgWoG+f9TVzdYSAI1naHMFfOv79s0jJQ8+oV38U2VDs4uu
	5vH67RKrIpYGnx+p7HLeQ6n5Sm1QW/f02i6HL0RlfhkUQrMxkUsSvkEem3LOvHhB8eTBR6NOZEn
	EFFw==
X-Gm-Gg: AYBFou2HmY31oEk2UUdqzBX86A5Sw+FNcfodDZqIOFNmqvmEbsoVFsmrLJRjUpTjM7U
	Vgn4QcevhXhAmsi7JZkcCGnymC4F08ogLxJXW8liwyWx1Y+djGN84CPXWeas5JbqG3ExEDNeWEU
	YZEKt+pr4X0LT9obPbP8070QUUvnZP2ANAJbEmywePzHpl+i5WuEJ+7sH7rYfsbr93z6YjozCxB
	pdEMlAJE3UOKDMiw1TPQXafL8C5C+KTy+6Pt95tppigN8W76wDleAyHZPMkfuwxbB37cxFHe+WF
	tmbO8Prj370efPeXqIbVCQHHyYP38PawrZkvaoCGl2YuclWT3FxpY/u7slg2VKYAaaw4xvE3MCl
	k+CpUIswNrj6cj8mmsEY/duiz+XWlvi9ZKRaIItK4fgKc0JuZ
X-Received: by 2002:a05:6a00:2343:b0:89e:9c7e:fd51 with SMTP id d2e1a72fcca58-8a04ba30b92mr8137413b3a.10.1792500694977;
        Tue, 20 Oct 2026 05:51:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:2343:b0:89e:9c7e:fd51 with SMTP id d2e1a72fcca58-8a04ba30b92mr8137402b3a.10.1792500694572;
        Tue, 20 Oct 2026 05:51:34 -0700 (PDT)
Received: from noble-leuven.lxd (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a05d4b04dcsm2692161b3a.16.2026.10.20.05.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:51:34 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liam Beguin <lvb@xiphos.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH] rtc: pcf2127: arm the alarm IRQ as a wake IRQ
Date: Tue, 20 Oct 2026 12:51:23 +0000
Message-ID: <20261020125124.1097546-1-aristo.chen@canonical.com>
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

Fixes: 8a914bac44be ("rtc: pcf2127: add alarm support")
Assisted-by: LLM
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
Tested on an i.MX93 FRDM board, where the PCF2131 INTA reaches the SoC
through a PCAL6524 GPIO expander. The board ran an Ubuntu 6.8 kernel
with devm_pm_set_wake_irq() (fd8318a32573) and tcpci wakeup support
(a5d2edb2c9fa) backported. With this patch, the PCF2131 alarm wakes the
board from suspend-to-RAM and from s2idle, also after unbinding and
rebinding the driver. Without it, the alarm doesn't wake the board from
suspend-to-RAM. Compile-tested on rtc-next (arm64 defconfig plus
RTC_DRV_PCF2127, W=1).

 drivers/rtc/rtc-pcf2127.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index ff2023908..51d8aebf3 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
 
@@ -1251,6 +1252,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	if (alarm_irq > 0 || device_property_read_bool(dev, "wakeup-source")) {
 		device_init_wakeup(dev, true);
 		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
+
+		if (alarm_irq > 0) {
+			ret = devm_pm_set_wake_irq(dev, alarm_irq);
+			if (ret)
+				dev_warn(dev, "failed to set wake IRQ: %d\n", ret);
+		}
 	}
 
 	if (pcf2127->cfg->has_int_a_b) {
-- 
2.43.0

