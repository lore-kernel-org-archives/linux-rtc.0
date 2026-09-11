Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094F2C1584;
	Fri, 11 Sep 2026 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127064; cv=none; b=ShdyoQS4NhQ/lOY7hXpaSDPgCRpuHf5STea/Uhq/vWF8gyQqkLlb1niSgcXu/xh2lSv3yZoaIPACXRFkW/NhgE+IqMX21ZKdcdzk2fFMmEKYcp7sXLP6Uder79MfzRfFSidPoDtZx4oLja24nHFGQyg6mRvVIRz4cJwt+TTBWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127064; c=relaxed/simple;
	bh=+bs57/bughUfPRjmHYoDLuYii4sHduoEapzv1jN/Bm4=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=CfIKNGEixjKTci8sTifzrXKJ6yOG7DAunbHQj/+vh4x6FhrtEgRMFUcCTrQVGXjNwKpKPy9eyXSTEt8c6aBV/q2HAjG27Y9H8hWs9RsXDOpqmkLtWTuTQPWcf8qHAF15wY8vlnWm+Y2IqXezXtg2M6bqoHIFJTtWxFYjY6ASwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=UkmR+viN; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="UkmR+viN"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1789127058; h=from:to:date:message-id:subject;
	bh=2aO7zrjq+oYvgYiAtxJw5PFJsURUUiBq37Hj2M3Yj0g=;
	b=UkmR+viN1YKLzRy3IZ4iRf+yjq9qWBixoHN59vCC4WwF8cJ8UYP7TKSH7mDdUpbTiGQlm2sfJTc
	aJaCGwLxOijKmj8vv+YgNwsoKKWPLHbuX1MmJVbMSHSFeS8e8la5zcBtAJ5gQ1AFdPa2jgxdJi2UK
	vML7lkWlBe64ATWjNDtScfFLF4CkgaJDTQivEnp7OY6QmXv6Fcc0wxX95PO6NyiBoFOV01uYICiI3
	wwzJ9iI9mLe1R9Xm4MSMJxAG8aMukvfbVB+korWkutoiHCNlBtQtrtfU00JGUpcvA67/lcSYZc8XQ
	Did9H0ySNCMmA/84uMIU2rN8ldU/mGxVIgVg==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 11 Sep
 2026 16:44:17 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 11 Sep 2026 16:44:18 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 11 Sep
 2026 16:44:18 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, Tony Lindgren <tony@atomide.com>, Keerthy
	<j-keerthy@ti.com>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] rtc: omap: check clk_prepare_enable() return value
Thread-Topic: [PATCH] rtc: omap: check clk_prepare_enable() return value
Thread-Index: AQHdQeLgX7ejRIW2vk6x/EUyItBnnw==
Date: Fri, 11 Sep 2026 11:44:18 +0000
Message-ID: <20260911114350.160356-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

clk_prepare_enable() may fail, e.g. with -EPROBE_DEFER if the clock
provider is not ready yet. The return value is ignored in
omap_rtc_probe(), so the driver continues probing with an unprepared
clock and later calls clk_disable_unprepare() on it, in
omap_rtc_remove() or in the ioremap error path, leading to a
prepare/unprepare imbalance.

Check the return value and propagate the error on failure. No
explicit cleanup is needed on the error path as the clock reference
is managed by devres and the clock was never prepared.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 532409aa1ba8 ("rtc: omap: Add internal clock enabling support")
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/rtc/rtc-omap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 0f90065e352c..97d03ded51db 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -758,8 +758,11 @@ static int omap_rtc_probe(struct platform_device *pdev=
)
 	else
 		rtc->clk =3D devm_clk_get(&pdev->dev, "int-clk");
=20
-	if (!IS_ERR(rtc->clk))
-		clk_prepare_enable(rtc->clk);
+	if (!IS_ERR(rtc->clk)) {
+		ret =3D clk_prepare_enable(rtc->clk);
+		if (ret)
+			return ret;
+	}
=20
 	rtc->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rtc->base)) {
--=20
2.53.0
