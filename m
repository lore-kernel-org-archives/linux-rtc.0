Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2731ED81;
	Sat,  4 Jul 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167614; cv=none; b=fAvuac5tWDqtSj+qpv73riJQKMyvgjg4EJCQiz4EI/ushK9pUUPVVh7Sjaew14qN1Mv8Vy+S8r3EChPK6aNYd6St19EM/4FbMIaWa55RqAIoMf/mbRskp60hkVPARFd8X9Xhrt4JUvF7cyZDHag4zMMn/Uc50hhNQWWK9HhuDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167614; c=relaxed/simple;
	bh=cJzzLCFt8BEO7kJWlz4FCumBkXXHKobYy6N8YWOOP5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+rCTybBcgy2TalyOaoIAUkYhMsPerCWyB5HX/MuwgDc92Y4wVZy3O0XGFXah5LNmLuqMuxrSuRB7chzIlv7C81PSLV4WnK7A1jHwWlFc5rrlztSti1ixG1ilGyN8Giwxzly+HDkcIpoqEuDsE9SGcLlq3XUZX+xUO6jL4g8gaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAC3vcR1+khqFg3WFg--.11298S2;
	Sat, 04 Jul 2026 20:20:05 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: s32g: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 20:20:03 +0800
Message-ID: <20260704122003.70108-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3vcR1+khqFg3WFg--.11298S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45uw1rurW7Aw4DuryrtFb_yoWDZFXEkF
	ykZrs7W3WkurWkKws3trZ3Ar1Ika4vgrykJr95K3sa9ay7Aw4xJaykCanxtw1DGrWxtF98
	Ar1kWFy8GrW2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4U
	JwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUw5l8UU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The driver has an OF match table wired to .of_match_table, but does
not export the table with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
information is generated for OF based module autoloading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the platform driver, and the missing module alias publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/rtc/rtc-s32g.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-s32g.c b/drivers/rtc/rtc-s32g.c
index 3a0818e972eb..86716192d10f 100644
--- a/drivers/rtc/rtc-s32g.c
+++ b/drivers/rtc/rtc-s32g.c
@@ -366,6 +366,7 @@ static const struct of_device_id rtc_dt_ids[] = {
 	{ .compatible = "nxp,s32g2-rtc", .data = &rtc_s32g2_data },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, rtc_dt_ids);
 
 static DEFINE_SIMPLE_DEV_PM_OPS(s32g_rtc_pm_ops,
 			 s32g_rtc_suspend, s32g_rtc_resume);

