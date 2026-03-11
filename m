Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF242FE042;
	Wed, 11 Mar 2026 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259364; cv=none; b=CAlgmjreq4pdv+xwUY0nqOJ4LTwyjEkb3Q4ja/fMF05/oVrroOVJA7jko/BEPakXiT024iVtG/eYNsAY6j9kJNuJwZNtPnIgbMJft6Rpm0M6scx60JCQayBS2YWhZJFLK/QZBgTYl9IeqHR2MSFgbqvqxr014atBM/IaTsMfc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259364; c=relaxed/simple;
	bh=8CnhxjSzp9LdbnH9y53CrfmRgQmBlg8BL6peyKqpyk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBIhbBdtRUNSzW+morRzJSb7jZRvjPRhCuCldZD0mGbbt1bW2Cl32CCS4TgyrWNcTyCvkCy2idA7/w+ghglVzjXasHqyhwRxaYJz0jZt8O2cuB9MaAL9HYm5+V357mpTvBiCDrlltsLfCzBWrsOByHiME9ZOO4zWIT14zREqjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=fail (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=XHfu4xK7 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="XHfu4xK7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=iUFH++oaMOJVwTLr1ChwBt8nUq8dxbnmpAJpiYS+VU0=; b=XHfu4xK7/pV4nNHphm+jwjOb8n
	W/ahywTAmCsEOievizM9ArxQiV1dqjyG9+iHcJ7o1q5mrJQpLLJr5xsK54LZc3GUdwNFhPPDDtLv3
	yPjHovFhlyiKN0kakFOjpgRQEOTrwrHahbjoZqVewh+pyDN2wAmWzIReIe6ONZcPiFrs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1w0PlR-000000000Lu-0N6p;
	Wed, 11 Mar 2026 16:02:41 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hugo@hugovil.com,
	bruno.thomsen@gmail.com,
	giampiero@sferalabs.cc,
	p.rosenberger@kunbus.com,
	antonio@amsobr.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 1/4] rtc: pcf2127: remove redundant break statement in switch-case
Date: Wed, 11 Mar 2026 16:02:27 -0400
Message-ID: <20260311200237.3531981-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311200237.3531981-1-hugo@hugovil.com>
References: <20260311200237.3531981-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Remove unreachable break statement after return.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index bb4fe81d3d62c..e2e9746027348 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -404,8 +404,6 @@ static int pcf2127_param_set(struct device *dev, struct rtc_param *param)
 					  PCF2127_CTRL3_PM,
 					  FIELD_PREP(PCF2127_CTRL3_PM, mode + value));
 
-		break;
-
 	default:
 		return -EINVAL;
 	}
-- 
2.47.3

