Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E252D876A
	for <linux-rtc@vger.kernel.org>; Sun,  6 Sep 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788693252; cv=none; b=Tdzn7FeJUz3w4YAb9H3zwRM35rMYIf98SyDxp44tACe80O0VGRhNBZoR7dSe2rkS/yPNFnPMFn0Uv6489JTEa1aVufSuHE1Gy0vPVPBTE7l4fxOHxCuKtCrVTONHXKbWDey4bf9ayEu/DGrhHctjX+ZpEn1yHdeXhLLeFZ/1g0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788693252; c=relaxed/simple;
	bh=cZDn3i2B41dm1+0cuLWMhxtjt5xxBl4YjwKFgKQKXYM=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=qxU/nnbMPMKVZY4YGDfpBvBYcgbZXqiRcar70CfW0i6T6uJqN4PPOeXvSFvwP7d6rLZ4KvSLG4mp7fvSShXH/Z/2DtTBpGuIbfa5WX8L7EfgWcpwWWAQwAzxWya6R4yMDloqLsTjEwPlH/SspQ6or1ow42rZRrqJO8+UWrfXY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqBjZC5P; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqBjZC5P"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d8fd3b729dso20695865ad.1
        for <linux-rtc@vger.kernel.org>; Sun, 06 Sep 2026 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788693251; x=1789298051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DEdh5HmNzXfseZwOB17l9FeOx8g8N1pY3V9IexD1Wc=;
        b=TqBjZC5PzL0K4rzu7wNDpeJKiXobRXG/cm8jhJRAu8dvqzBlKkR5yjYxbP2X+1dmOZ
         unak1gRMndeLKtXbV8BPtJgb10uBW7hsdlSRfGQwXI4L4rp0xwJzKHKj/8U1ufxzosml
         7+A9/UiJ6V5ibhXiddO5Q00pR/lNuZIzcw7E9TtdH3IwVVy0NfcoRQ3SXkhq1iSqj0dN
         qF6OFeiIdDLIQA1GuNGSIgV8+mLP5kfo/YZO7yjuxDzVLeOrPaY//Rk/mmjLxyly2BWK
         ZiPX750lIyWWpeUmvFDhGnx26OEOwsdDGO0hhLhxVYZZF8Iuwb58v72nl5ztbygD12qN
         GGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788693251; x=1789298051;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5DEdh5HmNzXfseZwOB17l9FeOx8g8N1pY3V9IexD1Wc=;
        b=YBHRbAyrLXGk4oN6kzU/vGfzH73Qa6bKDcZAtQl4xruJHwZXENJAe+Yw/fsXkLTDOO
         /87KvHCq2cykSw5mhDQY/OvBZqjQIRh9qjzWOExABQn6GYsyK/DEdv95YRk55ZA2NCVt
         cIeV8C/HV04iCDcp24jgNCoL8k0NeHriVMrFwAU+p/WgRy76T54V4ed1N+I9oCPgvt4d
         h68vTDPdLmTh0EMYTahHP/w8J21CdnLQT7Q5dmBMHtuMjRKNp7zl66CdLEPuk1B3pop4
         V4L/UmrnUwNuHOqB+pe2QvzTztMI+3Ccau1c/a8Y4nAdg2GEZzZ8ZL+2sx4+zxBJBJxI
         TylA==
X-Gm-Message-State: AFuF++m9WRtUx3IhqRA4w18OHkdz6v7VW7SYSC4ySyswBJ6PkKm+E8Q1
	+HdwK3ax7jz4cqmWG0MZN530Cg4Hk/YLJpgYTujlnOY67f+ZcbYyrPGU
