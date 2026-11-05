Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915610;
	b=OwtW5sh19jBM3BiXwCMl4js9zphtvuLHcrh8eHggxhSrM63B94g+fI5Pgem2iJLhdCM1
	 M4+X0lT0RsjnwfhM63W0eErvuT9nrXmvyT/qMKCfQ/Lm1CnJuMX0GPvwqqy/7dnPn9Xqt
	 CItRyRmpAaW7IJkg5aBOLDxV7zP9ioyzf6vKfENxtlNi0ByLxR9bZ0VuBPABuFCTrAqCx
	 gyHA5HQynFPDPWybYuxl2DlKUYAGKyyDYFDAEXc7rDw0ScjKXj8EXaj+hx0BqwHZBZr3c
	 Ae4n30C3cCm4I1COvcN6MSX5gG3BNAMarIXniFji87MHmu3PleFFpO5lEDhlOc2JQPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915610;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Trade-Whimsical:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:DKIM-Signature:
	 X-AuthUser:Received:From:To:Cc:Subject:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Date:
	 X-CM-Envelope:X-CM-Analysis;
	bh=AHNmQxajZGbM4aGt/Ao+fSqmi9KKqww7lQcOcOgpAxo=;
	b=SpjWVvoSnhdI4EV5CMb5bVUNC0T2xX8RupBiMQTb0lj8tlgGVWItSZNz1TYgL6MyGtG6
	 cUIVY7wJnRvEMzIjtdnkwKkn+AKxUfO8aOoVfyXzn6ldCfCvlIF3gkj964CBDPIIw0VBM
	 M/SVjBOAqXNjWI8a2KBspdRRiHKPHZQB7cPiDpr/QWt1L1ol1OvWsxwxNobLL4RpTF/Xt
	 /8tvhi1HUio0o/+TVEW0egFzkUGgxFaKV5Dz7ya1HydjehdyRtSsRCAoYPEMp7pXnKOiW
	 j2sbqD+UBOeeFL4A+qwnl2oFCkB8nnUvUh0WLljxRh1GPyMJPKtbWzUsWlFPgFJ2CHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marsrover.mx;
	spf=pass smtp.mailfrom=marsrover.mx;
	dkim=pass header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=Iml5lpg4;
	arc=none smtp.remote-ip=23.83.223.216
