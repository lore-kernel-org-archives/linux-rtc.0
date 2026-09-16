Received: from mta0.migadu.com (out-52.mta0.migadu.com [91.218.175.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8133E7174
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538985; cv=none; b=Nm+lOqHgOzwRFkFpqaEra1HwQn/egykTvwgSRQcLB1KZCSp2BDNsBXL65m5lH8hdVwdrdwtunwx4hs41/cxweTkzWarMIBNQEe2SvjvYiIzhP6nGpT7Mo2KBWURtOZsDza8iWyARvhlBbt0sR3zo8XAR53GsjSr55whKwGTyJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538985; c=relaxed/simple;
	bh=1FXPXUrDPcrYPLwRxPXtr4tpEmOLRIi+Rq2mTTRREaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNWGjKpM9MuMlfd9eOIHqnxec3AtCOr0NKwWZCaoLP715qUuHfwBYNqn7yuyPA1U6LMbmlqm1yM8sB1e+6SXfg89TVAi8ouhc4LQoHmCRMCqQeZF8yI8cT92sWULE19Q0NN/uudprAnJm+IccCTJLWZEev4LoWFugOTHf1GRBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P0LRIIU3; arc=none smtp.client-ip=91.218.175.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P0LRIIU3"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1FXPXUrDPcrYPLwRxPXtr4tpEmOLRIi+Rq2mTTRREaU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789538981; v=1; x=1790143781;
 b=P0LRIIU32CE79vjascQV+yMYtw82H/b6dQTfZMWX7/K6l+5JSQ9JaZDydMLCVvdjNAIE+kKq
 6LZUEeM5G36PWHYACJOahGES010/S5TjcAAW/Iux0fH+oJTZA+3+T9rFwNxsrxyoV7f3gw6gsuv
 KpXCVlVwm74FZLfdRHZi/0rM=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 56e648d48c427c41;
	Wed, 16 Sep 2026 06:09:41 +0000
X-Mizu-Trace-ID: 56e648d48c427c41
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 09:09:32 +0300
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
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Sverdlin@mva-rohm,
	Alexander <alexander.sverdlin@siemens.com>
Subject: [PATCH v4 06/10] rtc: bd70528: Support RTC on ROHM BD73800
Message-ID: <1ff511f419fcbd72dd241f598127608a6a0c9598.1789538455.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mUgRN4pDP+5ghfak"
Content-Disposition: inline
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>

--mUgRN4pDP+5ghfak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

BD73800 contains similar RTC block as BD71828 and BD71815. Only the address
offsets seem different. Support also BD73800 RTC using the rtc-bd70528.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

---
Revision history:
 v1 =3D> :
  - No changes
---
 drivers/rtc/rtc-bd70528.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index 482810b61495..fd415e327ea6 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -8,6 +8,7 @@
 #include <linux/mfd/rohm-bd71815.h>
 #include <linux/mfd/rohm-bd71828.h>
 #include <linux/mfd/rohm-bd72720.h>
+#include <linux/mfd/rohm-bd73800.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -284,6 +285,12 @@ static int bd70528_probe(struct platform_device *pdev)
 		bd_rtc->bd718xx_alm_block_start =3D BD72720_REG_RTC_ALM_START;
 		hour_reg =3D BD72720_REG_RTC_HOUR;
 		break;
+	case ROHM_CHIP_TYPE_BD73800:
+		bd_rtc->reg_time_start =3D BD73800_REG_RTC_START;
+		bd_rtc->bd718xx_alm_block_start =3D BD73800_REG_RTC_ALM_START;
+		hour_reg =3D BD73800_REG_RTC_HOUR;
+		break;
+
 	default:
 		dev_err(&pdev->dev, "Unknown chip\n");
 		return -ENOENT;
@@ -344,6 +351,7 @@ static const struct platform_device_id bd718x7_rtc_id[]=
 =3D {
 	{ .name =3D "bd71828-rtc", .driver_data =3D ROHM_CHIP_TYPE_BD71828 },
 	{ .name =3D "bd71815-rtc", .driver_data =3D ROHM_CHIP_TYPE_BD71815 },
 	{ .name =3D "bd72720-rtc", .driver_data =3D ROHM_CHIP_TYPE_BD72720 },
+	{ .name =3D "bd73800-rtc", .driver_data =3D ROHM_CHIP_TYPE_BD73800 },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_rtc_id);
--=20
2.55.0


--mUgRN4pDP+5ghfak
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqqMpwACgkQeFA3/03a
ocWHywf/TpnLoThLOPyYyeFOZbqVLZ+ucK3WNz1ae/rLX+DhEKXRo1QVhzEd1MLU
G7R6rQKd/0TcWu1aWVO/0+Gu7/AmOs1K0JRJToC6zxWekjznVQT3tZ6TOBZqupm0
rRMq44S0MVjDhDVCRmt8iCTxF2wdsuVUzWQu3TRs3JhH6wi82Zgdz/SSC6xOPQB/
nl7xJRLCF0JEAu2uJTPokEjZ1kv/xMHjz4W/LKVV2EBhwniv+UYt8+mXwhlJh3ks
vRNYzlH7NmnaoVZdR8l7QhPHuu0qrFBjhfTajAVA5IczJee3JCQAp8YVZLcH80Qg
zNUC1C5MxToP6G1mUQNQiv5w/HDoYA==
=Hs+m
-----END PGP SIGNATURE-----

--mUgRN4pDP+5ghfak--
