Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238476;
	b=HT5yYKdk/TT+gFNYO+7lDh8bIwAEXtWas4Me03J3Zu9n3ibG2ElqCaRJcaxrvZrBc7Vu
	 42n6F3XrsSLfZoEnCX9PlbA8Z45E68sgEM+GdU/uXxneaSny0hHF3oWh45cwffNbdcehI
	 rIFucmaFIKcocfurgVGWmoOnytFZZ6a4unlGy6uEzAAFDPkQhK+lthJKsoMyRTfVD1tRG
	 n9O3TsTfZldBzN5qC56bEfn2hpJmCDB5SXAGakGjjY6f3mM8zaeS6mgE2IqqIVrJtw0yW
	 QIHhIkROsiUs4KTI+X6iT1T626W/PEpr2RJDRbtMTYvCsmjE7ahYGpB1TLY7M80RDnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238476;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Harmony-Descriptive:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:DKIM-Signature:
	 X-AuthUser:Received:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Date:X-CM-Envelope:
	 X-CM-Analysis;
	bh=yQwoPBeCHUKMfvtv8rItuG884TPpZYwKs9O31MI9oyo=;
	b=nhOwGIRPye+W0IOT8vscw9V3wrUCZ+So3PBGKVp3e/CiWarl3GBrondYhwCm8PWUGOMM
	 MQfaepl61hjrPwCeaZes3uCaqnKIjC3PtoDQ/rALAePdH5jgPoROBQs0W+EBlUvOTFk9H
	 CwXd9hU8c0Is5Xi/4mUYeGIqndrDC69nYWOnTqh23UZT5Xz0TfEheC8MHP/HXiEiEEsFr
	 W6MaWXbOVRPO4iO+Z7H31wwxpGMQNBHjcSPXbFvATg+P1h+nM14mn1L2FZywxUqoYTmUV
	 5Ky4/r83TJB1U2OZiuPnamH2XxxCjxp//MFowoF7C6DFx+ZLbbqnB2Y4Az2b3BNnXtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marsrover.mx;
	spf=pass smtp.mailfrom=marsrover.mx;
	dkim=pass header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=flv0Q25g;
	arc=none smtp.remote-ip=23.83.222.45