Received: from puffin.cherry.relay.mailchannels.net (puffin.cherry.relay.mailchannels.net [23.83.223.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0395606A328;
	Thu,  5 Nov 2026 21:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0395606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=Iml5lpg4
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6DE644E233A;
	Thu, 05 Nov 2026 21:53:23 +0000 (UTC)
Received: from fr-int-smtpout22.hostinger.io (trex-green-2.trex.outbound.svc.cluster.local [100.99.176.144])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 917C14E19C6;
	Thu, 05 Nov 2026 21:53:21 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MailChannels-Auth-Id: hostingeremail
X-Trade-Whimsical: 68e1e6f375efd16d_1793915603308_3191682949
X-MC-Loop-Signature: 1793915603308:3338776904
X-MC-Ingress-Time: 1793915603308
Received: from fr-int-smtpout22.hostinger.io (fr-int-smtpout22.hostinger.io
 [148.222.54.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.176.144 (trex/8.0.2);
	Thu, 05 Nov 2026 21:53:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marsrover.mx;
	s=hostingermail-a; t=1793915599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHNmQxajZGbM4aGt/Ao+fSqmi9KKqww7lQcOcOgpAxo=;
	b=Iml5lpg40Wz2evqyjOlJr4rN+P9tHAqkutjWpMVsvzsWfla83LnSy17C3nheK7N8Cf61V+
	cFAmmLSC/i5Hh+nbPqtpsyQSk5vRrMkUKrm9cMXd395H6IzHPyaI074xd41gs/Y/878sc9
	fltM4bIIWVEcd5SK1QmZnY3KALVLEVbZpMXDzgbmxr/dFkTFI5l7M5pDwkxct1x9ACvbAP
	ZIFdj8xe4sRNKXexqK2x88sGdZCB8xB7eIvsHKWQwJrjJBgKxiY6wAqp+KMe/Jf0sL9inf
	PL3iiT5bG+NRnBPcX7r6JZTqskVyKpIfhPgta1BYCfyjDvNNEcP9xrNo246P+Q==
X-AuthUser: rodrigo.rea@marsrover.mx
Received: from 0-0 (unknown [IPv6:2806:103e:32:db7c:5585:b158:b565:ff3c])
	(Authenticated sender: rodrigo.rea@marsrover.mx)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4jLGJt0SMQzyZv;
	Thu,  5 Nov 2026 21:53:17 +0000 (UTC)
From: Rodrigo Rea <rodrigo.rea@marsrover.mx>
To: alexandre.belloni@bootlin.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexander.stein@ew.tq-group.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.aguirre@nxp.com,
	rodrigo.rea@nxp.com
Subject: [PATCH 2/2] rtc: pcf85063: Add support for NXP PCA85074A
Message-ID: <20261105215204.2446733-3-rodrigo.rea@marsrover.mx>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105215204.2446733-1-rodrigo.rea@marsrover.mx>
References: <20261105215204.2446733-1-rodrigo.rea@marsrover.mx>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Thu,  5 Nov 2026 21:53:17 +0000 (UTC)
X-CM-Envelope: MS4xfHwb/EVfs9crIhiQYUA15plBJqAXnP6LTePNdgsIyI0xwayu0ti6c5p6tKsMagShYZxPFhDiNkpFpA55VZmfXUVeHUaO1Tb5xZFJmUL/kk5U8Zmq9YOj LqmbZpu+bJo00O1HbsQIuAkMWtLyWT0MkwFSKTYTVxyepvglcXO//IF6NnbKuheFSRaIbFw5oS6H2lHVeq9T42ioUIDL4KNEYvAjJfycqAMPaCqjxA6qL3/S W27fC2FLdeZ0U3BqLdgFB+hdL1ToYvgAcwyBQeeOH3qZupze73tVjfjkjhPm1LWdtdLfzuvdQSSuui0X7ZSkXL3Z/vMMQDRu6yE1iSk67R0pm5afzW4Gxn7q r94I/nuomqwnZWGXmGNsjI/zLTZyWjl0ALLF2YNCjoQnXXlB+sDbij6eTpHd/pvACrAC/Ii8gJsC2/ZFVNUGaf82v81l3vFxBKEVLc24RydPHGuhO6YcI2Py SE0aItiSmXvtOam6t2gp7OufxNgtXnDPQ9eB01cnSpWlC0MwEI1fJ9XemFIp8d/sECBAEGL/G92tuX+igpLM3+RXnzM2OlnPMWQk5g==
X-CM-Analysis: v=2.4 cv=UdEDS7SN c=1 sm=1 tr=0 ts=6aecfacf a=IBQtBY+zZK3LDN2rWOxbiA==:617 a=xqWC_Br6kY4A:10 a=8AirrxEcAAAA:8 a=0WcUORTWb5vEv_qsYz8A:9 a=ST-jHhOKWsTCqRlWije3:22

From: Rodrigo Rea <rodrigo.rea@nxp.com>

The PCA85074A uses the same register map as the PCA85073A, which
already uses the PCF85063A configuration. Add I2C and OF match entries
that reuse config_pcf85063a for the PCA85074A as well.

Tested on i.MX91S and i.MX93 platforms.

Link: https://www.nxp.com/docs/en/data-sheet/PCA85074A.pdf

Signed-off-by: Rodrigo Rea <rodrigo.rea@nxp.com>
---
 drivers/rtc/rtc-pcf85063.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 32952e73f..64f106e92 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -763,6 +763,7 @@ static const struct pcf85063_config config_rv8263 = {
 
 static const struct i2c_device_id pcf85063_ids[] = {
 	{ .name = "pca85073a", .driver_data = (kernel_ulong_t)&config_pcf85063a },
+	{ .name = "pca85074a", .driver_data = (kernel_ulong_t)&config_pcf85063a },
 	{ .name = "pcf85063", .driver_data = (kernel_ulong_t)&config_pcf85063 },
 	{ .name = "pcf85063tp", .driver_data = (kernel_ulong_t)&config_pcf85063tp },
 	{ .name = "pcf85063a", .driver_data = (kernel_ulong_t)&config_pcf85063a },
@@ -774,6 +775,7 @@ MODULE_DEVICE_TABLE(i2c, pcf85063_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id pcf85063_of_match[] = {
 	{ .compatible = "nxp,pca85073a", .data = &config_pcf85063a },
+	{ .compatible = "nxp,pca85074a", .data = &config_pcf85063a },
 	{ .compatible = "nxp,pcf85063", .data = &config_pcf85063 },
 	{ .compatible = "nxp,pcf85063tp", .data = &config_pcf85063tp },
 	{ .compatible = "nxp,pcf85063a", .data = &config_pcf85063a },
-- 
2.56.0

