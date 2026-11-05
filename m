Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915600;
	b=aBGYcqdHH7jZ7qWcYVbeo/wBrzdYn6x3o3bigkaV6oNCqwt62ZZSObShbXTEDja2Dpme
	 kCDFcZDWVO+LOX72+CDORiVLL6JULfDzwom+eunjdXOlvQNNE7Ukr9MhP0vetceyMFIe7
	 PcwefkK6yi1dwYIACz8Ioa+7GCoTEoaNXBCAxronW9TtEcNjuW1qDRgKWl8/jlGUtX33u
	 TnkJjMhiF6tUEa1T2LV00m7DC+QIlkAZq0SoV0p8alm0HJRKN125tAx6YmKA7HbcQiwQN
	 ggynKpZApzct0CsmaHeOS+yLSHsJ3mWiGUHrxPNLGvO79qWvOJ705q50CgxbFXfYz8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915600;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Ruddy-Imminent:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:DKIM-Signature:
	 X-AuthUser:Received:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Date:X-CM-Analysis:
	 X-CM-Envelope;
	bh=yL4plWzPZsWT3Ip+iFdKNliNwIAzErGe5j/af9xMc4o=;
	b=hLtmkY0d5ER/vqNzrtr/IPbtV7NvVhJ6s0/Yvrt/RAYlephccY/T7LWJCSiRNyC+fuYp
	 1jhhCfZ98tx6Q6aVCmwO0gADHIkx5hYmlwhyVN+WiotBrQfBm8TJ/h+L4LoalftIjkMv3
	 vnblK2TiWPVtUqMBs1xIBhNMqs/qEXH6EbM3Tubh7tZgZFdlLfSi3hS70rwHQfoYyfOsH
	 /K6N7pOyGW7eJlNd1/cI4/2ntT1iRANmA+8LZLEvlAPMeuuTXJtYDDNMihsgMopxWEexG
	 4ZGIBNRilL2kkxUrisZCLVTfFE9l0J2cUCwKP+1S/yK1d7Cr/rxJmZVfw1DD3EdOlaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marsrover.mx;
	spf=pass smtp.mailfrom=marsrover.mx;
	dkim=pass header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=WEnq9fKd;
	arc=none smtp.remote-ip=23.83.222.48
