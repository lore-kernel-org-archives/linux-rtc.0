Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29543A63EC
	for <linux-rtc@vger.kernel.org>; Tue,  2 Jun 2026 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428372; cv=none; b=RdC9UQXgMUFBq1xWnXsWLxbfkAq+NBFFIdoMskAvOoqaYVm8YcyWrKqtcxYQJ+oIzlrO+a0T2g66x/65Xx2WlUui4nu4rfOmpvwqi6R6ubp7093o2yynRS2D+tsWpL5wgIhyP0BzStm41ajdvRdeghmd1IazNsT2e7B6WF1qjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428372; c=relaxed/simple;
	bh=vhJ8WlfT/UQKh+30bwKCtTBDLTkgAU6sbYcOm2fZ/iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLQ9SI6dkmGr54vhR13DfnvwCslgzmnkVN7xxWzRr1fxVkY0H9CTPPV/DavkgASQJrFMeNKbSfmDvzBajjkax9C1QLkSZ0JW3k2q3QBY5QkzsrBrCLWuJQ6HWm+o3oVwAuYdhWQxzifFNDeMJwTE6zVPtbZQ81XCFevhGxFmcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3vq3ao7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3vq3ao7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so4997345e9.0
        for <linux-rtc@vger.kernel.org>; Tue, 02 Jun 2026 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780428369; x=1781033169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcNCGawN55HsRcrqYdjNNvHCWY847Taw/F366F1svkU=;
        b=B3vq3ao7tj3+HgchqDNa1Umtn55nJkVqy6UkOAKPo7e289WRrZf4gv+w5+zIC+xXWO
         vaPgadYZ8Rf47QJqzl8ee5WBbKWCe39tfaE9l35/+dGk9V3mkfnLcsSEp3tutzkI5xpr
         K1atyATMHpS1sf0SjHlVzndcHMyd0FgmfvAyecVVBi9IBv/Q5C0pIZY/W9uv/DOvejL2
         LZrpPsB38oSCImRkWUAIBU4HUhjoGyBujzGaRD6qBwQCgowL64WDegEFW7bJnKum6xKn
         OqRcPyRRlinChdMuBQOhVCaxl9E5JmY5bkzM/fAcZqrrsc1duIkSazVxXVTkWSh7Dpqr
         wh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780428369; x=1781033169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcNCGawN55HsRcrqYdjNNvHCWY847Taw/F366F1svkU=;
        b=WwRJ3J9dnH6rPSURpjDaQsnjHc9wwqip7tW3PANl0MCEyXiPHvmkvfqX7NNZY1Zdvk
         vi3v2or2erRfBrXsJN8giOp7Hy5WKngfeGFxQUOIytvAmId17fpor5qen3f+DHj/ywGi
         o8XmdQmdc8wKgHpJCOr7jDkBSxbNKhNnXGLSj+t4ul7NeaYwyYPpHyJOYg2a0njqIsF+
         YMTWjpX7LIhliQ9MpOXTLG4+HERizjTBuz0r51tbLW10f10pVsWvvqADU1x1r4dEZfVS
         grAkXFmL+s2UhK/aybfMFAHg0c3LpttYjFHERdFWFCc0XW9xE/p7oGtKdKh1+++zAUZZ
         WBNA==
X-Forwarded-Encrypted: i=1; AFNElJ82v+k2ECHoQOCnt4oZqomw1+uE6JrE+1dmu8cwtQHsSLUAXsSFY7fac6+LpYmr3x02/qVvimOSv1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApqXm9jBjzmFgqYFMyObxXMBhjrR3UAByjT+NgNXYp0VIfbuh
	Zm2caqbv/HAVlk45XNW5nYPSKPRRphPQPzcBh/pZs+zxRqybA2TLqwoMhD2W4vJxHwc=
X-Gm-Gg: Acq92OEL0MizEg/+V3Pi7z0SEJv17ewBrNYjrydumaw6H1VY9rNoW/NaFLpok2aqo7l
	SeZmoiibD1GVQ/tusY1cfQpvZKeqEcyJEDEWhd4IgO7RFN6I+TUWTJeeZ5bSb3JzeesYNCPpbte
	P+WDmti7oToq0+tvX5euFgSrQDQAjXMO87y65rrY6bQ20fiM4lW6mFNiF/DkTLwOfXffqUCBZWe
	anIfmcyn8l3DYN5LtWM+0dzXiXnu8JbX7kl9L5v4cSoPO82hmf/9hH31II58zgJlRPSTBiKGYnA
	hHOGNmjMnaTCHymbLT3YcH3KcFwfY+pPuwWjkDdE3LCaILSC2y2nnFXqcyNa4eQZYmkckXr61Qo
	4Su6QW6K8yAg+BIiNwqXRof9A8Do214lxF6aKd8doLvolGVtO2h/rTw6Bw6rvkgkC0DyG3lNv4C
	KCfRmcDzmBoN23RognWht4sIF3PALcE5bIBnkH1CJwLVApKsaAkEhuHMuatmzJJ6N4DZ5yQXdJB
	/3NvLrhj/NiZs7bpSyFVlXw0/3xPDghOhhXpqHikhBe6swJZLlbtwrgLfhnJix9H6I=
X-Received: by 2002:a05:600c:3113:b0:490:388f:1c0d with SMTP id 5b1f17b1804b1-490b5e94d56mr2872955e9.5.1780428369407;
        Tue, 02 Jun 2026 12:26:09 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5ef:9913:4a77:3bcf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm1473364f8f.3.2026.06.02.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:26:09 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-rtc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/5] rtc: renesas-rtca3: Check RADJ poll result during initial setup
Date: Tue,  2 Jun 2026 20:25:56 +0100
Message-ID: <20260602192559.1791344-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602192559.1791344-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260602192559.1791344-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

In rtca3_initial_setup(), the driver clears the RTCA3_RADJ register and
waits for it to reach zero using readb_poll_timeout(). Check the return
value of readb_poll_timeout() and propagate the error if the poll fails.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index 2dc080d0eb6c..af2a3878289e 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -634,6 +634,8 @@ static int rtca3_initial_setup(struct clk *clk, struct rtca3_priv *priv)
 	writeb(0, priv->base + RTCA3_RADJ);
 	ret = readb_poll_timeout(priv->base + RTCA3_RADJ, tmp, !tmp, 10,
 				 RTCA3_DEFAULT_TIMEOUT_US);
+	if (ret)
+		return ret;
 
 	/* Start the RTC and enable automatic time error adjustment. */
 	mask = RTCA3_RCR2_START | RTCA3_RCR2_AADJE;
-- 
2.54.0

