Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8363921FB
	for <linux-rtc@vger.kernel.org>; Sun, 27 Sep 2026 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521952; cv=none; b=j4uEt0LaUQVBxDs6HNUxEbZgA9/ZbScK5RiuQsYIvMcg8LUJgN9XUvHt6DxOv2zOqZ4tYrtnVVJkPvbqGXVM2NYmzjy79vBcpiQZJYyVPQSeEJAzSHqsuoJRfJFELz0XNPwcihwh4ibweFrZQ7sUrteT1DHA+8Y3880jmwb3XOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521952; c=relaxed/simple;
	bh=iGxLkAPjn7iwM0RTaaX+V0ufn+VTyGjgMAZb+r2eUQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZnvOFRczRl1S3l5QgD18p3VpHhy2Hlo67/QcFI53zoRJo6fIxXAvMynA3nIixWzvjXUg1DlWJV0Uj9VemWhBDUhicN+D5RTWgnlk+X1VA8RKfyOkIgTJ/7wPd3AvrCkEAqLQHJykvq3bPQG8Si/J2miLP+K74sVtCppbFpdSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWMi1aeo; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWMi1aeo"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48881a62e09so1160008f8f.2
        for <linux-rtc@vger.kernel.org>; Sun, 27 Sep 2026 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790521949; x=1791126749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SnMP+yO9gTVCT1ht/mZTNiN+id9GPVSfGNROClqfyxw=;
        b=HWMi1aeopCUn6Aq2UZDyb2x1F+VqwuTTzaUTcRuU7ieu0kke368/EzFoKFjO0/hMET
         2WtdgHBB40342MS/F/mwf/bsFPEFQ8pb42Tunq5NFzshrwE+2y2S3niOG+8nJsWcp88s
         lz/jP8alWoSs4slRXbA6ZJAkkodkd330OCfiH6yeb1cjwuZUMqrOKsZbJv/fvZv8+W1W
         1JBVMj08efM6oTNw/LXjH4FOWoR6ujuSrQU+/Pwa8DM29h5agpJSVUTATSkGE7Vc1Cpx
         gnB/QJ3/UGKeJg2Ye68Ssz5O2Y7htit7KdrHZxTkhXWk0/O2yEYGi9kFXLnL5z+Opuvd
         ZFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790521949; x=1791126749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SnMP+yO9gTVCT1ht/mZTNiN+id9GPVSfGNROClqfyxw=;
        b=hU/emMkQqs9a2GYFdOv0EjqqyuMykImRxc0Pz49vTovha1A4pDS9GTPmBp4TuyF9c0
         vxbhzjyiIcviyBvAgb0/NlQz01gCByNVDiXYCKyhpWiF+CbUqrj48+zzrYq5i3hg2apS
         v5fvFqrbStwwUfSMe75sW1mAmWSO2SqOe1/kQEOI7gK1ypclgkQ+0tjed7/xwCRyA5Nv
         8SwEwX7ap+BO2HQjRXfjkIH8EZXf73BEffp4OcbApGRK1EG/21D1AARFhtHvyvYeFT2z
         gm2y1pbVqHx6EVoLSnt8DqFuCljJEqjYKFk7brmnk5FATDJNmWeubOaXzx1o3+BuHkdJ
         hnWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLHcBHuNHi7wss/NNTO7UTCUHh1j48FkbZsFkUlEeCcNrn8NoYjCHka5+xlrF75ddYGyDSeJwsYrU=@vger.kernel.org
X-Gm-Message-State: AFuF++l9rz7kn68Z8TGwi6JnYpS1U51xC2wlguZu7Yht3DnOTsczqX4c
	cEpnkxFMKUWkt3eqLIIgfhGm32FsSSTSeFDg0pIk8JMIUiky/eb6Vqrg
X-Gm-Gg: AYBFou38Dk9LnfbV5RtP7/fa8GNWlhJLNaChbLmvrcmTVs9+OdwHLhfeIXeJ4isgODh
	Lj3anLAcY24KiGLdivhr5zIcks9LCQtqXq7DkFcTom8PKfAL3SyzR+kWcHBWHwjrHH4+cQzSO1j
	Niz+JHFDj7IrmuuQD20INSzgKJR6KDJNypqlDwplwL4jMPJKwbyi78iJs6FA4mT9LQ3NjDJFRsX
	rMthV/9UDPWPJDU1VJi/cffFs/qnf63YGzqnM8snqJsyhXwajq5yeqmw4qO5wqfSxUt5uzi6PHx
	fwl1AvFCexpGFYL3CQ72suDZv14o3aa6wp5lBQJqRDg7I3nqc/6fsj5M6bxV2XpZRJJn+TBWj76
	lmFbVJv8Zshc4a8I6Bto649L7PZvxyn9LWV6LHOX1ItUG2Xx8jWUhITsPEmjqqouGZZfGf7362o
	qyfqUKG5008dOXUeAaQtgctv1q2+plx1+CsAhzoz8YL8h5M3e7qnYqIu0vliy5+u8HaH+f2gPyt
	bi2O/DTK6XFaaeaIs4IU4Ny3gN4Y8aMx7w6cePEEqU=
X-Received: by 2002:a05:600c:4694:b0:4a0:54a:bd36 with SMTP id 5b1f17b1804b1-4a0054abee2mr1501255e9.35.1790521948886;
        Sun, 27 Sep 2026 08:12:28 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a746c57sm19764208f8f.35.2026.09.27.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 08:12:28 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 06/11] rtc: sun6i: add Allwinner B288 compatible
Date: Sun, 27 Sep 2026 16:10:11 +0100
Message-ID: <20260927151016.186493-7-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927151016.186493-1-pmazzini@gmail.com>
References: <20260927151016.186493-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver only uses one alarm interrupt, so no functional change.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 7fc60880e409..cd6ac5bb20cd 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -859,6 +859,7 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ .compatible = "allwinner,sun8i-a23-rtc" },
+	{ .compatible = "allwinner,sun8i-b288-rtc" },
 	{ .compatible = "allwinner,sun8i-h3-rtc" },
 	{ .compatible = "allwinner,sun8i-r40-rtc" },
 	{ .compatible = "allwinner,sun8i-v3-rtc" },
-- 
2.53.0

