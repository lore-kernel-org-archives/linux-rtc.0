Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504864;
	b=H4C03fYGnSduIN7T8+WiRJLNYXSx+vMHTcv0wC6ZlRwBuyXlijw8ZU835Z85mN6f26Rq
	 g5bJjT4k9z83xtaMVRUgsqG4lZ6Xa/LuhaSc+WihQ/beWie/W2V8ylENM1zn6pSvTImJ1
	 LDpjErP2UhSj0dfA8JR92xsUn1GqFDrGhz91cpnySdrfulWcIq4SOV8fYFeIKEfdLos/K
	 zG9Tutpc/d9KAUL0hDgGEphePQTh1sEQpk29iRhQkmtU5BEbsywMuJhoU61cB4lpyL9Jt
	 6Zk0eD67uE6OKOr2fyIiV/nWxjps7loK6mCBiSRX7H9MOxFPcArc6Gd5bGpxdiQOAOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504864;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:To:
	 Content-Language:From:Subject:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=KkucrrMGhNWaZWvXJ19J79HJANRtIXVtP9s7lZdVBZ0=;
	b=jMOcsMaO50RfJqZfXAtHPxaK4OGwZj0nj17j/AHrej5k9ebIFNslpY9kO0d9leacC1sE
	 JZnaOHEL7qTbXRWA6erL+K6PGTSxHDzO20EV+57/mJ7IZn7xfgy3m9WQTiuFCLSEstxKM
	 OMDCKpipyVNCE3WGKNXaKWVpwE8LSEnkSO/oawLnEhu1k+oIcACt5BJeRxG+jozUiBSK2
	 w8qIRW6ld0h9DSNeiNtdoZS762kZgktVGiHnmzikFVpkWDDSgLg73+V+HDH6k1ri79e23
	 P4AYdgHirIZ8uL3K2rCm7xrtfKgaQEdhzqI7UcKv6u9O1b6CvMscAYRDNNNtIBS9FuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=X1h8FHwf;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB0606A330
	for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 07:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCB0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=X1h8FHwf
DKIM2-Signature:  i=1; m=1; t=1795504862;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:pdKqsE5o2CEQgcmKGgk0uzkaWPat
   /AvgysSW1mbVOOWgbojWQ3fbBznEHDpmU0Sb6yk9+3FWUfHGQ0xO+X90UC285lAt5SUD/DW7T3h
   1zchMlinMfAtqk5b6oJJ4hcFqldjKWhEYJFTbpzo6HhR1vfEQy/NYiRCqJs/ivm+zZ224aPjoq5
   /bISI455lrEJX6omIVUGIi5jQIrUIjGY3YxgArn/ckIQNyizerfpD8IS/2d77Z2kjf73BDtglHq
   3vFK6yy9tZ8i1FUy6Ns3F2FyUQxqUzWoIrxZyhZipb0KQFkknjqObeKWIOTvogArCD3wxDCoB8h
   dz36T3bqE5dPOA==;
Message-Instance:  m=1;
 h=sha256:
   DdZlVpehT64f0d8IdwhV/aXNE1YZ99rKOhhFrLNAfUo=:
   /D2s6nZJY45tqinpPXC3SLDJfDgpNRYsTifkJPYsgKA=,
  sha512:
   0l9PEeqI7qTg/j3To6afVCfEY0/6o8ylNJEQ4uktAdwXqPRW7ZWxrXoyox0c4w3t9cNyVzxkMgYzRr5wJ6fDTQ==:
   QfQGqiKu1UjvkyC626c4AEiqAkqxJtiOiSn4OVjlhbZ7hsJ8zRrwL4xQKV4Cv5afFOtPS6F85qlA+xXRypngIg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795504826; x=1796109626; i=markus.elfring@web.de;
	bh=KkucrrMGhNWaZWvXJ19J79HJANRtIXVtP9s7lZdVBZ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X1h8FHwfdKP1NIYZo1A3759DCaQ1LkTtOsp+uPNLepm2hjdIaVYVo4XFq4AQY51h
	 44THzZI3SDvvw5sUkp6UJILRnbLvaMdMfE7chcTdRHzdeVM3WGtK1Wkm4ZudDyTQS
	 OUZgOl+PqZnxSb7Aukpk9Js+49BH0jyyjCXMtqnaeKXSnVDBGllfM8Ov2tvroqEEW
	 hVd6itjeuBHSjgnZPci7fKvbUVlt+C+cSYp59ZaQiAy1UUmf1t3MaGjyRNZ5M59mp
	 QB51tkbXQkfdr5cF4s9TVnUPlflJLaq1rAgOGl/HBOfsC5scs5rUcJts1IO/FDLeP
	 fBJfx0M7A5AoSOL0BQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1yb03K0oPc-017v8M; Tue, 24
 Nov 2026 08:20:26 +0100