Received: from crocodile.ash.relay.mailchannels.net (crocodile.ash.relay.mailchannels.net [23.83.222.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BD606A31C;
	Mon,  9 Nov 2026 15:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C8BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=flv0Q25g
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0B27943E3A;
	Mon, 09 Nov 2026 15:24:15 +0000 (UTC)
Received: from fr-int-smtpout20.hostinger.io (trex-green-0.trex.outbound.svc.cluster.local [100.99.188.114])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8AC3D43DEC;
	Mon, 09 Nov 2026 15:24:07 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MailChannels-Auth-Id: hostingeremail
X-Harmony-Descriptive: 23e1a62c7dc25c91_1794237853495_4285909119
X-MC-Loop-Signature: 1794237853495:3014837285
X-MC-Ingress-Time: 1794237853494
Received: from fr-int-smtpout20.hostinger.io (fr-int-smtpout20.hostinger.io
 [148.222.54.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.114 (trex/8.0.2);
	Mon, 09 Nov 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marsrover.mx;
	s=hostingermail-a; t=1794237846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQwoPBeCHUKMfvtv8rItuG884TPpZYwKs9O31MI9oyo=;
	b=flv0Q25g/jwZUtHGTPEVITQCZ/njqOTmvNDgjnx49kgdiUQOrCKIgbWi6dtV2xgwQH+N11
	mswmtN04NOCqfTH2iTO+KF5EsL3DgfkVWg8cuhhsVZwFmEInESzSkUR3QHiRJgMTvrD7Ci
	FqyR9/uVgopa2GJxIfRYQfu/2GgEsEP4R2Uj9F07vF3yieNs0N/BRuvOe3Foi7PJOGa4zZ
	riDN4imvRPmIeEFSNR3Enu5AmWH+v1PW/aPAhCThfz+eVFJ0BbuWN6Z6nmPTiF8hgSb+aL
	CKtdLQ1Kv2qVLcvOmzBjyT5E35/EIOq4zhD/xduEopS8PfGUQTlvVDqDDB9fLA==
X-AuthUser: rodrigo.rea@marsrover.mx
Received: from 0-0.nxp.com (static-148-244-115-92.alestra.net.mx [148.244.115.92])
	(Authenticated sender: rodrigo.rea@marsrover.mx)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4jNYTt582Bz1xs1;
	Mon,  9 Nov 2026 15:24:02 +0000 (UTC)
From: Rodrigo Rea <rodrigo.rea@marsrover.mx>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: alexander.stein@ew.tq-group.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rodrigo.rea@nxp.com,
	daniel.aguirre@nxp.com
Subject: [PATCH v2] dt-bindings: rtc: pcf85063: Add NXP PCA85074A
Message-ID: <20261109152352.6335-1-rodrigo.rea@marsrover.mx>
X-Mailer: git-send-email 2.56.0
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
Date: Mon,  9 Nov 2026 15:24:02 +0000 (UTC)
X-CM-Envelope: MS4xfMeZN/7QRoKChcDFlOCSxgT7J+iXITc72Hl9xVaDtYF63zK13hFUuSYftq4Pluc4adMW6rZpFiESSANvjVJ1cD/Y8D/dE2N0mKpgYe6Gt1pxOVFaCq5B rfytiRdglHCPfRQVkQ8aAtElKOGku9HOpIB5uOGEuYZ0xY/wac30+jV8B9VXWAhxUZnnH8ye1d/nc6KCxEmt1QzeMOKZzghr5ub1cHI2WXghSXfHfV7auHx1 fjl82Myxnsgbmzc1ilCfJUd5MCY4L6/JL4MJtjAlEEJPoF/RWjyNoiZFtCcUeRfCBlGRcTEy0YHpDwyg5F9hy2r/MIr6Mxi4+0OjIIItyOtce+WsaSV72deH aDAHu4hEsYfrFvZ4BbBzCmYKUl6PciRRPjVWl/rzxxIJcR78PwSaiXmWsQkjty8pD2dbN5tNpC4bMbGLdLKFyJk2zRszw86LOjC6v4knf2GRIEck8ctRjOQV jQ5tYjQS5v3NKJ5wlAIL4fD718DIbbBxmLLlhu10hnEjuT7cOInCnQwWWko=
X-CM-Analysis: v=2.4 cv=UdEDS7SN c=1 sm=1 tr=0 ts=6af1e595 a=VnbrY5TOLAh+WZUOsuTEUw==:117 a=VnbrY5TOLAh+WZUOsuTEUw==:17 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=1jgfiXo00Dv-OZUlPjkA:9 a=ST-jHhOKWsTCqRlWije3:22

From: Rodrigo Rea <rodrigo.rea@nxp.com>

Document the NXP PCA85074A real-time clock with nxp,pca85073a as a
fallback compatible. Both devices have the same register layout for
clock, calendar, alarm, offset, RAM and timer functions, allowing the
existing PCA85073A driver support to be used without a new match entry.

Link: https://www.nxp.com/docs/en/data-sheet/PCA85074A.pdf
Signed-off-by: Rodrigo Rea <rodrigo.rea@nxp.com>
---
Changes in v2:
- Require nxp,pca85073a as the fallback compatible, as requested by
  Conor Dooley.
- Drop the driver patch: the existing fallback match provides DT support.
- No runtime test of the new fallback DT has been performed.

Link to v1:
https://lore.kernel.org/20261105215204.2446733-1-rodrigo.rea@marsrover.mx/

 .../devicetree/bindings/rtc/nxp,pcf85063.yaml  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
index f7013cd8f..8ce965caf 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
@@ -11,13 +11,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - microcrystal,rv8063
-      - microcrystal,rv8263
-      - nxp,pcf85063
-      - nxp,pcf85063a
-      - nxp,pcf85063tp
-      - nxp,pca85073a
+    oneOf:
+      - enum:
+          - microcrystal,rv8063
+          - microcrystal,rv8263
+          - nxp,pcf85063
+          - nxp,pcf85063a
+          - nxp,pcf85063tp
+          - nxp,pca85073a
+      - items:
+          - const: nxp,pca85074a
+          - const: nxp,pca85073a
 
   reg:
     maxItems: 1

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.56.0