Received: from dog.ash.relay.mailchannels.net (dog.ash.relay.mailchannels.net [23.83.222.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28266606A33C;
	Thu,  5 Nov 2026 21:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28266606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=WEnq9fKd
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 90F414C2605;
	Thu, 05 Nov 2026 21:53:12 +0000 (UTC)
Received: from fr-int-smtpout22.hostinger.io (trex-green-5.trex.outbound.svc.cluster.local [100.99.172.205])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5042B4C10E3;
	Thu, 05 Nov 2026 21:53:05 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MailChannels-Auth-Id: hostingeremail
X-Ruddy-Imminent: 7ec954c64b15c8a1_1793915592360_4225785096
X-MC-Loop-Signature: 1793915592360:2130590520
X-MC-Ingress-Time: 1793915592359
Received: from fr-int-smtpout22.hostinger.io (fr-int-smtpout22.hostinger.io
 [148.222.54.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.172.205 (trex/8.0.2);
	Thu, 05 Nov 2026 21:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marsrover.mx;
	s=hostingermail-a; t=1793915583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yL4plWzPZsWT3Ip+iFdKNliNwIAzErGe5j/af9xMc4o=;
	b=WEnq9fKdImgbXXABa0i8uGROvKsaZE0cvUQttZnMTRcEweLHYw4xE/uWfgerpoytq8lXY4
	sXVqh7zLI1TmAchj1yu92F1sSE/YufwWaS/n9eaEV/V3IOf+VulEhjirTfJ/OGMpU01bOm
	luonWfMLcb+hnMzpv/91gc1A7UvNXPljN4WlVAFKTnNuIGvzXYMOcj41JsnaQYRz1vK32w
	1/XtCFmpbGBPPHc2qJ6xnaAeeRii4dB9Q8xiscINNTD36p+WLetacOzG7ThcTQcOegv3fB
	5ceRtQWBENPP0w6uE3VIHyDmrZqZUrWQ7MfseqMuhjmVfJgxl/nDq1cRGQHD1Q==
X-AuthUser: rodrigo.rea@marsrover.mx
Received: from 0-0 (unknown [IPv6:2806:103e:32:db7c:5585:b158:b565:ff3c])
	(Authenticated sender: rodrigo.rea@marsrover.mx)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4jLGJY3fxszyVM;
	Thu,  5 Nov 2026 21:53:01 +0000 (UTC)
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
Subject: [PATCH 0/2] rtc: pcf85063: Add NXP PCA85074A support
Message-ID: <20261105215204.2446733-1-rodrigo.rea@marsrover.mx>
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
Date: Thu,  5 Nov 2026 21:53:01 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=P6tohTAu c=1 sm=1 tr=0 ts=6aecfabf a=IBQtBY+zZK3LDN2rWOxbiA==:617 a=xqWC_Br6kY4A:10 a=8AirrxEcAAAA:8 a=IcSB_v73T9drFG6vY-gA:9 a=ST-jHhOKWsTCqRlWije3:22
X-CM-Envelope: MS4xfCEhHxrLANYZ4mSrfTQaUWm4B6lRsiDpU/L9+S+BmlLJmY/O+ZqKO02wOOeL+Ii/rLLCQ+mWsbuMGqeXYQfhpwk0OxjcVbIMFDGPsG+SY7SPi+Id4TMe Mj4iV5pg/lhLXFrb9VANCZpB+Uf+n8Gm3wn7LhThK9VnNc7o2lHuXufVxs3oAgOWYfbcsavuHq/MqUWWZ43hbZkdht7xLrq77fxFzxMX7RL0AQMJk6AiFrjv 4bKLHpIQ+wWQXCH0waElNf56swW+nJSWUI7FQ7aP1jEYnSULaEVEf5DvXwu+PK2BJGsvJtHo82HQt02g03WyOG1QKuBf5bnkicq8OpeTYtSOwsThoZgca6B4 bYM34yIQyT6DOiWwrG8oD6OmDdksujs12Ezh4ldKWXpf7rU0M652mvAWXp0+YLP2LLwPuynST7y9vnX04o0chBIkW5T8Q7Ub9vVrjY92lulkxLjIIgUxeIKu LayMZ0Gq5MjDv5UHozg73jz0OI/HkFzlBf902+QZV7nB6IoDdduD+KB2MB51ZTR6tIkvG9GR1jFljqVoDq8pESRIg+UZu6Whmgn7Yw==

From: Rodrigo Rea <rodrigo.rea@nxp.com>

Add support for the NXP PCA85074A real-time clock.

The PCA85074A uses the same register map as the PCA85073A and can
reuse the existing PCF85063A configuration. The series documents the
new compatible and adds the corresponding I2C and OF match entries.
No changes to the timekeeping or alarm implementation are needed.

Tested on i.MX91S and i.MX93 platforms.

Host-side validation:
- scripts/checkpatch.pl --strict
- git diff --check
- Driver object build with W=1, I2C, OF and COMMON_CLK enabled
- dt_binding_check for rtc/nxp,pcf85063.yaml
- Patch application against the base revision

Datasheet: https://www.nxp.com/docs/en/data-sheet/PCA85074A.pdf

Rodrigo Rea (2):
  dt-bindings: rtc: pcf85063: Add NXP PCA85074A
  rtc: pcf85063: Add support for NXP PCA85074A

 Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml | 1 +
 drivers/rtc/rtc-pcf85063.c                              | 2 ++
 2 files changed, 3 insertions(+)


base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.56.0

