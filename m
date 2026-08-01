Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B83C3447
	for <linux-rtc@vger.kernel.org>; Sat,  1 Aug 2026 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609794; cv=none; b=CqT5YYAyiqX+6vhuxobMVvlHGaL/SEkeDpHL0RYwv9zEhpZDGUJMHgJLEK+PZZAGtCpWiAp0g5h8RuLhA7s5bajSeL4hYt7jm1WZfcwLJTAkc8/ILsq3k82sTltE6wb/C4HBRq6Jn67cDkezgEAawnFpSNukYf2RGbrRIu1E81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609794; c=relaxed/simple;
	bh=fZl3B+SYiSN0CoE6+O4hYlK9Wqy6umtF28rp8a6TBSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spupdr1ZpsCQ+6mki2v9zhKQ4cFMN80w99wtbed0QZtNu8656uqkrGPprI8N+c3Ebyoge+dt75nFdTG/JcqbNdtbsc0pGE/1cLCQinkBp2HKSbgMjAYGyGLnKE9sZMvLDlsNqUZ+BEPqplErXal4U7ifP/IrmcBNERHMVrSv1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=L7YQae4R; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="L7YQae4R"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 27437240028
	for <linux-rtc@vger.kernel.org>; Sat,  1 Aug 2026 20:43:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785609783;
	bh=S5UEi3GeWxJmjjaY8LOsfTG4uHV330+lLuwCpBBqRio=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=L7YQae4RnI7E8IG7eHxFe6nbczBzJkq49sbdKwgL/D1z7SQsSPfhcSTg8t+lKIcwd
	 02wMVhKQ5BlZqA54yx0ENs2UD8aw0G/IIGD2DkR0rF8cQcCjaUp5Vnp02B9ZnfE4PM
	 ixRpx2S2s9xAJWIx8ifE5XMfCFX4yQ0SmUTnSVl4lm/ay3tKAUm3MfVE7yKVKAJ85p
	 kqDWkUKq+9nyPvTN0P0bUVFQSlbRWnOS/2k49iUESSDz+F5PiXJrw+QcDmAUANaOgn
	 iXxreWf5CPHQndI15BRz6ZMcyty7hkE7GHUp8x8a6iq5Z39X6vXb9aO3w1M6abysyD
	 J4fEexfiVrWKQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hCBdd4hjJz9rxD;
	Sat,  1 Aug 2026 20:43:01 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 01 Aug 2026 18:43:02 +0000
Subject: [PATCH v2 3/5] rtc: s35390a: Fix alarm not disabling
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-rtc_s35390a_int1-v2-3-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
In-Reply-To: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=fZl3B+SYiSN0CoE6+O4hYlK9Wqy6umtF28rp8a6TBSg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqbj4wTLyWbXf9auYsd8GgJzeJhTY9iI/bvKQZE
 nY8r2D8UqqJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCam4+MBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9ITWA//X8vbegXbyMzXRGZxa8xfqWQ1dQ4uzIQ
 dAK7pKEstw0di1x3Lnpk00E5x1Xj2tlEfOef8V2yhIbiq/bqRXpjlwoFUMHmCQPvP6PoAoNs1bt
 +CR9P9QdEJUIWw3xm8XONk4ZQco9Wva8QnxTCt1JxV1jesuXqTXJEILP/m8W4mgmBl4eQGYr7w0
 Rnydof9bVXf9wtA6/fZSUO6LvHVaNcnZWg+J2VrQkK4LYtOWG3JRp/PeG/TW9zPLpDtYoQg2BdX
 tRpGzkhDZSRpiUPFjuIXiNanyc7BNnx1ZF2gSOrumtYjkdOYYEoDV52/ysuPC1BzMVpL81V1e9A
 WX2z5Yvcnu5FhJzuwf9GC78u35c5KKa/SS2soVJ9HEWpQuJGZyvvtKO9e2buNgaJ8bHeR9cNwBP
 XAqAj2Exvxzu0w5i4T7B9cPsJtd5Ia5QOmu5h95qh3QMZPT7k9Ykb3fFJCknyNx8ItuF4NZIKDl
 a2Gs58dISeF7bvbM368I4qBjJnEM5hXTW/PJR8IXJ5gjNkRXtL6zITO6rpwpN6+WaqP9KwmFBCg
 bx3x4Ypn0oaTgfH4Bcv3BQ5H9aNWPAQ5DjFOHEeUrFm5tVF9520pD5hRl8ltcxP6Db2Z6mByGB9
 FFX3qv7VUU3WxhIubChKuvvMCiS4sjRmNvtWd8PtKcZ+/LvC6z88=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement alarm_irq_enable callback to disable alarm if requested.
On reenable restore last used alarm time.

Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support for rtc-s35390A rtc chip")
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/rtc-s35390a.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 4cfe7034c516..fbf5471eb3d0 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -64,6 +64,7 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
 
 struct s35390a {
 	struct i2c_client *client[8];
+	struct rtc_time tm_alarm;
 	int twentyfourhour;
 };
 
@@ -320,6 +321,9 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	err = s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf,
 								sizeof(buf));
 
+	if (!err)
+		s35390a->tm_alarm = alm->time;
+
 	return err;
 }
 
@@ -379,6 +383,19 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	return 0;
 }
 
+static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct s35390a *s35390a = dev_get_drvdata(dev);
+	struct rtc_wkalrm alm;
+
+	alm.enabled = enabled;
+
+	if (enabled)
+		alm.time = s35390a->tm_alarm;
+
+	return s35390a_rtc_set_alarm(dev, &alm);
+}
+
 static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
 			     unsigned long arg)
 {
@@ -410,11 +427,12 @@ static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
 }
 
 static const struct rtc_class_ops s35390a_rtc_ops = {
-	.read_time	= s35390a_rtc_read_time,
-	.set_time	= s35390a_rtc_set_time,
-	.set_alarm	= s35390a_rtc_set_alarm,
-	.read_alarm	= s35390a_rtc_read_alarm,
-	.ioctl          = s35390a_rtc_ioctl,
+	.read_time		= s35390a_rtc_read_time,
+	.set_time		= s35390a_rtc_set_time,
+	.set_alarm		= s35390a_rtc_set_alarm,
+	.read_alarm		= s35390a_rtc_read_alarm,
+	.alarm_irq_enable	= s35390a_rtc_alarm_irq_enable,
+	.ioctl			= s35390a_rtc_ioctl,
 };
 
 static int s35390a_nvmem_read(void *priv, unsigned int offset, void *val,

-- 
2.54.0

