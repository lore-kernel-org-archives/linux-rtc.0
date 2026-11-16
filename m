Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854802;
	b=WV5u/M/03Gpysc6FcLVdG6pKsTzbUb+QhlrwigclL6OyLjGoPPzaBVWtiOXSLl++CizJ
	 3Y6FhePLqT6o0gnk+C0B+i46iZggIOqW6T9OP1f7wfH4XHAW0jSxQVkd84L6NAd2Tp3Rs
	 pLhK/ictyuWMDL2oxbE/n2VpRAV+sbr7xut8Wy1K+JzchIl54pnx8MuGobTrJu9vrhYTu
	 /YFSqw2P1ExLvznRGaIKEkuOtRoX6iUNoVxN1UrKwyILUMK3w82y8bKsnKdKfLsBk8NyE
	 26mWl/kQLf+SwANDkG39yN5UYZuqwfHKjmyVcyVRysrTBMgaFFu9ig4nW93maBb9YHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tFzDEYw+EnooXYdZM/QgeJxwD9oyUj/5EK6tkUOx56g=;
	b=TEXDSnpCsxALgm020Zb6FPPZRbyaedaRgVjsAI5aRxa+OpWpk3jDj9G/hmBw3zWL2Kgc
	 oBLboHXn+EGCVFUfFBhOup6sVG2kWkkuB7GrMRiooOF63W5SRRqmUJQ3rRhCdN1gIGvsc
	 8p+RKNdMaeoJYZ4qLMXhG97EnXGIrQmYTZh6ZAZ4i9AjwjPGiNpfAeh1FsyM+ppuuqUaC
	 w561CEw0j0q10ac3Ym+vpLWT7hkREJPk1HTb26fd4OCdyz/wqrZx9NGtig75UhY5jCaO+
	 ulRk1JVcgo7GFBRWWd0IE1vUL931LwZMG2tIW6zd1YMidsW+GcLs3bYTntl93b2xiMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LH2NaDId;
	arc=none smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF3606A335
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 18:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BF3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LH2NaDId
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c3bb46aaf0so1349608b6e.1
        for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854800; x=1795459600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFzDEYw+EnooXYdZM/QgeJxwD9oyUj/5EK6tkUOx56g=;
        b=LH2NaDIdv753SjJEeUr7ecK4bF/cc+zRWr1U26KYqgTiyD06NGMXCrAMQXdGBkEp9d
         fcQZjAzFzFiaTeDl7IZ615eUklx4vwO2lOFxDx8S6r12V3b9HeY3MtplnQC4rNrbr6Zo
         yARNzQB1HjTxhtRoRK68WqF2fIHw5/zuRnAWVSZm7PJLnzVj40TO8aWwLytLjmSag67D
         VIPWP7Bp3wbPmYlNuEBUjiuj9eXTBe7FSNpiVfajXs6SwzFaxhLoo4zwahGwci3pYG2p
         soVGU7w+mKiLJr7bQduw1oWIVaBp608WOhOq8LEJFb4vPn5q+OqqzuGkgfWYIMJzJyTv
         bqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854800; x=1795459600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFzDEYw+EnooXYdZM/QgeJxwD9oyUj/5EK6tkUOx56g=;
        b=z63oeLJV1QYksMA5GtPXY19GGre5e77ZHCE2uaeBdoIcokbVBIRwmE65UCIJ6BKphm
         /FBk+qzUowUCNjJB6Yeyyxtks9pmfMlS++QqRjZ6BfIYmPGBM/BWHcNUsL1R1OR23NSP
         uEY6tH4o3r7TNITDMUKNq8KNfeBK9nwJ0HhzEShC6OGTMezluLooThgXzweJAUcI+LYQ
         iVheoF3myFf3BYEFFn5j8yzQZ0GT7V3VGYgl1ra6x5SxDX3FsTvKyQdmhfnzKvjyeK5U
         QblehXJqEZyhcGJkdGYawqJvIbXabeSJjCQuD6HkVmTZukeFuQa5swjc1QLdg7ON03WC
         v76g==
X-Forwarded-Encrypted: i=1; AL+hErH+wpNQeK4hUzByF82HedWLi1QVnf3v+kOzFIZB/jFFj50FP3tDgNzYfKMOdGp6a40vR3kdhyTvoGc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZzS2OUvgymDn6XhytZL4Yv77X7EbTCX2dXXdfdjqW3WRonCnj
	XelIFJBElrmZFsGvSQeQ91EuQJrIy5BUV46hgVrZr1aAgbSUxu5hPL+6
