Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467791;
	b=G8PpSIridLgd/xImwGW+MPb8+KKQrKGfax/DpBZN8MUdaCU77t5MzafDtG3t2NNWghBf
	 Xm2c9iEa3KoPM8xH01WkEv8a3/1B4h8x33H7ONrlNLvmSyO8E5QWUe3AFfj0IM70D9g7T
	 gPyWcQkQA54nTAKTskzII6S7A/oVMVqU1HsmAiRJ9VJ2Alzh+6ysbQyQ3N80CHAjWqhyS
	 3S7LnavannY+I4/IBIsR89Aba/Azu+bIGEUksMbA3twyCDd7n6FJklC4Tt6Id8bZqwnL8
	 rAHDmV/jJswzKPGF/3MIw8sYmbo1mGM9kChbE1lOe2HxC3CdoO/Q/NBSYOuUBADTNzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467791;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=egWDgiKIHzV4GfcAHtXk+MTCpBz5fVd1NQ97EhLBJS8=;
	b=WIxJEVNbwcjAFBd7C2ZwNrLTcQkXgo4f4gRrK8be2NbLFu5iQ5E5Hu4scPQGu1xzcbwp
	 C+lF/um9r5hBd1TtZui1cUVU3bdF+Ht1Th0wDOZTF+z2NhFl7wtMV9iSEbhVZv+tnzMGF
	 IhR45iTr5gDJ40iU7Fh/asb9mpfcrwqU0RLJLEFi7GlIMyvmqbxsU96rs9PGEukHCtYix
	 MhKuUr924vq3NAX805xFFWYMBVlJvSD5Qnpr7nE3lxJWH1HEVu72AwLIB/5sKm6+fYz4E
	 ybYdfabE8oRZ1MZPk8JXHgW01lw25sPsRDSnXXAgYClE+fmeZ/xifS2kBdIQ+MIzwbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rjcmhV7z;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FBE606A332;
	Thu, 12 Nov 2026 07:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30FBE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rjcmhV7z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rjcmhV7zFoiY+H0SUL8OGOB+fhhKS05tKlVHjJeq6DN/9TcgPtt6L0GL9jCxMiSLvSejlw8O/fepw
	 EWxTg+YuqtNCq2h8C01M7CZnWtbp9zJqFAaGjVy6BIgPMfIlYafGZ5Z+1QIywGtLYeymk6AIa5d0CU
	 ubecwdNFIMxGJg7I=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af567cb35e-e47ba;
	Thu, 12 Nov 2026 15:16:28 +0800 (CST)
X-RM-TRANSID:2ee96af567cb35e-e47ba
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af567caa6b-f6ea9;
	Thu, 12 Nov 2026 15:16:28 +0800 (CST)
X-RM-TRANSID:2ee16af567caa6b-f6ea9
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] rtc: ds1307: Check the calibration register read result
Date: Thu, 12 Nov 2026 15:16:27 +0800
Message-ID: <20261112071627.154412-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

m41txx_rtc_read_offset() ignores regmap_read() failures and calculates
the calibration offset from an uninitialized control register value.
An I2C transfer error can therefore be reported as a successful offset
read with an arbitrary result.

Return the read error before decoding the register or updating the
caller's offset.

Fixes: 79230ff64167 ("rtc: ds1307: add offset sysfs for mt41txx chips.")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/rtc/rtc-ds1307.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 8ab28cc2f181..2e9f0b3d2a93 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -853,9 +853,12 @@ static int m41txx_rtc_read_offset(struct device *dev, long *offset)
 {
 	struct ds1307 *ds1307 = dev_get_drvdata(dev);
 	unsigned int ctrl_reg;
+	int ret;
 	u8 val;
 
-	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
+	ret = regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
+	if (ret)
+		return ret;
 
 	val = ctrl_reg & M41TXX_M_CALIBRATION;
 
-- 
2.51.0



