Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022704772BC
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477344; cv=none; b=tee65MTxpziCVxx9uYeopgWLYG/kbU3wCWJi7fiJ3VXvw0A/61dkHejXaEytxp3p5h8dGJRm/64Gqayh4857E8KOyn0w4ZDiFF5PUfwWbnSmTFRJZRqYCkx1dQZf/u1IJ5SgF2H7xlJkIpQJtAH803vMIO3csmMFRX6aww/OorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477344; c=relaxed/simple;
	bh=iymtdZbAVDC4szK+VL2vsDv4Um3gp/9GnkovC0TOf7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgBzQyPRgXS/Cl0g0jQ1RdpQAVZQpliEVtq31K3PU3PIL2xb4o05RBz/heJHzQqSY3y6cefRYTO+k7BJ8/Dz6yGi0BbVqfu1m8aqtLbddwIxWx6Y5/2h4XaoVGFq0onssORWrgMkCjuikzS7ZoJnflRmFXNj6Yf/tHGfZLNKqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsu/2LTZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsu/2LTZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954df200ddso1196515e9.0
        for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477340; x=1787082140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Lv+zt/h7dKa8TuGsaFOLj9Yjn5OU7W3HW8p5oLwNPc=;
        b=rsu/2LTZTEAhX//Q29JAAyuL/d9olDI3dISJO7M2kpO4uonZSqspmWPeTa8oQMf2P8
         nn76FbxH6ph5p6mQYExRgWNQ6yeli/B1K7JQYo9aE3yQXqmzwugptTkPAJz3F+Q6h/j9
         RuKKaMJV/pcndzbcx4HITrzLLcRIwWaftWJhsoioWPC/7CX4qkgQxhg6kimZ0jHf+LpW
         13CIjZkuVbpfoPEdzgumoLs9XHDnHRh/iSR4BHFICtiNS/1ixJc0I/Iqn/2FRpU/Htc0
         1NlSDDFf36CdkEiCHSermn/6v4njmioq1zdnQH4cnX0QR3TYPdqQhX3VjGY7aicIfsU9
         g8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477340; x=1787082140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Lv+zt/h7dKa8TuGsaFOLj9Yjn5OU7W3HW8p5oLwNPc=;
        b=a6nj7mSN+Zks54Dofm70KJHSxo7qGk1/9PClAj8VbXFhA7/N+CW2zq+veQFtDuDAQH
         TGkdoV9ApX+RI8Sk7V4HAj3RGmD90wbLwdMlHN59W54QMFwIZLQVl9DLeQcCbEySd6jb
         1+SGhTGIWAU+ATS+WdYzdh+V0yvX196rRVLC18UCpjtO3MBG3lzZdOkG0l88f+HV4vNH
         afHoheCDylCUvgkjHWrwIrbFkhxcfaGxBoOEIuTFNyTuTzt/gvktlgyq7nRNTYCsRdwR
         xTi4v5jVuyM+0QV5F6f0qpRYnGYgnSZkdDyw199kv5kK9URBklVn5A5NSJJnsRq93iWG
         VTQg==
X-Gm-Message-State: AOJu0YwRyuHGLo17z1A+galPtIEbK1fydR8mMpQ/bcrE1h+ECboiKMub
	eo4LDQ2IEGB0hpjmlH6YysRBufSrNG0Fj19ntmtnw6mtbfAykdzLZgaj
X-Gm-Gg: AR+sD13xIIG0ZAzTpbr2kl9df4gBiRueJTwa6WFgts38yD3X7Ru+TlAQAdSEt4ZnqYT
	QMcx0PSJ9xn4gTGnj3pp6ElYnipanCgm36hzgK1Khc20gVbT8TrAYSs2eh+3SOo/n0q+3I/cA7r
	fL16YuFpsj7GL0sFFlvV5sgRgnWb3CxmkhgRk5T/njxRJuAcScY8FGapkkCiUJJkDQ6zc+7yPOJ
	P6YULEdh1IVhNOaUSCDeWUKJKI5xz/7BHAZNXatmppAy1Q4oyxRSYdiIe2MuUzrgM8PaPFrp4N1
	24FI7lmSfBA54fYK76MG1gQILiO5Tj2arlZZTk3MhGe5AuJB9wbO+hAsYOfQCtMeQF8vlQOhXfi
	0/n7eyI8RPjfaCY07BiduP0fG7Vxb//fUaPDusZfkpMl3DahZ1g/ykQ1ymnlY19IxY9QgEyhk9u
	tfWbpHni34GSNe3GGqtxhUV6GKBrLJYhD33W87EHSUCSlOWdLeZ1P3RAY/yREJONI9
X-Received: by 2002:a05:600c:b85:b0:499:516b:83d5 with SMTP id 5b1f17b1804b1-4997845f3f3mr82515435e9.11.1786477339927;
        Tue, 11 Aug 2026 12:42:19 -0700 (PDT)
Received: from antoniarch ([78.213.143.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b22784fsm2606535e9.2.2026.08.11.12.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:19 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v5 2/9] rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
Date: Tue, 11 Aug 2026 21:40:27 +0200
Message-ID: <20260811194034.28937-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811194034.28937-1-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_smbus_read_i2c_block_data() returns the number of bytes read on
success and a negative error code on failure. The existing code treated
any non-zero return value as an error.

Fix the error handling by checking only for negative return values.

Fixes: 718a820a303c ("rtc: abx80x: add alarm support")
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 5486d9d0b1e5..fdf9664ebb6f 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -294,7 +294,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
 					    sizeof(buf), buf);
-	if (err)
+	if (err < 0)
 		return err;
 
 	irq_mask = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
-- 
2.55.0