X-Gm-Gg: AYBFou38gsKFOd6mHKnE144um/dyE7VeWrEVteHcm3qHv2rs3Vjps7ImPHnYHnFPWJx
	TPuQKCOl7/0ymaXvZaxHze/Bz02UI/F3Zbfzoi8W+Al4uPReMFHZB0XHussZULntugsG9HXqmYV
	XOgEzf5LsumJeZK0QRCE6xOV0i+5RUzfdSwePXJL+75BpOfKbn6oKoxXUJXn5eIhZTGRxNxT5Nr
	yofw6EkAQEyyS79sUs8zzQhUz7nCllXjPYGUbvJVdqdPJWMIk0FmdE1QU2/anlx4ZfdP0zokwFC
	uQhtNjaaEC2z3UyWMpcGynqOn3m+k4WRRmk2Sd+sNeGG/DVi9GeF4lDMptKdHUH0s/wkE6h32lG
	fY0PKbRhgmmyueNOYG1U3zv77GoWrw1ssJXDiw3r83xgfGbAEgpzCVti0lVFs7sM/p1j2ydPB+G
	zdfoGaIH5K6tSs+z9KWJHp0xu/PIbFIFWumucySiQEdvE10HKypetSfxKkAsnAuabqOK3+LE8k7
	NxEZjv99rKfH+5GLGtKG1BMii/vCl8hbN44ZsdYcmdEwt+r81xq7mylMNQm4Ze8KF3lEZgq8bGq
	TEK2c2E3gfWFVGsr5kpaf4cMZ9UWeEVxBjDAkOcHvoBEpaWinULHgMViiJst4gXhkf0mP3Qkqym
	r5naiJ9OCOQSW7WkfsQE=
X-Received: by 2002:a05:6808:4fd2:b0:4df:5cd0:89c1 with SMTP id 5614622812f47-56e63ba5727mr9976924b6e.23.1794854800435;
        Mon, 16 Nov 2026 10:46:40 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe242b670sm7210735fac.17.2026.11.16.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:46:39 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 16 Nov 2026 12:46:33 -0600
Subject: [PATCH v3 1/2] rtc: mt6397: rename the write trigger register
 offset
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-1-179145eb7e89@gmail.com>
References: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
In-Reply-To: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794854794; l=1817;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=df32cdCXYqRXb7AgGz4g+i9owLPH2NyaDIX+9W0kTJ8=;
 b=YXj0OOXR/Ek7mAgVNZ2ePkshYGmwdQh66wpXgUVRUARhBWhlo4xL7c+hw4g+ulZz6PAARMwLB
 rVWKea1gZoeASnjj2zRQPwTaWnyl9lPPgcWMM+sqyHTCH5hZTlMhQwv
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

struct mtk_rtc_data holds the offset of the register that commits RTC
writes, in a member called wrtgr after the register's datasheet name.
Call it write_trigger_reg, so that the next member, the control
register's offset, can be named the same way.

No functional change.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/rtc/rtc-mt6397.c       | 7 ++++---
 include/linux/mfd/mt6397/rtc.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index ab402f9f85c3..5afdb707a5b5 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -22,7 +22,8 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 	int ret;
 	u32 data;
 
-	ret = regmap_write(rtc->regmap, rtc->addr_base + rtc->data->wrtgr, 1);
+	ret = regmap_write(rtc->regmap,
+			   rtc->addr_base + rtc->data->write_trigger_reg, 1);
 	if (ret < 0)
 		return ret;
 
@@ -411,11 +412,11 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
 			mt6397_rtc_resume);
 
 static const struct mtk_rtc_data mt6358_rtc_data = {
-	.wrtgr = RTC_WRTGR_MT6358,
+	.write_trigger_reg = RTC_WRTGR_MT6358,
 };
 
 static const struct mtk_rtc_data mt6397_rtc_data = {
-	.wrtgr = RTC_WRTGR_MT6397,
+	.write_trigger_reg = RTC_WRTGR_MT6397,
 };
 
 static const struct of_device_id mt6397_rtc_of_match[] = {
diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
index f4da579ec638..44d2b2cb1ff7 100644
--- a/include/linux/mfd/mt6397/rtc.h
+++ b/include/linux/mfd/mt6397/rtc.h
@@ -71,7 +71,7 @@
 #define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
 
 struct mtk_rtc_data {
-	u32                     wrtgr;
+	u32                     write_trigger_reg;
 };
 
 struct mt6397_rtc {

-- 
2.56.0

