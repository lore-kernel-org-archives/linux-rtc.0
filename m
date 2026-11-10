Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288600;
	b=hR2vCkSrI9m+XKw+9Dwwc0q8Chxc/y6/RkRGNkQFrcxPAFKd78PCuHzWgFamvbE4pR/V
	 dl0SYdf+VNWsdpS9ph8jOHElPIiqZXp6L0KWsVky1gpjnLjvdBVLO85bc6mDjlACaAFHr
	 P7IfUPhbsANgpRsc6N6iaRWofp2BGy9rH71Q1jM57537UbY1cqHFuEpEsK93K1fn3eJU0
	 aPk3Q3jZFXOVzcSxnqMHMsuR4T20hcx7YnCl2AqYuxuy/JDk7naYj3vQvXK0IPGjeSkbW
	 dXVW1xEJixRj/lNkw7JcrJAPqJ46gREmkP2dxlI1qy8YQZRgzM81xSYeZzX5wexOMNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288600;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=D+mYm1lttYa9kf7qrXQpYhZwpnzXIe+jrgE8aWktRj0=;
	b=Hkf5+13cJ3rh6Q65rtu05IVUKVfNGMpfcO+iNSWFoiIwNCX60D4TLtdgm6slesLjEkXw
	 OiQQwOVrSSH42MDlRmiU/mrRYzBQuCcteQNJAyXVDMVPXJ1cFrPl7feDYhrc9C4srW8oY
	 koFGtMx73RSFOwrBLhYWMOY+XgWSbR/PlqH2lpwPQL3RcDwq3D0UDfNsXtBS4x4mOxlh8
	 OAuSl6MSQhqBYAGTkkBxAf/LoLiTpEPHQ6vqonykzm9/0VVbmct8aIw3URlaEmvSsQ8XT
	 ImSw+N4tIbwKsw0uY4RD0VrFFGfoWNWUGUPff9UfaR78GPploFITqgyXnL14DohQwtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="iho/Z508";
	arc=none smtp.remote-ip=91.218.175.221
Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747BD606A325
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 05:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747BD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iho/Z508
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IH3SJABSJYw3tcRTvLm41rLoiFX50NOHcNOjkaC24FU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794288592; v=1; x=1794893392;
 b=iho/Z50809cES3ZC0tlSLZPguWY+akgX58soVXbNTH/xgc1H1hSUfE9JRRWm7JnZmkCImMsp
 SGmv9jcSXB6o45YgxNlozQ6WtXbowhtaSIvXrn/FtSQ3MrZ5NopMEtQM56+AGjoKW9P9UX6fmo+
 fjqo4/K/fbp9kwf/LLXs4jC0=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5eb590928260b6d1;
	Tue, 10 Nov 2026 05:29:52 +0000
X-Mizu-Trace-ID: 5eb590928260b6d1
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 05:29:42 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, crofts@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexandre.belloni@bootlin.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: [PATCH v3] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move to my new linux.dev email address akhilesh.patil@linux.dev
I plan to use this email for kernel development going forward.
Also update email address in few yaml and driver source files.

Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
---

Link to v2: 
https://lore.kernel.org/all/20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com/ 

 .mailmap                                                      | 1 +
 .../devicetree/bindings/iio/pressure/aosong,adp810.yaml       | 2 +-
 Documentation/devicetree/bindings/rtc/st,m41t93.yaml          | 2 +-
 MAINTAINERS                                                   | 2 +-
 drivers/iio/pressure/adp810.c                                 | 4 ++--
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 7fb33babc931..d09fd3708023 100644
--- a/.mailmap
+++ b/.mailmap
@@ -27,6 +27,7 @@ Adrian Bunk <bunk@stusta.de>
 Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
 Akhil P Oommen <akhilpo@oss.qualcomm.com> <akhilpo@codeaurora.org>
 Akhil P Oommen <akhilpo@oss.qualcomm.com> <quic_akhilpo@quicinc.com>
+Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
 Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
diff --git a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
index ad5f26ce5043..ca4d4210f609 100644
--- a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: aosong adp810 differential pressure sensor
 
 maintainers:
-  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+  - Akhilesh Patil <akhilesh.patil@linux.dev>
 
 description:
   ADP810 is differential pressure and temperature sensor. It has I2C bus
diff --git a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
index bdd995c5c1f4..837679dc01ac 100644
--- a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
+++ b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ST M41T93 RTC and compatible
 
 maintainers:
-  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+  - Akhilesh Patil <akhilesh.patil@linux.dev>
 
 description:
   ST M41T93 is spi based Real Time Clock (RTC) with time, date,
diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..3aa8fa3c068f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4095,7 +4095,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
 F:	drivers/iio/chemical/ags02ma.c
 
 AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
-M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+M:	Akhilesh Patil <akhilesh.patil@linux.dev>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
index 82aa433548d2..832df6ba0ee3 100644
--- a/drivers/iio/pressure/adp810.c
+++ b/drivers/iio/pressure/adp810.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+ * Copyright (c) 2025 Akhilesh Patil <akhilesh.patil@linux.dev>
  *
  * Driver for adp810 pressure and temperature sensor
  * Datasheet:
@@ -219,6 +219,6 @@ static struct i2c_driver adp810_driver = {
 };
 module_i2c_driver(adp810_driver);
 
-MODULE_AUTHOR("Akhilesh Patil <akhilesh@ee.iitb.ac.in>");
+MODULE_AUTHOR("Akhilesh Patil <akhilesh.patil@linux.dev>");
 MODULE_DESCRIPTION("Driver for Aosong ADP810 sensor");
 MODULE_LICENSE("GPL");
-- 
2.34.1

