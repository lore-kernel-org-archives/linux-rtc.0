Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467806;
	b=oKSY3I81IavVRKBQEEEYt7z2ILKLaZjMul7AV82NhDTx7xO8v9fmOamuPq1TTk3XWPF0
	 zAaHP0dZRXIk9rAzSuyoxHo33b+5V3Dqrq1gnOAmDW1FaXkBZn4a8oH1JzmeVsXDtcMxI
	 e1zmwsX4Jkfbla+I2qKNVPm7+byxfyL/HcY/VXHRbBn7ONYNxUJyg7+2Aqjfa/BPWtj/6
	 AjvwN6uYlYnLXDqIKS7i1umAPoMkMbIWvmdxnXBv9blCEe2uUhfqHpn+S1QPifY/F5vX+
	 un/k81k9eLSD1Dt7XvwqEwuws8nSnlMgmVwlrDm4sOg1Jv2PP20TL+FN3Y3o9zt77bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467806;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=lUoG2M6Mlj8pfmjNuGBCjjggKSsvMYqMH3T6v1F2QZ4=;
	b=NB4Zpk6S8QAyQkYqQQzrz36iNY6U//euPyxJCTj5e110ASwQ1psxghRqsX5FWT5QG3n7
	 Sv7kzE/9lL0Tbyt8VpZVCGwuzDTLtAD7zGgjYZVftmm9cNLTvBNdIrxcbUivYrI2LjpXB
	 SHb9pPLa7rGETFkocVyqevXcPwW1HDlMnM1Hg5ixVPJpJYFJfbz2iHqrAJaff9LPBHk6j
	 9xQZWZDXng/iXvRTPY+aUwAb61qIccTRixxKPqesfa+EF2MzBXYNSZy9Wjucww0FFFpnu
	 z5zsJFAVMfNtH7EESO9o84yj6i2llJHdzKoOSm+LB/PNneWA1sfuCMktcvAZDNt9WGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=hqhJ2FXo;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65621606A321
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 21:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65621606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=hqhJ2FXo
DKIM2-Signature:  i=1; m=1; t=1795467803;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:dCZQJqSLgf/kRDwcTvwvj757DLUw
   EooquNgqDaGTcSVK2yvAYxGcWcOeLlgqZ/fO9K43gnMi8dMfJbvzRoaeGIjiRltCF4q4C2lIx7M
   faWO0A1eT+ALBdu/XCxmICJFboiyghNZ/h6T6PMYVGo/p21M3NeLIi1ewIBmM+fZL75Br2V2r10
   pFScP6hS4NaLJslcllSFt9X7+zNSep4IfQAuB3dt2Jsc2eCDUlg01q2t/zl10mAk6TQdvXmDgrF
   7SRgQRCVRQ2g4lJ/7XxCyHa2TGQloVj4UpZf95FPo9+wF09pEruxb4rBr6w1PtuBQHLmw5J9JTm
   fs1SWPhFvHL/CA==;
Message-Instance:  m=1;
 h=sha256:
   2ylPr61Vl8wSzuoOO0FS1UPf/2voYb+xyX5k5nCDEhE=:
   dBwnmNZ0twDUxk9hE7k+LCqdsgOTKI4ZP32BRk9Dihg=,
  sha512:
   Dr3P+Iyhyhk5nIFpJgQUOKhG5TT38zenUkhmZGZkoWg8fYOTs55wnq/kTMBKy3LJxfaW5ZYpQx0e+088NaSItA==:
   EAbfk2KS+oPyNaYFe/DIRoj6CPKLj32E0DK/JVdqis+zc6r6qeYuam0xyqzzfniQlqX5M1DkTYqRtwCG2ziEyw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795467764; x=1796072564; i=markus.elfring@web.de;
	bh=lUoG2M6Mlj8pfmjNuGBCjjggKSsvMYqMH3T6v1F2QZ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hqhJ2FXo9i6CaMJZCPbCo5UBse8U96zP0qGjTnaRMD1mVE+saWLIEBGH7pg1W9r8
	 1xAB/xqmTI9n73gzSax9giSxGylklGf6vD2WK49XWyIKF2JAJbyNDqjMcx23kp709
	 ydONjyI+ETVQ1PiomUOa0jaW5l+Kr6eLGILLidj3aic9DpnYlfEQtGiT78fHchnnI
	 lEMOHPY/gbxk54Gpz3Mxrxxm3UmlGAMvV5dA0h/I4J8Ak7SiLh3hHjx+dREurqZBu
	 w9wIVXrwOeTkQ+i2Nz8srV6SpQ89C2MdlVa1/kZZpe44cqKoMXKO12Iqe0ltYp3mo
	 3kkwwrrcV27jx7H3qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qcr-1xZC53328r-005EBR; Mon, 23
 Nov 2026 22:02:44 +0100