Message-ID: <d16d0991-d1d7-4828-8e05-8d8826cbb222@web.de>
Date: Tue, 24 Nov 2026 08:20:10 +0100
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
To: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Boris Brezillon <bbrezillon@kernel.org>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Johan Hovold <johan@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] rtc: at91sam9: Use devm_clk_get_enabled() in at91_rtc_probe()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Florian Fainelli <f.fainelli@gmail.com>, Frank Li <Frank.Li@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s603HhO5lWZhxUYLN9rLCOdh4gax4InudVezWexFsE5hq50LgPd
 pJ1yQjp8CeVW682Mwc04vsEwoThCOuQeE1Rw+PXddeOapfNRz5mmcxZDw11ZsV4RCjoIyEE
 eOdFiTfuAn7hRoXlciOj3SESrlz7b+pgeEM6iz7/NS37w1ybT5yeSXuIks1Qsmes/MuVhr+
 7xREQFUMOqc8rqUGQM9Ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i8BbCHjvpzE=;lsELVmmQqbv6ZQGCivQDptJsXqs
 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
 ECZKLwAHqlrEdAdbfA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Nov 2026 08:01:48 +0100

* Reuse existing functionality from devm_clk_get_enabled() instead of
  keeping duplicate source code.

* Delete a clk_disable_unprepare() call on an error handling path
  and in the implementation of the function =E2=80=9Cat91_rtc_remove=E2=80=
=9D.

* Omit the label =E2=80=9Cerr_clk=E2=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/rtc/rtc-at91sam9.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index cbd2f1a6c54a..6628335d6f46 100644
=2D-- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -375,21 +375,14 @@ static int at91_rtc_probe(struct platform_device *pd=
ev)
 		return -ENOMEM;
 	}
=20
-	rtc->sclk =3D devm_clk_get(&pdev->dev, NULL);
+	rtc->sclk =3D devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(rtc->sclk))
 		return PTR_ERR(rtc->sclk);
=20
-	ret =3D clk_prepare_enable(rtc->sclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Could not enable slow clock\n");
-		return ret;
-	}
-
 	sclk_rate =3D clk_get_rate(rtc->sclk);
 	if (!sclk_rate || sclk_rate > AT91_RTT_RTPRES) {
 		dev_err(&pdev->dev, "Invalid slow clock rate\n");
-		ret =3D -EINVAL;
-		goto err_clk;
+		return -EINVAL;
 	}
=20
 	mr =3D rtt_readl(rtc, MR);
@@ -405,10 +398,8 @@ static int at91_rtc_probe(struct platform_device *pde=
v)
 	rtt_writel(rtc, MR, mr);
=20
 	rtc->rtcdev =3D devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(rtc->rtcdev)) {
-		ret =3D PTR_ERR(rtc->rtcdev);
-		goto err_clk;
-	}
+	if (IS_ERR(rtc->rtcdev))
+		return PTR_ERR(rtc->rtcdev);
=20
 	rtc->rtcdev->ops =3D &at91_rtc_ops;
 	rtc->rtcdev->range_max =3D U32_MAX;
@@ -419,7 +410,7 @@ static int at91_rtc_probe(struct platform_device *pdev=
)
 			       dev_name(&rtc->rtcdev->dev), rtc);
 	if (ret) {
 		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", rtc->irq);
-		goto err_clk;
+		return ret;
 	}
=20
 	/* NOTE:  sam9260 rev A silicon has a ROM bug which resets the
@@ -433,11 +424,6 @@ static int at91_rtc_probe(struct platform_device *pde=
v)
 			 dev_name(&rtc->rtcdev->dev));
=20
 	return devm_rtc_register_device(rtc->rtcdev);
-
-err_clk:
-	clk_disable_unprepare(rtc->sclk);
-
-	return ret;
 }
=20
 /*
@@ -450,8 +436,6 @@ static void at91_rtc_remove(struct platform_device *pd=
ev)
=20
 	/* disable all interrupts */
 	rtt_writel(rtc, MR, mr & ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
-
-	clk_disable_unprepare(rtc->sclk);
 }
=20
 static void at91_rtc_shutdown(struct platform_device *pdev)
=2D-=20
2.56.1

