Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703482;
	b=iVh+kUmNNSVc36sAJEw9YhkKSCfRqaqDveB1dSunvdwbet03hGAn1HfjERbonAMofCD8
	 hjCXxlRn6vGbhgqo/4xxrbW/9nE1rzguQFTZKsPmb33k7Qvvzp2quI1cs7rF4FK84svew
	 ojt17gLuuREuUGx/o+D6/8hN304RvCmYIgdbgEunKWoDQUjsnrLqAhs3EBh3G7wXZqJj2
	 pde/N4fNEB33a26B8ezi9HdGj5LVseLM6tuGHxAD0VdBvwsYu3esDoYQ0uF6ywX8Q/Yju
	 NHVAY9sSnV3G3O4hNKdp57wkANNbxHJlOPdG1crcZ0c5tqtff+YwNwA3WVxEP9E9sSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703482;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=MfuUnO7MQsPJpDHuR7JnzHeMALwBfgM6IuedB8NN/Fc=;
	b=TfwcG5hoxW0wVt1FUqRjWrFvCaCEBSq4h7c26Pb/8zeD9KeMIYQfIscCZe5Vx8bVK2yz
	 NEYznLgUwdL8vDUfyMNfW744QFCp8SGguGBqL9K900VjVu6G8E1w9nPFK3yBiyEn0lWJi
	 mOVjEykel7p9oPF1oefmFgLzTGst8eONDOx6uiFprDiy3mJzrSk1aA9d+BYC3o5NMQedd
	 EQNqpG5erOMphXsJjTY4MkQpQP2KBEqeNS/6IJkSGAaV2BqGekzRvViPOjawpl0Ab9vU5
	 hYJ4utk8cmH3upbz+KFdbF7dQgc/VJB/8oLQ/zqsAXRJMYm7RHVgzzhH6aYEwl0KtOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C963606C5BA
	for <linux-rtc@vger.kernel.org>; Tue,  3 Nov 2026 10:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C963606C5BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH0JE3vulqveY7AA--.6819S2;
	Tue, 03 Nov 2026 18:57:59 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: m41t80: use devm for the square wave clock provider
Date: Tue,  3 Nov 2026 10:58:08 +0000
Message-Id: <20261103105808.1395292-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowADH0JE3vulqveY7AA--.6819S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4UJF4rKF47Aw4Uur1DAwb_yoW5WrWrpa
	93uFy5CF1aqr4xWr4vka13AFnIkw1xtF45Aa4xGws2vr15GFW8tayjyasYvFsIqrWruw47
	Jr4UtFWruF48ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWxJr0_Gc
	WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v2
	6F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUy2XdDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEAA2rpnO6EFAAAsk

m41t80_sqw_register_clk() registers the square wave clock with
clk_register() and publishes it with of_clk_add_provider(), but neither is
ever torn down again: m41t80_remove() only unregisters the watchdog.

The provider therefore keeps a reference to the device node and points at
m41t80->sqw, which lives in devm-allocated driver data that is freed when
the device is unbound. Resolving the clock afterwards dereferences freed
memory.

Switch to devm_clk_hw_register() and devm_of_clk_add_hw_provider() so that
the clock and its provider are released with the device. The function no
longer returns a struct clk pointer, so make it return an int instead.

Fixes: 1373e77b4f10 ("rtc: m41t80: add clock provider support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/rtc/rtc-m41t80.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 1385cb43864b..c20b8734cb66 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -563,13 +563,12 @@ static const struct clk_ops m41t80_sqw_ops = {
 	.set_rate = m41t80_sqw_set_rate,
 };
 
-static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
+static int m41t80_sqw_register_clk(struct m41t80_data *m41t80)
 {
 	struct i2c_client *client = m41t80->client;
 	struct device_node *node = client->dev.of_node;
 	struct device_node *fixed_clock;
 	struct clk_init_data init = {};
-	struct clk *clk;
 	int ret;
 
 	fixed_clock = of_get_child_by_name(node, "clock");
@@ -580,17 +579,17 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
 		 * registered automatically when being referenced.
 		 */
 		of_node_put(fixed_clock);
-		return NULL;
+		return 0;
 	}
 
 	/* First disable the clock */
 	ret = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
 	if (ret < 0)
-		return ERR_PTR(ret);
+		return ret;
 	ret = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
 					ret & ~(M41T80_ALMON_SQWE));
 	if (ret < 0)
-		return ERR_PTR(ret);
+		return ret;
 
 	init.name = "m41t80-sqw";
 	init.ops = &m41t80_sqw_ops;
@@ -604,11 +603,12 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
 	of_property_read_string(node, "clock-output-names", &init.name);
 
 	/* register the clock */
-	clk = clk_register(&client->dev, &m41t80->sqw);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	ret = devm_clk_hw_register(&client->dev, &m41t80->sqw);
+	if (ret)
+		return ret;
 
-	return clk;
+	return devm_of_clk_add_hw_provider(&client->dev, of_clk_hw_simple_get,
+					   &m41t80->sqw);
 }
 #endif
 
-- 
2.34.1