Message-ID: <ef3d0b97-e1ad-4924-b380-16a46fd17b94@web.de>
Date: Mon, 23 Nov 2026 22:02:29 +0100
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chuhong Yuan <hslester96@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Oleksij Rempel <linux@rempel-privat.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Florian Fainelli <f.fainelli@gmail.com>, Frank Li <Frank.Li@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] rtc: asm9260: Use devm_clk_get_enabled() in
 asm9260_rtc_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:++jd6/nmszqVoMYV2FP9TKcTxsCLrAOnyMVF9IO9wtCH3N++glD
 QGmU3SbLGBnMbS2Y8Kkvx4qClG6owO/3nOZRp4lXtAONkmTuYmwol/lWq5X9GKZQA5sXkEJ
 AagcQyXChx6DH42mrUkheX7QUyuON0lnzW+HTk+Kx+VZWRte5pog68gDNTU1QoDVUOmDejJ
 l+xCJLK5csyrhT1RuU+DQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PmMUrv4sBpI=;R1TiQoiMWva+KF15U7vWCLg6Hu6
 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
 lu8iruoqAjlCnSzzeQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 23 Nov 2026 21:50:07 +0100

* Reuse existing functionality from devm_clk_get_enabled() instead of
  keeping duplicate source code.

* Delete a clk_disable_unprepare() call on an error handling path
  and in the implementation of the function =E2=80=9Casm9260_rtc_remove=E2=
=80=9D.

* Omit the label =E2=80=9Cerr_return=E2=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/rtc/rtc-asm9260.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 95d7b894acd5..38a9bb8b3f9b 100644
=2D-- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -261,16 +261,10 @@ static int asm9260_rtc_probe(struct platform_device =
*pdev)
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);
=20
-	priv->clk =3D devm_clk_get(dev, "ahb");
+	priv->clk =3D devm_clk_get_enabled(dev, "ahb");
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
=20
-	ret =3D clk_prepare_enable(priv->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable clk!\n");
-		return ret;
-	}
-
 	ccr =3D ioread32(priv->iobase + HW_CCR);
 	/* if dev is not enabled, reset it */
 	if ((ccr & (BM_CLKEN | BM_CTCRST)) !=3D BM_CLKEN) {
@@ -287,7 +281,7 @@ static int asm9260_rtc_probe(struct platform_device *p=
dev)
 	if (IS_ERR(priv->rtc)) {
 		ret =3D PTR_ERR(priv->rtc);
 		dev_err(dev, "Failed to register RTC device: %d\n", ret);
-		goto err_return;
+		return ret;
 	}
=20
 	ret =3D devm_request_threaded_irq(dev, irq_alarm, NULL,
@@ -296,14 +290,10 @@ static int asm9260_rtc_probe(struct platform_device =
*pdev)
 	if (ret < 0) {
 		dev_err(dev, "can't get irq %i, err %d\n",
 			irq_alarm, ret);
-		goto err_return;
+		return ret;
 	}
=20
 	return 0;
-
-err_return:
-	clk_disable_unprepare(priv->clk);
-	return ret;
 }
=20
 static void asm9260_rtc_remove(struct platform_device *pdev)
@@ -312,7 +302,6 @@ static void asm9260_rtc_remove(struct platform_device =
*pdev)
=20
 	/* Disable alarm matching */
 	iowrite32(BM_AMR_OFF, priv->iobase + HW_AMR);
-	clk_disable_unprepare(priv->clk);
 }
=20
 static const struct of_device_id asm9260_dt_ids[] =3D {
=2D-=20
2.56.1

