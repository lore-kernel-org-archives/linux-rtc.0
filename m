Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915600;
	b=0MrTMziZwxII4vRl4o+jAwURWtLBHrl+e05EQ5l7SH48dc/PaA0QIG+pdNI4QtB4J3Bm
	 rYRpPwu6uleDCj7VN6VYJKaDQljy3Nt0YwpHUw0c5YlkUqdPf6G4wR0MGgSOuA/5Mghl7
	 54BNQexoCF3P0fORA6RXgrynnByvW3JAGiSsxWNrsyOyaKNnJLud20SsJjwOHTZXFGCGm
	 ePqooHbwczg893dQACwuUmMJzddxv03TrMjOHYU69rVvxVv3l3hlhI3QkQU30pCT0eKjY
	 Jzj9DBtKU4/HKE4UeLFeOc3Ntbvh5hZ4Wl1FL1p5rja04AiHSYlg+lDTZ7qH/SCeexA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915600;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Soft-Attack:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:DKIM-Signature:
	 X-AuthUser:Received:From:To:Cc:Subject:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Date:
	 X-CM-Analysis:X-CM-Envelope;
	bh=x6fWEIwcZqF+uebJhhOi96RZVMVojjt7Yr1nCZ0fX90=;
	b=vXf7uOC0hqpa+i1cNkoQPMlzEws8MhBMmW/i7jUYveJxuULpiokL6yNt5Li996ulSYiS
	 X26JHH5r9itqn0zelq3Ta2Ef+cLOn8w810J01GY8FqmkbYwjJ32RhFa7Z1QYiP94XIb91
	 gR666fB3fnV8yOl814m4Vy7hHHH6aSY1zzsKHLLxcCVkEqBkdMSVX1HIUf0u6uYFXPIzU
	 UJC+LhFVQDB3OTxILTgErNRJ0OxEjlEx67WEkidqlmXANikREdCM5T4/IY/XrVafYx+tv
	 IwWTJ/83H9sObMezx/1Pga6d8wcMrPmm5vqBlIO+4aU7xmPaZ14pzjnvtYPc2ylov9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marsrover.mx;
	spf=pass smtp.mailfrom=marsrover.mx;
	dkim=pass header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=qSPkgMW9;
	arc=none smtp.remote-ip=23.83.209.82
Received: from heron.birch.relay.mailchannels.net (heron.birch.relay.mailchannels.net [23.83.209.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58293606D802;
	Thu,  5 Nov 2026 21:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58293606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=qSPkgMW9
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 54B6C4E1FAC;
	Thu, 05 Nov 2026 21:53:13 +0000 (UTC)
Received: from fr-int-smtpout22.hostinger.io (100-99-176-144.trex-nlb.outbound.svc.cluster.local [100.99.176.144])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5BD944E1F32;
	Thu, 05 Nov 2026 21:53:11 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MailChannels-Auth-Id: hostingeremail
X-Soft-Attack: 3cc6770d49e0cae9_1793915593224_2425707991
X-MC-Loop-Signature: 1793915593224:3081047466
X-MC-Ingress-Time: 1793915593223
Received: from fr-int-smtpout22.hostinger.io (fr-int-smtpout22.hostinger.io
 [148.222.54.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.176.144 (trex/8.0.2);
	Thu, 05 Nov 2026 21:53:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marsrover.mx;
	s=hostingermail-a; t=1793915589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6fWEIwcZqF+uebJhhOi96RZVMVojjt7Yr1nCZ0fX90=;
	b=qSPkgMW9nd1cjHd+DeIfh4R/NOpjcAYWpWoSRnBkRAeiC2B882vFM+mxy24H8ZNGZIsHs2
	5VWSrsL6VrxfYe2S8b197E5z0+0pWpiDX6d9MhEOO5L00mlyiX7vMqhCxeq/5839BOTeo2
	FOUj4H7AMQ5Ynh5A7fEnTw/UGFuC+CFzI1HDPEOa9FxTt+tvSKAwd0EMotKi4WtH/4F9z7
	alB1NC7KmWlMt9CGpi2k/6GJSEAEDd8I0PkVkTlCDy/c1NPcuIn3RJsmuvjFtpxdEPCKS3
	fXqvBun8/wd3arFDMM9kRTeZeGbG6365N1FNT8P4gNgRi3un22gkpGTqnFGBUg==
X-AuthUser: rodrigo.rea@marsrover.mx
Received: from 0-0 (unknown [IPv6:2806:103e:32:db7c:5585:b158:b565:ff3c])
	(Authenticated sender: rodrigo.rea@marsrover.mx)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4jLGJg6sRCzyg7;
	Thu,  5 Nov 2026 21:53:07 +0000 (UTC)
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
Subject: [PATCH 1/2] dt-bindings: rtc: pcf85063: Add NXP PCA85074A
Message-ID: <20261105215204.2446733-2-rodrigo.rea@marsrover.mx>
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
Date: Thu,  5 Nov 2026 21:53:07 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=UdEDS7SN c=1 sm=1 tr=0 ts=6aecfac5 a=IBQtBY+zZK3LDN2rWOxbiA==:617 a=xqWC_Br6kY4A:10 a=8AirrxEcAAAA:8 a=6YoeE7raNcvHRFXWJXEA:9 a=ST-jHhOKWsTCqRlWije3:22
X-CM-Envelope: MS4xfFbLdyNXQfzM9Q9v/ZnOI06TLdUw95FPk+0FkPUiNAYnczLwE69wqjaIYu6b+EEME/U9PKDkr1BWOYiHW42H43GMjA1bIyLcAuka2AvhZW0w7Ys8/E7Z 41CnY/Dpw+098oEi/5UzVfV8jl3sgvESHC1I8oyKnuFibn1piwa+qoqSPNXp2kWigrjvFDyT3Op/RwEuWYmvqvJyAAlJIwEvPpjEBJCozD0RrF69LJBHv1U6 PLKLqF9VQ7ZbD0wS5+oRx8XAILzXgOJx2fIZJHDTYRPHS/tKI/DkF/pbncGe/Q2/+JiN7qNdEI6CpbvrfDfsKOLvOiQ1mkXho7RFFShi/RiIpTpzxYvJ9PU8 8Dq1dwgIY4QOO+7yGlyXv6bhQ2TCjIt2A86+ZaEQamlgLp25FuuTXyttU3H3r6WH+fv7sIYDoSEVtAPfuj3EuO9Ay6zmHIN26Y1xUmIc+JAK2ScbuKm6HVDd 4BYg+dDLPGU6VxGj82G0xKQmuqmczqpBZ7JOoelWfuQW79ChFmHKv+kMeZxLnpWD0kyX7CN2w0J/frIRLOhclKalawGklFpGWoBXWg==

From: Rodrigo Rea <rodrigo.rea@nxp.com>

Document the NXP PCA85074A real-time clock compatible.

Signed-off-by: Rodrigo Rea <rodrigo.rea@nxp.com>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
index f7013cd8f..b06ad3e0c 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
@@ -18,6 +18,7 @@ properties:
       - nxp,pcf85063a
       - nxp,pcf85063tp
       - nxp,pca85073a
+      - nxp,pca85074a
 
   reg:
     maxItems: 1
-- 
2.56.0

