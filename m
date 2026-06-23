Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0A21A92F;
	Tue, 23 Jun 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209368; cv=none; b=QZNVW1uNOMNCw/GKaXZg6zet1N3ZooMU5y3BhZNFxJgzpcx+QKFZgUnT8hJyIYXOy70x3H7lYuYdwbDJphCBjApKjnKAwDQ2hlesJw2hrFxwfSl8Gm3v81IuSZVu7cYsqijkIJNd/QSyCBQd0cJwBDPggftL05r3UIOJcGWaafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209368; c=relaxed/simple;
	bh=1hhTCQCjqwvG71DABL1oLSts8WcvngCyVK5FZ2xMDrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hruohm4Wk9u0gG7nVIre1juz8IkuEm3Wkb5GKrE6NMUfBPkm62wIbg39BOC8gBTO+gES+OP2lXU7mcNWKAWzhG5eSPdvOMg9XqW13d8uDvo+a1GPHiSrd1DC2lyk0XC2WsDadmy8P7ixikA6zfc8adr8svc/DIR+cA2PKwSVVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EHdpT5ha; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EHdpT5ha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pr
	rZVqeAdymGUf+J6Qq11p4VnhLZAsuhJO+K9UWj9Ss=; b=EHdpT5hatVTO3Xjnu8
	G5RYHfUNluUE+vs5zvVM+og8uu65nz7Ycx+YFNeJkP8RPYRGEo2Si3Bc/1soum3Q
	FjAxrNGsB52SeXz6RvawXbn/mUGQqmo1SHgeC/qFIhhLSs+DKICjNbkydpVxyKJE
	vvwmiyech92JKr0Y4Jz7vtC/8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3HzMxWzpq54TPDg--.18142S2;
	Tue, 23 Jun 2026 18:08:50 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: alexandre.belloni@bootlin.com,
	bwalle@suse.de,
	akpm@linux-foundation.org
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] rtc: cmos: unregister HPET IRQ handler on probe failure
Date: Tue, 23 Jun 2026 18:08:48 +0800
Message-Id: <20260623100848.2127281-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3HzMxWzpq54TPDg--.18142S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFW5WryrGrWUCr47JryfCrg_yoW8Aw17p3
	Z3ua4DAr4qqr409a1UGa4jkFW8Wr18WrW3Arn3K3yagw48Jry0qFyqkasrAF45CryrZF1a
	gr1Dtw4fCFs8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piVOJUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RIMemo6WzKojAAA3U

cmos_do_probe() registers cmos_interrupt() as the HPET RTC IRQ
handler before requesting the RTC IRQ and registering the RTC
device. If either request_irq() or devm_rtc_register_device()
fails afterwards, the error path leaves the HPET RTC IRQ handler
installed. This leaves a stale handler behind and make a later
hpet_register_irq_handler() fail with -EBUSY.

Track whether the HPET handler was registered successfully and
undo the registration on the probe error path. Also mask the HPET
RTC IRQ bits to match the normal shutdown cleanup.

Fixes: 9d8af78b0797 ("rtc: add HPET RTC emulation to RTC_DRV_CMOS")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/rtc/rtc-cmos.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index f89ab58f5048..fa04ece151b8 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -934,6 +934,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	unsigned char			rtc_control;
 	unsigned			address_space;
 	u32				flags = 0;
+	bool				hpet_registered = false;
 	struct nvmem_config nvmem_cfg = {
 		.name = "cmos_nvram",
 		.word_size = 1,
@@ -1091,6 +1092,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 						" failed in rtc_init().");
 				goto cleanup1;
 			}
+			hpet_registered = true;
 		} else
 			rtc_cmos_int_handler = cmos_interrupt;
 
@@ -1140,6 +1142,10 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	if (is_valid_irq(rtc_irq))
 		free_irq(rtc_irq, cmos_rtc.rtc);
 cleanup1:
+	if (hpet_registered) {
+		hpet_mask_rtc_irq_bit(RTC_IRQMASK);
+		hpet_unregister_irq_handler(cmos_interrupt);
+	}
 	cmos_rtc.dev = NULL;
 cleanup0:
 	if (RTC_IOMAPPED)
-- 
2.25.1

