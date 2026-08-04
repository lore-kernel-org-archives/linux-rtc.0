Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CE4582E8
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838999; cv=none; b=uxVv1FwjioNJmxpJ5QToA66IhbvqqpAIIK1IMyGv3I9iTj7f6Nmx6Mjh46YxwEGJJbu4NcVVjMRi7LxD7HQv7OHc8AC71u3FP5DpbjlYFLuYZNJlJpea+qSWGvY2hiK2uVz69+lH4PuPCaCT/CDyq1rsWTetHk+1MbjmeHiKnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838999; c=relaxed/simple;
	bh=c/cL6CH88hXmr+yyhYydGRpG+eon1J//izf+65Nyi1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvbgj8XDpXwxoy4siO/qBv4k879rdpUd7gtr3SJUY9Hn1DZ3BaWLX1duOgWmUgjtT4DHXAoXus8hChrjyYJPZdV3oU+xwZbOIstCC6Nc2Nh9HQyvIcj3rtFfOPhAuWMzYjMxKQ8InrQafTlDskq/YT+OJIbfduIwmtZYnd2OFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b2A+U+av; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b2A+U+av"
Date: Tue, 4 Aug 2026 13:23:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785838995; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=vyKbrJh+mJhurETsWqt7ut9pqly28OJNV6Fh9JzfE7k=;
	b=b2A+U+avQzKF2t9O0nNZNC8oIu7p7t5CDVKSs3zZuJ8LsBchTtC4lJ7tqkVauNzD64Tqhw
	rZ827ZY37cvoC2iGzWPHqrvOhlJHgvAHxRn53lIvnge3kXXBhHcbSeztwm0GX6RrKpVht5
	tZ15Fw+EKaqD2GHj/M6TTmEhHw62QXM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 08/10] clk: bd718x7: Support ROHM BD73800
Message-ID: <032e165ebc5236cb58e91bce7d2e56c64d6a4976.1785838585.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bfzzk+jKxlQKq7Wf"
Content-Disposition: inline
In-Reply-To: <cover.1785838584.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--bfzzk+jKxlQKq7Wf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD73800 PMIC has a 32.768 kHz clock gate. Add support for
controlling this clock.

NOTE: The CLKOUT pin can be muxed by an OTP option. On some OTP
configurations the CLKOUT is not outputting the clk signal.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
  - No changes
---
 drivers/clk/clk-bd718x7.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 1cae974e6d1d..2dc6b8e46f18 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -21,6 +21,9 @@
 #define BD718XX_REG_OUT32K	0x2E
 /* BD72720 */
 #define BD72720_REG_OUT32K	0x9a
+/* BD73800 */
+#define BD73800_REG_OUT32K	0x50
+
 /*
  * BD71837, BD71847, and BD71828 all use bit [0] to clk output control
  */
@@ -123,6 +126,10 @@ static int bd71837_clk_probe(struct platform_device *p=
dev)
 		c->reg =3D BD72720_REG_OUT32K;
 		c->mask =3D CLK_OUT_EN_MASK;
 		break;
+	case ROHM_CHIP_TYPE_BD73800:
+		c->reg =3D BD73800_REG_OUT32K;
+		c->mask =3D CLK_OUT_EN_MASK;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown clk chip\n");
 		return -EINVAL;
@@ -152,6 +159,7 @@ static const struct platform_device_id bd718x7_clk_id[]=
 =3D {
 	{ "bd71828-clk", ROHM_CHIP_TYPE_BD71828 },
 	{ "bd71815-clk", ROHM_CHIP_TYPE_BD71815 },
 	{ "bd72720-clk", ROHM_CHIP_TYPE_BD72720 },
+	{ "bd73800-clk", ROHM_CHIP_TYPE_BD73800 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_clk_id);
--=20
2.55.0


--bfzzk+jKxlQKq7Wf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpxvYUACgkQeFA3/03a
ocUt6gf/Z79R2a0inH6wCI69ywBpui212rNJBnVRMBPexlrZi758a4NDQgk0YjRI
IybHp+0domj40zb8yyizEyPzlYoLejbNPC7e+XSrxW/ut/qNYPeBGsd8S8vWrpg7
4/s8mx/vce2bWuqNXWs8l9xBBBuDGO9trX3eMAkYfghp3X8XNBaS3YIzFX2Nz5Dx
ZNJHqfsjW6IaLVNXROQXWcVesWjrvRhfSt7UtArkK5T/eTZpamdLQt5P4VODuAtH
4FhCbzxAw3zsl+yyiIGeXzQKpBxP+8KTs8KvKqLEK+vYLNxkgp3ue5ZT9Aifi93Z
4Ip7EGAb/MjdvOF8e7uf54ImyzQVtA==
=as9c
-----END PGP SIGNATURE-----

--bfzzk+jKxlQKq7Wf--
