Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AB403AE0
	for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750436; cv=none; b=tOIVX1h+QP2b0nOVVt4lDUl6K/ZvobcV8E5I7tSooT7lPC4KfLG71dPxdG6feGZDVO1DXm+GuH7WJTQ77StFRRP3fIL8BfzhtgYL1wAmZ2DUPNkBjCU37kbSwXKiU1gXUIdgmTgXppah2V0qHrQvkP13S82B3p6TTU80ur5e3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750436; c=relaxed/simple;
	bh=pEkIRxRWvYHz+dz3NpwZqKpLPS9hkD79MDfEkwAeZf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDRxHrSZbdiERjBZ62u/0/sdYcXxw6/JhnWi+Cc2KVrlplnOSLpR0Xt/OmzL3DBcRO+DRGpsssHAoVhIAfMD3ox9DNUAxuUuA2wxSYOEwbhxizoGXJlQIfe8qTg/qNRSKd7OY7rwHbKjtDYDIVGRn5yzD2PwxGBz0IXT8E/ZgJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh+M1znx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh+M1znx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f633e6058so5374868f8f.0
        for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784750430; x=1785355230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5mORs65Yll7OpCDVibb83AtzmBXkayu+8iC2S0zkHp8=;
        b=Gh+M1znxjfE7LPSzSb4ODyw4g16NjjZPV0Ge94iee2jC1vQZ/r97iW+7HVYmbg3Oes
         kqavOYquPi+AwO2s1aWh2lPZUL6z6d2Al8cK1vAEp47elLdoIUAGBTcWTFutUgfnh6Jz
         LxHAjiuBdPqB0UuMe5tNpgj1fBObJcFt7GhiWdOVfSFiVZuYzu49vXrgFCEx7386JWbY
         LHBh76xk1HrJ3kX2hq7vb17gum/6zLnCHLqicrtqtc/gP+eefpKxYHN3MtaVfhbxuoK6
         kHHiXzNQ2J4yT1TxnJ5wvrt91llZqBzsele+nu7LoX/7W+m3nJgyOSGZVWOaTwdHQ8h0
         KXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750430; x=1785355230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mORs65Yll7OpCDVibb83AtzmBXkayu+8iC2S0zkHp8=;
        b=cV5tnS/zVUUvlAqmkd72xnNTCWU7xN4ppQJD+SW0fC5DUfeEEka+8lWq54yle9Pjr1
         FNZ/gBxZ2Z5Ze4pmaBC8OYOjhm0PI0Kncuvg0wFDjaaQ+iOO7LTnO/MrtpvUQnCazpkM
         zlvCGN5vfwfGWH1QfhXBiwM7jg57a0IySaUEP26Mziq8bOX6cV1bWcx4TKWPcIUtDd97
         qHiUvvSYf4Mz99VFAEs0m8sZGVyh8GxU6xuMMX6I/XTyS8IGOKm1N0sHvrk/7s2ZLqPt
         ONBaRdD1jVBUumk6ng0T+Ua7Ea0HL/4rM9bAR0ED4OVM9fm3HxQIhJ+2bYPgjFiisqHj
         U9Nw==
X-Gm-Message-State: AOJu0YwD5XhxLkyZd4izwZtasT7mEN5KwM+TSIvq+mjCTSTTT7/brbx1
	vdy0+ajzMor4Qf2jzUgM/tgpH/QqJZDHzNpS/Fe9hL2UTMOapnyLJXhB
X-Gm-Gg: AR+sD11Aq1Ob5l2r5x7elw8NksPXywpr9axdh4RmPgXUtJAU7W+E/E7naGrRF3T9Vau
	4IKheBma1ToBLgcsklVwt8UenSOOxJ+O8jnlHpshx8xjGfPrPCFlFt/4kZWJNqCKHJVQpzLmB2S
	pVTgH1eoDg7iUWpk3mckjhcfQ9hLITXMJNX0TKL/qk3MpfDtDn91zf5vyTg6iIFhCkUPp7J9LDX
	bDtCb5r1LrldODW3wGi3TDrrhw2U1VijB0595pCHTC0hblIsbh38hp11gJW/kh4ufq5H62Q4+Cq
	SNgRU5XggXggmBdi96XCrKX4xlWvuARUIRGfg76H7TZYxpNMaelflc/WOM9WTUr2l/KKhkO2bVD
	1N0siWkp6+ov3J/c+8JpU+QUrBw0ueYAtZmHtT4tTgrz4xQaWc1czS+5BXDULHSvndiGjdH/Jqy
	IinWaJdw==
X-Received: by 2002:a05:6000:2509:b0:47d:fc45:8589 with SMTP id ffacd0b85a97d-47f8d4b6b89mr380482f8f.0.1784750430345;
        Wed, 22 Jul 2026 13:00:30 -0700 (PDT)
Received: from antoniarch ([78.210.252.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fa9sm9532851f8f.20.2026.07.22.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:00:29 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 0/6] rtc: abx80x: add support for ABX81X
Date: Wed, 22 Jul 2026 21:58:08 +0200
Message-ID: <20260722195814.298552-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This patch series adds support for the ABX81X RTCs, which are essentially
SPI versions of the ABX80X RTCs. The first patches contain cleanup and
reorganization changes (converting the driver to use the regmap API was
needed for this), followed by the actual ABX81X support.

Kind regards,
Antoni Pokusinski

Antoni Pokusinski (6):
  dt-bindings: rtc: abx80x: document ABX81X RTCs
  rtc: abx80x: add irq to struct abx80x_priv
  rtc: abx80x: use regmap instead of I2C specific API
  rtc: abx80x: replace read-modify-write pattern with regmap helpers
  rtc: abx80x: create abx80x_i2c_probe()
  rtc: abx80x: add support for ABX81X

 .../bindings/rtc/abracon,abx80x.yaml          |  15 +-
 drivers/rtc/Kconfig                           |  25 +-
 drivers/rtc/rtc-abx80x.c                      | 595 +++++++++++-------
 3 files changed, 384 insertions(+), 251 deletions(-)

-- 
2.55.0