X-Gm-Gg: AYBFou1YVh70qCiqGneYBzburXsRn7QyC3EPbABnKf2VdddpUfx4VfmjbiGsfedvsuw
	JVJ/Bxyk1UsrQdFlNSwgafknizsmq0wvXNcVRT2Q06Sovn6fOuYGVsQwT9+DlHzIqHOPsmo+1Nr
	fqk9sfuJ8hqI8zg9mlH9jXyQUVo9p6tmQgv9P/TIBLz/3YxL7jua+Pp/4EwlswbzCspAArjZQc8
	ZHOeR2B+tb/2c4ngy2p6CB13eLdjayLJgZ5dwlqDkptu9Mq3lGqbJ/IEM1aK/SK1Py+aghDQRnW
	Hz41Y6S474Xym4pRQ5f7EJBY3e1XTDiAmF8fqLOXn6r1cZTLDq8Twk95/xoEgLoq1cpgk9yIFz7
	mMWqxf34m4fx1edtasqC7q6sJpGgLT1t+X6OAO8Cy6VO7AtPDlSfE7TYvhNXYT7u8U898/tgu3P
	s7O5P2HiZKDiQAFU/7ekHobJWiJZpC2Zp9u1zvUw7FxgiAhxRln2A9bdCjgA/VIyJ1fXr+0ek6y
	e9r0VtpRNm4uhNrqF5MswVbm44+jze8ekFd2lbkgGT5B4jf8F87w5AZvlUlUEinL56f
X-Received: by 2002:a17:90b:17cd:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-39b26272b4dmr25093820a91.13.1788693250979;
        Sun, 06 Sep 2026 04:14:10 -0700 (PDT)
Received: from manush ([2406:7400:94:7a79:f149:be84:942d:9300])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33517b57ac8sm10400667eec.28.2026.09.06.04.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:14:10 -0700 (PDT)
Message-ID: <6a9d4b02.7d74b517.206c4c.75f8@mx.google.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: conor.dooley@microchip.com, daire.mcnamara@microchip.com,
 alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: 6 Sep 2026 16:44:09 +0530
Subject: [PATCH] rtc: mpfs: fix unchecked devm_clk_get() error pointer in
 probe()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

devm_clk_get(&pdev->dev, "rtcref")'s return value was passed stra=
ight=0D=0Ainto clk_get_rate() without checking it for an error fi=
rst, unlike the=0D=0A"rtc" clock a few lines above which is corre=
ctly checked with=0D=0AIS_ERR(). clk_get_rate() only guards again=
st a NULL clk, not an error=0D=0Apointer:=0D=0A=0D=0A	if (!clk)=0D=0A=
		return 0;=0D=0A	...=0D=0A	rate =3D clk_core_get_rate_recalc(clk=
->core);=0D=0A=0D=0Aso if devm_clk_get() ever returns an error po=
inter here (for example=0D=0AERR_PTR(-EPROBE_DEFER), which is the=
 normal, expected outcome if the=0D=0Aclkcfg clock-provider this =
RTC depends on has not registered its=0D=0Aclocks yet by the time=
 this driver probes), clk_get_rate() dereferences=0D=0Athat error=
 pointer instead of returning 0, crashing instead of letting=0D=0A=
probe defer.=0D=0A=0D=0ACapture the clock in the existing 'clk' l=
ocal and check it with=0D=0AIS_ERR() before calling clk_get_rate(=
), matching the handling already=0D=0Aused for the "rtc" clock in=
 this same function.=0D=0A=0D=0ASigned-off-by: Manush Prajwal <ma=
nushprajwal555@gmail.com>=0D=0A---=0D=0A drivers/rtc/rtc-mpfs.c |=
 6 +++++-=0D=0A 1 file changed, 5 insertions(+), 1 deletion(-)=0D=0A=
=0D=0Adiff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.=
c=0D=0Aindex ece6de4a6..60596b0ea 100644=0D=0A--- a/drivers/rtc/r=
tc-mpfs.c=0D=0A+++ b/drivers/rtc/rtc-mpfs.c=0D=0A@@ -256,8 +256,1=
2 @@ static int mpfs_rtc_probe(struct platform_device *pdev)=0D=0A=
 		return ret;=0D=0A 	}=0D=0A =0D=0A+	clk =3D devm_clk_get(&pdev-=
>dev, "rtcref");=0D=0A+	if (IS_ERR(clk))=0D=0A+		return PTR_ERR(c=
lk);=0D=0A+=0D=0A 	/* prescaler hardware adds 1 to reg value */=0D=0A=
-	prescaler =3D clk_get_rate(devm_clk_get(&pdev->dev, "rtcref")) =
- 1;=0D=0A+	prescaler =3D clk_get_rate(clk) - 1;=0D=0A 	if (presc=
aler > MAX_PRESCALER_COUNT) {=0D=0A 		dev_dbg(&pdev->dev, "invali=
d prescaler %lu\n", prescaler);=0D=0A 		return -EINVAL;=0D=0A-- =0D=0A=
2.46.2.windows.1=0D=0A

