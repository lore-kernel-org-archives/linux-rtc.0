Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCB349CD1;
	Sat,  4 Jul 2026 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178735; cv=none; b=TbEUjkHz3WEXikTUcc3IxhZN0le5rWMHxjAB2gEa10nnusW1yjtQSkAA/03Xr3mIGspEgyBnOFrwUeDqPui25SbMKogMAWSmBwwp0LIlWl3dcJwqPUIkspZoI56BVSeWCuvn8z0TGOkOVYZXGHqxqjc9doWOfiqwesdPVGPiwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178735; c=relaxed/simple;
	bh=KUdnRPWqmiFj+MVbQFhMgRadgqr0DWnoZOgERMzMeuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppJC+bhYH3IC9iBs6K0CUz/CsV/eIsU8GIrbUnWNNLV4o37xvWRNwz9tU1JLtzBCQo0IO+XoetnreDpi5WGfQafge/mhfUE55ub36reWxoC4fO2AzP09+yjB/7cb5BuBT+hUQC//LPjeU9oWMtG9I9H5ZP12Nma38mLeMyZfTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAC3F9vpJUlqMcvbFg--.2137S2;
	Sat, 04 Jul 2026 23:25:30 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ab-eoz9: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 23:25:28 +0800
Message-ID: <20260704152528.53258-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3F9vpJUlqMcvbFg--.2137S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWktrWrZr4UtryUKw4fGrg_yoWDXrbEkF
	y8Xr4fWa1DWF95K34fWrs3ZryIya18Wr1kury0gasYqa42yw17CFyv9rsxtw4kJr18tF98
	Jr9xXFyrCr42qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAKzI0EY4vE
	52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j
	6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfU83
	80DUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The driver has a match table for the i2c bus wired into its driver
structure, but the table is not exported with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE() entry so module alias information
is generated for automatic module loading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the driver registration structure, and the missing module alias
publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/rtc/rtc-ab-eoz9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
index de002f7a39bf..8dc656bb78bf 100644
--- a/drivers/rtc/rtc-ab-eoz9.c
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -549,6 +549,7 @@ static const struct i2c_device_id abeoz9_id[] = {
 	{ "abeoz9" },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, abeoz9_id);
 
 static struct i2c_driver abeoz9_driver = {
 	.driver = {
-- 
2.53.0

