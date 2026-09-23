Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A63F58E8
	for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194992; cv=none; b=Hvh/UlH8OutcoY5hjk+EUE5/f0miTg3lVKa0d9yIbdjJ7eNk3U9HFkHvlExqSMBlEd0bYxSL6bYsAICVI1dp7Y45lJVU2FAPwA29reqV9EJCCb+ocwSwOG6IYp7ga2teMEG3kXHF0D8IValFxaAj7oht2qWnEfW5ail/XfuCFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194992; c=relaxed/simple;
	bh=iGxLkAPjn7iwM0RTaaX+V0ufn+VTyGjgMAZb+r2eUQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn/m5GRbvrtRKCfVkaSWW6xoqtgPzppQhIzzBYQgcDfOo0bSS2ZTOY5mqkWjw0G1NHYBSwb1aP9SQSfQfcFQb8QaNwTGo5Czf7FixM+JI4ewrp7l0LgPufMjTpiImcfz5HsQYq36W6hhyCUlf9ERzMKcV2Yq/f9x3SsEVX+8nnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1DxGSpP; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1DxGSpP"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1a631f6aso172708666b.3
        for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194985; x=1790799785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SnMP+yO9gTVCT1ht/mZTNiN+id9GPVSfGNROClqfyxw=;
        b=H1DxGSpPYLSxUygKsUtXVv+jry3Exlxvjn22Laowv9KBgC7XunJtSHs33WQlhhGoeN
         iONrXuOyAJxAx/XATErvzylRZXdHT/Gl5dyjEjBWhyLB7V+ZhaioUKjuhbi4qKEIHy7U
         9bfL32VJiO07YStYWzvHo4s0OpjCZ8MtHuvX/6YlFIyhnPKL3JJ41ODHp1S1yD9QkaqT
         lFp9PVXselqxjdABp6qZ1PtbbtkERjo7+4ULXUxB+dm40IaqCs2FmjRJPeFkRQX1JznQ
         5BFL9sXyKCBACWK9YI+g9LBHIkRMstgp+XLwjHvcJ5cVRwV3TXWFOFHeB3AsXew4IWOU
         tJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194985; x=1790799785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SnMP+yO9gTVCT1ht/mZTNiN+id9GPVSfGNROClqfyxw=;
        b=VAWtS7RI/S097fCCncPnfhxmLHzDlExBVCzNxbabFd4h062AzzFsCNyyQEX00UwPXE
         /M1VMowD49ibEh/lylZtCZYomW5XtvD0Fyl0H+gSJm/+DXdEysEWzVjUVyi3+xfua0cP
         u3pgWRS6adLAOiHju5zair2Q/9E3MJgwvbDSCkOp9kvidy+ulyp5OwCvtOkZb4mOXGnm
         6uuUJmsr1/fMrzYI+n2OwVQcEF+keM12HGUic5z+u92XElfchC8pNq6qc0LFM7ZxC/3m
         7AI68VxAbqB6pyRMhFCchejohSi29muhEVuNAGKkM1bOk750N2hlcvwDkmkzxZfLnbkS
         l2HQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZ9ag1D5tpJL1OL6vy6z77K8XMUYHD5Ys2IuWq/6XUhuIJawvziHSjD9gl/UA4hJD8cR9KnkvG0OY=@vger.kernel.org
X-Gm-Message-State: AFuF++mwHNoCBk79GKE/LzBtbdx9CYH+fp06JBd81IzhXdiiLQEKYJE5
	RlH+YPxX4/GrX7gi/eecVVl6JK1VtwA9EFGzjtulmOfjrcf+gFVpfk2q
X-Gm-Gg: AYBFou3wzVqjj9rXQLEqevS+mKsgsrEcVHFWkLYmiX7f08SivXzZgoXv5wqHh79AFGk
	YCqkzRoZSWfcVx1Kc/C0a67wuGBJbCzT6zNzbe+SKFQ+NXtk6g96xpaxmVdKlOicxIviAda0Sa2
	QJ4eFw7g1TcUKW9bl8bApMnLZGIxaKYlx2Y/5PkUy8lDshtuKpfxRMmvIlFJ3QhMhXfvjbd7FOw
	f37f0XoO8WGpUidBbe23UAKsYlrkIahM/AgciokHUI04B8fV5UZMIC72KZ9px7s3ZGIPbJpohBP
	0T3ILiCuMzKtpslBZ8cX3PNbo9JTkjHCc38fiI70w0Lqvr1JeWi2XAaUaT9f7Twy5Fp6z6+de9P
	JjXVX9BfVjScAXWns9Yx6f1R+rkenRdOwBQ15Ie5IW2bHsj6HV/Q6EoF1D1NUIoJQa3u1GyOJMb
	z3wBBjMmEjtwr7gVZ94FYbVLqCLzqgsUzE8g540lypOJi0R1oN1PA1vYzuCdtqB0NoxvBw1v8/D
	vK0r21rIZTn8aU5Oy73yRGZgbwbQ35PG1hTtAiH3Cs=
X-Received: by 2002:a17:907:3c8f:b0:c29:f5d5:5a92 with SMTP id a640c23a62f3a-c2ac23ec44fmr24127066b.28.1790194984695;
        Wed, 23 Sep 2026 13:23:04 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c8a44sm177243566b.20.2026.09.23.13.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:23:04 -0700 (PDT)
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
Subject: [PATCH v1 06/11] rtc: sun6i: add Allwinner B288 compatible
Date: Wed, 23 Sep 2026 21:16:56 +0100
Message-ID: <20260923201701.43391-6-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923201701.43391-1-pmazzini@gmail.com>
References: <20260923201701.43391-1-pmazzini@gmail.com>
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

